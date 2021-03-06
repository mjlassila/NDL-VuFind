<?php
/**
 * Hold Logic Class
 *
 * PHP version 5
 *
 * Copyright (C) Villanova University 2007.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2,
 * as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 * @category VuFind
 * @package  Support_Classes
 * @author   Demian Katz <demian.katz@villanova.edu>
 * @author   Luke O'Sullivan <l.osullivan@swansea.ac.uk>
 * @license  http://opensource.org/licenses/gpl-2.0.php GNU General Public License
 * @link     http://vufind.org/wiki/system_classes#index_interface Wiki
 */

require_once 'CatalogConnection.php';
require_once 'Crypt/generateHMAC.php';

/**
 * Hold Logic Class
 *
 * @category VuFind
 * @package  Support_Classes
 * @author   Demian Katz <demian.katz@villanova.edu>
 * @author   Luke O'Sullivan <l.osullivan@swansea.ac.uk>
 * @license  http://opensource.org/licenses/gpl-2.0.php GNU General Public License
 * @link     http://vufind.org/wiki/system_classes#index_interface Wiki
 */
class HoldLogic
{
    protected $catalog;
    protected $hideHoldings;

    /**
     * Constructor
     *
     * @param object $catalog A catalog connection
     *
     * @access public
     */
    public function __construct($catalog = false)
    {
        global $configArray;

        $this->hideHoldings = isset($configArray['Record']['hide_holdings'])
            ? $configArray['Record']['hide_holdings'] : array();

        $this->catalog = ($catalog == true)
            ? $catalog : ConnectionManager::connectToCatalog();
    }

    /**
     * Support method to rearrange the holdings array for displaying convenience.
     * VuFind is currently set up to display only the notes and summaries found
     * in the first item for a location; this method gathers notes and summaries
     * from other items and pushes them into the first for convenience.
     *
     * Note: This is not very elegant -- it would make more sense to have separate
     * elements in the return array for holding collected notes and summaries rather
     * than stuffing them into an arbitrary item; this will be addressed in VuFind
     * 2.0.
     *
     * @param array $holdings An associative array of location => item array
     *
     * @return array          An associative array keyed by location with each
     * entry being a list of items where the first holds the summary
     * and notes for all.
     * @access protected
     */
    protected function formatHoldings($holdings)
    {
        foreach ($holdings as $location => $items) {
            $notes = array();
            $summaries = array();
            foreach ($items as $item) {
                if (isset($item['notes'])) {
                    if (!is_array($item['notes'])) {
                        $item['notes'] = empty($item['notes'])
                            ? array() : array($item['notes']);
                    }
                    foreach ($item['notes'] as $note) {
                        if (!in_array($note, $notes)) {
                            $notes[] = $note;
                        }
                    }
                }
                if (isset($item['summary'])) {
                    if (!is_array($item['summary'])) {
                        $item['summary'] = empty($item['summary'])
                            ? array() : array($item['summary']);
                    }
                    foreach ($item['summary'] as $summary) {
                        if (!in_array($summary, $summaries)) {
                            $summaries[] = $summary;
                        }
                    }
                }
            }
            $holdings[$location][0]['notes'] = $notes;
            $holdings[$location][0]['summary'] = $summaries;
        }
        return $holdings;
    }

    /**
     * Public method for getting item holdings from the catalog and selecting which
     * holding method to call
     *
     * @param string $id     An Bib ID
     * @param array  $patron An array of patron data
     *
     * @return array A sorted results set
     * @access public
     */

    public function getHoldings($id, $patron = false)
    {
        $holdings = array();

        // Get Holdings Data
        if ($this->catalog && $this->catalog->status) {
            $result = $this->catalog->getHolding($id, $patron);
            if (PEAR::isError($result)) {
                PEAR::raiseError($result);
            }

            $mode = CatalogConnection::getHoldsMode();
            
            if ($mode == "disabled") {
                 $holdings = $this->standardHoldings($result);
            } else if ($mode == "driver") {
                $holdings = $this->driverHoldings($result);
            } else {
                $holdings = $this->generateHoldings($result, $mode);
            }
        }
        // Don't format holdings as we want to keep call numbers separate 
        // and it would ruin notes and summaries
        //return $this->formatHoldings($holdings);
        return $this->sortHoldings($holdings);
    }

    /**
     * Protected method for standard (i.e. No Holds) holdings
     *
     * @param array $result A result set returned from a driver
     *
     * @return array A sorted results set
     * @access protected
     */
    protected function standardHoldings($result)
    {
        $holdings = array();
        if (count($result)) {
            foreach ($result as $copy) {
                $show = !in_array($copy['location'], $this->hideHoldings);
                if ($show) {
                    $holdings[$copy['location']][] = $copy;
                }
            }
        }
        return $holdings;
    }

    /**
     * Protected method for driver defined holdings
     *
     * @param array $result A result set returned from a driver
     *
     * @return array A sorted results set
     * @access protected
     */
    protected function driverHoldings($result)
    {
        $holdings = array();

        // Are holds allowed?
        $id = null;
        $record = current($result);
        if ($record) {
            $id = $record['id'];
        }
        $checkHolds = $this->catalog->checkFunction("Holds", $id);
        $checkCallSlips = $this->catalog->checkFunction("CallSlips", $id);
        $checkUBRequests = $this->catalog->checkFunction("UBRequests", $id);
        if (count($result)) {
            foreach ($result as $copy) {
                $show = !in_array($copy['location'], $this->hideHoldings);
                if ($show) {
                    if ($checkHolds != false) {
                        // Is this copy holdable / linkable
                        if (isset($copy['addLink']) && $copy['addLink'] && strcmp($copy['addLink'], 'block') !== 0) {
                            $copy['link'] = $this->_getHoldDetails(
                                $copy, $checkHolds['HMACKeys']
                            );
                            // If we are unsure whether hold options are available,
                            // set a flag so we can check later via AJAX:
                            $copy['check'] = (strcmp($copy['addLink'], 'check') == 0)
                                ? true : false;
                        }
                    }
                    if ($checkCallSlips !== false) {
                        if (isset($copy['addCallSlipLink']) && $copy['addCallSlipLink'] && strcmp($copy['addCallSlipLink'], 'block') !== 0) {
                            $copy['callSlipLink'] = $this->_getCallSlipDetails(
                                $copy, $checkCallSlips['HMACKeys']
                            );
                            // If we are unsure whether call slip options are available,
                            // set a flag so we can check later via AJAX:
                            $copy['checkCallSlip'] = (strcmp($copy['addCallSlipLink'], 'check') == 0)
                                ? true : false;
                        }
                    }
                    if ($checkUBRequests !== false) {
                        if (isset($copy['addUBRequestLink']) && $copy['addUBRequestLink'] && strcmp($copy['addUBRequestLink'], 'block') !== 0) {
                            $copy['UBRequestLink'] = $this->_getUBRequestDetails(
                                $copy, $checkUBRequests['HMACKeys']
                            );
                            // If we are unsure whether UB request options are available,
                            // set a flag so we can check later via AJAX:
                            $copy['checkUBRequest'] = (strcmp($copy['addUBRequestLink'], 'check') == 0)
                                ? true : false;
                        }
                    }
                    $holdings[$copy['location']][] = $copy;
                }
            }
        }
        return $holdings;
    }

    /**
     * Protected method for vufind (i.e. User) defined holdings
     *
     * @param array  $result A result set returned from a driver
     * @param string $type   The holds mode to be applied from:
     * (all, holds, recalls, availability)
     *
     * @return array A sorted results set
     * @access protected
     */
    protected function generateHoldings($result, $type)
    {
        global $configArray;

        $holdings = array();
        $any_available = false;

        $holds_override = isset($configArray['Catalog']['allow_holds_override'])
            ? $configArray['Catalog']['allow_holds_override'] : false;

        if (count($result)) {
            foreach ($result as $copy) {
                $show = !in_array($copy['location'], $this->hideHoldings);
                if ($show) {
                    $holdings[$copy['location']][] = $copy;
                    // Are any copies available?
                    if ($copy['availability'] == true) {
                        $any_available = true;
                    }
                }
            }

            // Are holds allowed?
            $id = null;
            $record = current($result);
            if ($record) {
                $id = $record['id'];
            }
            $checkHolds = $this->catalog->checkFunction("Holds", $id);
            $checkCallSlips = $this->catalog->checkFunction("CallSlips", $id);
            $checkUBRequests = $this->catalog->checkFunction("UBRequests", $id);
            
            if (is_array($holdings)) {
                // Generate Links
                // Loop through each holding
                foreach ($holdings as $location_key => $location) {
                    foreach ($location as $copy_key => $copy) {
                        if ($checkHolds != false) {
                            // Override the default hold behavior with a value from
                            // the ILS driver if allowed and applicable:
                            $switchType
                                = ($holds_override && isset($copy['holdOverride']))
                                ? $copy['holdOverride'] : $type;

                            switch($switchType) {
                            case "all":
                                $addlink = true; // always provide link
                                break;
                            case "holds":
                                $addlink = $copy['availability'];
                                break;
                            case "recalls":
                                $addlink = !$copy['availability'];
                                break;
                            case "availability":
                                $addlink = !$copy['availability']
                                    && ($any_available == false);
                                break;
                            default:
                                $addlink = false;
                                break;
                            }
                            // If a valid holdable status has been set, use it to
                            // determine if a hold link is created
                            $addlink = isset($copy['is_holdable'])
                                ? ($addlink && $copy['is_holdable']) : $addlink;

                            if ($addlink) {
                                $holdLink = "";
                                if ($checkHolds['function'] == "getHoldLink") {
                                    /* Build opac link */
                                    $holdings[$location_key][$copy_key]['link']
                                        = $this->catalog->getHoldLink(
                                            $copy['id'], $copy
                                        );
                                } else {
                                    /* Build non-opac link */
                                    $holdings[$location_key][$copy_key]['link']
                                        = $this->_getHoldDetails(
                                            $copy, $checkHolds['HMACKeys']
                                        );
                                }
                            }
                        }
                        if ($checkCallSlips !== false) {
                            if (isset($copy['addCallSlipLink']) && $copy['addCallSlipLink']) {
                                $holdings[$location_key][$copy_key]['callSlipLink'] = (strcmp($copy['addCallSlipLink'], 'block') == 0)
                                    ? "?errorMsg=call_slip_error_blocked"
                                    : $this->_getCallSlipDetails(
                                        $copy, $checkCallSlips['HMACKeys']
                                    );
                                // If we are unsure whether call slip options are available,
                                // set a flag so we can check later via AJAX:
                                $holdings[$location_key][$copy_key]['checkCallSlip'] = (strcmp($copy['addCallSlipLink'], 'check') == 0)
                                    ? true : false;
                            }
                        }
                        if ($checkUBRequests !== false) {
                            if (isset($copy['addUBRequestLink']) && $copy['addUBRequestLink']) {
                                unset($copy['item_id']);
                                unset($copy['mfhd_id']);
                                $copy['UBRequestLink'] = (strcmp($copy['addUBRequestLink'], 'block') == 0)
                                    ? "?errorMsg=ub_request_error_blocked"
                                    : $this->_getUBRequestDetails(
                                        $copy, $checkUBRequests['HMACKeys']
                                    );
                                // If we are unsure whether UB request options are available,
                                // set a flag so we can check later via AJAX:
                                $copy['checkUBRequest'] = (strcmp($copy['addUBRequestLink'], 'check') == 0)
                                    ? true : false;
                            }
                        }
                    }
                }
            }
        }
        return $holdings;
    }

    /**
     * Get Hold Form
     *
     * Supplies holdLogic with the form details required to place a hold
     *
     * @param array $holdDetails An array of item data
     * @param array $HMACKeys    An array of keys to hash
     *
     * @return string A url link (with HMAC key)
     * @access private
     */
    private function _getHoldDetails($holdDetails, $HMACKeys)
    {
        global $configArray;

        $siteUrl = $configArray['Site']['url'];
        $id = $holdDetails['id'];

        // Generate HMAC
        $HMACkey = generateHMAC($HMACKeys, $holdDetails);

        // Add Params
        foreach ($holdDetails as $key => $param) {
            $needle = in_array($key, $HMACKeys);
            if ($needle) {
                $queryString[] = $key. "=" .urlencode($param);
            }
        }

        //Add HMAC
        $queryString[] = "hashKey=" . $HMACkey;

        // Build Params
        $urlParams = "?" . implode("&", $queryString);

        $holdLink = $siteUrl."/Record/".urlencode($id)."/Hold".$urlParams."#tabnav";

        return $holdLink;
    }

    /**
     * Get Call Slip Form
     *
     * Supplies holdLogic with the form details required to place a call slip request
     *
     * @param array $details  An array of item data
     * @param array $HMACKeys An array of keys to hash
     *
     * @return string A url link (with HMAC key)
     * @access private
     */
    private function _getCallSlipDetails($details, $HMACKeys)
    {
        global $configArray;

        $siteUrl = $configArray['Site']['url'];
        $id = $details['id'];

        // Generate HMAC
        $HMACkey = generateHMAC($HMACKeys, $details);

        // Add Params
        foreach ($details as $key => $param) {
            $needle = in_array($key, $HMACKeys);
            if ($needle) {
                $queryString[] = $key. "=" .urlencode($param);
            }
        }

        //Add HMAC
        $queryString[] = "hashKey=" . $HMACkey;

        // Build Params
        $urlParams = "?" . implode("&", $queryString);

        $link = $siteUrl."/Record/".urlencode($id)."/CallSlip".$urlParams."#tabnav";

        return $link;
    }

    /**
     * Get UB Request Form
     *
     * Supplies holdLogic with the form details required to place a UB request
     *
     * @param array $details  An array of item data
     * @param array $HMACKeys An array of keys to hash
     *
     * @return string A url link (with HMAC key)
     * @access private
     */
    private function _getUBRequestDetails($details, $HMACKeys)
    {
        global $configArray;

        $siteUrl = $configArray['Site']['url'];
        $id = $details['id'];

        // Generate HMAC
        $HMACkey = generateHMAC($HMACKeys, $details);

        // Add Params
        foreach ($details as $key => $param) {
            $needle = in_array($key, $HMACKeys);
            if ($needle) {
                $queryString[] = $key. "=" .urlencode($param);
            }
        }

        //Add HMAC
        $queryString[] = "hashKey=" . $HMACkey;

        // Build Params
        $urlParams = "?" . implode("&", $queryString);

        $link = $siteUrl."/Record/".urlencode($id)."/UBRequest".$urlParams."#tabnav";

        return $link;
    }
    
    /**
     * Support method to rearrange the holdings array by location, 
     * call number, and number.
     * 
     * @param array $holdings An associative array of location => item array
     *
     * @return array          An associative array keyed by location 
     * @access protected
     */
    protected function sortHoldings($holdings)
    {
        $callNumber = array();
        $number = array();
        foreach ($holdings as $location => &$items) {
            foreach ($items as $key => $row) {
                $callNumber[$key] = $row['callnumber'];
                $number[$key] = $row['number'];
            }
            array_multisort($callNumber, SORT_ASC, $number, SORT_NUMERIC, $items);
        }
        return $holdings;
    }    
}
?>
