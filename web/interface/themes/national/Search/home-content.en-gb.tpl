<!-- START of: Search/home-content.en-gb.tpl -->

<div id="introduction" class="section clearfix">
  <div class="content">
    <div class="grid_14">
      <div id="siteDescription">
       <h2>For seekers of information and inspiration</h2>
        <p>The Finna information search service brings together the collections of Finnish archives, libraries and museums.</p><p> New content is continuously added to the service, which can also be used to browse and read from thousands of <a href='{$url}/Search/Results?lookfor=&type=AllFields&prefiltered=-&filter[]=online_boolean%3A"1"&view=list'>electronic resources.</a></p>
      </div>
    </div>
    <div class="grid_10 push_right">
      <div>
        {include file="Search/document-type-list.tpl"}
      </div>
    </div>
  </div>
</div>
<div id="content-carousel" class="section clearfix">
  <div class="content">
    <div id="carousel">
      {include file="Search/home-carousel.$userLang.tpl"}
    </div>
  </div>
</div>
<div id="home-timeline" class="section clearfix">
  <div class="content">
    <p class="grid_18"><span class="large">By narrowing your search by year, </span> you can find images, books, objects, documents and other material
   from the past to the present.
    </p>
  </div>
  {include file="Search/Recommend/DateRangeVisAjax.tpl"}
</div>
{* <!--
<div id="popular-map" class="section clearfix">
  <div class="content">
    <div class="grid_14">
      <div id="topSearches">
        <h2>10 most popular searches</h2>
        <div id="popularSearches" class="recent-searches"><div class="loading"></div></div>
        {include file="AJAX/loadPopularSearches.tpl"}
      </div>
    </div>
    <div class="grid_10 push_right">
      <div id="mapSearchHome">
        <h2>Try the geographic search</h2>
        <p>You can also refine your search to a specific area on the map. The geographic search function currently encompasses some 12,630 items.</p>
        <a class="button" href="{$url}/Search/Advanced#mapSearch">Geographic search</a>
      </div>
    </div>
  </div>
</div>
--> *}

<!-- END of: Search/home-content.en-gb.tpl -->
