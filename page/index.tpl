{block name='page-index'}
    {block name='page-index-include-selection-wizard'}
        {include file='selectionwizard/index.tpl'}
    {/block}

    {if isset($StartseiteBoxen) && $StartseiteBoxen|@count > 0}
        {assign var=moreLink value=null}
        {assign var=moreTitle value=null}

        {opcMountPoint id='opc_before_boxes' inContainer=false}

        {block name='page-index-boxes'}
            {foreach $StartseiteBoxen as $Box}
                {if isset($Box->Artikel->elemente) && count($Box->Artikel->elemente) > 0 && isset($Box->cURL)}
                    {if $Box->name === 'TopAngebot'}
                        {lang key='topOffer' assign='title'}
                        {lang key='showAllTopOffers' assign='moreTitle'}
                    {elseif $Box->name === 'Sonderangebote'}
                        {lang key='specialOffer' assign='title'}
                        {lang key='showAllSpecialOffers' assign='moreTitle'}
                    {elseif $Box->name === 'NeuImSortiment'}
                        {lang key='newProducts' assign='title'}
                        {lang key='showAllNewProducts'  assign='moreTitle'}
                    {elseif $Box->name === 'Bestseller'}
                        {lang key='bestsellers' assign='title'}
                        {lang key='showAllBestsellers' assign='moreTitle'}
                    {/if}
                    {assign var=moreLink value=$Box->cURL}
                    {block name='page-index-include-product-slider'}
                        {container class="container product-slider-wrapper product-slider-{$Box->name} {if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}" fluid=true}
                            {include file='snippets/product_slider.tpl'
                                productlist=$Box->Artikel->elemente
                                title=$title
                                hideOverlays=true
                                moreLink=$moreLink
                                moreTitle=$moreTitle
                                titleContainer=true}
                        {/container}
                    {/block}
                {/if}
            {/foreach}
        {/block}
    {/if}

    {block name='page-index-additional-content'}
        {if isset($oNews_arr) && $oNews_arr|@count > 0}

            {opcMountPoint id='opc_before_news' inContainer=false}
						<div class="bg-secondary py-5 index-news-wrapper" style="margin-bottom: -3rem !important;">
              <div class="container py-3">
              	{block name='page-index-subheading-news'}
                  <div class="h4 text-center pb-4">
                    {link href="{get_static_route id='news.php'}"}{lang key='featured_blog_entries' section='custom'}{/link}
                  </div>
                {/block}
                {block name='page-index-news'}
                  <div class="tns-carousel">
                    <div class="tns-carousel-inner" {literal}data-carousel-options='{"items": {/literal}{$oNews_arr|count}{literal}, "controls": false, "autoHeight": true, "responsive": {"0":{"items":1},"740":{"items":2, "gutter": 20},"900":{"items":3, "gutter": 20}, "1100":{"items":3, "gutter": 30}}}'{/literal}>
                      {foreach $oNews_arr as $oNews}
                        {blogItemData newsItem=$oNews basic=true cAssign='News'}
                        <article itemprop="about" itemscope=true itemtype="https://schema.org/Blog">
                          {if !empty($oNews->getPreviewImage())}
                            <a class="blog-entry-thumb mb-3" href="{$oNews->getURL()}">
                              <img class="rounded" src="{$oNews->getPreviewImage()}" alt="{$oNews->getTitle()|strip_tags}">
                            </a>
                          {else}
                          	<div class="position-relative">
                              <div class="card-img ratio ratio-4x3 bg-faded-accent mb-3"></div>
                              <i class="ci-image position-absolute top-50 start-50 translate-middle fs-1 text-muted opacity-50"></i>
                            </div>
                          {/if}
                          <div class="d-flex align-items-center fs-sm mb-2">
                            {if $News->author !== null}
                              <span class="blog-entry-meta-link">by {$News->author->cName}</span>
                              <span class="blog-entry-meta-divider"></span>
                            {/if}
                            <span class="blog-entry-meta-link">{$News->dateValidFrom}</span>
                          </div>
                          <h3 class="h6 blog-entry-title">
                            <a href="{$oNews->getURL()}">{$oNews->getTitle()}</a>
                          </h3>
                        </article>
                      {/foreach} 
                    </div>
                  </div>
                {/block}
              </div>
            </div>
        {/if}
    {/block}
{/block}
