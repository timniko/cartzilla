{block name='productlist-footer'}
  {block name='productlist-footer-include-productlist-page-nav'}
    <nav class="d-flex justify-content-between pt-2" aria-label="Page navigation">
      <ul class="pagination">
        <li class="page-item">
        	<a class="page-link" href="{$filterPagination->getPrev()->getURL()}" aria-label="{lang key='previous' section='productOverview'}"><i class="ci-arrow-left me-2"></i>{lang key='previous' section='productOverview'}</a>
        </li>
      </ul>
      {if $Suchergebnisse->getPages()->getMaxPage() > 1}
        <ul class="pagination">
          {block name='snippets-productlist-page-nav-pages'}
            <li class="page-item d-sm-none">
              <span class="page-link page-link-static">{lang key="products"} {$Suchergebnisse->getOffsetStart()} - {$Suchergebnisse->getOffsetEnd()} {lang key='of' section='productOverview'} {$Suchergebnisse->getProductCount()}</span>
            </li>
            {foreach $filterPagination->getPages() as $page}
              {if $page->isActive()}
                <li class="page-item active d-none d-sm-block" aria-current="page">
                  <span class="page-link">
                    {$page->getPageNumber()}<span class="visually-hidden">(current)</span>
                  </span>
                </li>
              {else}
                <li class="page-item d-none d-sm-block">
                  <a class="page-link" href="{$page->getURL()}">{$page->getPageNumber()}</a>
                </li>
              {/if}
            {/foreach}
          {/block}
        </ul>
      {/if}
      <ul class="pagination">
        <li class="page-item">
        	<a class="page-link" href="{$filterPagination->getNext()->getURL()}" aria-label="{lang key='next' section='productOverview'}">{lang key='next' section='productOverview'}<i class="ci-arrow-right ms-2"></i></a>
        </li>
      </ul>
    </nav>
  {/block}
{/block}
