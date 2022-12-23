{block name='checkout-step3-shipping-options'}
    {row}
        {col cols=12 lg=12}
            {if !isset($Versandarten)}
                {block name='checkout-step3-shipping-options-alert'}
                    {alert variant="danger"}{lang key='noShippingMethodsAvailable' section='checkout'}{/alert}
                {/block}
            {else}
                {block name='checkout-step3-shipping-options-form'}
                    {form method="post" action="{get_static_route id='bestellvorgang.php'}" class="form checkout-shipping-form needs-validation" novalidate=true}
                        {block name='checkout-step3-shipping-options-fieldset-shipping-payment'}
                            <fieldset id="checkout-shipping-payment">
                                {block name='checkout-step3-shipping-options-legend-shipping-options'}
                                    <h2 class="h6 mb-2"><i class="ci-delivery me-2"></i>{lang key='fillShipping' section='checkout'}</h2>
                                {/block}
                                {block name='checkout-step3-shipping-options-shipping-address-hr'}{/block}
                                {block name='checkout-step3-shipping-options-shipping-options'}
                                    <div class="table-responsive">
                                      <table class="table table-hover fs-sm border-top">
                                        <thead>
                                          <tr>
                                            <th class="align-middle"></th>
                                            <th class="align-middle">{lang key='shippingOptions'}</th>
                                            <th class="align-middle">{lang key='shippingTime'}</th>
                                            <th class="align-middle">{lang key='handlingFee' section='custom'}</th>
                                          </tr>
                                        </thead>
                                        <tbody>
                                          {foreach $Versandarten as $versandart}
                                            {block name='checkout-step3-shipping-options-shipment'}
                                              <tr>
                                                <td class="align-middle">
                                                  <div class="form-check checkout-shipping-method m-0">
                                                    <input class="form-check-input" type="radio" value="{$versandart->kVersandart}" id="del{$versandart->kVersandart}" name="Versandart"{if $Versandarten|@count == 1 || $AktiveVersandart == $versandart->kVersandart} checked{/if}{if $versandart@first} required{/if}>
                                                  </div>
                                                </td>
                                                <td class="align-middle">
                                                	<label class="form-check-label" for="del{$versandart->kVersandart}">
                                                    {block name='checkout-step3-shipping-options-shipping-option-title'}
                                                      {block name='checkout-step3-shipping-options-shipping-option-title-image'}
                                                        {if $versandart->cBild && false}
                                                          {image fluid=true class="w-20" src=$versandart->cBild alt=$versandart->angezeigterName|trans}
                                                        {/if}
                                                      {/block}
                                                      {block name='checkout-step3-shipping-options-shipping-option-title-title'}
                                                        <span class="text-dark fw-medium">{$versandart->angezeigterName|trans}</span>
                                                        {if !empty($versandart->angezeigterHinweistext|trans)}
                                                          <br>
                                                          <span class="text-muted">{$versandart->angezeigterHinweistext|trans}</span>
                                                        {/if}
                                                      {/block}
                                                    {/block}
                                                  </label>
                                                </td>
                                                {block name='checkout-step3-shipping-options-shipping-option-info'}
                                                	<td class="align-middle">{$versandart->cLieferdauer|trans}</td>
                                                {/block}
                                                {block name='checkout-step3-shipping-options-shipping-option-price'}
                                                	<td class="align-middle">
                                                  	{$versandart->cPreisLocalized}
                                                  	{if !empty($versandart->Zuschlag->fZuschlag)}
                                                    	<br>
																											<span class="text-muted">{$versandart->Zuschlag->angezeigterName|trans} +{$versandart->Zuschlag->cPreisLocalized}</span>
																										{/if}
                                                  </td>
                                                {/block}
                                              </tr>
                                            {/block}
                                            {if isset($versandart->specificShippingcosts_arr)}
                                                <span class="checkout-shipping-form-options-specific-cost">
                                                    {foreach $versandart->specificShippingcosts_arr as $specificShippingcosts}
                                                        {block name='checkout-step3-shipping-options-shipping-option-cost'}
                                                            {row}
                                                                {col cols=8}
                                                                    <ul>
                                                                        <li>
                                                                            <small>{$specificShippingcosts->cName|trans}</small>
                                                                        </li>
                                                                    </ul>
                                                                {/col}
                                                                {col cols=4}
                                                                    <small>
                                                                        {$specificShippingcosts->cPreisLocalized}
                                                                    </small>
                                                                {/col}
                                                            {/row}
                                                        {/block}
                                                    {/foreach}
                                                </span>
                                            {/if}
                                          {/foreach}
                                        </tbody>
                                      </table>
                                    </div>
                                {/block}
                                {block name='checkout-step3-shipping-options-shipping-address-link'}
                                    <div class="checkout-shipping-form-change">
                                        {lang key='shippingTo' section='checkout'}: {$Lieferadresse->cStrasse} {$Lieferadresse->cHausnummer}, {$Lieferadresse->cPLZ} {$Lieferadresse->cOrt}, {$Lieferadresse->cLand}
                                        {button href="{get_static_route id='bestellvorgang.php'}?editLieferadresse=1"
                                            variant="link"
                                            size="sm"
                                            class="font-size-sm"
                                        }
                                            <span class="text-decoration-underline">{lang key='change'}</span>
                                            <span class="checkout-shipping-form-change-icon ci-edit-alt"></span>
                                        {/button}
                                    </div>
                                {/block}
                                
                                
                            </fieldset>
                        {/block}
                        {block name='checkout-step3-shipping-options-fieldset-payment'}
                            <fieldset id="fieldset-payment">
                                {block name='checkout-step3-shipping-options-legend-payment'}
                                    <h2 class="h6 mt-5">
                                    	<i class="ci-money-bag me-2"></i>{lang key='paymentOptions'}
                                    </h2>
                                {/block}
                                {$step4_payment_content}
                            </fieldset>
                        {/block}
                        {if isset($Verpackungsarten) && $Verpackungsarten|@count > 0}
                            {block name='checkout-step3-shipping-options-fieldset-packaging-types'}
                                <fieldset>
                                    {block name='checkout-step3-shipping-options-legend-packaging-types'}
                                        <div class="h2">{lang section='checkout' key='additionalPackaging'}</div>
                                    {/block}
                                    {block name='checkout-step3-shipping-options-legend-packaging-types-hr'}
                                        <hr>
                                    {/block}
                                    {checkboxgroup stacked=true}
                                    {foreach $Verpackungsarten as $oVerpackung}
                                        {block name='checkout-step3-shipping-options-packaging'}
                                            <div class="checkout-shipping-form-packaging">
                                                {checkbox
                                                    name="kVerpackung[]"
                                                    value=$oVerpackung->kVerpackung
                                                    id="pac{$oVerpackung->kVerpackung}"
                                                    checked=(isset($oVerpackung->bWarenkorbAktiv) && $oVerpackung->bWarenkorbAktiv === true || (isset($AktiveVerpackung[$oVerpackung->kVerpackung]) && $AktiveVerpackung[$oVerpackung->kVerpackung] === 1))
                                                }
                                                    <span class="checkout-shipping-form-packaging-title">
                                                        {$oVerpackung->cName}
                                                    </span>
                                                    <span class="checkout-shipping-form-packaging-cost price-col">
                                                        {if $oVerpackung->nKostenfrei == 1}{lang key='ExemptFromCharges'}{else}{$oVerpackung->fBruttoLocalized}{/if}
                                                    </span>
                                                    <span class="checkout-shipping-form-packaging-desc">
                                                        <small>{$oVerpackung->cBeschreibung}</small>
                                                    </span>
                                                {/checkbox}
                                            </div>
                                        {/block}
                                    {/foreach}
                                    {/checkboxgroup}
                                </fieldset>
                            {/block}
                        {/if}
                        {if isset($Versandarten)}
                            {block name='checkout-step3-shipping-options-shipping-type-submit'}
                                {input type="hidden" name="versandartwahl" value="1"}
                                {input type="hidden" name="zahlungsartwahl" value="1"}
                                <input type="submit" class="d-none" name="submitButton">
                            {/block}
                        {/if}
                    {/form}
                {/block}
            {/if}
        {/col}
    {/row}
    {if isset($smarty.get.editZahlungsart)}
        {block name='checkout-step3-shipping-options-script-scroll'}
            {inline_script}<script>
                $(document).ready(function () {
                    $.evo.extended().smoothScrollToAnchor('#fieldset-payment');
                });
            </script>{/inline_script}
        {/block}
    {/if}
{/block}
