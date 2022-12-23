{if isset($Artikel->Variationen) && $Artikel->Variationen|@count > 0}
  {assign var=VariationsSource value='Variationen'}
  {if isset($ohneFreifeld) && $ohneFreifeld}
    {assign var=VariationsSource value='VariationenOhneFreifeld'}
  {/if}
  {assign var=oVariationKombi_arr value=$Artikel->getChildVariations()}
  {foreach name=Variationen from=$Artikel->$VariationsSource key=i item=Variation}
    {block name='productdetails-variation-radio-outer'}
      <div class="text-center pb-2">
        {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
          {assign var=bSelected value=false}
          {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
           {assign var=bSelected value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
          {/if}
          {if isset($oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft])}
            {assign var=bSelected value=$Variationswert->kEigenschaftWert == $oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft]->kEigenschaftWert}
          {/if}
          {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl == 1 &&
          $Einstellungen.global.artikeldetails_variationswertlager == 3 &&
          !empty($Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar) && $Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar == 1}
          
          {else}
            {block name='productdetails-variation-radio-inner'}
              <div class="form-check form-option form-check-inline mb-2">
                <a class="form-option-label d-inline-block" href="{$Artikel->cURLFull}">{$Variationswert->cName}</a>
              </div>
            {/block}
          {/if}
        {/foreach}
      </div>
    {/block}
  {/foreach}
  {/if}