{assign var='isOnCompareList' value=false}
{if !isset($size)}
  {assign var='size' value=''}
{/if}
{if isset($smarty.session.Vergleichsliste)}
    {foreach $smarty.session.Vergleichsliste->oArtikel_arr as $product}
        {if $product->kArtikel === $Artikel->kArtikel}
            {$isOnCompareList=true}
            {break}
        {/if}
    {/foreach}
{/if}
{block name='snippets-comparelist-button-main'}
    <button name="Vergleichsliste" class="btn-outline-info compare action-tip-animation-b btn-wishlist {$size} float-end me-2{if $isOnCompareList} on-list{/if}" type="submit" data-bs-toggle="tooltip" data-bs-placement="left" title="{lang key='addToCompare' section='productOverview'}" aria-label="{lang key='addToCompare' section='productOverview'}" data-product-id-cl="{$Artikel->kArtikel}">
			<i class="ci-view-list"></i>
		</button>
{/block}
