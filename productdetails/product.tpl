{block name='productdetails-details-form'}
  <!-- Page Title-->
  <div class="page-title-overlap bg-dark pt-4">
    <div class="container d-lg-flex justify-content-between py-2 py-lg-3">
      {block name='layout-header-breadcrumb'}
        {include file='layout/breadcrumb.tpl'}
      {/block}
      {block name='productdetails-details-info-product-title'}
        {opcMountPoint id='opc_before_headline'}
        <div class="order-lg-1 pe-lg-4 text-center text-lg-start">
          <h1 class="h3 text-light mb-0" itemprop="name">{$Artikel->cName}</h1>
        </div>
      {/block}
    </div>
  </div>
  <div class="container">
    <!-- Gallery + details-->
    <div class="bg-light shadow-lg rounded-3 px-4 py-3 mb-5">
      <div class="px-lg-3">
        {if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt}
          {block name='productdetails-details-include-pushed-success'}
            {include file='productdetails/pushed_success.tpl' card=true}
          {/block}
        {else}
          {block name='productdetails-details-alert-product-note'}
            {$alertList->displayAlertByKey('productNote')}
          {/block}
        {/if}
        <div class="row">
          {block name='productdetails-details-include-image'}
            {opcMountPoint id='opc_before_gallery'}
            {include file='productdetails/image.tpl'}
            {opcMountPoint id='opc_after_gallery'}
          {/block}
          <!-- Product details-->
          <div class="col-lg-5 pt-4 pt-lg-0">
          	{opcMountPoint id='opc_before_buy_form' inContainer=false}
						{form id="buy_form" action=$Artikel->cURLFull class="needs-validation"}
              <div class="product-details ms-auto pb-3"{if !($Artikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === 'N')} itemprop="offers" itemscope itemtype="https://schema.org/Offer"{/if}>
                {block name='productdetails-details-info-hidden'}
                  {if !($Artikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === 'N')}
                    <meta itemprop="url" content="{$Artikel->cURLFull}">
                    <link itemprop="businessFunction" href="http://purl.org/goodrelations/v1#Sell" />
                  {/if}
                  {input type="hidden" name="inWarenkorb" value="1"}
                  {if $Artikel->kArtikelVariKombi > 0}
                    {input type="hidden" name="aK" value=$Artikel->kArtikelVariKombi}
                  {/if}
                  {if isset($Artikel->kVariKindArtikel)}
                    {input type="hidden" name="VariKindArtikel" value=$Artikel->kVariKindArtikel}
                  {/if}
                  {if isset($smarty.get.ek)}
                    {input type="hidden" name="ek" value=$smarty.get.ek|intval}
                  {/if}
                  {input type="hidden" name="AktuellerkArtikel" class="current_article" name="a" value=$Artikel->kArtikel}
                  {input type="hidden" name="wke" value="1"}
                  {input type="hidden" name="show" value="1"}
                  {input type="hidden" name="kKundengruppe" value=$smarty.session.Kundengruppe->getID()}
                  {input type="hidden" name="kSprache" value=$smarty.session.kSprache}
                {/block}
                <div class="d-flex justify-content-between align-items-center mb-2">
                  {if isset($Artikel->cArtNr)}
                    {if $Einstellungen.bewertung.bewertung_anzeigen === 'Y'}
                      {block name='productdetails-details-info-rating-wrapper'}
                        {include file='productdetails/rating.tpl' stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt total=$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}
                      {/block}
                    {/if}
                  {/if}
                  {if !($Artikel->nIstVater && $Artikel->kVaterArtikel == 0)}
                    {block name='productdetails-image-actions'}
                      <div class="product-actions" data-toggle="product-actions">
                        {if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
                          {block name='productdetails-image-include-wishlist-button'}
                            {include file='snippets/wishlist_button.tpl'}
                          {/block}
                        {/if}
                        {if $Einstellungen.artikeldetails.artikeldetails_vergleichsliste_anzeigen === 'Y'
                          && $Einstellungen.vergleichsliste.vergleichsliste_anzeigen === 'Y'}
                          {block name='productdetails-image-include-comparelist-button'}
                            {include file='snippets/comparelist_button.tpl'}
                          {/block}
                        {/if}
                      </div>
                    {/block}
                  {/if}
                </div>
                
                {block name='productdetails-details-include-price'}
                  {if !($Artikel->Preise->fVKNetto == 0 && isset($Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_VOUCHER_FLEX]))}
                    {include file='productdetails/price.tpl' Artikel=$Artikel tplscope='detail' priceLarge=true}
                  {/if}
                {/block}
                
                {block name='productdetails-details-info-essential'}
                  <div class="position-relative me-n4">
                    {block name='productdetails-details-stock'}
                      {block name='productdetails-details-include-stock'}
                        {include file='productdetails/stock.tpl'}
                      {/block}
                    {/block}
                  </div>
                  {block name='productdetails-details-info-item-id'}
                    {if isset($Artikel->cArtNr)}
                      <div class="fs-sm mb-1">
                        <span class="text-heading fw-medium me-1">{lang key='sortProductno'}:</span>
                        <span class="text-muted" itemprop="sku">{$Artikel->cArtNr}</span>
                      </div>
                    {/if}
                  {/block}
                  {block name='productdetails-details-info-mhd'}
                    {if isset($Artikel->dMHD) && isset($Artikel->dMHD_de)}
                      <div class="fs-sm mb-1">
                        <span class="text-heading fw-medium me-1">{lang key='productMHD'}:</span>
                        <span class="text-muted" itemprop="best-before">{$Artikel->dMHD_de}</span>
                      </div>
                    {/if}
                  {/block}
                  {block name='productdetails-details-info-gtin'}
                    {if !empty($Artikel->cBarcode)
                    && ($Einstellungen.artikeldetails.gtin_display === 'details'
                    || $Einstellungen.artikeldetails.gtin_display === 'always')}
                      <div class="fs-sm mb-1">
                        <span class="text-heading fw-medium me-1">{lang key='ean'}:</span>
                        <span class="text-muted" itemprop="{if $Artikel->cBarcode|count_characters === 8}gtin8{else}gtin13{/if}">{$Artikel->cBarcode}</span>
                      </div>
                    {/if}
                  {/block}
                  {block name='productdetails-details-info-isbn'}
                    {if !empty($Artikel->cISBN)
                    && ($Einstellungen.artikeldetails.isbn_display === 'D'
                    || $Einstellungen.artikeldetails.isbn_display === 'DL')}
                      <div class="fs-sm mb-1">
                        <span class="text-heading fw-medium me-1">{lang key='isbn'}:</span>
                        <span class="text-muted" itemprop="gtin13">{$Artikel->cISBN}</span>
                      </div>
                    {/if}
                  {/block}
                  {if !isset($availability)}
                    {block name='productdetails-stock-estimated-delivery'}
                      {if $Artikel->cEstimatedDelivery}
                        <div class="fs-sm mb-1">
                          <span class="text-heading fw-medium me-1"><i class="ci-delivery me-1"></i>{if !isset($shippingTime)}{lang key='shippingTime'}: {/if}</span><span class="text-muted">{$Artikel->cEstimatedDelivery}</span>
                        </div>
                      {/if}
                    {/block}
                  {/if}
                  {block name='productdetails-details-info-category-wrapper'}
                    {assign var=cidx value=($Brotnavi|@count)-2}
                    {if $Einstellungen.artikeldetails.artikeldetails_kategorie_anzeigen === 'Y' && isset($Brotnavi[$cidx])}
                      {block name='productdetails-details-info-category'}
                        <div class="fs-sm mb-1">
                          <span class="word-break">
                            <span class="text-heading fw-medium me-1">{lang key='category'}:</span>
                            <a href="{$Brotnavi[$cidx]->getURLFull()}" itemprop="category">{$Brotnavi[$cidx]->getName()}</a>
                          </span>
                        </div>
                      {/block}
                    {/if}
                  {/block}
                  {block name='productdetails-details-info-manufacturer-wrapper'}
                    {if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'N' && isset($Artikel->cHersteller)}
                      {block name='productdetails-details-product-info-manufacturer'}
                        <div class="fs-sm mb-1" itemprop="brand" itemscope="true" itemtype="https://schema.org/Organization">
                          <span class="text-heading fw-medium me-1">{lang key='manufacturers'}:</span>
                          {if $Einstellungen.artikeldetails.artikel_weitere_artikel_hersteller_anzeigen === 'Y'}
                            <a href="{if !empty($Artikel->cHerstellerHomepage)}{$Artikel->cHerstellerHomepage}{else}{$Artikel->cHerstellerSeo}{/if}"
                              {if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen === 'B'}
                                data-toggle="tooltip"
                                data-placement="left"
                                title="{$Artikel->cHersteller}"
                              {/if}
                             itemprop="url">
                          {/if}
                          {if ($Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen === 'B'
                            || $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen === 'BT')
                            && !empty($Artikel->cHerstellerBildURLKlein)}
                            {image lazy=true
                              webp=true
                              src=$Artikel->cHerstellerBildURLKlein
                              alt=$Artikel->cHersteller|escape:'html'
                            }
                            <meta itemprop="image" content="{$Artikel->cHerstellerBildURLKlein}">
                          {/if}
                          {if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'B'}
                            <span itemprop="name">{$Artikel->cHersteller}</span>
                          {/if}
                          {if $Einstellungen.artikeldetails.artikel_weitere_artikel_hersteller_anzeigen === 'Y'}
                            </a>
                          {/if}
                        </div>
                      {/block}
                    {/if}
                  {/block}
                  {block name='productdetails-details-hazard-info'}
                    {if !empty($Artikel->cUNNummer) && !empty($Artikel->cGefahrnr)
                    && ($Einstellungen.artikeldetails.adr_hazard_display === 'D'
                    || $Einstellungen.artikeldetails.adr_hazard_display === 'DL')}
                      <div class="fs-sm mb-1">
                        <span class="text-heading fw-medium me-1">{lang key='adrHazardSign'}:</span>
                        <table class="adr-table">
                          <tr>
                            <td><span class="text-muted">{$Artikel->cGefahrnr}</span></td>
                          </tr>
                          <tr>
                            <td><span class="text-muted">{$Artikel->cUNNummer}</span></td>
                          </tr>
                        </table>
                      </div>
                    {/if}
                  {/block}
                {/block}
                
                {$showProductWeight = false}
                {$showShippingWeight = false}
                {if isset($Artikel->cArtikelgewicht) && $Artikel->fArtikelgewicht > 0
                && $Einstellungen.artikeldetails.artikeldetails_artikelgewicht_anzeigen === 'Y'}
                    {$showProductWeight = true}
                {/if}
                {if isset($Artikel->cGewicht) && $Artikel->fGewicht > 0
                && $Einstellungen.artikeldetails.artikeldetails_gewicht_anzeigen === 'Y'}
                    {$showShippingWeight = true}
                {/if}
                {$showAttributesTable = ($Einstellungen.artikeldetails.merkmale_anzeigen === 'Y'
                && !empty($Artikel->oMerkmale_arr) || $showProductWeight || $showShippingWeight
                || $Einstellungen.artikeldetails.artikeldetails_abmessungen_anzeigen === 'Y'
                && (!empty($dimension['length']) || !empty($dimension['width']) || !empty($dimension['height']))
                || isset($Artikel->cMasseinheitName) && isset($Artikel->fMassMenge) && $Artikel->fMassMenge > 0
                && $Artikel->cTeilbar !== 'Y' && ($Artikel->fAbnahmeintervall == 0 || $Artikel->fAbnahmeintervall == 1)
                || ($Einstellungen.artikeldetails.artikeldetails_attribute_anhaengen === 'Y' || $funcAttr == 1)
                && !empty($Artikel->Attribute))}
                {include file='productdetails/attributes.tpl' showAttributesTable=$showAttributesTable}
                
                {block name='productdetails-details-include-variation'}
                  <!-- VARIATIONEN -->
                  {include file='productdetails/variation.tpl' simple=$Artikel->isSimpleVariation showMatrix=$showMatrix}
                {/block}
                
                <div class="mb-grid-gutter">
                  {if $Artikel->bHasKonfig}
                    {block name='productdetails-details-config-button'}
                      {row}
                        {if isset($Artikel->Variationen) && $Artikel->Variationen|@count > 0}
                          {block name='productdetails-details-config-button-info'}
                            {col cols=12 class="js-choose-variations-wrapper"}
                              <div class="alert alert-info d-flex" role="alert">
                                <div class="alert-icon">
                                  <i class="ci-announcement"></i>
                                </div>
                                <div>{lang key='chooseVariations' section='messages'}</div>
                              </div>
                            {/col}
                          {/block}
                        {/if}
                        {block name='productdetails-details-config-button-button'}
                          {col cols=12 sm=6}
                            {button type="button"
                              class="start-configuration js-start-configuration"
                              value="{lang key='configure'}"
                              block=true
                              data=["toggle"=>"modal", "target"=>"#cfg-container"]
                              disabled=(isset($Artikel->Variationen) && $Artikel->Variationen|@count > 0)
                            }
                              <span>{lang key='configure'}</span> <i class="ci-settings"></i>
                            {/button}
                          {/col}
                        {/block}
                      {/row}
                    {/block}
                  {else}
                    {block name='productdetails-details-include-basket'}
                      {include file='productdetails/basket.tpl'}
                    {/block}
                  {/if}
                </div>
                <label class="form-label d-inline-block align-middle my-2 me-3">{lang key='share' section='custom'}:</label>
                
                <span class="me-2 my-2">
                  <a data-pin-do="buttonBookmark" data-pin-tall="true" href="https://www.pinterest.com/pin/create/button/"></a>
                </span>
                <script async defer src="//assets.pinterest.com/js/pinit.js"></script>
                
                <a href="https://twitter.com/share?ref_src=twsrc%5Etfw" class="btn-share btn-twitter me-2 my-2" data-show-count="false" target="_blank">
                  <i class="ci-twitter"></i>Twitter
                </a>
                <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
                
                <script async defer crossorigin="anonymous" src="https://connect.facebook.net/es_ES/sdk.js#xfbml=1&version=v15.0" nonce="Ry8EcbbP"></script>
                <span class="fb-share-button" data-href="{$Artikel->cURLFull}" data-layout="button" data-size="large">
                  <a target="_blank" href="https://www.facebook.com/sharer/sharer.php?u={$Artikel->cURLFull|escape:'url'}&amp;src=sdkpreparse" class="fb-xfbml-parse-ignore btn-share btn-facebook my-2" target="_blank">
                    <i class="ci-facebook"></i>Facebook
                  </a>
                </span>
                <div id="fb-root"></div>
            	</div>
						{/form}
          </div>
        </div>
      </div>
    </div>
    
    {opcMountPoint id='opc_after_product_info'}
    {$useDescriptionWithMediaGroup = ((($Einstellungen.artikeldetails.mediendatei_anzeigen === 'YA'
    && $Artikel->cMedienDateiAnzeige !== 'tab') || $Artikel->cMedienDateiAnzeige === 'beschreibung')
    && !empty($Artikel->getMediaTypes()))}
    {$useDescription = (($Artikel->cBeschreibung|strlen > 0) || $useDescriptionWithMediaGroup || $showAttributesTable)}
    {if $useDescription}
      {block name='productdetails-tabs-tab-description'}
        <div class="desc row justify-content-center pt-lg-3 pb-4 pb-sm-5">
          <div class="col-lg-8">
            {opcMountPoint id='opc_before_desc'}
            {$Artikel->cBeschreibung}
            {opcMountPoint id='opc_after_desc'}
          </div>
        </div>
        
        {if $Einstellungen.artikeldetails.merkmale_anzeigen === 'Y'}
          {if count($Artikel->oMerkmale_arr) > 0}
            {block name='productdetails-attributes-characteristics'}
              <div class="card border-0 shadow">
                <div class="card-body">
                  <h5 class="card-title">{lang key='characteristics' section='comparelist'}</h5>
                  <div class="table-responsive">
                    <table class="table">
                      <tbody>
                        {foreach $Artikel->oMerkmale_arr as $characteristic}
                          <tr>
                            <th>{$characteristic->cName}</th>
                            {strip}
                              <td class="attr-characteristic">
                                {isColorFilter kMerkmal=$characteristic->kMerkmal Werte=$characteristic->oMerkmalWert_arr}
                                {foreach $characteristic->oMerkmalWert_arr as $characteristicValue}
                                  {if $isColor->value && isset($isColor->data[$characteristicValue->kMerkmalWert])}
                                    <a class="d-inline-block mb-2 me-2 border border-1 rounded-circle" style="width: 2rem; height: 2rem; padding: .15rem;" href="{$characteristicValue->cURLFull}">
                                      <div class="rounded-circle h-100 w-100" style="background-color: {$isColor->data[$characteristicValue->kMerkmalWert]};"></div>
                                    </a>
                                  {elseif $characteristic->cTyp === 'TEXT' || $characteristic->cTyp === 'SELECTBOX' || $characteristic->cTyp === ''}
                                    {block name='productdetails-attributes-badge'}
                                      {link href=$characteristicValue->cURLFull class="btn-tag me-2 mb-2"}{$characteristicValue->cWert|escape:'html'}{/link}
                                    {/block}
                                  {else}
                                    {block name='productdetails-attributes-image'}
                                      {link href=$characteristicValue->cURLFull
                                        class="text-decoration-none-util"
                                        data=['toggle'=>'tooltip', 'placement'=>'top', 'boundary'=>'window']
                                        title=$characteristicValue->cWert|escape:'html'
                                        aria=["label"=>$characteristicValue->cWert|escape:'html']
                                      }
                                        {$img = $characteristicValue->getImage(\JTL\Media\Image::SIZE_XS)}
                                        {if $img !== null && $img|strpos:$smarty.const.BILD_KEIN_MERKMALBILD_VORHANDEN === false
                                        && $img|strpos:$smarty.const.BILD_KEIN_ARTIKELBILD_VORHANDEN === false}
                                          {include file='snippets/image.tpl'
                                          item=$characteristicValue
                                          square=false
                                          srcSize='xs'
                                          sizes='40px'
                                          width='40'
                                          height='40'
                                          class='img-aspect-ratio'
                                          alt=$characteristicValue->cWert}
                                        {else}
                                          {badge variant="primary"}{$characteristicValue->cWert|escape:'html'}{/badge}
                                        {/if}
                                      {/link}
                                    {/block}
                                  {/if}
                                {/foreach}
                              </td>
                            {/strip}
                          </tr>
                        {/foreach}
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            {/block}
          {/if}
        {/if}
      {/block}
    {/if}
    
  </div>
{/block}