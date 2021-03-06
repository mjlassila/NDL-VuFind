<!-- START of: RecordDrivers/Index/holdings.tpl -->

<div class="well-small">
  <h3>{translate text=$source prefix='source_'}</h3>

{if $id|substr:0:7 == 'helmet.'}
  <br/>
  <span class="native_link">
    <a href="http://haku.helmet.fi/iii/encore/record/C|R{$id|substr:7|escape}" target="_blank">{translate text='Holdings details from'} HelMet</a><br/>
  </span>
{/if}

{if !$hideLogin && $offlineMode != "ils-offline"}
  {if ($driverMode && !empty($holdings)) || $titleDriverMode}
    {if $showLoginMsg || $showTitleLoginMsg}
      <div class="userMsg alert alert-info">
        <a class="btn btn-mini" href="{$path}/MyResearch/Home?followup=true&followupModule=Record&followupAction={$id}">{translate text="Login"}</a> {translate text="hold_login"}
      </div>
    {/if}
    {if $user && !$user->cat_username}
      <div class="userMsg alert alert-info">
        <a class="btn btn-mini" href="{$path}/MyResearch/Profile">{translate text="Add an account to place holds"}</a>
      </div>
    {/if}
  {/if}
{/if}

{if $holdingTitleHold && $holdingTitleHold != 'block'}
    <a class="holdPlace" href="{$holdingTitleHold|escape}">{translate text="title_hold_place"}</a>
{/if}
{if $holdingTitleHold == 'block'}
    {translate text="hold_error_blocked"}
{/if}

{assign var="ublink" value=false}
{foreach from=$holdings item=holding}
  {if !$ublink}
    {foreach from=$holding item=row}
      {if !$ublink && $row.UBRequestLink}
        <a class="UBRequestPlace checkUBRequest" href="{$row.UBRequestLink|escape}"><span>{translate text="ub_request_check"}</span></a>
        {assign var="ublink" value=true}
      {/if}
    {/foreach}
  {/if}
{/foreach}

{if !empty($holdingURLs) || $holdingsOpenURL}
  <h5 class="label label-inverse">{translate text="Internet"}</h5>
  {if !empty($holdingURLs)}
    {foreach from=$holdingURLs item=desc key=currentUrl name=loop}
      <a href="{$currentUrl|proxify|escape}" target="_blank">{$desc|translate_prefix:'link_'|escape}</a><br/>
    {/foreach}
  {/if}
  {if $holdingsOpenURL}
    {include file="Search/openurl.tpl" openUrl=$holdingsOpenURL}
  {/if}
{/if}


{if !$holdings}
<h5 class="alert alert-info">{translate text="No holdings information available"}</h5>
{/if}
{foreach from=$holdings item=holding key=location}
  {assign var=prevMfhdId value=''}
  {foreach from=$holding item=row}

{if $prevMfhdId != $row.mfhd_id}
  {if $prevMfhdId}
  </table>
  {/if}
  <h5 class="label label-info">{$location|translate|escape}</h5>
  {assign var=prevMfhdId value=$row.mfhd_id}
<table cellpadding="2" cellspacing="0" border="0" class="table table-condensed table-hover citation" summary="{translate text='Holdings details from'} {translate text=$location}">
  {if $row.callnumber}
  <tr>
    <th>{translate text="Call Number"}: </th>
    <td>{$row.callnumber|escape}</td>
  </tr>
  {/if}
  {if $row.summary}
  <tr>
    <th>{translate text="Volume Holdings"}: </th>
    <td>
      {foreach from=$row.summary item=summary}
      {$summary|escape}<br>
      {/foreach}
    </td>
  </tr>
  {/if}
  {if $row.purchase_history}
  <tr>
    <th>{translate text="Most Recent Received Issues"}: </th>
    <td>
      {foreach from=$row.purchase_history item=row}
      {$row.issue|escape}<br>
      {/foreach}
    </td>
  </tr>
  {/if}
  {if $row.notes}
  <tr>
    <th>{translate text="Notes"}: </th>
    <td>
      {foreach from=$row.notes item=data}
      {$data|escape}<br>
      {/foreach}
    </td>
  </tr>
  {/if}
  {if $row.supplements}
  <tr>
    <th>{translate text="Supplements"}: </th>
    <td>
      {foreach from=$row.supplements item=supplement}
      {$supplement|escape}<br>
      {/foreach}
    </td>
  </tr>
  {/if}
  {if $row.indexes}
  <tr>
    <th>{translate text="Indexes"}: </th>
    <td>
      {foreach from=$row.indexes item=index}
      {$index|escape}<br>
      {/foreach}
    </td>
  </tr>
  {/if}
{/if}

    {if $row.item_id}
  <tr>
    <th>{translate text="Copy"} {$row.number|escape}</th>
    <td>
      {if $row.reserve == "Y"}
      {translate text="On Reserve - Ask at Circulation Desk"}
      {elseif $row.use_unknown_message}
      <span class="unknown">{translate text="status_unknown_message"}</span>
      {else}
        {if $row.availability}
        {* Begin Available Items (Holds) *}
          <div>
           <span class="available">{translate text="Available"}</span>
          {if $row.link}
            <a class="holdPlace{if $row.check} checkRequest{/if}" href="{$row.link|escape}"><span>{if !$row.check}{translate text="Place a Hold"}{else}{translate text="Check Hold"}{/if}</span></a>
          {/if}
          {if $row.callSlipLink}
            <a class="callSlipPlace{if $row.checkCallSlip} checkCallSlipRequest{/if}" href="{$row.callSlipLink|escape}"><span>{if !$row.checkCallSlip}{translate text="call_slip_place_text"}{else}{translate text="Check Call Slip Request"}{/if}</span></a>
          {/if}
          </div>
        {else}
        {* Begin Unavailable Items (Recalls) *}
          <div>
          <span class="checkedout">{translate text=$row.status prefix='status_'}</span>
          {if $row.returnDate} <span class="statusExtra">{$row.returnDate|escape}</span>{/if}
          {if $row.duedate}
          <span class="statusExtra">{translate text="Due"}: {$row.duedate|escape}</span>
          {/if}
          {if $row.requests_placed > 0}
            <span>{translate text="Requests"}: {$row.requests_placed|escape}</span>
          {/if}
          {if $row.link}
            <a class="holdPlace{if $row.check} checkRequest{/if}" href="{$row.link|escape}"><span>{if !$row.check}{translate text="Recall This"}{else}{translate text="Check Recall"}{/if}</span></a>
          {/if}
          </div>
        {/if}
      {/if}
    </td>
  </tr>
    {/if}
  {/foreach}
</table>
{/foreach}

</div>

{literal}
<script type="text/javascript">
$(document).ready(function() {
	$('a.holdPlace,a.callSlipPlace,a.UBRequestPlace').click(function() {
	  var id = {/literal}'{$id}'{literal};
	  var href = $(this).attr('href');
	  var hashPos = href.indexOf('#');
	  if (hashPos >= 0) {
	    href = href.substring(0, hashPos);      
	  }
	  var $dialog = getPageInLightbox(href + '&lightbox=1', $(this).text(), 'Record', '', id);
	  return false;
	});
});
</script>
{/literal}


<!-- END of: RecordDrivers/Index/holdings.tpl -->
