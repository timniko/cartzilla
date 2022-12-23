{block name='snippets-productlist-page-nav'}
    {if $Suchergebnisse->getProductCount() > 0}
        {opcMountPoint id='opc_before_page_nav_'|cat:$navid}
        <div class="d-flex flex-wrap">
        	{if isset($Einstellungen.template.productlist.show_product_sorting) && $Einstellungen.template.productlist.show_product_sorting === "Y"}
            <div class="d-flex align-items-center flex-nowrap me-3 me-sm-4 pb-3">
              <label class="text-light opacity-75 text-nowrap fs-sm me-2 d-none d-sm-block" for="sorting">{lang key="sorting" section="productOverview"}:</label>
              <select class="form-select" id="sorting">
                {foreach $Suchergebnisse->getSortingOptions() as $option}
                  <option value="{$option->getURL()}"{if $option->isActive()} selected{/if}>{$option->getName()}</option>
                {/foreach}
              </select>
              {inline_script}<script>
              $("#sorting").on("change", function(){
                window.location.href = $(this).val();
              });
              </script>{/inline_script}
            </div>
          {/if}
        </div>
        
        <div class="d-flex pb-3">
          {block name='snippets-productlist-page-nav-pages'}
            <a class="nav-link-style nav-link-light me-3" href="{$filterPagination->getPrev()->getURL()}">
              <i class="ci-arrow-left"></i>
            </a>
            
            {block name='snippets-productlist-page-nav-current-page-count'}
              <span class="fs-md text-light">{$Suchergebnisse->getOffsetStart()} - {$Suchergebnisse->getOffsetEnd()}<span class="d-none d-md-inline-block">&nbsp;{lang key='of' section='productOverview'} {$Suchergebnisse->getProductCount()}</span></span>
            {/block}
            
            <a class="nav-link-style nav-link-light ms-3" href="{$filterPagination->getNext()->getURL()}">
              <i class="ci-arrow-right"></i>
            </a>
          {/block}
        </div>
    {/if}
{/block}
