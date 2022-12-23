{block name='productdetails-stock'}
  {assign var=anzeige value=$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige}
  {if !isset($showBadge)}
    {assign var=showBadge value=true}
  {/if}
  {block name='productdetails-stock-stock-info'}
    {if !isset($shippingTime)}
      {block name='productdetails-stock-shipping-time'}
        {if $Artikel->inWarenkorbLegbar === $smarty.const.INWKNICHTLEGBAR_UNVERKAEUFLICH}
          <div class="product-not-available{if $showBadge} product-badge mt-n3{/if}">
            <i class="ci-security-close{if !$showBadge} me-1{/if}"></i>{lang key='productUnsaleable' section='productDetails'}
          </div>
        {elseif !$Artikel->nErscheinendesProdukt}
          {block name='productdetails-stock-include-stock-status'}
            {include file='snippets/stock_status.tpl' currentProduct=$Artikel showBadge=$showBadge}
          {/block}
        {else}
          <div class="product-available{if $showBadge} product-badge mt-n3{/if}">
            {if $anzeige === 'verfuegbarkeit' || $anzeige === 'genau' && $Artikel->fLagerbestand > 0}
              <i class="ci-security-check{if !$showBadge} me-1{/if}"></i>{$Artikel->Lageranzeige->cLagerhinweis[$anzeige]}
            {elseif $anzeige === 'ampel' && $Artikel->fLagerbestand > 0}
              <i class="ci-security-check{if !$showBadge} me-1{/if}"></i>{$Artikel->Lageranzeige->AmpelText}
            {/if}
          </div>
        {/if}
        {* rich snippet availability *}
        {block name='productdetails-stock-rich-availability'}
          {if $Artikel->cLagerBeachten === 'N' || $Artikel->fLagerbestand > 0 || $Artikel->cLagerKleinerNull === 'Y'}
            <link itemprop="availability" href="https://schema.org/InStock" />
          {elseif $Artikel->nErscheinendesProdukt && $Artikel->Erscheinungsdatum_de !== '00.00.0000' && $Einstellungen.global.global_erscheinende_kaeuflich === 'Y'}
            <link itemprop="availability" href="https://schema.org/PreOrder" />
          {elseif $Artikel->cLagerBeachten === 'Y' && $Artikel->cLagerKleinerNull === 'N' && $Artikel->fLagerbestand <= 0}
            <link itemprop="availability" href="https://schema.org/OutOfStock" />
          {/if}
        {/block}
        {if isset($Artikel->cLieferstatus) && ($Einstellungen.artikeldetails.artikeldetails_lieferstatus_anzeigen === 'Y' ||
        ($Einstellungen.artikeldetails.artikeldetails_lieferstatus_anzeigen === 'L' && $Artikel->fLagerbestand == 0 && $Artikel->cLagerBeachten === 'Y') ||
        ($Einstellungen.artikeldetails.artikeldetails_lieferstatus_anzeigen === 'A' && ($Artikel->fLagerbestand > 0 || $Artikel->cLagerKleinerNull === 'Y' || $Artikel->cLagerBeachten !== 'Y')))}
          {block name='productdetails-stock-delivery-status'}
            <div class="{if $showBadge}product-badge mt-n3{/if}{if $Artikel->Lageranzeige->nStatus == 1 || $Artikel->Lageranzeige->nStatus == 2} product-available{else} product-not-available{/if}">
              <i class="ci-security-{if $Artikel->Lageranzeige->nStatus == 1 || $Artikel->Lageranzeige->nStatus == 2}check{else}close{/if}{if !$showBadge} me-1{/if}"></i>{$Artikel->cLieferstatus}
            </div>
          {/block}
        {/if}
      {/block}
    {/if}
  {/block}
{/block}
