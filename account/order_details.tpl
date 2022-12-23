{block name='account-order-details'}
  {block name='account-order-details-script-location'}
		<script>
			if (top.location !== self.location){
				top.location = self.location.href;
			}
    </script>
  {/block}
  {block name='account-order-details-order-details-data'}
    <div class="card">
      <div class="card-header fs-sm bg-info text-white">
        <i class="ci-calendar me-2"></i>{$Bestellung->dErstelldatum_de}
      </div>
      <div class="card-body">
        {if isset($Kunde) && $Kunde->kKunde > 0}
          {block name='account-order-details-payment'}
            <span class="fs-5 fw-bold">{lang key='paymentOptions' section='global'}</span>
            <ul class="list-group list-group-flush">
              <li class="list-group-item">
                <span class="fw-bold">{$Bestellung->cZahlungsartName}:</span>
                {if ($Bestellung->cStatus == BESTELLUNG_STATUS_OFFEN || $Bestellung->cStatus == BESTELLUNG_STATUS_IN_BEARBEITUNG)
                  && (($Bestellung->Zahlungsart->cModulId !== 'za_ueberweisung_jtl'
                  && $Bestellung->Zahlungsart->cModulId !== 'za_nachnahme_jtl'
                  && $Bestellung->Zahlungsart->cModulId !== 'za_rechnung_jtl'
                  && $Bestellung->Zahlungsart->cModulId !== 'za_barzahlung_jtl')
                  && (isset($Bestellung->Zahlungsart->bPayAgain) && $Bestellung->Zahlungsart->bPayAgain))}
                  {link href="{get_static_route id='bestellab_again.php'}?kBestellung={$Bestellung->kBestellung}"}{lang key='payNow' section='global'}{/link}
                {else}
                  {lang key='notPayedYet' section='login'}
                {/if}
              </li>
              {foreach $incommingPayments as $paymentProvider => $incommingPayment}
                <li class="list-group-item">
                  <span class="fw-bold">{$paymentProvider|htmlentities}</span>
                  <ul class="list-group list-group-flush">
                    {foreach $incommingPayment as $payment}
                      <li class="list-group-item">{$payment->paymentLocalization}</li>
                    {/foreach}
                  </ul>
                </li>
              {/foreach}
            </ul>
          {/block}
          {block name='account-order-details-shipping'}
            <span class="fs-5 fw-bold">{lang key='shippingOptions' section='global'}</span>
            <ul class="list-group list-group-flush">
              <li class="list-group-item"><span class="fw-bold">{$Bestellung->cVersandartName}</span>
                <ul class="list-group list-group-flush">
                  {if $Bestellung->cStatus == BESTELLUNG_STATUS_VERSANDT}
                    <li class="list-group-item"><i class="ci-delivery me-2"></i>{lang key='shippedOn' section='login'} {$Bestellung->dVersanddatum_de}</li>
                  {elseif $Bestellung->cStatus == BESTELLUNG_STATUS_TEILVERSANDT}
                    <li class="list-group-item"><i class="ci-delivery me-2"></i>{$Bestellung->Status}</li>
                  {else}
                    <li class="list-group-item"><span>{lang key='notShippedYet' section='login'}</span></li>
                    {if $Bestellung->cStatus != BESTELLUNG_STATUS_STORNO}
                      <li class="list-group-item">
                        <span>{lang key='shippingTime' section='global'}: {if isset($cEstimatedDeliveryEx)}{$cEstimatedDeliveryEx}{else}{$Bestellung->cEstimatedDelivery}{/if}</span>
                      </li>
                    {/if}
                  {/if}
                </ul>
              </li>
            </ul>
          {/block}
          <div class="row">
            <div class="col-12">
              {block name='account-order-details-billing-address'}
                <div class="fs-5 fw-bold">{lang key='billingAdress' section='checkout'}</div>
                {block name='account-order-details-include-inc-billing-address'}
                  {include file='checkout/inc_billing_address.tpl' orderDetail=true}
                {/block}
              {/block}
            </div>
            <div class="col-12">
              {block name='account-order-details-shipping-address'}
                <div class="fs-5 fw-bold">{lang key='shippingAdress' section='checkout'}</div>
                {if !empty($Lieferadresse->kLieferadresse)}
                  {block name='account-order-details-include-inc-delivery-address'}
                    {include file='checkout/inc_delivery_address.tpl' orderDetail=true}
                  {/block}
                {else}
                  {lang key='shippingAdressEqualBillingAdress' section='account data'}
                {/if}
              {/block}
            </div>
            <div class="col-12 mt-2">
              {block name='account-order-details-order-subheading-basket'}
                <div class="fs-5 fw-bold">{lang key='basket'}</div>
              {/block}
              {block name='account-order-details-include-order-item'}
                <div class="d-sm-flex align-items-center my-2 pb-3 flex-wrap">
                  <div class="row">
                    {foreach $Bestellung->Positionen as $oPosition}
                      <div class="col-12 mb-2">
                        {block name='account-order-item-items-data'}
													{if $oPosition->nPosTyp == $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL}
                            <div class="d-block d-sm-flex align-items-center text-center text-sm-start">
                              {block name='account-order-item-image'}
                                {if isset($oPosition->Artikel->cURLFull)}
                                  <a href="{$oPosition->Artikel->cURLFull}" title="{$oPosition->cName|trans|escape:'html'}" class="d-inline-block me-sm-4">
                                    {if !empty($oPosition->Artikel->cVorschaubild)}
                                      {image webp=true fluid=true lazy=true
                                        src=$oPosition->Artikel->cVorschaubild
                                        alt=$oPosition->cName|trans|escape:'html'
                                        style="min-width: 100px;"
                                      }
                                    {else}
                                      <div style="min-width: 100px;" class="me-sm-4">
                                        <div class="position-relative">
                                          <div class="card-img ratio ratio-4x3 bg-secondary"></div>
                                          <i class="ci-{if $oPosition->nPosTyp === 2}delivery{else if $oPosition->nPosTyp === 3}discount{else if $oPosition->nPosTyp === 4}percent{else if $oPosition->nPosTyp === 5}money-bag{else if $oPosition->nPosTyp === 11}gift{else}image{/if} position-absolute top-50 start-50 translate-middle fs-1 text-muted opacity-50"></i>
                                        </div>
                                      </div>
                                    {/if}
                                  </a>
                                {else}
                                  <div style="min-width: 100px;" class="me-sm-4">
                                    <div class="position-relative">
                                      <div class="card-img ratio ratio-4x3 bg-secondary"></div>
                                      <i class="ci-{if $oPosition->nPosTyp === 2}delivery{else if $oPosition->nPosTyp === 3}discount{else if $oPosition->nPosTyp === 4}percent{else if $oPosition->nPosTyp === 5}money-bag{else if $oPosition->nPosTyp === 11}gift{else}image{/if} position-absolute top-50 start-50 translate-middle fs-1 text-muted opacity-50"></i>
                                    </div>
                                  </div>
                                {/if}
                              {/block}
                              <div class="p-2">
                                <h3 class="product-title fs-base mb-2">
                                  {if isset($oPosition->Artikel->cURLFull)}
                                    <a href="{$oPosition->Artikel->cURLFull}" title="{$oPosition->cName|trans|escape:'html'}">{$oPosition->cName|trans|escape:'html'}</a>
                                  {else}
                                    <span class="">{$oPosition->cName|trans|escape:'html'}</span>
                                  {/if}
                                </h3>
                                <ul class="list-unstyled text-muted-util small item-detail-list">
                                  {block name='account-order-item-sku'}
                                    <li class="sku">{lang key='productNo' section='global'}: {$oPosition->Artikel->cArtNr}</li>
                                  {/block}
                                  {if isset($oPosition->Artikel->dMHD, $oPosition->Artikel->dMHD_de)}
                                    {block name='account-order-item-mhd'}
                                      <li title="{lang key='productMHDTool' section='global'}" class="best-before">
                                        {lang key='productMHD' section='global'}:{$oPosition->Artikel->dMHD_de}
                                      </li>
                                    {/block}
                                  {/if}
                                  {if $oPosition->Artikel->cLocalizedVPE && $oPosition->Artikel->cVPE !== 'N'}
                                    {block name='account-order-item-base-price'}
                                      <li class="baseprice">{lang key='basePrice' section='global'}:{$oPosition->Artikel->cLocalizedVPE[$NettoPreise]}</li>
                                    {/block}
                                  {/if}
                                  {if $Einstellungen.kaufabwicklung.warenkorb_varianten_varikombi_anzeigen === 'Y' && isset($oPosition->WarenkorbPosEigenschaftArr) && !empty($oPosition->WarenkorbPosEigenschaftArr)}
                                    {block name='account-order-item-variations'}
                                      {foreach $oPosition->WarenkorbPosEigenschaftArr as $Variation}
                                        <li class="variation">
                                          {$Variation->cEigenschaftName|trans}: {$Variation->cEigenschaftWertName|trans} {if !empty($Variation->cAufpreisLocalized[$NettoPreise])}&raquo;
                                            {if $Variation->cAufpreisLocalized[$NettoPreise]|substr:0:1 !== '-'}+{/if}{$Variation->cAufpreisLocalized[$NettoPreise]} {/if}
                                        </li>
                                      {/foreach}
                                    {/block}
                                  {/if}
                                  {if !empty($oPosition->cHinweis)}
                                    {block name='account-order-item-notice'}
                                      <li class="text-info notice">{$oPosition->cHinweis}</li>
                                    {/block}
                                  {/if}

                                  {* Buttonloesung eindeutige Merkmale *}
                                  {if $oPosition->Artikel->cHersteller && $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen != "N"}
                                    {block name='account-order-item-manufacturer'}
                                      <li class="manufacturer">
                                        {lang key='manufacturer' section='productDetails'}:
                                        <span class="values">
                                         {$oPosition->Artikel->cHersteller}
                                        </span>
                                      </li>
                                    {/block}
                                  {/if}

                                  {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelmerkmale == 'Y' && !empty($oPosition->Artikel->oMerkmale_arr)}
                                    {block name='account-order-item-characteristics'}
                                      {foreach $oPosition->Artikel->oMerkmale_arr as $oMerkmale_arr}
                                        <li class="characteristic">
                                          {$oMerkmale_arr->cName}:
                                          <span class="values">
                                            {foreach $oMerkmale_arr->oMerkmalWert_arr as $oWert}
                                              {if !$oWert@first}, {/if}
                                              {$oWert->cWert}
                                            {/foreach}
                                          </span>
                                        </li>
                                      {/foreach}
                                    {/block}
                                  {/if}

                                  {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelattribute == 'Y' && !empty($oPosition->Artikel->Attribute)}
                                    {block name='account-order-item-attributes'}
                                      {foreach $oPosition->Artikel->Attribute as $oAttribute_arr}
                                        <li class="attribute">
                                          {$oAttribute_arr->cName}:
                                          <span class="values">
                                            {$oAttribute_arr->cWert}
                                          </span>
                                        </li>
                                      {/foreach}
                                    {/block}
                                  {/if}

                                  {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelkurzbeschreibung == 'Y' && $oPosition->Artikel->cKurzBeschreibung|strlen > 0}
                                    {block name='account-order-item-short-desc'}
                                      <li class="shortdescription">{$oPosition->Artikel->cKurzBeschreibung}</li>
                                    {/block}
                                  {/if}
                                  {block name='account-order-item-delivery-status'}
                                    <li class="delivery-status">{lang key='orderStatus' section='login'}:
                                      <strong>
                                        {if $oPosition->bAusgeliefert}
                                          {lang key='statusShipped' section='order'}
                                        {elseif $oPosition->nAusgeliefert > 0}
                                          {if $oPosition->cUnique|strlen == 0}{lang key='statusShipped' section='order'}: {$oPosition->nAusgeliefertGesamt}{else}{lang key='statusPartialShipped' section='order'}{/if}
                                        {else}
                                          {lang key='notShippedYet' section='login'}
                                        {/if}
                                      </strong>
                                    </li>
                                  {/block}
                                </ul>
                                {block name='account-order-item-price-overall'}
                                  <div class="fs-lg text-accent pt-2">
                                    {if is_string($oPosition->cUnique) && !empty($oPosition->cUnique) && (int)$oPosition->kKonfigitem === 0}
                                      {$oPosition->cKonfigpreisLocalized[$NettoPreise]}
                                    {else}
                                      {$oPosition->cGesamtpreisLocalized[$NettoPreise]}
                                    {/if}
                                  </div>
                                {/block}
															</div>
                            </div>
													{else}
                            {block name='account-order-item-details-not-product'}
                              <div class="d-block d-sm-flex text-center text-sm-start">
                                <div style="min-width: 100px;" class="me-sm-4">
                                  <div class="position-relative">
                                    <div class="card-img ratio ratio-4x3 bg-secondary"></div>
                                    <i class="ci-{if $oPosition->nPosTyp === 2}delivery{else if $oPosition->nPosTyp === 3}discount{else if $oPosition->nPosTyp === 4}percent{else if $oPosition->nPosTyp === 5}money-bag{else if $oPosition->nPosTyp === 11}gift{else}image{/if} position-absolute top-50 start-50 translate-middle fs-1 text-muted opacity-50"></i>
                                  </div>
                                </div>
                                <div class="p-2">
                                  <h3 class="product-title fs-base mb-2">
                                    {$oPosition->cName|trans}
                                    {if isset($oPosition->discountForArticle)}
                                      {$oPosition->discountForArticle|trans}
                                    {/if}
                                  </h3>
                                  {if isset($oPosition->cArticleNameAffix)}
                                    {if is_array($oPosition->cArticleNameAffix)}
                                      <ul class="small text-muted-util">
                                        {foreach $oPosition->cArticleNameAffix as $cArticleNameAffix}
                                          <li>{$cArticleNameAffix|trans}</li>
                                        {/foreach}
                                      </ul>
                                    {else}
                                      <ul class="small text-muted-util">
                                        <li>{$oPosition->cArticleNameAffix|trans}</li>
                                      </ul>
                                    {/if}
                                  {/if}
                                  {if !empty($oPosition->cHinweis)}
                                    <small class="text-info notice">{$oPosition->cHinweis}</small>
                                  {/if}
                                </div>
                              </div>
                            {/block}
													{/if}
                        {/block}
                      </div>
                    {/foreach}
                  </div>
                </div>
              {/block}
            </div>
            {block name='account-order-items-total-wrapper'}
              <div class="col-12 mt-2">
                {row}
                  {col xl=5 md=6 class='order-items-total'}
                    {block name='account-order-items-total'}
                      {if $NettoPreise}
                        {block name='account-order-items-total-price-net'}
                          {row class="total-net"}
                            {col }
                              <span class="price_label"><strong>{lang key='totalSum'} ({lang key='net'}):</strong></span>
                            {/col}
                            {col class="col-auto price-col"}
                              <strong class="price total-sum">{$Bestellung->WarensummeLocalized[1]}</strong>
                            {/col}
                          {/row}
                        {/block}
                      {/if}
                      {if $Bestellung->GuthabenNutzen == 1}
                        {block name='account-order-items-total-customer-credit'}
                          {row class="customer-credit"}
                            {col}
                              {lang key='useCredit' section='account data'}
                            {/col}
                            {col class="col-auto ml-auto-util text-right-util"}
                              {$Bestellung->GutscheinLocalized}
                            {/col}
                          {/row}
                        {/block}
                      {/if}
                      {if $Einstellungen.global.global_steuerpos_anzeigen !== 'N'}
                        {block name='account-order-items-total-tax'}
                          {foreach $Bestellung->Steuerpositionen as $taxPosition}
                            {row class="tax"}
                              {col}
                                <span class="tax_label">{$taxPosition->cName}:</span>
                              {/col}
                              {col class="col-auto price-col"}
                                <span class="tax_label">{$taxPosition->cPreisLocalized}</span>
                              {/col}
                            {/row}
                          {/foreach}
                        {/block}
                      {/if}
                      {block name='account-order-items-total-total'}
                        <hr>
                        {row}
                          {col}
                            <span class="price_label"><strong>{lang key='totalSum'} {if $NettoPreise}{lang key='gross' section='global'}{/if}:</strong></span>
                          {/col}
                          {col class="col-auto price-col"}
                            <strong class="price total-sum">{$Bestellung->WarensummeLocalized[0]}</strong>
                          {/col}
                        {/row}
                      {/block}
                      {if !empty($Bestellung->OrderAttributes)}
                        {block name='account-order-items-total-order-attributes'}
                          {foreach $Bestellung->OrderAttributes as $attribute}
                            {if $attribute->cName === 'Finanzierungskosten'}
                              {row class="type-{$smarty.const.C_WARENKORBPOS_TYP_ZINSAUFSCHLAG}"}
                                {block name='account-order-items-finance-costs'}
                                  {col}
                                    {lang key='financeCosts' section='order'}
                                  {/col}
                                {/block}
                                {block name='account-order-items-finance-costs-value'}
                                  {col class="col-auto price-col"}
                                    <strong class="price_overall">
                                      {$attribute->cValue}
                                    </strong>
                                  {/col}
                                {/block}
                              {/row}
                            {/if}
                          {/foreach}
                        {/block}
                      {/if}
                    {/block}
                  {/col}
                {/row}
              </div>
            {/block}
          </div>
        {else}
          {block name='account-order-details-request-plz'}
            {row}
              {col cols=12 md=6}
                {form method="post" id='request-plz' action="{get_static_route}" class="jtl-validate" slide=true}
                  {input type="hidden" name="uid" value="{$uid}"}
                  <p>{lang key='enter_plz_for_details' section='account data'}</p>
                  {formgroup
                      label-for="postcode"
                      label={lang key='plz' section='account data'}
                  }
                    {input
                      type="text"
                      name="plz"
                      value=""
                      id="postcode"
                      class="postcode_input"
                      placeholder=" "
                      required=true
                      autocomplete="billing postal-code"
                    }
                  {/formgroup}
                  {row}
                    {col class='ml-auto-util col-md-auto'}
                      {button type='submit' value='1' block=true variant='primary' class='mb-3'}
                        {lang key='view' section='global'}
                      {/button}
                    {/col}
                  {/row}
                {/form}
              {/col}
              {col cols=12 md=9}
                {block name='account-order-details-order-subheading-basket'}
                  <span class="subheadline">{lang key='basket'}</span>
                {/block}
                {block name='account-order-details-include-order-item'}
                  {include file='account/order_item.tpl' tplscope='confirmation'}
                {/block}
              {/col}
            {/row}
          {/block}
        {/if}
      </div>
    </div>
  {/block}

  {if isset($Kunde) && $Kunde->kKunde > 0}
    {block name='account-order-details-include-downloads'}
      {include file='account/downloads.tpl'}
    {/block}
    {block name='account-order-details-include-uploads'}
      {include file='account/uploads.tpl'}
    {/block}

    {if $Bestellung->oLieferschein_arr|@count > 0}
      {block name='account-order-details-delivery-note-content'}
        <div class="h2 mt-5">{if $Bestellung->cStatus == BESTELLUNG_STATUS_TEILVERSANDT}{lang key='partialShipped' section='order'}{else}{lang key='shipped' section='order'}{/if}</div>
        <div class="table-responsive mb-3">
          <table class="table table-striped table-bordered">
            <thead>
              {block name='account-order-details-delivery-note-header'}
                <tr>
                  <th>{lang key='shippingOrder' section='order'}</th>
                  <th>{lang key='shippedOn' section='login'}</th>
                  <th class="text-right-util">{lang key='packageTracking' section='order'}</th>
                </tr>
              {/block}
            </thead>
            <tbody>
              {block name='account-order-details-delivery-notes'}
                {foreach $Bestellung->oLieferschein_arr as $oLieferschein}
                  <tr>
                    <td>
                      <a href="#shipping-order-{$oLieferschein->getLieferschein()}" title="tntAI10060DEV-001" id="{$oLieferschein->getLieferschein()}" data-bs-toggle="modal" title="{$oLieferschein->getLieferscheinNr()}">
                        {$oLieferschein->getLieferscheinNr()}
                      </a>
                    </td>
                    <td>{$oLieferschein->getErstellt()|date_format:"%d.%m.%Y %H:%M"}</td>
                    <td class="text-right-util">
                      {foreach $oLieferschein->oVersand_arr as $oVersand}
                        {if $oVersand->getIdentCode()}
                          <p>{link href=$oVersand->getLogistikVarUrl() target="_blank" class="shipment" title=$oVersand->getIdentCode()}{lang key='packageTracking' section='order'}{/link}</p>
                        {/if}
                      {/foreach}
                    </td>
                  </tr>
                {/foreach}
              {/block}
            </tbody>
          </table>
        </div>

        {* Lieferschein Popups *}
        {foreach $Bestellung->oLieferschein_arr as $oLieferschein}
          {block name='account-order-details-delivery-note-popup'}
            <div class="modal fade" tabindex="-1" role="dialog" id="shipping-order-{$oLieferschein->getLieferschein()}">
              <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title">{(($Bestellung->cStatus == BESTELLUNG_STATUS_TEILVERSANDT) ? {lang key='partialShipped' section='order'} : {lang key='shipped' section='order'})}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='close' section='consent'}"></button>
                  </div>
                  <div class="modal-body">
                    {block name='account-order-details-delivery-note-popup-heading'}
                        <div class="shipping-order-modal-mb">
                            <strong>{lang key='shippingOrder' section='order'}</strong>: {$oLieferschein->getLieferscheinNr()}<br />
                            <strong>{lang key='shippedOn' section='login'}</strong>: {$oLieferschein->getErstellt()|date_format:"%d.%m.%Y %H:%M"}<br />
                        </div>
                    {/block}
                    {if $oLieferschein->getHinweis()|@count_characters > 0}
                        {block name='account-order-details-delivery-note-popup-alert'}
                            {alert variant="info" class="shipping-order-modal-mb"}{$oLieferschein->getHinweis()}{/alert}
                        {/block}
                    {/if}
                    {block name='account-order-details-delivery-note-popup-tracking'}
                        <div class="shipping-order-modal-mb">
                            {foreach $oLieferschein->oVersand_arr as $oVersand}
                                {if $oVersand->getIdentCode()}
                                    <p>
                                        {link href=$oVersand->getLogistikVarUrl() target="_blank" class="shipment" title=$oVersand->getIdentCode()}
                                            {lang key='packageTracking' section='order'}
                                        {/link}
                                    </p>
                                {/if}
                            {/foreach}
                        </div>
                    {/block}
                    {block name='account-order-details-delivery-note-popup-table'}
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>{lang key="partialShippedPosition" section="order"}</th>
                                <th>{lang key="partialShippedCount" section="order"}</th>
                                <th>{lang key='productNo' section='global'}</th>
                                <th>{lang key='product' section='global'}</th>
                                <th>{lang key="order" section="global"}</th>
                            </tr>
                            </thead>
                            <tbody>
                            {foreach $oLieferschein->oLieferscheinPos_arr as $oLieferscheinpos}
                                <tr>
                                <td>{$oLieferscheinpos@iteration}</td>
                                <td>{$oLieferscheinpos->getAnzahl()}</td>
                                <td>{$oLieferscheinpos->oPosition->cArtNr}</td>
                                <td>
                                    {$oLieferscheinpos->oPosition->cName}
                                    <ul class="list-unstyled text-muted-util small">
                                        {if !empty($oLieferscheinpos->oPosition->cHinweis)}
                                            <li class="text-info notice">{$oLieferscheinpos->oPosition->cHinweis}</li>
                                        {/if}

                                        {* eindeutige Merkmale *}
                                        {if $oLieferscheinpos->oPosition->Artikel->cHersteller && $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen != "N"}
                                            <li class="manufacturer">
                                                <strong>{lang key='manufacturer' section='productDetails'}</strong>:
                                                <span class="values">
                                                   {$oLieferscheinpos->oPosition->Artikel->cHersteller}
                                                </span>
                                            </li>
                                        {/if}

                                        {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelmerkmale == 'Y' && !empty($oLieferscheinpos->oPosition->Artikel->oMerkmale_arr)}
                                            {foreach $oLieferscheinpos->oPosition->Artikel->oMerkmale_arr as $oMerkmale_arr}
                                                <li class="characteristic">
                                                    <strong>{$oMerkmale_arr->cName}</strong>:
                                                    <span class="values">
                                                        {foreach $oMerkmale_arr->oMerkmalWert_arr as $oWert}
                                                            {if !$oWert@first}, {/if}
                                                            {$oWert->cWert}
                                                        {/foreach}
                                                    </span>
                                                </li>
                                            {/foreach}
                                        {/if}
                                    </ul>
                                </td>
                                <td>{$Bestellung->cBestellNr}</td>
                            </tr>
                            {/foreach}
                            </tbody>
                        </table>
                    {/block}
                  </div>
                  <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">{lang key='close' section='consent'}</button>
                  </div>
                </div>
              </div>
            </div>
          {/block}
        {/foreach}
      {/block}
    {/if}

    {block name='account-order-details-order-comment'}
      {if !empty($Bestellung->cKommentar|trim)}
        <div class="h5 mt-4">{lang key='yourOrderComment' section='login'}</div>
        <p>{$Bestellung->cKommentar}</p>
      {/if}
    {/block}
    {block name='account-order-details-actions'}
      {row class="btn-row"}
        {col md=3 cols=12}
          {link class="btn btn-outline-primary btn-block mt-2" href="{get_static_route id='jtl.php'}?bestellungen=1"}
            {lang key='back'}
          {/link}
        {/col}
      {/row}
    {/block}
  {/if}
{/block}
