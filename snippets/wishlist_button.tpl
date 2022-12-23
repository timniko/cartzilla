{block name='snippets-wishlist-button'}
    {assign var='isOnWishList' value=false}
    {assign var='wishlistPos' value=0}
    {assign var='isVariationItem' value=!empty($Artikel->Variationen) && empty($Artikel->kVariKindArtikel)}
    {if !isset($size)}
    	{assign var='size' value=''}
    {/if}
    {if isset($smarty.session.Wunschliste) && !$isVariationItem}
        {foreach $smarty.session.Wunschliste->CWunschlistePos_arr as $product}
            {if $product->kArtikel === $Artikel->kArtikel || $product->kArtikel === $Artikel->kVariKindArtikel}
                {$isOnWishList=true}
                {$wishlistPos=$product->kWunschlistePos}
                {break}
            {/if}
        {/foreach}
    {/if}
    {block name='snippets-wishlist-button-main'}
            {block name='snippets-wishlist-button-button'}
                <button name="Wunschliste" class="btn-outline-primary compare action-tip-animation-b btn-wishlist {$size} float-end{if isset($showComp) && $showComp} me-2{/if}{if $isOnWishList} on-list{/if}" type="submit" data-bs-toggle="tooltip" data-bs-placement="left" title="{lang key='addToWishlist' section='productDetails'}" aria-label="{lang key='addToWishlist' section='productDetails'}" data-wl-pos="{$wishlistPos}" data-product-id-wl="{if isset($Artikel->kVariKindArtikel)}{$Artikel->kVariKindArtikel}{else}{$Artikel->kArtikel}{/if}">
                  <i class="ci-heart"></i>
                </button>
            {/block}
        {block name='snippets-wishlist-button-hidden'}
            {input type="hidden" name="wlPos" value=$wishlistPos}
        {/block}
    {/block}
{/block}
