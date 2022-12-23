{block name='layout-breadcrumb'}
    {strip}
    {has_boxes position='left' assign='hasLeftBox'}
    {if !empty($Brotnavi) && !$bExclusive && $nSeitenTyp !== $smarty.const.PAGE_STARTSEITE && $nSeitenTyp !== $smarty.const.PAGE_BESTELLVORGANG && $nSeitenTyp !== $smarty.const.PAGE_BESTELLSTATUS}
      {if !isset($dark)}
      	{$dark=false}
      {/if}
      <div class="order-lg-2 mb-3 mb-lg-0 pt-lg-2">
        <nav aria-label="breadcrumb" id="breadcrumb" itemprop="breadcrumb" itemscope="" itemtype="https://schema.org/BreadcrumbList">
          <ol class="breadcrumb breadcrumb-{if $dark}dark{else}light{/if} flex-lg-nowrap justify-content-center justify-content-lg-start">
            {block name='layout-breadcrumb-items'}
              {foreach $Brotnavi as $oItem}
                {if $oItem@first}
                	{block name='layout-breadcrumb-first-item'}
                    <li class="breadcrumb-item">
                      <a class="text-nowrap" href="{$oItem->getURLFull()}" title="{sanitizeTitle title=$oItem->getName()}" itemprop="url" target="_self"><i class="ci-home"></i>
                        <span itemprop="name">{$oItem->getName()|escape:'html'}</span>
                        <meta itemprop="item" content="{$oItem->getURLFull()}" />
                        <meta itemprop="position" content="{$oItem@iteration}" />
                      </a>
                    </li>
                  {/block}
                {elseif $oItem@last}
                	{block name='layout-breadcrumb-last-item'}
                		<li class="breadcrumb-item text-nowrap active" aria-current="page">
                    	<span itemprop="name">
                        {if $oItem->getName() !== null}
                          {$oItem->getName()}
                        {elseif !empty($Suchergebnisse->getSearchTermWrite())}
                          {$Suchergebnisse->getSearchTermWrite()}
                        {/if}
                      </span>
                      <meta itemprop="item" content="{$oItem->getURLFull()}" />
                      <meta itemprop="position" content="{$oItem@iteration}" />
                    </li>
                  {/block}
                {else}
                	{block name='layout-breadcrumb-item'}
                    <li class="breadcrumb-item text-nowrap">
                      <a class="text-nowrap" href="{$oItem->getURLFull()}" title="{sanitizeTitle title=$oItem->getName()}" itemprop="url" target="_self">
                      	<span itemprop="name">{$oItem->getName()}</span>
                        <meta itemprop="item" content="{$oItem->getURLFull()}" />
                        <meta itemprop="position" content="{$oItem@iteration}" />
                      </a>
                    </li>
                  {/block}
                {/if}
            	{/foreach}
            {/block}
          </ol>
        </nav>
      </div>
    {/if}
    {/strip}
{/block}