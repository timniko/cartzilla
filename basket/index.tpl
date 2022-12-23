{block name='basket-index'}
  {block name='basket-index-include-header'}
    {include file='layout/header.tpl'}
  {/block}

  {block name='basket-index-content'}
    <div class="page-title-overlap bg-dark pt-4">
      <div class="container d-lg-flex justify-content-between py-2 py-lg-3">
        {block name='layout-header-breadcrumb'}
          {include file='layout/breadcrumb.tpl'}
        {/block}
        {block name='heading'}
          <div class="order-lg-1 pe-lg-4 text-center text-lg-start">
            <h1 class="h3 text-light mb-0">{lang key='basket'}</h1>
          </div>
        {/block}
      </div>
    </div>

    {container fluid=$Link->getIsFluid() class="pb-5 mb-2 mb-md-4 basket {if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
      {row}
        {block name='basket-index-main'}
          <section class="col-lg-8">
            {opcMountPoint id='opc_before_heading'}
						{block name='basket-index-include-extension'}
              {include file='snippets/extension.tpl'}
            {/block}
            <div class="d-flex justify-content-between align-items-center pt-3 pb-4 pb-sm-5 mt-1">
              {block name='basket-index-heading'}
                <h2 class="h6 text-light mb-0">({count($smarty.session.Warenkorb->PositionenArr)} {lang key='products'})</h2>
              {/block}
              <a class="btn btn-outline-primary btn-sm ps-2" href="{$ShopURL}"><i class="ci-arrow-left me-2"></i>{lang key='continueShopping' section='checkout'}</a>
            </div>
            {if ($Warenkorb->PositionenArr|@count > 0)}
              {block name='basket-index-basket'}
                {opcMountPoint id='opc_before_basket'}
                <div class="basket_wrapper">
                  {block name='basket-index-basket-items'}
                    {block name='basket-index-form-cart'}
                      {form id="cart-form" method="post" action="{get_static_route id='warenkorb.php'}" class="jtl-validate" slide=true}
                        {input type="hidden" name="wka" value="1"}
                        <div class="basket-items">
                          {block name='basket-index-include-order-items'}
                            {include file='basket/cart_items.tpl'}
                          {/block}
                        </div>
                        {block name='basket-index-include-uploads'}
                          {include file='snippets/uploads.tpl' tplscope='basket'}
                        {/block}
                      {/form}
                    {/block}
                    
                    {if $oArtikelGeschenk_arr|@count > 0}
                      {block name='basket-index-freegifts-content'}
                        {$selectedFreegift=0}
                        {foreach $smarty.session.Warenkorb->PositionenArr as $oPosition}
                          {if $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_GRATISGESCHENK}
                            {$selectedFreegift=$oPosition->Artikel->kArtikel}
                          {/if}
                        {/foreach}
                        {row class="basket-freegift mt-4"}
                          {col cols=12}
                            {block name='basket-index-freegifts-heading'}
                              <h2 class="h3 pb-4">{lang key='freeGiftFromOrderValueBasket'}</h2>
                            {/block}
                          {/col}
                          {col cols=12}
                            {block name='basket-index-form-freegift'}
                              {form method="post" name="freegift" action="{get_static_route id='warenkorb.php'}" class="text-center-util" slide=true}
                                {block name='basket-index-freegifts'}
                                  <div class="tns-carousel tns-controls-static tns-controls-outside">
                                    {literal}
                                      <div class="tns-carousel-inner" data-carousel-options='{"items": {/literal}{$oArtikelGeschenk_arr|@count}{literal}, "controls": true, "nav": false, "autoHeight": false, "responsive": {"0":{"items":1},"500":{"items":2, "gutter": 18},"768":{"items":3, "gutter": 20}, "1100":{"items":4, "gutter": 30}}}'>
                                    {/literal}
                                      {include file='snippets/slider_items.tpl' items=$oArtikelGeschenk_arr type='freegift'}
                                    </div>
                                  </div>
                                {/block}
                                {block name='basket-index-freegifts-form-submit'}
                                  {input type="hidden" name="gratis_geschenk" value="1"}
                                  {input name="gratishinzufuegen" type="hidden" value="{lang key='addToCart'}"}
                                {/block}
                              {/form}
                            {/block}
                          {/col}
                        {/row}
                      {/block}
                    {/if}

                    {if !empty($xselling->Kauf) && count($xselling->Kauf->Artikel) > 0}
                      {block name='basket-index-basket-xsell'}
                        {lang key='basketCustomerWhoBoughtXBoughtAlsoY' assign='panelTitle'}
                        {block name='basket-index-include-product-slider'}
                          {include file='snippets/product_slider.tpl' productlist=$xselling->Kauf->Artikel title=$panelTitle tplscope='half'}
                        {/block}
                      {/block}
                    {/if}
                    
                  {/block}
                </div>
							{/block}
            {else}
              {block name='basket-index-cart-empty'}
                {row class="basket-empty"}
                  {col}
                    {block name='basket-index-alert-empty'}
                      <div class="alert alert-info d-flex" role="alert">
                        <div class="alert-icon">
                          <i class="ci-basket"></i>
                        </div>
                        <div>{lang key='emptybasket' section='checkout'}</div>
                      </div>

                    {/block}
                    {block name='basket-index-empty-continue-shopping'}
                      {link href=$ShopURL class="btn btn-primary"}{lang key='continueShopping' section='checkout'}{/link}
                    {/block}
                  {/col}
                {/row}
              {/block}
            {/if}
          </section>
          
					<aside class="col-lg-4 pt-4 pt-lg-0 ps-xl-5">
            <div class="bg-white rounded-3 shadow-lg p-4">
              <div class="py-2 px-xl-2">
                <div class="text-center mb-4 pb-3 border-bottom">
                  {block name='basket-index-price-sticky'}
                    <div class="basket-summary-total">
                      <h2 class="h6 mb-3 pb-1">{lang key='subtotal' section='account data'}</h2>
                      <h3 class="fw-normal">{$WarensummeLocalized[0]}</h3>
                    </div>
                  {/block}
                </div>
                <div class="mb-4 pb-3 border-bottom">
                  {block name='basket-index-price-tax'}
                    {if $NettoPreise}
                      {block name='basket-index-price-net'}
                        {row class="total-net"}
                          {col class="text-left-util" cols=7}
                            <span class="price_label"><strong>{lang key='subtotal' section='account data'} ({lang key='net'}):</strong></span>
                          {/col}
                          {col class="text-right-util price-col" cols=5}
                            <strong class="price total-sum">{$WarensummeLocalized[$NettoPreise]}</strong>
                          {/col}
                        {/row}
                      {/block}
                    {/if}
                    {if $Einstellungen.global.global_steuerpos_anzeigen !== 'N' && $Steuerpositionen|@count > 0}
                      {block name='basket-index-tax'}
                        {foreach $Steuerpositionen as $Steuerposition}
                          {row class="tax"}
                            {col class="text-left-util" cols=7}
                              <span class="tax_label">{$Steuerposition->cName}:</span>
                            {/col}
                            {col class="text-right-util price-col" cols=5}
                              <span class="tax_label">{$Steuerposition->cPreisLocalized}</span>
                            {/col}
                          {/row}
                        {/foreach}
                      {/block}
                    {/if}
                    {if isset($smarty.session.Bestellung->GuthabenNutzen) && $smarty.session.Bestellung->GuthabenNutzen == 1}
                      {block name='basket-index-credit'}
                        {row class="customer-credit"}
                          {col class="text-left-util" cols=7}
                            {lang key='useCredit' section='account data'}
                          {/col}
                          {col class="text-right-util" cols=5}
                            {$smarty.session.Bestellung->GutscheinLocalized}
                          {/col}
                        {/row}
                      {/block}
                    {/if}
                    {block name='basket-index-shipping'}
                      {if $favourableShippingString !== ''}
                        <small>{$favourableShippingString}</small>
                      {/if}
                    {/block}
                  {/block}
                </div>
								{if ($Warenkorb->PositionenArr|@count > 0)}
                  {if $Einstellungen.kaufabwicklung.warenkorb_kupon_anzeigen === 'Y'}
                    {$expand="promo"}
                    {if (isset($Versandland) && isset($VersandPLZ)) && (!empty($Versandland) && !empty($VersandPLZ))}
                      {$expand="shipping"}
                    {/if}
                    {block name='basket-index-coupon'}
                      <div class="accordion" id="order-options">
                        <div class="accordion-item">
                          {block name='basket-index-coupon-heading'}
                            <h3 class="accordion-header">
                              <a class="accordion-button{if $expand !== 'promo'} collapsed{/if}" href="#promo-code" role="button" data-bs-toggle="collapse" aria-expanded="{if $expand === 'promo'}true{else}false{/if}" aria-controls="promo-code">
                                {lang key='useCoupon' section='checkout'}
                              </a>
                            </h3>
                          {/block}
                          <div class="accordion-collapse collapse{if $expand === 'promo'} show{/if}" id="promo-code" data-bs-parent="#order-options">
                            {if $KuponMoeglich == 1}
                              {block name='basket-index-coupon-available'}
                                {block name='basket-index-coupon-form'}
                                  {form class="accordion-body needs-validation" id="basket-coupon-form" method="post" action="{get_static_route id='warenkorb.php'}" slide=true novalidate=true}
                                    <div class="mb-3">
                                      {input class="form-control" aria=["label"=>"{lang key='couponCode' section='account data'}"] type="text" name="Kuponcode" id="couponCode" maxlength="32" placeholder=" " required=true}
                                      <div class="invalid-feedback">Please provide promo code.</div>
                                    </div>
                                    {button type="submit" value=1 variant="outline-primary" class="d-block w-100" block=true}{lang key='couponSubmit' section='checkout'}{/button}
                                  {/form}
                                {/block}
                              {/block}
                            {else}
                              {block name='basket-index-coupon-unavailable'}
                                <div class="p-3">
                                  {lang key='couponUnavailable' section='checkout'}
                                </div>
                              {/block}
                            {/if}
                          </div>
                        </div>
                      </div>
                    {/block}
                  {/if}
                  
                  {if $Einstellungen.kaufabwicklung.warenkorb_versandermittlung_anzeigen === 'Y'}
                    {block name='basket-index-form-shipping-calc'}
                      {opcMountPoint id='opc_before_shipping_calculator'}
                      <div class="accordion-item">
                        {block name='snippets-shipping-calculator-estimate'}
                          <h3 class="accordion-header">
                            <a class="accordion-button{if $expand !== 'shipping'} collapsed{/if}" href="#shipping-estimates" role="button" data-bs-toggle="collapse" aria-expanded="{if $expand === 'shipping'}true{else}false{/if}" aria-controls="shipping-estimates">{lang key='estimateShippingCostsTo' section='checkout'}</a>
                          </h3>
                        {/block}
                        <div class="accordion-collapse collapse{if $expand === 'shipping'} show{/if}" id="shipping-estimates" data-bs-parent="#order-options">
                          <div class="accordion-body">
                            {form id="basket-shipping-estimate-form" class="shipping-calculator-form needs-validation" method="post" action="{get_static_route id='warenkorb.php'}#basket-shipping-estimate-form" slide=true novalidation=true}
                              {block name='basket-index-include-shipping-calculator'}
                                {include file='snippets/shipping_calculator.tpl' checkout=true hrAtEnd=false}
                              {/block}
                            {/form}
                          </div>
                        </div>
                      </div>
                    {/block}
                  {/if}
								{/if}
              </div>
              {if ($Warenkorb->PositionenArr|@count > 0)}
                {block name='basket-index-proceed-button'}
                  {link id="cart-checkout-btn" href="{get_static_route id='bestellvorgang.php'}?wk=1" class="btn btn-primary btn-shadow d-block w-100 mt-4"}
                    <i class="ci-card fs-lg me-2"></i>{lang key='nextStepCheckout' section='checkout'}
                  {/link}
                {/block}
              {/if}
              
              {if !empty($WarenkorbVersandkostenfreiHinweis) && $Warenkorb->PositionenArr|@count > 0}
                {block name='basket-index-alert'}
                  <div class="basket-summary-notice basket-summary-top mt-4">
                    <i class="ci-delivery me-2"></i>
                    <small class="basket_notice">{$WarenkorbVersandkostenfreiHinweis}</small>
                  </div>
                {/block}
              {/if}
              {if $Einstellungen.kaufabwicklung.warenkorb_gesamtgewicht_anzeigen === 'Y'}
                {block name='basket-index-notice-weight'}
                  <div class="basket-summary-notice-weight-wrapper mt-4{if empty($WarenkorbVersandkostenfreiHinweis)} basket-summary-top{else} border-top{/if}">
                    <i class="ci-scale me-2"></i>
                    <small class="basket-summary-notice-weight">{lang key='cartTotalWeight' section='basket' printf=$WarenkorbGesamtgewicht}</small>
                  </div>
                {/block}
              {/if}
            </div>
          </aside>
				{/block}
      {/row}
    {/container}
  {/block}

  {block name='basket-index-include-footer'}
    {include file='layout/footer.tpl'}
  {/block}
{/block}
