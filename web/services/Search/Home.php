<?php
/**
 * Home action for Search module
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
 * @package  Controller_Search
 * @author   Andrew S. Nagy <vufind-tech@lists.sourceforge.net>
 * @author   Demian Katz <demian.katz@villanova.edu>
 * @license  http://opensource.org/licenses/gpl-2.0.php GNU General Public License
 * @link     http://vufind.org/wiki/building_a_module Wiki
 */
require_once 'Action.php';

/**
 * Home action for Search module
 *
 * @category VuFind
 * @package  Controller_Search
 * @author   Andrew S. Nagy <vufind-tech@lists.sourceforge.net>
 * @author   Demian Katz <demian.katz@villanova.edu>
 * @license  http://opensource.org/licenses/gpl-2.0.php GNU General Public License
 * @link     http://vufind.org/wiki/building_a_module Wiki
 */
class Home extends Action
{
    /**
     * Process incoming parameters and display the page.
     *
     * @return void
     * @access public
     */
    public function launch()
    {
        global $interface;
        global $configArray;

        // Cache homepage
        $homeFacets = isset($configArray['Site']['home_page_facets']) && $configArray['Site']['home_page_facets'];
        if ($homeFacets) {
            $interface->caching = 1;
        } 
        $cacheId = 'homepage|' . $interface->lang . '|' .
            (UserAccount::isLoggedIn() ? '1' : '0') . '|' .
            (isset($_SESSION['lastUserLimit']) ? $_SESSION['lastUserLimit'] : '') .
            '|' .
            (isset($_SESSION['lastUserSort']) ? $_SESSION['lastUserSort'] : '');
        if (!$interface->is_cached('layout.tpl', $cacheId)) {
            $interface->setPageTitle('Search Home');
            $interface->assign('searchTemplate', 'search.tpl');
            $interface->setTemplate('home.tpl');

            if ($homeFacets) {
                // Create our search object
                $searchObject = SearchObjectFactory::initSearchObject();
                // TODO: The template looks for specific facets. Make it more flexible.
                $searchObject->initHomePageFacets();
                // We don't want this search in the search history
                $searchObject->disableLogging();
                // Go get the facets
                $searchObject->processSearch();
                $facetList = $searchObject->getFacetList();
                // Shutdown the search object
                $searchObject->close();
    
                // Add a sorted version to the facet list:
                if (count($facetList) > 0) {
                    $facets = array();
                    foreach ($facetList as $facet => $details) {
                        $facetList[$facet]['sortedList'] = array();
                        foreach ($details['list'] as $value) {
                            $facetList[$facet]['sortedList'][$value['value']]
                                = $value['url'];
                        }
                        natcasesort($facetList[$facet]['sortedList']);
                    }
                    $interface->assign('facetList', $facetList);
                }
            }
          // Get theme(s)
          $themes = explode(',', $interface->getVuFindTheme());
          // if theme 'national' in use initialize visFacets for Timeline in Home Page
          if (in_array("national", $themes)) {
            $visFacets = array('search_sdaterange_mv' => array(0 => "", 1 => "", 'label' => "Other"));
            $interface->assign('visFacets', $visFacets);
          }
        }
        $interface->display('layout.tpl', $cacheId);
    }

}

?>
