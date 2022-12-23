{block name='snippets-language-dropdown'}
  {if isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1}
    {foreach $smarty.session.Sprachen as $language}
      {block name='snippets-language-dropdown-item'}
        <li><a class="dropdown-item pb-1 link-lang{if $language->getId() == $smarty.session.kSprache} active{/if}" href="{$language->getUrl()}" rel="nofollow" data-iso="{$language->getIso()}" target="_self">
          <img class="me-2" src="{$ShopURL}/templates/cartzilla/img/flags/{$language->getIso639()|lower}.png" width="20" alt="{$language->getNameEN()}">{$language->getNameEN()}
        </a></li>
      {/block}
    {/foreach}
  {/if}
{/block}