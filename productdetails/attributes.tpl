{block name='productdetails-attributes'}
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
  {$dimension = $Artikel->getDimension()}
  {$funcAttr = $Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_ATTRIBUTEANHAENGEN]|default:0}
  <div class="accordion mb-3 mt-3" id="ProductAttributes">
    {if $Einstellungen.artikeldetails.artikeldetails_kurzbeschreibung_anzeigen === 'Y' && $Artikel->cKurzBeschreibung}
      <div class="accordion-item">
        <h2 class="accordion-header" id="heading_clpseDescription">
          <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#clpseDescription" aria-expanded="true" aria-controls="clpseDescription">{lang key='shortDescription' section='comparelist'}</button>
        </h2>
        <div class="accordion-collapse collapse show" id="clpseDescription" aria-labelledby="heading_clpseDescription" data-bs-parent="#ProductAttributes">
          <div class="accordion-body">
            {block name='productdetails-details-info-description-wrapper'}
              {block name='productdetails-details-info-description'}
                {opcMountPoint id='opc_before_short_desc'}
                <div class="" itemprop="description">
                  {$Artikel->cKurzBeschreibung}
                </div>
              {/block}
              {opcMountPoint id='opc_after_short_desc'}
            {/block}
          </div>
        </div>
      </div>
    {/if}
    {if $showShippingWeight ||
    $showProductWeight ||
    (isset($Artikel->cMasseinheitName) && isset($Artikel->fMassMenge) && $Artikel->fMassMenge > 0 && $Artikel->cTeilbar !== 'Y' && ($Artikel->fAbnahmeintervall == 0 || $Artikel->fAbnahmeintervall == 1) && isset($Artikel->cMassMenge)) ||
    ($dimension && $Einstellungen.artikeldetails.artikeldetails_abmessungen_anzeigen === 'Y' && $Artikel->getDimensionLocalized()|count > 0) ||
    (($Einstellungen.artikeldetails.artikeldetails_attribute_anhaengen === 'Y' || $Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_ATTRIBUTEANHAENGEN]|default:0 == 1) && count($Artikel->Attribute) > 0)}
      <div class="accordion-item">
        <h2 class="accordion-header" id="heading_clpseArticelDetails">
          <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#clpseArticelDetails" aria-expanded="false" aria-controls="clpseArticelDetails">{lang key='articledetails' section='productDetails'}</button>
        </h2>
        <div class="accordion-collapse collapse" id="clpseArticelDetails" aria-labelledby="heading_clpseArticelDetails" data-bs-parent="#ProductAttributes">
          <div class="accordion-body">
            <ul class="list-group">
            	{$show_icon=false}
              {if isset($Einstellungen.template.general.show_detail_icons) && $Einstellungen.template.general.show_detail_icons === "Y"}
              	{$show_icon=true}
              {/if}
              {if $showShippingWeight}
                {block name='productdetails-attributes-shipping-weight'}
                  <li class="list-group-item d-flex justify-content-between align-items-center">
                    <span>
                      <div>{if $show_icon}<i class="ci-scale text-muted me-2"></i>{/if}
                      {lang key='shippingWeight'}:</div>
                      <span class="text-nowrap">{$Artikel->cGewicht} {lang key='weightUnit'}</span>
                    </span>
                  </li>
                {/block}
              {/if}
              {if $showProductWeight}
                {block name='productdetails-attributes-product-weight'}
                  <li class="list-group-item d-flex justify-content-between align-items-center">
                    <span itemprop="weight" itemscope itemtype="https://schema.org/QuantitativeValue">
                      <div>{if $show_icon}<i class="ci-scale text-muted me-2"></i>{/if}
                      {lang key='productWeight'}:</div>
                      <span class="text-nowrap">
                        <span itemprop="value">{$Artikel->cArtikelgewicht}</span> <span itemprop="unitText">{lang key='weightUnit'}</span>
                      </span>
                  </li>
                {/block}
              {/if}
              {if isset($Artikel->cMasseinheitName) && isset($Artikel->fMassMenge) && $Artikel->fMassMenge > 0 && $Artikel->cTeilbar !== 'Y' && ($Artikel->fAbnahmeintervall == 0 || $Artikel->fAbnahmeintervall == 1) && isset($Artikel->cMassMenge)}
                {block name='productdetails-attributes-unit'}
                  <li class="list-group-item d-flex justify-content-between align-items-center">
                    <span>
                      <div>{lang key='contents' section='productDetails'}:</div>
                      <span class="text-nowrap">{$Artikel->cMassMenge} {$Artikel->cMasseinheitName}</span>
                    </span>
                  </li>
                {/block}
              {/if}
              {if $dimension && $Einstellungen.artikeldetails.artikeldetails_abmessungen_anzeigen === 'Y'}
                {block name='productdetails-attributes-dimensions'}
                  {assign var=dimensionArr value=$Artikel->getDimensionLocalized()}
                  {if $dimensionArr|count > 0}
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                      <span>
                        <div>{if $show_icon}<i class="ci-ruler text-muted me-2"></i>{/if}
                        {foreach $dimensionArr as $dimkey => $dim}
                          {$dimkey}{if !$dim@last} &times; {/if}
                        {/foreach}:</div>
                        <span class="text-nowrap">
                          {foreach $dimensionArr as $dim}
                            {$dim}{if $dim@last} cm {else} &times; {/if}
                          {/foreach}
                        </span>
                      </span>
                    </li>
                  {/if}
                {/block}
              {/if}
              {if $Einstellungen.artikeldetails.artikeldetails_attribute_anhaengen === 'Y' || $Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_ATTRIBUTEANHAENGEN]|default:0 == 1}
                {block name='productdetails-attributes-shop-attributes'}
                  {foreach $Artikel->Attribute as $Attribut}
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                      <span>
                        <div>{if $show_icon}<i class="ci-message text-muted me-2"></i>{/if}
                        {$Attribut->cName}:</div>
                        <span class="text-nowrap">{$Attribut->cWert}</span>
                      </span>
                    </li>
                  {/foreach}
                {/block}
              {/if}
            </ul>
          </div>
        </div>
      </div>
    {/if}
    {$useDownloads = (isset($Artikel->oDownload_arr) && $Artikel->oDownload_arr|@count > 0)}
    {$useQuestionOnItem = $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'Y'}
    {$usePriceFlow = ($Einstellungen.preisverlauf.preisverlauf_anzeigen === 'Y' && $bPreisverlauf)}
    {$useAvailabilityNotification = ($verfuegbarkeitsBenachrichtigung !== 0)}
    {$useMediaGroup = ((($Einstellungen.artikeldetails.mediendatei_anzeigen === 'YM'
    && $Artikel->cMedienDateiAnzeige !== 'beschreibung') || $Artikel->cMedienDateiAnzeige === 'tab')
    && !empty($Artikel->getMediaTypes()))}
    {$hasVotesHash = isset($smarty.get.ratings_nPage)
    || isset($smarty.get.bewertung_anzeigen)
    || isset($smarty.get.ratings_nItemsPerPage)
    || isset($smarty.get.ratings_nSortByDir)
    || isset($smarty.get.btgsterne)}
    
    {if $useDownloads}
      {block name='productdetails-tabs-tab-downloads'}
        <div class="accordion-item">
          <h2 class="accordion-header" id="heading_clpseDownloadSection">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#clpseDownloadSection" aria-expanded="false" aria-controls="clpseDownloadSection">{lang section="productDownloads" key="downloadSection"}</button>
          </h2>
          <div class="accordion-collapse collapse" id="clpseDownloadSection" aria-labelledby="heading_clpseDownloadSection" data-bs-parent="#ProductAttributes">
            <div class="accordion-body">
              {opcMountPoint id='opc_before_download'}
              {include file='productdetails/download.tpl'}
              {opcMountPoint id='opc_after_download'}
            </div>
          </div>
        </div>
      {/block}
    {/if}
    {if !empty($separatedTabs)}
      {block name='productdetails-tabs-tab-separated-tabs'}
        {foreach $separatedTabs as $separatedTab}
          <div class="accordion-item">
            <h2 class="accordion-header" id="heading_clpse{$separatedTab.name|seofy}">
              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#clpse{$separatedTab.name|seofy}" aria-expanded="false" aria-controls="clpse{$separatedTab.name|seofy}">{$separatedTab.name}</button>
            </h2>
            <div class="accordion-collapse collapse" id="clpse{$separatedTab.name|seofy}" aria-labelledby="heading_clpse{$separatedTab.name|seofy}" data-bs-parent="#ProductAttributes">
              <div class="accordion-body">
                {opcMountPoint id='opc_before_separated_'|cat:$separatedTab.id}
								{$separatedTab.content}
								{opcMountPoint id='opc_after_separated_'|cat:$separatedTab.id}
              </div>
            </div>
          </div>
				{/foreach}
      {/block}
    {/if}
    {if $usePriceFlow}
      {block name='productdetails-tabs-tab-price-flow'}
        <div class="accordion-item">
          <h2 class="accordion-header" id="heading_clpsePriceFlow">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#clpsePriceFlow" aria-expanded="false" aria-controls="clpsePriceFlow">{lang key='priceFlow' section='productDetails'}</button>
          </h2>
          <div class="accordion-collapse collapse" id="clpsePriceFlow" aria-labelledby="heading_clpsePriceFlow" data-bs-parent="#ProductAttributes">
            <div class="accordion-body">
              {opcMountPoint id='opc_before_tab_price_history'}
              {include file='productdetails/price_history.tpl'}
              {opcMountPoint id='opc_after_tab_price_history'}
            </div>
          </div>
        </div>
      {/block}
    {/if}
    {if $useMediaGroup}
      {block name='productdetails-tabs-tab-mediagroup'}
        {foreach $Artikel->getMediaTypes() as $mediaType}
          {$cMedienTypId = $mediaType->name|seofy}
          <div class="accordion-item">
            <h2 class="accordion-header" id="heading_clpse_mediaType{$cMedienTypId}">
              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#clpse_mediaType{$cMedienTypId}" aria-expanded="false" aria-controls="clpse_mediaType{$cMedienTypId}">{$mediaType->name} ({$mediaType->count})</button>
            </h2>
            <div class="accordion-collapse collapse" id="clpse_mediaType{$cMedienTypId}" aria-labelledby="heading_clpse_mediaType{$cMedienTypId}" data-bs-parent="#ProductAttributes">
              <div class="accordion-body">
                {include file='productdetails/mediafile.tpl'}
              </div>
            </div>
          </div>
        {/foreach}
      {/block}
    {/if}
		{if isset($Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen) && $Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen === 'Y' && isset($Artikel->oStueckliste_arr) && $Artikel->oStueckliste_arr|@count > 0}
      {block name='productdetails-details-include-product-slider-partslist'}
				<div class="accordion-item partslist">
          <h2 class="accordion-header" id="heading_clpsePartlist">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#clpsePartlist" aria-expanded="false" aria-controls="clpsePartlist">{lang key='listOfItems' section='global'}</button>
          </h2>
          <div class="accordion-collapse collapse" id="clpsePartlist" aria-labelledby="heading_clpsePartlist" data-bs-parent="#ProductAttributes">
            <div class="accordion-body">
            	{foreach $Artikel->oStueckliste_arr as $Artikel}
              	<div class="d-flex align-items-center py-2 border-bottom">
                	<a class="d-block flex-shrink-0" href="{$Artikel->cURLFull}">
                    {if isset($Artikel->Bilder[0]->cAltAttribut)}
                      {assign var=alt value=$Artikel->Bilder[0]->cAltAttribut|truncate:60}
                    {else}
                      {assign var=alt value=$Artikel->cName}
                    {/if}
                    {include file='snippets/image.tpl' item=$Artikel square=false srcSize='sm' class='product-image rounded' width="64"}
                  </a>
                  <div class="ps-2">
                    <h6 class="widget-product-title">
                    	<a href="{$Artikel->cURLFull}">{$Artikel->fAnzahl_stueckliste} x {$Artikel->cKurzbezeichnung}</a>
										</h6>
                    <div class="widget-product-meta">
                      <span class="text-muted me-2">{lang key='pricePerUnit' section='productDetails'}:</span>
                      {include file='productdetails/price.tpl' Artikel=$Artikel tplscope='box' size='sm'}
										</div>
                  </div>
                </div>
              {/foreach}
            </div>
          </div>
        </div>
      {/block}
		{/if}
    
    {if isset($Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen) && $Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen === 'Y' && isset($Artikel->oProduktBundle_arr) && $Artikel->oProduktBundle_arr|@count > 0}
      {block name='productdetails-details-include-bundle'}
        <div class="accordion-item bundle">
          <h2 class="accordion-header" id="heading_clpseBundle">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#clpseBundle" aria-expanded="false" aria-controls="clpseBundle">{lang key='buyProductBundle' section='productDetails'}</button>
          </h2>
          <div class="accordion-collapse collapse" id="clpseBundle" aria-labelledby="heading_clpseBundle" data-bs-parent="#ProductAttributes">
            <div class="accordion-body">
          		{include file='productdetails/bundle.tpl' ProductKey=$Artikel->kArtikel Products=$Artikel->oProduktBundle_arr ProduktBundle=$Artikel->oProduktBundlePrice ProductMain=$Artikel->oProduktBundleMain}
						</div>
          </div>
				</div>
      {/block}
    {/if}
    
  </div>
{/block}
