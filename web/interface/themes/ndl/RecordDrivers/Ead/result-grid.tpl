<div id="record{$summId|escape}" class="gridRecordBox recordId" >
  {assign var=img_count value=$summImages|@count}
  {if $img_count > 1}
    <div class="imagelinks">
    {foreach from=$summImages item=desc name=imgLoop}
      <a href="{$url}/thumbnail.php?id={$summId|escape:"url"}&index={$smarty.foreach.imgLoop.iteration-1}&size=large" class="title"  onclick="launchFancybox(this); return false;" onmouseover="document.getElementById('thumbnail_{$summId|escape:"url"}').src='{$path}/thumbnail.php?id={$summId|escape:"url"}&index={$smarty.foreach.imgLoop.iteration-1}&size=small'; document.getElementById('thumbnail_link_{$summId|escape:"url"}').href='{$path}/thumbnail.php?id={$summId|escape:"url"}&index={$smarty.foreach.imgLoop.iteration-1}&size=large'; return false;" />      {if $desc}{$desc|escape}{else}{$smarty.foreach.imgLoop.iteration + 1}{/if}
      {if $desc}{$desc|escape}{else}{$smarty.foreach.imgLoop.iteration + 1}{/if}
      </a>
    {/foreach}
    </div>
  {/if}
  <div class="addToFavLink">
    <a id="saveRecord{$summId|escape}" href="{$url}/Record/{$summId|escape:"url"}/Save" class="fav tool saveRecord" title="{translate text='Add to favorites'}"></a>
  </div>
  <div class="gridContent">
    <div class="gridTitleBox" >
      <a class="gridTitle" href="{$url}/{if $summCollection}Collection{else}Record{/if}/{$summId|escape:"url"}" id="thumbnail_link_{$summId|escape:"url"}" >
      {if !$summTitle}{translate text='Title not available'}{elseif !empty($summHighlightedTitle)}{$summHighlightedTitle|truncate:80:"..."|highlight}{else}{$summTitle|truncate:80:"..."|escape}{/if}
      </a>
      <div class="gridPublished">
        {if $summDate}{translate text='Published'}: {$summDate.0|escape}{/if}
      </div>
    </div>
  </div>
  <div class="coverDiv">
    {if is_array($summFormats)}
      {assign var=mainFormat value=$summFormats.0} 
      {assign var=displayFormat value=$summFormats|@end} 
    {else}
      {assign var=mainFormat value=$summFormats} 
      {assign var=displayFormat value=$summFormats} 
    {/if}
  
    <div class="resultNoImage format{$mainFormat|lower|regex_replace:"/[^a-z0-9]/":""} format{$displayFormat|lower|regex_replace:"/[^a-z0-9]/":""}"></div>
    {if $summThumb}
      <div class="resultImage"><a href="{$summThumb|regex_replace:"/&size=small/":"&size=large"|escape}" onclick="launchFancybox(this); return false;" rel="{$summId|escape:"url"}" id="thumbnail_link{$summId|escape:"url"}"><img src="{$summThumb|escape}" id="thumbnail_{$summId|escape:"url"}" class="summcover" alt="{translate text='Cover Image'}" /></a></div>
    {/if}
  </div> 
</div>