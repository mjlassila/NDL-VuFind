<!-- START of: footer.tpl -->

<div id="footerCol1"><p class="strong">{translate text='Search Options'}</p>
  <ul>
    <li><a href="{$path}/Search/History">{translate text='Search History'}</a></li>
    <li><a href="{$path}/Search/Advanced">{translate text='Advanced Search'}</a></li>
  </ul>
</div>

<div id="footerCol2"><p class="strong">{translate text='Find More'}</p>
  <ul>
    <li><a href="{$path}/Browse/Home">{translate text='Browse the Catalog'}</a></li>
    <li><a href="{$path}/AlphaBrowse/Home">{translate text='Browse Alphabetically'}</a></li>
    <li><a href="{$path}/Search/TagCloud">{translate text='Browse by Tags'}</a></li>
    <li><a href="{$path}/Search/Reserves">{translate text='Course Reserves'}</a></li>
    <li><a href="{$path}/Search/NewItem">{translate text='New Items'}</a></li>
  </ul>
</div>

<div id="footerCol3"><p class="strong">{translate text='Need Help?'}</p>
  <ul>
    <li><a href="{$url}/Help/Home?topic=search" class="searchHelp">{translate text='Search Tips'}</a></li>
    <li><a href="#">{translate text='Ask a Librarian'}</a></li>
    <li><a href="#">{translate text='FAQs'}</a></li>
  </ul>
</div>

<div id="footerCol4" class="last">
{if $userLang=='en-gb'}
  <a href="http://www.kdk.fi/en" class="footerLogo">{image src="kdk_logo_small.png" alt=""}The National Digital Library</a>
{else}
	<a href="http://www.kdk.fi" class="footerLogo">{image src="kdk_logo_small.png" alt=""}Kansallinen digitaalinen kirjasto</a>
{/if}
	<br />
	<a href="http://www.vufind.org" class="footerLogo">{image src="vufind_logo_small.png" alt=""}www.vufind.org</a>
</div>
<div class="clear"></div>

{* Comply with Serials Solutions terms of service -- this is intentionally left untranslated. *}
{if $module == "Summon"}Powered by Summon™ from Serials Solutions, a division of ProQuest.{/if}

<!-- END of: footer.tpl -->
