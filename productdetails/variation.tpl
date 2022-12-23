{block name='productdetails-variation'}
  {if isset($Artikel->Variationen) && $Artikel->Variationen|@count > 0 && !$showMatrix}
    {assign var=VariationsSource value='Variationen'}
    {if isset($ohneFreifeld) && $ohneFreifeld}
      {assign var=VariationsSource value='VariationenOhneFreifeld'}
    {/if}
    {assign var=oVariationKombi_arr value=$Artikel->getChildVariations()}
    {block name='productdetails-variation-spinner'}
      <div class="updatingStockInfo text-center-util d-none">
        <div class="spinner-border text-primary fa-spin" role="status">
          <span class="visually-hidden">{lang key='updatingStockInformation' section='productDetails'}</span>
        </div>
      </div>
    {/block}
    {block name='productdetails-variation-variation'}
			<div class="variations {if $simple}simple{else}switch{/if}-variations">
        {foreach name=Variationen from=$Artikel->$VariationsSource key=i item=Variation}
          <div class="card mb-4">
            <div class="card-header">
              <span class="h6">{$Variation->cName}</span>
              
              {if $Variation->cTyp === 'IMGSWATCHES'}
                <span class="swatches-selected text-success" data-id="{$Variation->kEigenschaft}">
                {foreach $Variation->Werte as $variationValue}
                  {if isset($oVariationKombi_arr[$variationValue->kEigenschaft])
                    && in_array($variationValue->kEigenschaftWert, $oVariationKombi_arr[$variationValue->kEigenschaft])}
                    {$variationValue->cName}
                    {break}
                  {/if}
                {/foreach}
                </span>
              {/if}
              
              <span class="spinner-border spinner-border-sm text-primary d-none float-end" role="status">
                <span class="visually-hidden">{lang key='ajaxLoading'}</span>
              </span>
            </div>
            <div class="card-body">
              {if $Variation->cTyp === 'SELECTBOX'}
                <div class="mb-grid-gutter">
                  <div class="mb-3">
                    {block name='productdetails-variation-select-outer'}
                      {select data=["size"=>"10"] class='form-select selectpicker' title="{lang key='pleaseChooseVariation' section='productDetails'}" name="eigenschaftwert[{$Variation->kEigenschaft}]" required=!$showMatrix}
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
                            {block name='productdetails-variation-select-inner'}
                              {block name='productdetails-variation-select-include-variation-value'}
                                {include file='productdetails/variation_value.tpl' assign='cVariationsWert'}
                              {/block}
                              <option value="{$Variationswert->kEigenschaftWert}" class="variation"
                                data-content="<span data-value='{$Variationswert->kEigenschaftWert}'>{$cVariationsWert|trim|escape:'html'}
                                {if $Variationswert->notExists} <span class='badge bg-danger ms-2 badge-not-available'>{lang key='notAvailableInSelection'}</span>
                                {elseif !$Variationswert->inStock}<span class='badge bg-danger ms-2 badge-not-available'>{lang key='ampelRot'}</span>{/if}</span>"
                                  data-type="option"
                                  {if $Variationswert->notExists || !$Variationswert->inStock}disabled=true{/if}
                                  data-original="{$Variationswert->cName}"
                                  data-key="{$Variationswert->kEigenschaft}"
                                  data-value="{$Variationswert->kEigenschaftWert}"
                                  {if !empty($Variationswert->cBildPfadMini)}
                                    data-list='{prepare_image_details item=$Variationswert json=true}'
                                    data-title='{$Variationswert->cName}'
                                  {/if}
                                  {if isset($Variationswert->oVariationsKombi)}
                                    data-ref="{$Variationswert->oVariationsKombi->kArtikel}"
                                  {/if}
                                  {if $bSelected} selected="selected"{/if}>
                                {$cVariationsWert|trim|escape:'html'}
                              </option>
                            {/block}
                          {/if}
                        {/foreach}
                      {/select}
                    {/block}
                  </div>
                </div>
              {elseif $Variation->cTyp === 'RADIO' || $Variation->cTyp === 'IMGSWATCHES' || $Variation->cTyp === 'TEXTSWATCHES'}
                {block name='productdetails-variation-radio-outer'}
                  <div class="fs-sm">
                    {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                      {assign var=bSelected value=false}
                      {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                       {assign var=bSelected value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                      {/if}
                      {if isset($oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft])}
                        {assign var=bSelected value=$Variationswert->kEigenschaftWert == $oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft]->kEigenschaftWert}
                      {/if}
                      
                      {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) &&
                        $Artikel->nVariationOhneFreifeldAnzahl == 1 &&
                        $Einstellungen.global.artikeldetails_variationswertlager == 3 &&
                        !empty($Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar) &&
                        $Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar == 1}
                      {else}
                        {block name='productdetails-variation-radio-inner'}
                          <div class="form-check{if $Variation->cTyp === 'IMGSWATCHES'} form-option form-check-inline{/if} mb-2">
                            <input type="radio"
                            class="form-check-input{if $Variation->cTyp === 'IMGSWATCHES'} invisRadio{/if}"
                            name="eigenschaftwert[{$Variation->kEigenschaft}]"
                            id="{if isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                            value="{$Variationswert->kEigenschaftWert}"
                            {if $bSelected} checked="checked"{/if}
                            {if $Variationswert->notExists || !$Variationswert->inStock}disabled=true{/if}
                            {if $smarty.foreach.Variationswerte.index === 0 && !$showMatrix} required{/if}>
                            
                            <label class="{if $Variation->cTyp === 'IMGSWATCHES'}form-option-label rounded-circle radioLabel-size-lg{else}form-check-label{/if}"
                            for="{if isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                            data-type="radio"
                            data-url=""
                            data-original="{$Variationswert->cName}"
                            data-key="{$Variationswert->kEigenschaft}"
                            data-value="{$Variationswert->kEigenschaftWert}"
                            {if !empty($Variationswert->cBildPfadMini)}
                              data-list='{prepare_image_details item=$Variationswert json=true}'
                              data-title='{$Variationswert->cName}{if $Variationswert->notExists} - {lang key='notAvailableInSelection'}{elseif !$Variationswert->inStock} - {lang key='ampelRot'}{/if}'
                            {/if}
                            {if !$Variationswert->inStock}
                              data-stock="out-of-stock"
                            {/if}
                            {if isset($Variationswert->oVariationsKombi)}
                              data-ref="{$Variationswert->oVariationsKombi->kArtikel}"
                            {/if}
                            >
                              {block name='productdetails-variation-radio-include-variation-value'}
                                {if !empty($Variationswert->cBildPfadMini)}
                                  <span class="form-option-color rounded-circle radio-size-lg" style="background-image: url({$Variationswert->cBildPfadMini})"></span>
                                {else}
                                  {include file="productdetails/variation_value.tpl" badgeRight=true}
                                {/if}
                                {if $Variationswert->notExists}
                                  <span class='badge bg-danger ms-2 badge-not-available'>{lang key='notAvailableInSelection'}</span>
                                {elseif !$Variationswert->inStock}
                                  <span class='badge bg-danger ms-2 badge-not-available'>{lang key='ampelRot'}</span>
                                {/if}
                              {/block}
                            </label>
                            <span class="invalid-feedback">{lang key='mandatoryFieldNotification' section='errorMessages'}</span>
                          </div>
                        {/block}
                      {/if}
                    {/foreach}
                  </div>
                {/block}
              {elseif $Variation->cTyp === 'FREIFELD' || $Variation->cTyp === 'PFLICHT-FREIFELD'}
                {block name='productdetails-variation-info-variation-text'}
                  <div class="fs-sm mb-2">
                    <label for="vari-{$Variation->kEigenschaft}" class="sr-only form-label">{$Variation->cName}</label>
                    {input id="vari-{$Variation->kEigenschaft}" name='eigenschaftwert['|cat:$Variation->kEigenschaft|cat:']'
                     value=$oEigenschaftWertEdit_arr[$Variation->kEigenschaft]->cEigenschaftWertNameLocalized|default:''
                     data=['key' => $Variation->kEigenschaft] required=$Variation->cTyp === 'PFLICHT-FREIFELD'
                     class="form-control"
                     maxlength=255}
                   </div>
                {/block}
              {/if}
            </div>
          </div>
        {/foreach}
			</div>
      {inline_script}<script>
				/*
      	$(".switch-variations input[type='radio'], .switch-variations select").on("change", function(e){
					e.preventDefault();
					$(this).closest(".card").addClass("bg-faded-primary").find(".card-header .spinner-border").removeClass("d-none");
					var cardBody = $(this).closest(".card-body");
					cardBody.addClass("blr");
					cardBody.css("cursor", "wait");
					cardBody.find("*").css("cursor", "wait");
					return false;
				});
				*/
      </script>{/inline_script}
    {/block}
  {/if}
{/block}
