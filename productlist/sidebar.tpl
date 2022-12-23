<!-- Sidebar-->
<aside class="col-lg-4" id="sidepanel_left">
  {block name='footer-sidepanel-left-content'}
    <!-- Sidebar-->
    <div class="offcanvas offcanvas-collapse bg-white w-100 rounded-3 shadow-lg py-1" id="shop-sidebar" style="max-width: 22rem;">
      <div class="offcanvas-header align-items-center shadow-sm">
        <h2 class="h5 mb-0">{lang key='filter'}</h2>
        <button class="btn-close ms-auto" type="button" data-bs-dismiss="offcanvas" aria-label="Close"></button>
      </div>
      <div class="offcanvas-body py-grid-gutter px-lg-grid-gutter">
				{if true}
          <!-- Categories-->
          {block name='boxes-box-categories'}
          	{if !isset($activeId)}
              {if $NaviFilter->hasCategory()}
                {$activeId = $NaviFilter->getCategory()->getValue()}
              {elseif $nSeitenTyp === $smarty.const.PAGE_ARTIKEL && isset($Artikel)}
                {$activeId = $Artikel->gibKategorie()}
              {elseif $nSeitenTyp === $smarty.const.PAGE_ARTIKEL && isset($smarty.session.LetzteKategorie)}
                {$activeId = $smarty.session.LetzteKategorie}
              {else}
                {$activeId = 0}
              {/if}
            {/if}
            <div class="widget widget-categories mb-4 pb-4 border-bottom">
            	{block name='boxes-box-categories-title'}
                <h3 class="widget-title">{lang key='categories'}</h3>
              {/block}
              <div class="accordion mt-n1" id="shop-categories">
                {block name='boxes-box-categories-include-categories-recursive'}
                	{get_category_array categoryId=0 assign='categories'}
                  {if !empty($categories)}
                  	{articleCount}
                    {if !isset($activeParents) && ($nSeitenTyp === $smarty.const.PAGE_ARTIKEL || $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE)}
                      {get_category_parents categoryId=$activeId assign='activeParents'}
                      {foreach $categories as $category}
                        {assign var=activeParent value=NULL}
                        {if isset($activeParents) && is_array($activeParents) && isset($activeParents[0])}
                          {assign var=activeParent value=$activeParents[0]->getID()}
                        {else}
                        	{assign var=activeParent value=$activeId}
                        {/if}
                        {if $category->isOrphaned() === false}
                        	<div class="accordion-item">
                            <h3 class="accordion-header">
                            	<a class="accordion-button{if $category->getID() != $activeParent} collapsed{/if}" href="#filter_cat_{$category->getID()}" role="button" data-bs-toggle="collapse" aria-expanded="{if $category->getID() == $activeParent}true{else}false{/if}" aria-controls="filter_cat_{$category->getID()}">{$category->getName()}</a>
                            </h3>
                            <div class="accordion-collapse collapse{if $category->getID() == $activeParent} show{/if}" id="filter_cat_{$category->getID()}" data-bs-parent="#shop-categories">
                              <div class="accordion-body">
                                <div class="widget widget-links widget-filter">
                                  <div class="input-group input-group-sm mb-2">
                                    <input class="widget-filter-search form-control rounded-end" type="text" placeholder="{lang key='find'}"><i class="ci-search position-absolute top-50 end-0 translate-middle-y fs-sm me-3"></i>
                                  </div>
                                  <ul class="widget-list widget-filter-list pt-1" style="height: 12rem;" data-simplebar data-simplebar-auto-hide="false">
                                    {if !empty($category->getChildren())}
                                      {assign var=sub_categories value=$category->getChildren()}
                                    {else}
                                    	{if $category->getParentID() > 0}
                                        {get_category_array categoryId=$category->getID() assign='sub_categories'}
                                      {else}
                                      	{assign var=sub_categories value=[]}
                                      {/if}
                                    {/if}
                                    <li class="widget-list-item widget-filter-item">
                                      <a class="widget-list-link d-flex justify-content-between align-items-center" href="{$category->getURL()}">
                                        <span class="widget-filter-item-text">{lang key="AllProductsPerSite"}</span>
                                        <span class="fs-xs text-muted ms-3">{$cat_art_cnt[$category->getID()]}</span>
                                      </a>
                                    </li>
                                    {foreach $sub_categories as $sub}
                                      <li class="widget-list-item widget-filter-item">
                                        <a class="widget-list-link d-flex justify-content-between align-items-center" href="{$sub->getURL()}">
                                          <span class="widget-filter-item-text">{$sub->getName()}</span>
                                          <span class="fs-xs text-muted ms-3">{$cat_art_cnt[$sub->getID()]}</span>
                                        </a>
                                      </li>
                                    {/foreach}
                                  </ul>
                                </div>
                              </div>
                            </div>
                          </div>
                        {/if}
											{/foreach}
                    {/if}
									{/if}
                {/block}
              </div>
            </div><!-- Categories-->
          {/block}
          
          {if isset($Einstellungen.template.productlist.show_pricerange_filter) && $Einstellungen.template.productlist.show_pricerange_filter === "Y"}
            {block name='boxes-box-filter-pricerange'}
              {block name='boxes-box-filter-pricerange-content'}
                {block name='boxes-box-filter-pricerange-include-price-slider'}
                  {block name='snippets-filter-price-slider'}
                    {block name='snippets-filter-price-slider-content'}
                      {$startRange = 0}
                      {$endRange = $priceRangeMax}
                      {if $priceRange != ""}
                        {assign var="offset" value=$priceRange|strrpos:"_"}
                        {assign var="startRange" value=$priceRange|substr:0:$offset}
                        {assign var="endRange" value=$priceRange|substr:($offset+1)}
                      {/if}
                      <!-- Price range-->
                      <div class="widget mb-4 pb-4 border-bottom">
                        <h3 class="widget-title">{lang key='rangeOfPrices'}</h3>
                        <div class="range-slider js-price-range-box" data-start-min="{$startRange}" data-start-max="{$endRange}" data-min="0" data-max="{$priceRangeMax}" data-step="1" data-currency="{$smarty.session.Waehrung->getHtmlEntity()}">
                          <div class="range-slider-ui"></div>
                          <div class="d-flex pb-1 price-range-inputs">
                            <div class="w-50 pe-2 me-2">
                              <div class="input-group input-group-sm">
                                <span class="input-group-text">{$smarty.session.Waehrung->getName()}</span>
                                <input class="form-control range-slider-value-min price-range-input" type="text" id="price-slider-box-from" placeholder="0" aria-label="{lang key='differentialPriceFrom' section='productOverview'}">
                              </div>
                            </div>
                            <div class="w-50 ps-2">
                              <div class="input-group input-group-sm">
                                <span class="input-group-text">{$smarty.session.Waehrung->getName()}</span>
                                <input class="form-control range-slider-value-max price-range-input" type="text" id="price-slider-box-to" placeholder="{$priceRangeMax}" aria-label="{lang key='differentialPriceTo' section='productOverview'}">
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      {input data=['id'=>'js-price-range'] type="hidden" value="{$priceRange}"}
                      {input data=['id'=>'js-price-range-max'] type="hidden" value="{$priceRangeMax}"}
                      {input data=['id'=>'js-price-range-id'] type="hidden" value="price-slider-box"}
                      <div id="price-slider-box" class="price-range-slide"></div>
                    {/block}
                    {block name='snippets-filter-price-slider-script'}
                      {inline_script}<script>
                      function setPrange(){
                        $.evo.redirectToNewPriceRange($("#price-slider-box-from").val() + '_' + $("#price-slider-box-to").val(), true, $(".range-slider"));
                      }
                      $("#price-slider-box-from, #price-slider-box-to").on("change", function(){
                        setPrange();
                      });
                      document.addEventListener("sliderUpdate", () => {
                        setPrange();
                      });
                      </script>{/inline_script}
                    {/block}
                  {/block}
                {/block}
              {/block}
            {/block}
          {/if}
          
          {getActiveFilter}
          {getFilter}
          
          {if isset($Einstellungen.template.productlist.show_manufacturer_filter) && $Einstellungen.template.productlist.show_manufacturer_filter === "Y"}
            {block name='boxes-box-filter-manufacturer'}
              <!-- Filter by Brand-->
              {if isset($allFilter->manufacturers)}
                {if !empty($allFilter->manufacturers)}
                  <div class="widget widget-filter mb-4 pb-4 border-bottom">
                    <h3 class="widget-title">{lang key='manufacturers'}</h3>
                    <div class="input-group input-group-sm mb-2">
                      <input class="widget-filter-search form-control rounded-end pe-5" type="text" placeholder="{lang key='find'}"><i class="ci-search position-absolute top-50 end-0 translate-middle-y fs-sm me-3"></i>
                    </div>
                    {block name='boxes-box-filter-manufacturer-include-manufacturer'}
                      {block name='snippets-filter-manufacturer'}
                        <ul class="widget-list widget-filter-list list-unstyled pt-1" style="max-height: 11rem;" data-simplebar data-simplebar-auto-hide="false">
                          {foreach $allFilter->manufacturers as $manufacturer}
                            <li class="widget-filter-item d-flex justify-content-between align-items-center mb-1">
                              <div class="form-check">
                                <input class="form-check-input filter" type="checkbox" id="fil_man_{$manufacturer->value}" data-filter="{$manufacturer->url}"{if isset($aktiveFilter["Manufacturer-{$manufacturer->value}"])} checked{/if}>
                                <label class="form-check-label widget-filter-item-text" for="fil_man_{$manufacturer->value}">{$manufacturer->cName|escape:'html'}</label>
                              </div>
                              <span class="fs-xs text-muted">{$manufacturer->total}</span>
                            </li>
                          {/foreach}
                        </ul>
                      {/block}
                    {/block}
                  </div>
                {/if}
              {/if}
            {/block}
          {/if}
          
          {if isset($Einstellungen.template.productlist.show_availability_filter) && $Einstellungen.template.productlist.show_availability_filter === "Y"}
            {block name='boxes-box-filter-availability'}
              <!-- Filter by availability-->
              {if isset($allFilter->availability)}
                {if !empty($allFilter->availability)}
                  <div class="widget widget-filter mb-4 pb-4 border-bottom">
                    <h3 class="widget-title">{lang key='filterAvailability'}</h3>
                    <div class="input-group input-group-sm mb-2">
                      <input class="widget-filter-search form-control rounded-end pe-5" type="text" placeholder="{lang key='find'}"><i class="ci-search position-absolute top-50 end-0 translate-middle-y fs-sm me-3"></i>
                    </div>
                    {block name='boxes-box-filter-availability-content'}
                      {block name='snippets-filter-genericFilterItem'}
                        <ul class="widget-list widget-filter-list list-unstyled pt-1" style="max-height: 11rem;" data-simplebar data-simplebar-auto-hide="false">
                          {foreach $allFilter->availability as $availability}
                            <li class="widget-filter-item d-flex justify-content-between align-items-center mb-1">
                              <div class="form-check">
                                <input class="form-check-input filter" type="checkbox" id="fil_ava_{$availability->niceName}" data-filter="{$availability->url}"{if isset($aktiveFilter["Availability-{$availability->value}"])} checked{/if}>
                                <label class="form-check-label widget-filter-item-text" for="fil_ava_{$availability->niceName}">{$availability->cName|escape:'html'}</label>
                              </div>
                              <span class="fs-xs text-muted">{$availability->total}</span>
                            </li>
                          {/foreach}
                        </ul>
                      {/block}
                    {/block}
                  </div>
                {/if}
              {/if}
            {/block}
          {/if}
          
					{if isset($Einstellungen.template.productlist.show_characteristics_filter) && $Einstellungen.template.productlist.show_characteristics_filter === "Y"}
            <!-- CHARACTERISTICS -->
            {block name='boxes-box-filter-characteristics'}
              {if isset($allFilter->characteristics)}
                {if count($allFilter->characteristics) > 0}
                  {foreach $allFilter->characteristics as $merkmal}
                    {if $merkmal->type == "text"}
                      <div class="widget widget-filter mb-4 pb-4 border-bottom">
                        <h3 class="widget-title">{$merkmal->frontendName}</h3>
                        <div class="input-group input-group-sm mb-2">
                          <input class="widget-filter-search form-control rounded-end pe-5" type="text" placeholder="{lang key='find'}"><i class="ci-search position-absolute top-50 end-0 translate-middle-y fs-sm me-3"></i>
                        </div>
                        <ul class="widget-list widget-filter-list list-unstyled pt-1" style="max-height: 11rem;" data-simplebar data-simplebar-auto-hide="false">
                          {foreach $merkmal->values as $merkmalWert}
                            <li class="widget-filter-item d-flex justify-content-between align-items-center mb-1">
                              <div class="form-check">
                                <input class="form-check-input filter" type="checkbox" id="filter_{$merkmal->niceName}-{$merkmalWert->wert}" name="filter_{$merkmal->niceName}-{$merkmalWert->wert}" data-filter="{$merkmalWert->url}"{if isset($aktiveFilter["{$merkmal->niceName}-{$merkmalWert->wert}"])} checked{/if}>
                                <label class="form-check-label widget-filter-item-text" for="filter_{$merkmal->niceName}-{$merkmalWert->wert}">{$merkmalWert->wert}</label>
                              </div><span class="fs-xs text-muted">{$merkmalWert->total}</span>
                            </li>
                          {/foreach}
                        </ul>
                      </div>
                    {else if $merkmal->type == "color"}
                      <div class="widget colour-filter">
                        <h3 class="widget-title">{$merkmal->frontendName}</h3>
                        <div class="d-flex flex-wrap">
                          {foreach $merkmal->values as $merkmalWert}
                            <div class="form-check form-option text-center mb-2 mx-1" style="width: 4rem;">
                              <input class="form-check-input filter" type="checkbox" id="filter_{$merkmal->niceName}-{$merkmalWert->wert}" name="filter_{$merkmal->niceName}-{$merkmalWert->wert}" data-filter="{$merkmalWert->url}"{if isset($aktiveFilter["{$merkmal->niceName}-{$merkmalWert->wert}"])} checked{/if}>
                              <label class="form-option-label rounded-circle" for="filter_{$merkmal->niceName}-{$merkmalWert->wert}"><span class="form-option-color rounded-circle" style="background-color: {$merkmalWert->attr};"></span></label>
                              <label class="d-block fs-xs text-muted mt-n1" for="filter_{$merkmal->niceName}-{$merkmalWert->wert}">{$merkmalWert->wert} <small>({$merkmalWert->total})</small></label>
                            </div>
                          {/foreach}
                        </div>
                      </div>
                    {/if}
                  {/foreach}
                {/if}
              {/if}
            {/block}
					{/if}
          
				{/if}
      </div>
    </div>
    {inline_script}<script>
      $("#sidepanel_left input.filter").on("change", function(){
        window.location.href = $(this).data("filter");
      });
    </script>{/inline_script}
	{/block}
</aside>