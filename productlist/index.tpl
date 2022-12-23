{block name='productlist-index'}
  {block name='productlist-index-include-header'}
    {if !isset($bAjaxRequest) || !$bAjaxRequest}
      {include file='layout/header.tpl'}
    {/if}
  {/block}

  {block name='productlist-index-content'}
    <div id="result-wrapper" data-wrapper="true">
      {block name='productlist-index-include-productlist-header-grid'}
        {block name='productlist-index-include-productlist-header-grid-gallery'}
          {assign var=style value='gallery'}
        {/block}
      {/block}

      {if !empty($Suchergebnisse->getError())}
        {block name='productlist-index-alert'}
          <div class="alert alert-danger d-flex" role="alert">
            <div class="alert-icon">
              <i class="ci-close-circle"></i>
            </div>
            <div>{$Suchergebnisse->getError()}</div>
          </div>
        {/block}
      {/if}

      {block name='productlist-index-products'}
        <!-- Page Title-->
        <div class="page-title-overlap bg-dark pt-4">
          <div class="container d-lg-flex justify-content-between py-2 py-lg-3">
            {block name='layout-header-breadcrumb'}
              {include file='layout/breadcrumb.tpl'}
            {/block}
            {opcMountPoint id='opc_before_heading'}
            {block name='productlist-header-description-heading'}
              <div class="order-lg-1 pe-lg-4 text-center text-lg-start">
                {assign var=category value=$oNavigationsinfo->getCategory()}
                {if !is_null($category) && $category->existierenUnterkategorien()}
                	{getChildCats catID=$category->getID()}
                  <h1 class="mb-0">
                    <div class="dropdown">
                      <a class="h3 text-light dropdown-toggle mb-0" href="#" role="button" id="h1_dropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        {$oNavigationsinfo->getName()}
                      </a>
                      <ul class="dropdown-menu" aria-labelledby="h1_dropdown">
                        {foreach $subCategories as $subCat}
                          <li><a class="dropdown-item" href="{$subCat->cURLFull}">{$subCat->cName}</a></li>
                        {/foreach}
                      </ul>
                    </div>
                  </h1>
                {else}
                	<h1 class="h3 text-light mb-0">{$oNavigationsinfo->getName()}</h1>
                {/if}
              </div>
            {/block}
          </div>
        </div>
        
				<div class="container pb-5 mb-2 mb-md-4">
        	<div class="row">
            {block name='layout-footer-aside'}
              {if ($smarty.const.PAGE_ARTIKELLISTE === $nSeitenTyp || $Einstellungen.template.theme.left_sidebar === 'Y')}
                {block name='layout-footer-sidepanel-left'}
                  {include file='productlist/sidebar.tpl'}
                {/block}
              {/if}
            {/block}
            {if $Suchergebnisse->getProducts()|@count > 0}
              {opcMountPoint id='opc_before_products'}
              {if false}{include file='productlist/quick_view.tpl'}{/if}
							<section class="col-lg-8">
              	<!-- Toolbar-->
                {block name='productlist-header-include-productlist-page-nav'}
                	{opcMountPoint id='opc_before_page_nav_header'}
									{block name='snippets-productlist-page-nav-actions'}
										{block name='snippets-productlist-page-nav-actions-sort'}
											{if count($Suchergebnisse->getSortingOptions()) > 0}
                      	<div class="d-flex justify-content-center justify-content-sm-between align-items-center pt-2 pb-4 pb-sm-5">
                          {block name='productlist-header-include-productlist-page-nav'}
														{include file='snippets/productlist_page_nav.tpl' navid='header'}
                          {/block}
                        </div>
                      {/if}
										{/block}
									{/block}
								{/block}
              
                {block name='productlist-header-include-selection-wizard'}
									{include file='selectionwizard/index.tpl' container=false}
								{/block}
                
                {block name='productlist-header-include-active-filter'}
									{if $NaviFilter->getFilterCount() > 0}
										{$alertList->displayAlertByKey('noFilterResults')}
									{/if}
									{include file='snippets/filter/active_filter.tpl'}
                {/block}
                {assign var=showBanner value=0}
                {assign var=bannerIndex value=0}
                {getBanner nSeitenTyp=$nSeitenTyp currentCat=$category}
                <div class="row mx-n2 layout-gallery" id="product-list" itemscope itemprop="mainEntity" itemtype="https://schema.org/ItemList">
                  {foreach $Suchergebnisse->getProducts() as $Artikel}
                    {if count($adBanner) > 0 && ($showBanner == 6 || $showBanner == 15)}
                      {if isset($adBanner[$bannerIndex])}
                    		{include file='productlist/adBanner.tpl' banner=$adBanner[$bannerIndex]}
                      {/if}
                      {$bannerIndex=$bannerIndex+1}
                    {/if}
                    <div class="col-md-4 col-sm-6 px-2 mb-4 product-wrapper" itemprop="itemListElement" itemscope itemtype="https://schema.org/Product">
                      {block name='productlist-index-include-item-box'}
                        {include file='productlist/item_box.tpl' tplscope='gallery'}
                      {/block}
                      <hr class="d-sm-none">
                    </div> 
                    {$showBanner=$showBanner+1}
                  {/foreach}
                </div>
                {include file='productlist/footer.tpl'}
							</section>
              
            {/if}
					</div>
				</div>
      {/block}
    </div>
  {/block}

  {block name='productlist-index-include-footer'}
    {if !isset($bAjaxRequest) || !$bAjaxRequest}
      {include file='layout/footer.tpl'}
    {/if}
  {/block}
{/block}
