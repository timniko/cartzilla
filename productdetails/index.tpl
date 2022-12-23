{block name='productdetails-index'}
    {block name='productdetails-index-include-header'}
        {if !isset($bAjaxRequest) || !$bAjaxRequest}
            {include file='layout/header.tpl'}
        {/if}
    {/block}
    {block name='productdetails-index-content'}
        {if isset($bAjaxRequest) && $bAjaxRequest && isset($listStyle) && ($listStyle === 'list' || $listStyle === 'gallery')}
            {if $listStyle === 'gallery'}
                {assign var=tplscope value='gallery'}
                {assign var=class value='thumbnail'}
                {block name='productdetails-index-include'}
                    {include file='productlist/item_box.tpl'}
                {/block}
            {/if}
        {else}
            {block name='productdetails-index-result-wrapper'}
                <div id="result-wrapper" data-wrapper="true" itemprop="mainEntity" itemscope itemtype="https://schema.org/Product">
                    <meta itemprop="url" content="{$Artikel->cURLFull}">
                    {block name='productdetails-index-include-extension'}
                        {include file='snippets/extension.tpl'}
                    {/block}
                    {block name='productdetails-index-include-details'}
                        {include file='productdetails/details.tpl'}
                    {/block}
                </div>
                {if !isset($bAjaxRequest) || !$bAjaxRequest}
                  {block name='productdetails-details-content-not-quickview'}
                    {*SLIDERS*}
                    {if isset($Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen) && $Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen === 'Y' && isset($Artikel->oStueckliste_arr) && $Artikel->oStueckliste_arr|@count > 0
                    || isset($Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen) && $Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen === 'Y' && isset($Artikel->oProduktBundle_arr) && $Artikel->oProduktBundle_arr|@count > 0
                    || isset($Xselling->Standard->XSellGruppen) && count($Xselling->Standard->XSellGruppen) > 0
                    || isset($Xselling->Kauf->Artikel) && count($Xselling->Kauf->Artikel) > 0
                    || isset($oAehnlicheArtikel_arr) && count($oAehnlicheArtikel_arr) > 0}
                      {container fluid=true class="container {if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
                        {if isset($Xselling->Standard) || isset($Xselling->Kauf) || isset($oAehnlicheArtikel_arr)}
                          <!-- Product carousel (You may also like)-->
                          <div class="recommendations d-print-none">
                            {block name='productdetails-details-recommendations'}
                              {if isset($Xselling->Standard->XSellGruppen) && count($Xselling->Standard->XSellGruppen) > 0}
                                {foreach $Xselling->Standard->XSellGruppen as $Gruppe}
                                  {include file='snippets/product_slider.tpl' class='x-supplies' id='slider-xsell-group-'|cat:$Gruppe@iteration productlist=$Gruppe->Artikel title=$Gruppe->Name}
                                {/foreach}
                              {/if}
                    
                              {if isset($Xselling->Kauf->Artikel) && count($Xselling->Kauf->Artikel) > 0}
                                {lang key='customerWhoBoughtXBoughtAlsoY' section='productDetails' assign='slidertitle'}
                                {include file='snippets/product_slider.tpl' class='x-sell' id='slider-xsell' productlist=$Xselling->Kauf->Artikel title=$slidertitle}
                              {/if}
                    
                              {if isset($oAehnlicheArtikel_arr) && count($oAehnlicheArtikel_arr) > 0}
                                {lang key='RelatedProducts' section='productDetails' assign='slidertitle'}
                                {include file='snippets/product_slider.tpl' class='x-related' id='slider-related' productlist=$oAehnlicheArtikel_arr title=$slidertitle}
                              {/if}
                            {/block}
                          </div>
                        {/if}
                      {/container}
                    {/if}
                    {block name='productdetails-details-include-popups'}
                      <div id="article_popups">
                        {include file='productdetails/popups.tpl'}
                      </div>
                    {/block}
                  {/block}
								{/if}
            {/block}
        {/if}
    {/block}

    {block name='productdetails-include-footer'}
        {if !isset($bAjaxRequest) || !$bAjaxRequest}
            {include file='layout/footer.tpl'}
        {/if}
    {/block}
{/block}
