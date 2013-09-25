<?php
/**
 * Fines action for MyResearch module
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
 * @package  Controller_MyResearch
 * @author   Andrew S. Nagy <vufind-tech@lists.sourceforge.net>
 * @author   Demian Katz <demian.katz@villanova.edu>
 * @license  http://opensource.org/licenses/gpl-2.0.php GNU General Public License
 * @link     http://vufind.org/wiki/building_a_module Wiki
 */
require_once 'services/MyResearch/MyResearch.php';

/**
 * Fines action for MyResearch module
 *
 * @category VuFind
 * @package  Controller_MyResearch
 * @author   Andrew S. Nagy <vufind-tech@lists.sourceforge.net>
 * @author   Demian Katz <demian.katz@villanova.edu>
 * @license  http://opensource.org/licenses/gpl-2.0.php GNU General Public License
 * @link     http://vufind.org/wiki/building_a_module Wiki
 */
class Fines extends MyResearch
{
    /**
     * Process parameters and display the page.
     *
     * @return void
     * @access public
     */
    public function launch()
    {
        global $interface;
        global $finesIndexEngine;

        // Assign the ID of the last search so the user can return to it.
        $interface->assign(
            'lastsearch',
            isset($_SESSION['lastSearchURL']) ? $_SESSION['lastSearchURL'] : 'perkele'
        );

        // Get My Fines
        if ($patron = UserAccount::catalogLogin()) {
            if (PEAR::isError($patron)) {
                PEAR::raiseError($patron);
            }
            $result = $this->catalog->getMyFines($patron);
            $loans = $this->catalog->getMyTransactions($patron);
            if (!PEAR::isError($result)) {
                // assign the "raw" fines data to the template
                // NOTE: could use foreach($result as &$row) here but it only works
                // with PHP5
                $sum = 0;
                for ($i = 0; $i < count($result); $i++) {
                    $row = &$result[$i];
                    $sum += $row['balance'];
                    $record = $this->db->getRecord($row['id']);
                    $row['title'] = $record ? $record['title_short'] : null;
                    $row['checkedOut'] = false;
                    if (is_array($loans)) {
                        foreach ($loans as $loan) {
                            if ($loan['id'] == $row['id']) {
                                $row['checkedOut'] = true;
                                break;
                            }
                        }
                    }
                    $formats = array();
                    foreach (isset($record['format']) ? $record['format'] : array() as $format) {
                        $formats[] = preg_replace('/^\d\//', '', $format);
                    }
                    $row['format'] = $formats;
                }
                $interface->assign('rawFinesData', $result);
                $interface->assign('sum', $sum);
            }
        }

        $interface->setTemplate('fines.tpl');
        $interface->setPageTitle('My Fines');
        $interface->display('layout.tpl');
    }
    
}

?>