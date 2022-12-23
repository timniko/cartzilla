{block name='productlist-item-slider'}
	<div>
    <div class="card border-0">
    	{block name='productlist-item-slider-link'}
        <a class="card-img-top d-block overflow-hidden text-center" href="{$Artikel->cURLFull}">
          {if isset($Artikel->Bilder[0]->cAltAttribut)}
            {assign var=alt value=$Artikel->Bilder[0]->cAltAttribut|truncate:60}
          {else}
            {assign var=alt value=$Artikel->cName}
          {/if}
          {block name='productlist-item-slider-image'}
            {include file='snippets/image.tpl' item=$Artikel square=false srcSize='sm' class='product-image'}
          {/block}
          {if $tplscope !== 'box'}
            <meta itemprop="image" content="{$Artikel->Bilder[0]->cURLNormal}">
            <meta itemprop="url" content="{$Artikel->cURLFull}">
          {/if}
        </a>
      {/block}
			{block name='productlist-item-slider-caption'}
        <div class="card-body py-2">
        	{block name='productlist-item-slider-caption-short-desc'}
          	{get_article_kat Artikel=$Artikel}
            <a class="product-meta d-block fs-xs pb-1" href="{$article_kat->cURLFull}">{$article_kat->cName}</a>
            <h3 class="product-title fs-sm">
            	<a href="{$Artikel->cURLFull}"{if $tplscope !== 'box'} itemprop="name"{/if}>{$Artikel->cKurzbezeichnung}</a>
            </h3>
          {/block}
          <div class="d-flex justify-content-between">
            {if $tplscope === 'box'}
              {if $Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->fDurchschnittsBewertung > 0}
                {block name='productlist-item-slider-include-rating'}
                  <div class="item-slider-rating star-rating">
                  	{include file='productdetails/rating.tpl' stars=$Artikel->fDurchschnittsBewertung link=$Artikel->cURLFull}
                  </div>
                {/block}
              {/if}
            {/if}
            {block name='productlist-item-slider-include-price'}
              <div class="item-slider-price product-price" itemprop="offers" itemscope itemtype="https://schema.org/Offer">
                {include file='productdetails/price.tpl' Artikel=$Artikel tplscope=$tplscope}
              </div>
            {/block}
          </div>
        </div>
			{/block}
    </div>
  </div>
{/block}