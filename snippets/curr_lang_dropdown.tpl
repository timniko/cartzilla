{if (isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1) || (isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1)}
	{if !isset($btn_class)}
  	{$btn_class = 'topbar-link dropdown-toggle'}
  {/if}
  <a class="{$btn_class}" href="#" data-bs-toggle="dropdown">
    {foreach $smarty.session.Sprachen as $language}
      {if $language->getId() == $smarty.session.kSprache}
        {block name='snippets-language-dropdown-text'}
          <img class="me-2" src="{$ShopURL}/templates/cartzilla/img/flags/{$language->getIso639()|lower}.png" width="20" alt="{$language->getNameEN()}">{$language->getIso639()|upper} / {$smarty.session.Waehrung->getHtmlEntity()}
        {/block}
      {/if}
    {/foreach}
  </a>
  <ul class="dropdown-menu dropdown-menu-end">
    {if isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1}
      <li class="dropdown-item">
        <select class="form-select form-select-sm currency_select">
          {foreach $smarty.session.Waehrungen as $currency}
            <option value="{$currency->getURLFull()}"{if $smarty.session.Waehrung->getName() === $currency->getName()} selected{/if}>{$currency->getHtmlEntity()} {$currency->getName()}</option>
          {/foreach}
        </select>
      </li>
    {/if}
    {block name='layout-header-top-bar-user-settings-include-language-dropdown'}
        {include file='snippets/language_dropdown.tpl'}
    {/block}
  </ul>
  {if isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1}
    {inline_script}<script>
      $("select.currency_select").on("change", function(){
        window.location.href = $(this).val();
      });
    </script>{/inline_script}
  {/if}
{/if}