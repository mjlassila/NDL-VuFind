{if $offlineMode == "ils-offline"}
  <div class="sysInfo">
    <h2>{translate text="ils_offline_title"}</h2>
    <p><strong>{translate text="ils_offline_status"}</strong></p>
    <p>{translate text="ils_offline_login_message"}</p>
    <p><a href="mailto:{$supportEmail}">{$supportEmail}</a></p>
  </div>
{elseif $hideLogin}
  <div class="error">{translate text='login_disabled'}</div>
{/if}

{if !$hideLogin}
  {if $authMethod == 'Shibboleth'}
  <div id="bd">
    <div id="yui-main" class="content">
      <div class="yui-b first contentbox">
        {if $message}<div class="error">{$message|translate}</div>{/if}
      </div>
    </div>
  </div>
  {else}
  <div id="bd">
    <div id="yui-main" class="content">
      <div class="yui-b first contentbox">

        <h2>{translate text='Login'}</h2><br>

        {if $message}<div class="error">{$message|translate}</div>{/if}
        <div class="result">
          <form method="post" action="{$url}/MyResearch/Home" name="loginForm">
            <table class="citation">
              <tr>
                <td>{translate text='Username'}: </td>
                <td><input id="mainFocus" type="text" name="username" value="{$username|escape}" size="15"></td>
              </tr>

              <tr>
                <td>{translate text='Password'}: </td>
                <td><input type="password" name="password" size="15"></td>
              </tr>

              <tr>
                <td></td>
                <td>
                  <input type="submit" name="submit" value="{translate text='Login'}">
                {if $followup}
                  <input type="hidden" name="followup" value="{$followup}"/>
                  {if $followupModule}<input type="hidden" name="followupModule" value="{$followupModule}"/>{/if}
                  {if $followupAction}<input type="hidden" name="followupAction" value="{$followupAction}"/>{/if}
                  {if $recordId}<input type="hidden" name="recordId" value="{$recordId|escape:"html"}"/>{/if}
                {/if}
                </td>
              </tr>
            </table>
            {if $extraParams}
              {foreach from=$extraParams item=item}
                <input type="hidden" name="extraParams[]" value="{$item.name|escape}|{$item.value|escape}" />
              {/foreach}
            {/if}
          </form>
          <script type="text/javascript">var o = document.getElementById('mainFocus'); if (o) o.focus();</script>

          {if $authMethod == 'DB'}
            <a href="{$url}/MyResearch/Account">{translate text='Create New Account'}</a>
          {/if}
        </div>
      </div>
    </div>
  </div>
  {/if}
{/if}