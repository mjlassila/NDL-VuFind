<!-- START of: header-menu.sv.tpl -->

<li class="menuHome"><a href="{$path}/"><span>{translate text='Home'}</span></a></li>

<li class="menuAbout"><a href="{$path}/Content/about"><span>{translate text='navigation_about'}</span></a></li>

<li class="menuSearch menuSearch_{$userLang}"><a href="#"><span>{translate text='navigation_search'}</span></a>
  <ul class="subNav">
    <li>
      <a href="{$path}/Search/Advanced">
        <span>Utökad sökning</span>
        <span>Fler sökvillkor och sökning på karta.</span>
      </a>
    </li>
    {if $dualResultsEnabled}
    <li>
      <a href="{$path}/PCI/Advanced">
        <span>{translate text="Advanced PCI Search"}</span>
        <span>{translate text="pci_advanced_search_description"}</span>
      </a>
    </li>
    {/if}
    {if $metalibEnabled}
    <li>
      <a href="{$path}/MetaLib/Home">
        <span>{translate text="MetaLib Search"}</span>
        <span>{translate text="metalib_search_description"}</span>
      </a>
    </li>
    {/if}
    <li>
      <a href="{$path}/Browse/Home">
        <span>Bläddra i katalogen</span>
        <span>Bläddra enligt författare, ämne, område, tidsperiod eller tagg.</span>
      </a>
    </li>
    <li>
      <a href="{$path}/Search/History">
        <span>Sökhistorik</span>
        <span>Din sökhistorik enligt session. Om du loggar in kan du spara dina sökningar.</span>
      </a>    
    </li>
  </ul>
</li>

<li class="menuHelp menuHelp_{$userLang}"><a href="#"><span>{translate text='navigation_help'}</span></a>
  <ul class="subNav">
    <li>
      <a href="{$path}/Content/searchhelp">
        <span>Söktips</span>
        <span>Detaljerade sökanvisningar.</span>
      </a>
    </li>
  </ul> 
</li>

<li class="menuFeedback"><a href="{$path}/Feedback/Home"><span>{translate text='navigation_feedback'}</span></a></li>

{include file="login-element.tpl"}

<!-- END of: header-menu.sv.tpl -->
