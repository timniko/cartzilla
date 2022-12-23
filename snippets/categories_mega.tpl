{block name='snippets-categories-mega'}
	{strip}
    {block name='snippets-categories-mega-assigns'}
      {if !isset($i)}
        {assign var=i value=0}
      {/if}
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
    {/block}
		{block name='snippets-categories-mega-categories'}
      {if $Einstellungen.template.megamenu.show_categories !== 'N'
			&& ($Einstellungen.global.global_sichtbarkeit != 3 || \JTL\Session\Frontend::getCustomer()->getID() > 0)}
        {get_category_array categoryId=0 assign='categories'}
        {if !empty($categories)}
          {if !isset($activeParents) && ($nSeitenTyp === $smarty.const.PAGE_ARTIKEL || $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE)}
						{get_category_parents categoryId=$activeId assign='activeParents'}
          {/if}
          {block name='snippets-categories-mega-categories-inner'}
            <ul class="navbar-nav navbar-mega-nav pe-lg-2 me-lg-2">
              {if isset($activeParents) && is_array($activeParents) && isset($activeParents[$i])}
                {assign var=activeParent value=$activeParents[$i]}
              {/if}
              <li class="nav-item dropdown{if isset($activeParent)} active{/if}">
                <a class="nav-link dropdown-toggle ps-lg-0 nav-mobile-heading" href="#" title="{lang key='allCategories'}" data-bs-toggle="dropdown" target="_self">
                  <i class="ci-view-grid me-2"></i>{lang key='allCategories'}
                </a>
								<div class="dropdown-menu px-2 pb-4 scrollable">
									{foreach from=$categories item=$category name=cat_iter}
                    {if $category->isOrphaned() === false}
                      {if $smarty.foreach.cat_iter.index % 3 == 0}
                      	{$counter = 0}
                        <div class="d-flex flex-wrap flex-sm-nowrap">
                      {/if}
                      {assign var=counter value=$counter+1}
                      <div class="mega-dropdown-column pt-3 pt-sm-4 px-2 px-lg-3">
                        <div class="widget widget-links">
                          <a class="d-block overflow-hidden" href="{$category->getURL()}">
                            {if $Einstellungen.template.megamenu.show_category_images !== 'N'}
                              {$imgAlt = $category->getAttribute('img_alt')}
                              {image lazy=true
                                webp=true
                                src=$category->getImage(\JTL\Media\Image::SIZE_SM)
                                alt="{if empty($imgAlt->cWert)}{$category->getName()|escape:'html'}{else}{$imgAlt->cWert}{/if}"
                                fluid-grow=true
                                rounded=true
                              }
                            {/if}
                            <h6 class="fs-base mb-2 mt-3">{$category->getName()}</h6>
                          </a>
                          {if $category->hasChildren() && $Einstellungen.template.megamenu.show_subcategories !== 'N'}
                            {block name='snippets-categories-mega-category-child'}
                              {block name='snippets-categories-mega-sub-categories'}
                                {if !empty($category->getChildren())}
                                  {assign var=sub_categories value=$category->getChildren()}
                                {else}
                                  {get_category_array categoryId=$category->getID() assign='sub_categories'}
                                {/if}
                                <ul class="widget-list">
                                  {block name='snippets-categories-mega-category-child-body-include-categories-mega-recursive'}
                                    {foreach $sub_categories as $sub}
                                      {include file='snippets/categories_mega_recursive.tpl' mainCategory=$sub firstChild=true subCategory=$i + 1}
                                    {/foreach}
                                  {/block}
                                </ul>
                              {/block}
                            {/block}
                          {/if}
                        </div>
                      </div>
											{if $counter == 3 || $smarty.foreach.cat_iter.last}
                    		</div>
                    	{/if}
										{/if}
									{/foreach}
								</div>
							</li>
						</ul>
					{/block}
        {/if}
      {/if}
    {/block}
    
    {block name='snippets-categories-mega-include-linkgroup-list'}
      <ul class="navbar-nav">
        {if $Einstellungen.template.megamenu.show_pages !== 'N'}
          {include file='snippets/linkgroups.tpl' linkgroupname='megamenu'}
          {include file='snippets/linkgroups.tpl' linkgroupname='Informationen'}
          {include file='snippets/linkgroups.tpl' linkgroupname='Fuss'}
        {/if}
      </ul>
    {/block}
	{/strip}
{/block}
