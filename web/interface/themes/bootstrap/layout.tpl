{if $smarty.request.subPage && $subTemplate}
  {include file="$module/$subTemplate"}
{else}
<!DOCTYPE html>
{* Do not use HTML comments before DOCTYPE to avoid quirks-mode in IE *} 
<!-- START of: layout.tpl -->

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{$userLang}" lang="{$userLang}">

{* We should hide the top search bar and breadcrumbs in some contexts - TODO, remove xmlrecord.tpl when the actual record.tpl has been taken into use: *}
{if ($module=="Search" || $module=="Summon" || $module=="PCI" || $module=="WorldCat" || $module=="Authority" || $module=="MetaLib") && $pageTemplate=="home.tpl" || $pageTemplate=="xmlrecord.tpl"}
    {assign var="showTopSearchBox" value=0}
    {assign var="showBreadcrumbs" value=0}
{else}
    {assign var="showTopSearchBox" value=1}
    {assign var="showBreadcrumbs" value=1}
{/if}

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=9" >
    {if $addHeader}{$addHeader}{/if}

    {* For mobile devices *}
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    {include file="og-metatags.tpl"}

    <title>{$pageTitle|truncate:64:"..."}</title>
    <link rel="shortcut icon" href="{path filename="images/favicon.ico"}" type="image/x-icon" />
    <link rel="apple-touch-icon-precomposed" href="{path filename="images/apple-touch-icon.png"}" />

    {if $module=='Record' && $hasRDF}
    <link rel="alternate" type="application/rdf+xml" title="RDF Representation" href="{$url}/Record/{$id|escape}/RDF"/>    
    {/if}

    <link rel="search" type="application/opensearchdescription+xml" title="Library Catalog Search" href="{$url}/Search/OpenSearch?method=describe"/>

    {* css media="screen, projection" filename="../js/jquery-ui-1.8.23.custom/css/smoothness/jquery-ui-1.8.23.custom.css" *}

    {* Load Fancybox css *}
    {css media="screen" filename="fancybox/jquery.fancybox.css"}
    
    {* Load JSTree css *}
    {css media="screen" filename="../js/jsTree/themes/apple/style.css"}

    {* Load Bootstrap CSS framework *}
    {* To use alternative Bootstrap theme either replace bootstrap.css with it
       or load the theme css after bootstrap.css.
       For FREE themes see e.g.
       http://bootswatch.com/
       http://www.bootstrapfree.com/
       For COMMERCIAL themses see e.g.
       http://bootstrapthemes.com/
       https://wrapbootstrap.com/
       http://bootstrapstyler.com/
       http://themeforest.net/collections/2712342-bootstrap-templates
       For ROLLING YOUR OWN theme, try
       http://pikock.github.io/bootstrap-magic/
       http://www.boottheme.com/
    *}
    {css media="screen, projection" filename="bootstrap-2.3.1/css/bootstrap.css"}
    {* css media="screen, projection" filename="bootstrap-2.3.0/bootstrap.css" *}
    {* css media="screen, projection" filename="bootstrap-2.3.0/bootstrap-responsive.css" *}
    {css media="screen, projection" filename="bootstrap-select/bootstrap-select.min.css"}
    {* css media="screen, projection" filename="jquery.mobile-1.0a4.1.css" *}


    {* Load SlidePanel CSS for mobile/narrow screens *}
    {css media="screen, projection" filename="../js/SlidePanel/jquery.codebomber.slidepanel.css"}

    {* Load VuFind specific stylesheets *}
    {css media="screen" filename="ui.dynatree.css"}
    {css media="screen" filename="datatables.css"}
    
    {*  Set of css files based loosely on
        Less Framework 4 http://lessframework.com by Joni Korpi
        License: http://opensource.org/licenses/mit-license.php  *}
    {* css media="screen, projection" filename="typography.css" *}
    {css media="screen, projection" filename="default.css"}
    {css media="screen, projection" filename="default_custom.css"}
    {* css media="screen, projection" filename="home.css" *}
    {* css media="screen, projection" filename="home_custom.css" *}
    {* css media="screen, projection" filename="breadcrumbs.css" *}
    {* css media="screen, projection" filename="footer.css" *}
    {* css media="screen, projection" filename="768tablet.css" *}
    {* css media="screen, projection" filename="480mobilewide.css" *}
    {* css media="screen, projection" filename="320mobile.css" *}
    {css media="screen, projection" filename="settings.css"}
    {* Load retina style sheet last *}
    {* css media="screen, projection" filename="retina.css" *}
    
    {* Disabled print styles until a fix for IE8 is found *}
    {* {css media="print" filename="print.css"} *}
    
    {if $dateRangeLimit}
      {css media="screen, projection" filename="jslider/jslider.css"}
    {/if}
    {if $facetList}
      {css media="screen, projection" filename="chosen/chosen.css"}
    {/if}
    {* <!--[if lt IE 9]>{css media="screen, projection" filename="ie.css"}<![endif]--> *}
    {* <!--[if lt IE 7]>{css media="screen, projection" filename="iepngfix/iepngfix.css"}<![endif]--> *}

    {* Set global javascript variables *}
    <script type="text/javascript">
    <!--//--><![CDATA[//><!--
      var path = '{$url}';
    //--><!]]>
    </script>

    {* Load jQuery framework and plugins *}
    {js filename="jquery-1.8.3.min.js"}
    {js filename="jquery-ui-1.8.23.custom/js/jquery-ui-1.8.23.custom.min.js"}
    {js filename="jquery.form.js"}
    {js filename="jquery.metadata.js"}
    {js filename="jquery.validate.min.js"}
    {js filename="jquery.qrcode.js"}
    {js filename="jquery.dataTables.js"}   
    {js filename="jquery.clearsearch.js"}
    {js filename="jquery.collapse.js"}
    {js filename="jquery.dynatree-1.2.2-mod.js"}

    {* Load Bootstrap *}
    {js filename="bootstrap-2.3.1/js/bootstrap.js"}
    {js filename="bootstrap-select/bootstrap-select.js"}
    {js filename="bootstrap-select/selectpicker.js"} {* dropdown menu modification *}
    
    {* Load custom javascript functions *}
    {js filename="custom.js"}
    
    {* load Fancybox *}
    {js filename="fancybox/jquery.fancybox.pack.js"}

    {* Load dynamic facets *}
    {js filename="facets.js"}

    {* Load javascript microtemplating *}
    {js filename="tmpl.js"}

    {* Load dialog/lightbox functions *}
    {js filename="lightbox.js"}
    
    {* Load common javascript functions *}
    {js filename="common.js"}
    
    {* Load carouFredSel, touchSwipe and imagesloaded *}
    {js filename="jquery.carouFredSel-6.2.0-packed.js"}
    {* js filename="jquery.touchSwipe.min.js" *}
    {js filename="jquery.imagesloaded.min.js"}

    {* Load QRCodes *}
    {js filename="qrcode.js"} 

    {* Load dropdown menu modification *}
    {js filename="dropdown.js"}

    {* Load Mozilla Persona support *}
    {if $mozillaPersona}
    <script type="text/javascript" src="https://login.persona.org/include.js"></script>
    {js filename="persona.js"}
    {/if}

    {* Load SlidePanel for mobile *}
    {* if $mobileViewLink *}
        {js filename="SlidePanel/jquery.codebomber.slidepanel.js"}
    {* /if *}

{literal}
    <script type="text/javascript">
// Long field truncation
$(document).ready(function() {
  $('.truncateField').collapse({maxLength: 150, more: "{/literal}{translate text="more"}{literal}&nbsp;»", less: "«&nbsp;{/literal}{translate text="less"}{literal}"});
      
  // Load child theme custom functions
  //customInit();
{/literal}
{if $mozillaPersona}
    mozillaPersonaSetup({if $mozillaPersonaCurrentUser}"{$mozillaPersonaCurrentUser}"{else}null{/if}, {if $mozillaPersonaAutoLogout}true{else}false{/if});
{/if}

{* if $mobileViewLink *}
    $('#panel').codebomber_Panel();
{* /if *}

{literal}
});
{/literal}
    </script>

    {* **** IE fixes **** *}
    {* Load IE CSS1 background-repeat and background-position fix *}
    {* <!--[if lt IE 7]>{js filename="../css/iepngfix/iepngfix_tilebg.js"}<![endif]--> *}
    {* Enable HTML5 in old IE - http://code.google.com/p/html5shim/
       can also use src="//html5shiv.googlecode.com/svn/trunk/html5.js" *}
    <!--[if lt IE 9]>
      {js filename="html5shim/html5shiv-printshiv.js"}
    <![endif]-->


  </head>
  <body>
    <div class="container-fluid">
      {* Screen readers: skip to main content *}
      {if $pageTemplate == 'list.tpl'}
        <div id="skip-link-results">
          <a href="#resultList" class="element-invisible">{translate text='Skip to search results'}</a>
        </div>
      {/if}
      {if $pageTemplate == 'view.tpl' || $pageTemplate == 'record.tpl'}
        <div id="skip-link-details">
          <a href="#resultMain" class="element-invisible">{translate text='Skip to record details'}</a>
        </div>
      {/if}

      {* mobile device button *}
      {if $mobileViewLink}
          <div class="mobileViewLink"><a href="{$mobileViewLink|escape}">{translate text="mobile_link"}</a></div>
      {/if}
      {* End mobile device button *}

      {* LightBox *}
      <div id="lightboxLoading" style="display: none;">{translate text="Loading"}...</div>
      <div id="lightboxError" style="display: none;">{translate text="lightbox_error"}</div>
      <div id="lightbox" onclick="hideLightbox(); return false;"></div>
      <div id="popupbox" class="popupBox"><b class="btop"><b></b></b></div>
      {* End LightBox *}

      {if $developmentSite}
      <div class="row-fluid">
        <div class="span12">
          <div class="w-i-p alert alert-block text-center">{translate text="development_disclaimer"}</div>
        </div>
      </div>
      {/if}
      <!--[If lt IE 8]>
      <div class="row-fluid">
        <div class="ie span12 alert alert-error text-center">{translate text="ie_disclaimer"}</div>
      </div>
      <![endif]-->

      <div id="topBar{if !$showTopSearchBox && ($module == 'Search')}Home{/if}" class="{if $showTopSearchBox || ($module != 'Search')}breadcrumb {/if}row-fluid"> <!-- 1 -->
        {* Start BETA BANNER - Remove/comment out when not in beta anymore ===> *}
        {*if !$showTopSearchBox}
        <div id="beta-banner">
            <a href="{$url}{if $module=='MetaLib'}/MetaLib/Home{/if}" title="{translate text="Home"}">{image src="beta-overlay.png"}</a>
        </div>
        {/if*}
        {* <=== Remove/comment out when not in beta anymore - End BETA BANNER *}

        {if $module=='PCI' || $module=='MetaLib'}{assign var="showBreadcrumbs" value ="true"}{/if}
        {if $showBreadcrumbs}
          <div class="pull-left">
            <ul class="breadcrumb pull-left">
            <li><a href="{$url}"><i class="icon-home" title="{translate text='Home'}"></i></a>&nbsp;<span class="divider">/</span></li>
            <li>{if $module}{include file="$module/breadcrumbs.tpl"}{/if}</li>
            </ul>
          </div>
        {/if}

          <div class="{if $showBreadcrumbs}hidden-phone{/if} pull-right nav-language">

            {if is_array($allLangs) && count($allLangs) > 1}
                <ul class="nav nav-pills pull-right">
                {foreach from=$allLangs key=langCode item=langName}
                  {if $userLang == $langCode}
                  <li class="offscreen"><a href="#">{translate text=$langName}</a></li>
                  {else}
                  <li><a href="{$fullPath|removeURLParam:'lng'|addURLParams:"lng=$langCode"|encodeAmpersands}">{translate text=$langName}</a></li>
                  {/if}
                {/foreach}
                </ul>
            {/if}

          </div>
      </div> <!-- /1 -->

      <div class="row-fluid"> <!-- 2 -->
        <div class="span12 backgroundContainer header{if !$showTopSearchBox}-home{/if} well well-small {if $module!='Search'} header{$module}{/if}">
          {include file="header.tpl"}
        </div>
        
        {* if !$showTopSearchBox}
        <div class="navigationMenu navigationMenu-home">
        {include file="Search/navigation.tpl"} 
        </div>
        {/if *}
      </div> <!-- /2 -->

      <div class="row-fluid main{if !$showTopSearchBox}-home{/if} module-{$module}">
      {if $useSolr || $useWorldcat || $useSummon || $useEBSCO || $usePCI || $useMetaLib}
        {if $useSolr}
        <div id="toptab">
          <ul>
        {/if}
            <li{if $module != "WorldCat" && $module != "Summon" && $module != "EBSCO" && $module != "PCI" && $module != "MetaLib"} class="active"{/if}><a href="{$url}/Search/Results?lookfor={$lookfor|escape:"url"}">{translate text="University Library"}</a></li>
        {/if}
        {if $useWorldcat}
            <li{if $module == "WorldCat"} class="active"{/if}><a href="{$url}/WorldCat/Search?lookfor={$lookfor|escape:"url"}">{translate text="Other Libraries"}</a></li>
        {if $useSummon}
            <li{if $module == "Summon"} class="active"{/if}><a href="{$url}/Summon/Search?lookfor={$lookfor|escape:"url"}">{translate text="Journal Articles"}</a></li>
        {/if}
        {if $useEBSCO}
            <li{if $module == "EBSCO"} class="active"{/if}><a href="{$url}/EBSCO/Search?lookfor={$lookfor|escape:"url"}">{translate text="Journal Articles"}</a></li>
        {/if}
        {if $usePCI}
            <li{if $module == "PCI"} class="active"{/if}><a href="{$url}/PCI/Search?lookfor={$lookfor|escape:"url"}">{translate text="Journal Articles"}</a></li>
        {/if}
        {if $useMetaLib}
            <li{if $module == "MetaLib"} class="active"{/if}><a href="{$url}/MetaLib/Search?lookfor={$lookfor|escape:"url"}">{translate text="MetaLib Databases"}</a></li>
        {/if}
          </ul>
        </div>
      {/if}

        {include file="$module/$pageTemplate"}
      </div>
          
      {* if $showTopSearchBox}
      <div class="row-fluid navigationMenu">
        {include file="Search/navigation.tpl"} 
      </div>
      {/if *}

      <div class="row-fluid footer">
        {include file="footer.tpl"}
      </div>

      <div class="visible-phone">
        <a class="btn btn-mini btn-warning panel_open" href="#" rel="panel">
          <i class="icon-align-justify block"></i>
          <i class="icon-chevron-right"></i>
        </a>

        <div id="panel" class="cb_slide_panel">
          <div class="panel_wrapper">
            <a class="close" href="#">{translate text="Close"}</a>
            <div class="panel_inner">
                <div class="panel_wrapper">{include file="panel-navi.tpl"}</div>
            </div>
          </div>
        </div>
      </div>


    </div> {* container-fluid *}

{include file="piwik.tpl"}
{include file="AJAX/keepAlive.tpl"}
  </body>
</html>
{/if}

<!-- END of: layout.tpl -->

