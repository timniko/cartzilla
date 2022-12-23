{block name='checkout-index'}
  {block name='checkout-index-include-header'}
    {if !isset($bAjaxRequest) || !$bAjaxRequest}
      {include file='layout/header.tpl'}
    {/if}
  {/block}

  {block name='checkout-index-content'}
  	{if !isset($bAjaxRequest) || !$bAjaxRequest}
      <!-- Page Title-->
      <div class="page-title-overlap bg-dark pt-4">
        <div class="container d-lg-flex justify-content-between py-2 py-lg-3">
          {block name='layout-header-breadcrumb'}
            {include file='layout/breadcrumb.tpl'}
          {/block}
          <div class="order-lg-1 pe-lg-4 text-center text-lg-start">
            <h1 class="h3 text-light mb-0">{lang key='checkout' section='breadcrumb'}</h1>
          </div>
        </div>
      </div>
    {/if}

    <div id="result-wrapper" data-wrapper="true">
      {container fluid=$Link->getIsFluid() id="checkout" class="pb-5 mb-2 mb-md-4"}
        <div class="row">
          <section class="col-lg-8">
            {block name='checkout-index-include-inc-steps'}
              {include file='checkout/inc_steps.tpl'}
            {/block}
            {block name='checkout-index-include-extension'}
                {include file='snippets/extension.tpl'}
            {/block}
            {if $step === 'accountwahl'}
                {include file='checkout/step0_login_or_register.tpl'}{*bestellvorgang_accountwahl.tpl*}
            {elseif $step === 'edit_customer_address' || $step === 'Lieferadresse'}
                {include file='checkout/step1_edit_customer_address.tpl'}{*bestellvorgang_unregistriert_formular.tpl*}
            {elseif $step === 'Versand' || $step === 'Zahlung'}
                {include file='checkout/step3_shipping_options.tpl'}{*bestellvorgang_versand.tpl*}
            {elseif $step === 'ZahlungZusatzschritt'}
                {include file='checkout/step4_payment_additional.tpl'}{*bestellvorgang_zahlung_zusatzschritt*}
            {elseif $step === 'Bestaetigung'}
                {include file='checkout/step5_confirmation.tpl'}{*bestellvorgang_bestaetigung*}
            {/if}
            <div class="d-none d-lg-flex pt-4 mt-3">
              <div class="w-50 pe-3">
                <a class="btn btn-secondary d-block w-100" href="javascript:history.back()">
                  <i class="ci-arrow-left mt-sm-0 me-1"></i>
                  <span class="d-none d-sm-inline">{lang key='back'}</span>
                  <span class="d-inline d-sm-none">{lang key='back'}</span>
                </a>
              </div>
              <div class="w-50 ps-2">
                <a class="btn btn-primary d-block w-100 cCheckout" href="#">
                  <span class="d-none d-sm-inline">
                  	{if $step === 'Bestaetigung'}
                      {lang key='orderLiableToPay' section='checkout'}
                    {else}
                      {lang key='continueOrder' section='account data'}
                    {/if}
                  </span>
                  <span class="d-inline d-sm-none">
                    {if $step === 'Bestaetigung'}
                      {lang key='orderLiableToPay' section='checkout'}
                    {else}
                      {lang key='continueOrder' section='account data'}
                    {/if}
                  </span>
                  <i class="ci-{if $step === 'Bestaetigung'}check{else}arrow-right{/if} mt-sm-0 ms-1"></i>
                </a>
              </div>
            </div>
          </section>
          
          <aside class="col-lg-4 pt-4 pt-lg-0 ps-xl-5">
            <div class="bg-white rounded-3 shadow-lg p-4 ms-lg-auto">
              <div class="py-2 px-xl-2">
                <div class="widget mb-3">
                  <h2 class="widget-title text-center">{lang key='summary' section='checkout'}</h2>
                  {foreach $smarty.session.Warenkorb->PositionenArr as $oPosition}
                    {$posName=$oPosition->cName|trans|escape:'html'}
                    <div class="d-flex align-items-center py-2 border-bottom">
                      {if !empty($oPosition->Artikel->cVorschaubild)}
                        {link href=$oPosition->Artikel->cURLFull title=$posName class="d-block flex-shrink-0"}
                          {image lazy=true
                            webp=true
                            src=$oPosition->Artikel->cVorschaubild
                            alt=$posName
                            fluid-grow=false
                            width="64px"
                          }
                        {/link}
                      {else}
                        <div class="d-block flex-shrink-0">
                          <div class="position-relative" style="width: 64px;">
                            <div class="card-img ratio ratio-4x3 bg-secondary"></div>
                            <i class="ci-{if $oPosition->nPosTyp === 2}delivery{else if $oPosition->nPosTyp === 3}discount{else if $oPosition->nPosTyp === 4}percent{else if $oPosition->nPosTyp === 5}money-bag{else if $oPosition->nPosTyp === 11}gift{else}image{/if} position-absolute top-50 start-50 translate-middle fs-1 text-muted opacity-50"></i>
                          </div>
                        </div>
                      {/if}
                      <div class="ps-2">
                        <h6 class="widget-product-title">
                        	{if $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL || $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_GRATISGESCHENK}
                            {link class="cart-items-name" href=$oPosition->Artikel->cURLFull title=$posName}
                              {$oPosition->cName|trans}
                            {/link}
                          {else}
                          	<span class="cart-items-name">{$oPosition->cName|trans}{if isset($oPosition->discountForArticle)}{$oPosition->discountForArticle|trans}{/if}</span>
                          {/if}
                        </h6>
                        <div class="widget-product-meta">
                          <span class="text-accent me-1 h6">
                            {if $oPosition->istKonfigVater()}
                              {$oPosition->cKonfigpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                            {else}
                              {$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                            {/if}
                          </span>
                          <span class="text-muted">x {$oPosition->nAnzahl|replace_delim} {if !empty($oPosition->Artikel->cEinheit)}{$oPosition->Artikel->cEinheit}{/if}</span>
                          {if isset($oPosition->Artikel->cGewicht)}
                            <div class="d-block fs-xs">
                              <span class="me-2">{lang key='shippingWeight'}:</span>
                              <span class="value">{$oPosition->Artikel->cGewicht} {lang key='weightUnit'}</span>
                            </div>
                          {/if}
                        </div>
                      </div>
                    </div>
                  {/foreach}
                </div>
                <ul class="list-unstyled fs-sm pb-2 border-bottom">
                  <li class="d-flex justify-content-between align-items-center">
                    <span class="me-2">{lang key='subtotal' section='account data'}:</span>
                    <span class="text-end">{$WarensummeLocalized[0]}</span>
                  </li>
                  {if $Einstellungen.global.global_steuerpos_anzeigen !== 'N' && $Steuerpositionen|@count > 0}
                    {foreach $Steuerpositionen as $Steuerposition}
                      <li class="d-flex justify-content-between align-items-center">
                        <span class="me-2">{$Steuerposition->cName}:</span>
                        <span class="text-end">{$Steuerposition->cPreisLocalized}</span>
                      </li>
                    {/foreach}
                  {/if}
                </ul>
                <h3 class="fw-normal text-center my-4">
                	{if $step === 'Bestaetigung'}
                  	<span class="d-block lead">{lang key='totalSum'}</span>
                  {/if}
									{$WarenkorbGesamtsumme[0]}
                </h3>
                {block name='basket-index-coupon-available'}
                  {block name='basket-index-coupon-form'}
                    {form class="accordion-body needs-validation" id="basket-coupon-form" method="post" action="{get_static_route id='warenkorb.php'}" slide=true novalidate=true}
                      <div class="mb-3">
                        {input class="form-control" aria=["label"=>"{lang key='couponCode' section='account data'}"] type="text" name="Kuponcode" id="couponCode" maxlength="32" placeholder="{lang key='useCoupon' section='checkout'}" required=true}
                        <div class="invalid-feedback">Please provide promo code.</div>
                      </div>
                      {button type="submit" value=1 variant="outline-primary" class="d-block w-100" block=true}{lang key='couponSubmit' section='checkout'}{/button}
                    {/form}
                  {/block}
                {/block}
              </div>
            </div>
          </aside>
          
        </div>
        <!-- Navigation (mobile)-->
        <div class="row d-lg-none">
          <div class="col-lg-8">
            <div class="d-flex pt-4 mt-3">
              <div class="w-50 pe-3">
                <a class="btn btn-secondary d-block w-100" href="javascript:history.back()">
                  <i class="ci-arrow-left mt-sm-0 me-1"></i>
                  <span class="d-none d-sm-inline">{lang key='back'}</span>
                  <span class="d-inline d-sm-none">{lang key='back'}</span>
                </a>
              </div>
              <div class="w-50 ps-2">
                <a class="btn btn-primary d-block w-100 cCheckout" href="#">
                  <span class="d-none d-sm-inline">
                  	{if $step === 'Bestaetigung'}
                      {lang key='orderLiableToPay' section='checkout'}
                    {else}
                      {lang key='continueOrder' section='account data'}
                    {/if}
                  </span>
                  <span class="d-inline d-sm-none">
                  	{if $step === 'Bestaetigung'}
                      {lang key='orderLiableToPay' section='checkout'}
                    {else}
                      {lang key='continueOrder' section='account data'}
                    {/if}
                  </span>
                  <i class="ci-{if $step === 'Bestaetigung'}check{else}arrow-right{/if} mt-sm-0 ms-1"></i>
                </a>
              </div>
            </div>
          </div>
        </div>
      {/container}
    </div>
    {inline_script}<script>
    	$("a.cCheckout").on("click", function(e){
				e.preventDefault();
				if($("input[name='submitButton']").length){
					$("input[name='submitButton']").trigger("click");
				}else{
					if($("#form-register").length){
						$("#form-register").submit();
					}
				}
				return false;
			});
    </script>{/inline_script}
    {if (isset($nWarenkorb2PersMerge) && $nWarenkorb2PersMerge === 1)}
      {block name='checkout-index-script-basket-merge'}
        {inline_script}<script>
					$(window).on('load', function() {
						$(function() {
							eModal.addLabel('{lang key='yes' section='global'}', '{lang key='no' section='global'}');
							var options = {
								message: '{lang key='basket2PersMerge' section='login'}',
								label: '{lang key='yes' section='global'}',
								title: '{lang key='basket' section='global'}'
							};
							eModal.confirm(options).then(
								function() {
									window.location = "{get_static_route id='bestellvorgang.php'}?basket2Pers=1&token={$smarty.session.jtl_token}"
								}
							);
						});
					});
        </script>{/inline_script}
      {/block}
    {/if}
    {block name='checkout-index-script-location'}
			<script>
				if (top.location !== self.location) {
					top.location = self.location.href;
				}
      </script>
    {/block}
  {/block}

  {block name='checkout-index-include-footer'}
    {if !isset($bAjaxRequest) || !$bAjaxRequest}
      {include file='layout/footer.tpl'}
    {/if}
  {/block}
{/block}