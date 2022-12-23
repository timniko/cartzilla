{block name='comparelist-index'}
	{block name='comparelist-index-include-header'}
		{include file='layout/header.tpl'}
	{/block}
    
  {block name='comparelist-index-include-extension'}
    {include file='snippets/extension.tpl'}
  {/block}

  {assign var='descriptionLength' value=80}

    {block name='comparelist-index-content'}
    	{opcMountPoint id='opc_before_heading' inContainer=false}
      <div class="bg-dark py-4">
        <div class="container d-lg-flex justify-content-between py-2 py-lg-3">
          {include file='layout/breadcrumb.tpl'}
          <div class="order-lg-1 pe-lg-4 text-center text-lg-start">
            {block name='comparelist-index-heading'}
              {opcMountPoint id='opc_before_heading'}
              <h1 class="h3 text-light mb-0">{lang key='compare' section='global'}</h1>
            {/block}
          </div>
        </div>
      </div>

      {if $oVergleichsliste->oArtikel_arr|@count > 0}
      	<div class="container py-5 mb-2">
         	{block name='comparelist-index-products'}
            <div class="comparelist table-responsive">
              <table class="table table-bordered table-layout-fixed fs-sm" style="min-width: 45rem;">
                {block name='comparelist-index-products-header'}
                  <thead>
                    <tr>
                      <th class="align-middle bg-secondary">
                        <select class="form-select" id="compare-criteria" data-filter-trigger>
                          <option value="all">{lang key='filterBy'}</option>
                          <option value="rating">{lang key='paginationOrderByRating'}</option>
                          <option value="price">{lang key='price'}</option>
                          {foreach $prioRows as $row}
                            {if $row['key'] !== 'cKurzBeschreibung' && $row['key'] !== 'cBeschreibung'}
                              {if $row['key'] !== 'Merkmale' && $row['key'] !== 'Variationen'}
                                <option value="{$row['key']|lower}">{$row['name']}</option>
                              {elseif $row['key'] === 'Merkmale'}
                                {foreach $oMerkmale_arr as $oMerkmale}
                                  <option value="attr-{$oMerkmale->cName|lower}">{$row['name']}: {$oMerkmale->cName}</option>
                                {/foreach}
                              {elseif $row['key'] === 'Variationen'}
                                {foreach $oVariationen_arr as $oVariationen}
                                  <option value="vari-{$oVariationen->cName|lower}">{$row['name']}: {$oVariationen->cName}</option>
                                {/foreach}
                              {/if}
                            {/if}
                          {/foreach}
                        </select>
                        <div class="pt-3">
                          {block name='comparelist-index-products-header-delete-all'}
                            {button class="comparelist-delete-all mt-2 w-100"
                              href="{get_static_route id='vergleichsliste.php'}?delete=all"
                              variant="primary"
                              id="delete-all"}
                              <i class="ci-trash me-1"></i>{lang key='comparelistDeleteAll' section='comparelist'}
                            {/button}
                          {/block}
                        </div>
                      </th>
                      {foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
                        <td class="comparelist-item min-w text-center px-4 pb-4" data-product-id-cl="{$oArtikel->kArtikel}">
                          {block name='comparelist-index-products-header-image'}
                            {link href=$oArtikel->cURLFull class="d-inline-block mb-3"}
                              {include file='snippets/image.tpl' item=$oArtikel srcSize='xs' square=false class='comparelist-item-image'}
                            {/link}
                          {/block}
                          {block name='comparelist-index-products-header-title'}
														<h3 class="product-title fs-sm">
                              {link href=$oArtikel->cURLFull}
                                {$oArtikel->cName}
                              {/link}
                            </h3>
													{/block}
                          {block name='comparelist-index-products-header-delete'}
                            {link href=$oArtikel->cURLDEL
                              class="btn btn-primary btn-sm"
                              title="{lang key='removeFromCompareList' section='comparelist'}"
                              aria=["label"=>"{lang key='removeFromCompareList' section='comparelist'}"]
                              data=["toggle"=>"tooltip"]}
                              <i class="ci-trash me-1"></i>{lang key='delete'}
                            {/link}
                          {/block}
												</td>
                      {/foreach}
                    </tr>
                  </thead>
                {/block}
                {block name='comparelist-index-products-rows'}
									<tbody id="rating" data-filter-target>
                    <tr class="comparelist-row" data-id="row-rating">
                      <th class="comparelist-label text-uppercase text-dark bg-secondary">
                        {lang key='paginationOrderByRating'}
                      </th>
                      {foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
                        <td data-product-id-cl="{$oArtikel->kArtikel}">
                          {block name='comparelist-index-include-rating'}
                            {include file='productdetails/rating.tpl' stars=$oArtikel->fDurchschnittsBewertung link=$oArtikel->cURLFull}
                          {/block}
                        </td>
                      {/foreach}
                    </tr>
                  </tbody>
                  <tbody id="price" data-filter-target>
                    <tr class="comparelist-row" data-id="row-price">
                      <th class="comparelist-label text-uppercase text-dark bg-secondary">
                        {lang key='price'}
                      </th>
                      {foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
                        <td data-product-id-cl="{$oArtikel->kArtikel}">
                          {block name='comparelist-index-products-header-availability'}
                            {if $oArtikel->getOption('nShowOnlyOnSEORequest', 0) === 1}
                              {lang key='productOutOfStock' section='productDetails'}
                            {elseif $oArtikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === 'N'}
                              {lang key='priceOnApplication' section='global'}
                            {else}
                              {block name='comparelist-index-include-price'}
                                {include file='productdetails/price.tpl' Artikel=$oArtikel tplscope='detail'}
                              {/block}
                            {/if}
                          {/block}
                        </td>
                      {/foreach}
                    </tr>
                  </tbody>
                  {foreach $prioRows as $row}
                  	{if $row['key'] !== 'cKurzBeschreibung' && $row['key'] !== 'cBeschreibung'}
                      {if $row['key'] !== 'Merkmale' && $row['key'] !== 'Variationen'}
                        <tbody id="{$row['key']|lower}" data-filter-target>
                          <tr class="comparelist-row" data-id="row-{$row['key']|lower}">
                            {block name='comparelist-index-products-row-name'}
                              <th class="comparelist-label text-uppercase text-dark bg-secondary">
                                {$row['name']|truncate:20}
                              </th>
                            {/block}
                            {block name='comparelist-index-products'}
                              {foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
                                {if $row['key'] === 'verfuegbarkeit'}
                                  <td data-product-id-cl="{$oArtikel->kArtikel}">
                                    {block name='comparelist-index-products-row-abailability'}
                                      {block name='comparelist-index-products-includes-stock-availability'}
                                        {include file='productdetails/stock.tpl' Artikel=$oArtikel availability=true showBadge=false}
                                      {/block}
                                      {if $oArtikel->nErscheinendesProdukt}
                                        <div>
                                          {lang key='productAvailableFrom' section='global'}: <strong>{$oArtikel->Erscheinungsdatum_de}</strong>
                                          {if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y' && $oArtikel->inWarenkorbLegbar == 1}
                                            ({lang key='preorderPossible' section='global'})
                                          {/if}
                                        </div>
                                      {/if}
                                    {/block}
                                  </td>
                                {elseif $row['key'] === 'lieferzeit'}
                                  <td data-product-id-cl="{$oArtikel->kArtikel}">
                                    {block name='comparelist-index-products-includes-stock-shipping-time'}
                                      {include file='productdetails/stock.tpl' Artikel=$oArtikel shippingTime=true showBadge=false}
                                    {/block}
                                  </td>
                                {elseif $oArtikel->$row['key'] !== ''}
                                  <td style="min-width: {$Einstellungen_Vergleichsliste.vergleichsliste.vergleichsliste_spaltengroesse}px" data-product-id-cl="{$oArtikel->kArtikel}">
                                    {if $row['key'] === 'fArtikelgewicht' || $row['key'] === 'fGewicht'}
                                      {block name='comparelist-index-products-row-weight'}
                                        {$oArtikel->$row['key']} {lang key='weightUnit' section='comparelist'}
                                      {/block}
                                    {else}
                                      {block name='comparelist-index-products-row-default'}
                                        {$oArtikel->$row['key']}
                                      {/block}
                                    {/if}
                                  </td>
                                {else}
                                  {block name='comparelist-index-products-row-none'}
                                    <td data-product-id-cl="{$oArtikel->kArtikel}">--</td>
                                  {/block}
                                {/if}
                              {/foreach}
                            {/block}
                          </tr>
                        </tbody>
                      {elseif $row['key'] === 'Merkmale'}
                      	{block name='comparelist-index-characteristics'}
                          {foreach $oMerkmale_arr as $oMerkmale}
                            <tbody id="attr-{$oMerkmale->cName|lower}" data-filter-target>
                              <tr class="comparelist-row" data-id="row-attr-{$oMerkmale->cName|lower}">
                                {block name='comparelist-index-products-row-name'}
                                  <th class="comparelist-label text-uppercase text-dark bg-secondary">
                                    {$oMerkmale->cName|truncate:20}
                                  </th>
                                {/block}
                                {foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
                                  <td style="min-width: {$Einstellungen_Vergleichsliste.vergleichsliste.vergleichsliste_spaltengroesse}px" data-product-id-cl="{$oArtikel->kArtikel}">
                                    {if count($oArtikel->oMerkmale_arr) > 0}
                                      {foreach $oArtikel->oMerkmale_arr as $oMerkmaleArtikel}
                                        {if $oMerkmale->cName == $oMerkmaleArtikel->cName}
                                          {foreach $oMerkmaleArtikel->oMerkmalWert_arr as $oMerkmalWert}
                                            {$oMerkmalWert->cWert}{if !$oMerkmalWert@last}, {/if}
                                          {/foreach}
                                        {/if}
                                      {/foreach}
                                    {else}
                                      --
                                    {/if}
                                  </td>
                                {/foreach}
                            	</tr>
														</tbody>
                          {/foreach}
                        {/block}
                      {elseif $row['key'] === 'Variationen'}
                      	{block name='comparelist-index-variations'}
                          {foreach $oVariationen_arr as $oVariationen}
                            <tbody id="vari-{$oVariationen->cName|lower}" data-filter-target>
                              <tr class="comparelist-row" data-id="row-vari-{$oVariationen->cName|lower}">
                                {block name='comparelist-index-variation-name'}
                                  <th class="comparelist-label text-uppercase text-dark bg-secondary">
                                    {$oVariationen->cName|truncate:20}
                                  </th>
                                {/block}
                                {foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
                                  <td data-product-id-cl="{$oArtikel->kArtikel}">
                                    {if isset($oArtikel->oVariationenNurKind_arr) && $oArtikel->oVariationenNurKind_arr|@count > 0}
                                      {foreach $oArtikel->oVariationenNurKind_arr as $oVariationenArtikel}
                                        {if $oVariationen->cName == $oVariationenArtikel->cName}
                                          {foreach $oVariationenArtikel->Werte as $oVariationsWerte}
                                            {$oVariationsWerte->cName}
                                            {if $oArtikel->nVariationOhneFreifeldAnzahl == 1 && ($oArtikel->kVaterArtikel > 0 || $oArtikel->nIstVater == 1)}
                                              {assign var=kEigenschaftWert value=$oVariationsWerte->kEigenschaftWert}
                                              ({$oArtikel->oVariationDetailPreisKind_arr[$kEigenschaftWert]->Preise->cVKLocalized[$NettoPreise]}{if !empty($oArtikel->oVariationDetailPreisKind_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise])}, {$oArtikel->oVariationDetailPreisKind_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]}{/if})
                                            {/if}
                                          {/foreach}
                                        {/if}
                                      {/foreach}
                                    {elseif $oArtikel->Variationen|@count > 0}
                                      {foreach $oArtikel->Variationen as $oVariationenArtikel}
                                        {if $oVariationen->cName == $oVariationenArtikel->cName}
                                          {foreach $oVariationenArtikel->Werte as $oVariationsWerte}
                                            {$oVariationsWerte->cName}
                                            {if $Einstellungen_Vergleichsliste.artikeldetails.artikel_variationspreisanzeige == 1 && $oVariationsWerte->fAufpreisNetto != 0}
                                              ({$oVariationsWerte->cAufpreisLocalized[$NettoPreise]}{if !empty($oVariationsWerte->cPreisVPEWertAufpreis[$NettoPreise])}, {$oVariationsWerte->cPreisVPEWertAufpreis[$NettoPreise]}{/if})
                                            {elseif $Einstellungen_Vergleichsliste.artikeldetails.artikel_variationspreisanzeige == 2 && $oVariationsWerte->fAufpreisNetto != 0}
                                              ({$oVariationsWerte->cPreisInklAufpreis[$NettoPreise]}{if !empty($oVariationsWerte->cPreisVPEWertInklAufpreis[$NettoPreise])}, {$oVariationsWerte->cPreisVPEWertInklAufpreis[$NettoPreise]}{/if})
                                            {/if}
                                            {if !$oVariationsWerte@last},{/if}
                                          {/foreach}
                                        {/if}
                                      {/foreach}
                                    {else}
                                      &nbsp;
                                    {/if}
                                  </td>
                                {/foreach}
                              </tr>
														</tbody>
                          {/foreach}
                        {/block}
                      {/if}
										{/if}
                  {/foreach}
                {/block}
              </table>
            </div>
          {/block}
        </div>
      {else}
        {block name='comparelist-index-empty'}
          {container fluid=$Link->getIsFluid() class=" py-5 mb-2{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive} container-plus-sidebar{/if}"}
            {lang key='compareListNoItems'}
          {/container}
        {/block}
      {/if}

      {if isset($bAjaxRequest) && $bAjaxRequest}
        {block name='comparelist-index-script-remove'}
          {inline_script}<script>
						$('.modal a.remove').click(function(e) {
							var kArtikel = $(e.currentTarget).data('id');
							$('section.box-compare li[data-id="' + kArtikel + '"]').remove();
							eModal.ajax({
								size: 'lg',
								url: e.currentTarget.href,
								title: '{lang key='compare' section='global'}',
								keyboard: true,
								tabindex: -1
							});

							return false;
						});
						new function(){
							var clCount = {if isset($oVergleichsliste->oArtikel_arr)}{$oVergleichsliste->oArtikel_arr|count}{else}0{/if};
							$('.navbar-nav .compare-list-menu .badge em').html(clCount);
							if (clCount > 1) {
								$('section.box-compare .panel-body').removeClass('hidden');
							} else {
								$('.navbar-nav .compare-list-menu .link_to_comparelist').removeAttr('href').removeClass('popup');
								eModal.close();
							}
						}();
          </script>{/inline_script}
        {/block}
      {/if}
      {block name='comparelist-index-script-check'}{/block}
  {/block}

  {block name='comparelist-index-include-footer'}
    {include file='layout/footer.tpl'}
  {/block}
{/block}
