{block name='snippets-ribbon'}
  {if !empty($Artikel->Preise->Sonderpreis_aktiv)}
    {$sale = $Artikel->Preise->discountPercentage}
  {/if}

  {block name='snippets-ribbon-main'}
    <span class="badge bg-danger badge-shadow">
      {block name='snippets-ribbon-content'}
        {lang key='ribbon-'|cat:$Artikel->oSuchspecialBild->getType() section='productOverview' printf=$sale|default:''|cat:'%'}
      {/block}
    </span>
  {/block}
{/block}
