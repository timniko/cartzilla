{block name='productdetails-bundle'}
    {if !empty($Products)}
        {block name='productdetails-bundle-form'}
            {block name='productdetails-bundle-hidden-inputs'}{/block}
            {block name='productdetails-bundle-include-product-slider'}
							{foreach $ProductMain->oStueckliste_arr as $Artikel}
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
            {/block}
            {if $smarty.session.Kundengruppe->mayViewPrices()}
                {block name='productdetails-bundle-form-price'}
                    {row}
                        {col cols=12 md='auto' class='bundle-price'}
                            <strong>
                                {lang key='priceForAll' section='productDetails'}:
                                <span class="price price-sm">{$ProduktBundle->cPriceLocalized[$NettoPreise]}</span>
                            </strong>
                            {if $ProduktBundle->fPriceDiff > 0}
                                <span class="text-warning">({lang key='youSave' section='productDetails'}: {$ProduktBundle->cPriceDiffLocalized[$NettoPreise]})</span>
                            {/if}
                            {if $ProductMain->cLocalizedVPE}
                                <strong>{lang key='basePrice'}: </strong>
                                <span>{$ProductMain->cLocalizedVPE[$NettoPreise]}</span>
                            {/if}
                        {/col}
                        {col cols=12 md='auto'}
                            {block name='productdetails-bundle-form-submit'}
                                {if !empty($ProductMain->cURLFull)}
                                <a href="{$ProductMain->cURLFull}" class="btn btn-primary">{lang section='custom' key='show_product'}</a>
                                {/if}
                            {/block}
                        {/col}
                    {/row}
                {/block}
            {/if}
        {/block}
    {/if}
{/block}
