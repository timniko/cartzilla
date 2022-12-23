{block name='layout-header-top-bar'}
{strip}
<!-- Topbar-->
<div class="topbar topbar-dark bg-dark">
  <div class="container d-block d-md-flex">
    <div class="topbar-text text-nowrap d-inline-block">
			{if $Einstellungen.template.general.cz_support_topBar !== ''}
    		<i class="ci-support"></i><span class="text-muted me-1">{lang key='contact' section='breadcrumb'}</span><a class="topbar-link" href="tel:{$Einstellungen.template.general.cz_support_topBar|regex_replace:'/\+/':'00'|regex_replace:'/[^0-9]+/':''}">{$Einstellungen.template.general.cz_support_topBar}</a>
      {/if}
    </div>
    <div class="m-0 ms-md-3 text-nowrap flex-grow-1 flex-md-grow-0">
      {block name='snippets-consent-manager-button'}
        <button type="button" class="consent-btn consent-btn-outline-primary topbar-link me-4 d-none float-start float-md-none" id="consent-settings-btn" title="{lang key='cookieSettings' section='consent'}">
          <i class="ci-security-check m-0 me-1"></i>{lang key='cookieSettings' section='consent'}
        </button>
      {/block}
      {block name='layout-header-top-bar-user-settings'}
        {block name='layout-header-top-bar-user-settings-currency'}
          <div class="topbar-text dropdown disable-autohide float-end float-md-none">
          	{include file='snippets/curr_lang_dropdown.tpl'}
          </div>
        {/block}
			{/block}
    </div>
  </div>
</div>
{/strip}
{/block}
