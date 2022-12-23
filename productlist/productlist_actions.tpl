{block name='productlist-productlist-actions'}
    {form action="#" method="post" class="product-actions actions-small d-inline-block pt-2 position-absolute end-0" data=["toggle" => "product-actions"]}
        {block name='productlist-productlist-actions-buttons'}
            {if !($Artikel->nIstVater && $Artikel->kVaterArtikel === 0)}
                {$showComp = false}
                {if $Einstellungen.artikeluebersicht.artikeluebersicht_vergleichsliste_anzeigen === 'Y'
                    && $Einstellungen.vergleichsliste.vergleichsliste_anzeigen === 'Y'}
                    {block name='productlist-productlist-actions-include-comparelist-button'}
                        {include file='snippets/comparelist_button.tpl' size='btn-sm'}
                    {/block}
                    {$showComp = true}
                {/if}
                {if $Einstellungen.global.global_wunschliste_anzeigen === 'Y' && $Einstellungen.artikeluebersicht.artikeluebersicht_wunschzettel_anzeigen === 'Y'}
                    {block name='productlist-productlist-actions-include-wishlist-button'}
                        {include file='snippets/wishlist_button.tpl' showComp=$showComp size='btn-sm'}
                    {/block}
                {/if}
            {/if}
        {/block}
        {block name='productlist-productlist-actions-input-hidden'}
            {input type="hidden" name="a" value="{if !empty({$Artikel->kVariKindArtikel})}{$Artikel->kVariKindArtikel}{else}{$Artikel->kArtikel}{/if}"}
        {/block}
    {/form}
{/block}
