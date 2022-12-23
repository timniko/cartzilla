{block name='snippets-stock-status'}
  {assign var=anzeige value=$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige}
  {if $anzeige !== 'nichts'
    && ($currentProduct->cLagerKleinerNull === 'N'
        || $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U')
    && $currentProduct->getBackorderString() !== ''
    && $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen !== 'N'}
    {block name='snippets-stock-status-in-flowing'}
      <div class="{if $currentProduct->Lageranzeige->nStatus == 1 || $currentProduct->Lageranzeige->nStatus == 2}product-available{else}product-not-available{/if}{if $showBadge} product-badge{/if}">
        <i class="ci-security-{if $currentProduct->Lageranzeige->nStatus == 1 || $currentProduct->Lageranzeige->nStatus == 2}check{else}close{/if}{if !$showBadge} me-1{/if}"></i>{$currentProduct->getBackorderString()}
      </div>
    {/block}
  {elseif $anzeige !== 'nichts'
    && $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen !== 'N'
    && $currentProduct->cLagerBeachten === 'Y'
    && $currentProduct->fLagerbestand <= 0
    && $currentProduct->fLieferantenlagerbestand > 0
    && $currentProduct->fLieferzeit > 0
    && ($currentProduct->cLagerKleinerNull === 'N'
      && $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'I'
      || $currentProduct->cLagerKleinerNull === 'Y'
      && $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U')}
    {block name='snippets-stock-status-supllier-stock-notice'}
      <div class="product-not-available{if $showBadge} product-badge{/if}">
        <i class="ci-security-close{if !$showBadge} me-1{/if}"></i>{lang key='supplierStockNotice' printf=$currentProduct->fLieferzeit}
      </div>
    {/block}
  {elseif $anzeige === 'verfuegbarkeit'
    || $anzeige === 'genau'}
    {block name='snippets-stock-status-exact'}
      <div class="{if $currentProduct->Lageranzeige->nStatus == 1 || $currentProduct->Lageranzeige->nStatus == 2}product-available{else}product-not-available{/if}{if $showBadge} product-badge{/if}">
        <i class="ci-security-{if $currentProduct->Lageranzeige->nStatus == 1 || $currentProduct->Lageranzeige->nStatus == 2}check{else}close{/if}{if !$showBadge} me-1{/if}"></i>{$currentProduct->Lageranzeige->cLagerhinweis[$anzeige]}
      </div>
    {/block}
  {elseif $anzeige === 'ampel'}
    {block name='snippets-stock-status-traffic-light'}
      <div class="{if $showBadge}product-badge{/if}{if $currentProduct->Lageranzeige->nStatus == 1 || $currentProduct->Lageranzeige->nStatus == 2} product-available{else} product-not-available{/if}">
        <i class="ci-security-{if $currentProduct->Lageranzeige->nStatus == 1 || $currentProduct->Lageranzeige->nStatus == 2}check{else}close{/if}{if !$showBadge} me-1{/if}"></i>{$currentProduct->Lageranzeige->AmpelText}
      </div>
    {/block}
  {/if}
{/block}
