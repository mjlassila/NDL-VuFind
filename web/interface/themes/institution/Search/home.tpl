<div class="searchHome">
  <div class="searchHomeContent">
    <div class="searchHomeLogo">
      <img src="{$path}/interface/themes/institution/images/morgan_logo.gif" alt="MORGAN - KIRJASTO, ARKISTO JA MUSEO" />
{* Slogan is not necessarily needed if it is integrated into the logo or not use at all *}
{*
      <p>{translate text="home_slogan"}</p>
*}
    </div>
    <div class="searchHomeForm">
      {include file="Search/searchbox.tpl"}
    </div>

  </div>
</div>

{* Search by browsing
   instead of commenting out, this might be better to do in settings somewhere if possible *}
<!--
{if $facetList}
<div class="searchHomeBrowse">

  {assign var=columns value=0}
  {foreach from=$facetList item=details key=field}
    {assign var=list value=$details.sortedList}
    {if $field == 'callnumber-first'}{assign var=currentSize value=10}{else}{assign var=currentSize value=5}{/if}
    {assign var=columns value=$columns+$currentSize}
    <h2 class="snap-{$currentSize}">{translate text="home_browse"} {translate text=$details.label}</h2> 
  {/foreach}
  {if $columns > 0 && $columns < 24}
    <div class="snap-{math equation="24 - x" x=$columns} last">&lt;!-- pad out header row --&gt;</div>
  {/if}
  {foreach from=$facetList item=details key=field}
    {assign var=list value=$details.sortedList}
    <ul class="snap-5">
      {* Special case: two columns for LC call numbers... *}
      {if $field == "callnumber-first"}
        {foreach from=$list item=url key=value name="callLoop"}
          <li><a href="{$url|escape}">{$value|escape}</a></li>
          {if $smarty.foreach.callLoop.iteration == 10}
            </ul>
            <ul class="snap-5">
          {/if}
        {/foreach}
      {else}
        {assign var=break value=false}
        {foreach from=$list item=url key=value name="listLoop"}
          {if $smarty.foreach.listLoop.iteration > 12}
            {if !$break}
              <li><a href="{$path}/Search/Advanced"><strong>{translate text="More options"}...</strong></a></li>
              {assign var=break value=true}
            {/if}
          {else}
            <li><a href="{$url|escape}">{$value|escape}</a></li>
          {/if}
        {/foreach}
      {/if}
    </ul>
  {/foreach}

</div>
<div class="clear"></div>
{/if}
-->
