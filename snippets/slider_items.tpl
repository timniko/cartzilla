{block name='snippets-slider-items'}
    {foreach $items as $item}
        {if $type === 'product'}
        	{block name='snippets-slider-items-product'}
          	{include file='productlist/item_slider.tpl' Artikel=$item tplscope=$tplscope}
          {/block}
        {elseif $type === 'news'}
          {block name='snippets-slider-items-news'}
            <div class="product-wrapper product-wrapper-news
            {if $item@first && $item@last}
                mx-auto
            {elseif $item@first}
                ml-auto-util
            {elseif $item@last}
                mr-auto
            {/if}">
              {include file='blog/preview.tpl' newsItem=$item}
            </div>
          {/block}
        {elseif $type === 'freegift'}
          <div class="form-check form-option">
            <input class="form-check-input" type="radio" id="gift{$item->kArtikel}" name="gratisgeschenk" value="{$item->kArtikel}" onclick="submit();">
            <label for="gift{$item->kArtikel}" class="cz_gift_label{if $selectedFreegift===$item->kArtikel} active{/if}">
              <div>
                <div class="card border-0 navbar-tool">
                  <span class="top-0 end-0 navbar-tool-label act_badge" style="line-height: 0;">
                    <i class="ci-check" style="line-height: 1.25rem;"></i>
                  </span>
                  <div class="card-img-top d-block overflow-hidden text-center">
                    {image lazy=true
                      webp=true
                      src=$item->Bilder[0]->cURLKlein
                      fluid=true
                      alt=$item->cName}
                  </div>
                  <div class="card-body py-2">
                    <span class="product-meta d-block fs-xs pb-1">{lang key='freeGiftFrom1'} {$item->cBestellwert} {lang key='freeGiftFrom2'}</span>
                    <h3 class="product-title fs-sm">
                      {link href=$item->cURLFull}{$item->cName}{/link}
                    </h3>
                  </div>
                </div>
              </div>
            </label>
          </div>
        
{if false}
            <div class="product-wrapper product-wrapper-freegift {if $item@first && $item@last} m-auto {elseif $item@first} ml-auto-util {elseif $item@last} mr-auto {/if}freegift">
                <div class="custom-control custom-radio">
                    <input class="custom-control-input " type="radio" id="gift{$item->kArtikel}" name="gratisgeschenk" value="{$item->kArtikel}" onclick="submit();">
                    <label for="gift{$item->kArtikel}" class="custom-control-label {if $selectedFreegift===$item->kArtikel}badge-check{/if}">
                        {if $selectedFreegift===$item->kArtikel}{badge class="badge-circle"}<i class="fas fa-check mx-auto"></i>{/badge}{/if}
                        <div class="square square-image">
                            <div class="inner">
                                {image lazy=true
                                    webp=true
                                    src=$item->Bilder[0]->cURLKlein
                                    fluid=true
                                    alt=$item->cName}
                            </div>
                        </div>
                        <div class="caption">
                            <p class="small text-muted-util">{lang key='freeGiftFrom1'} {$item->cBestellwert} {lang key='freeGiftFrom2'}</p>
                            <p>{link href=$item->cURLFull}{$item->cName}{/link}</p>
                        </div>
                    </label>
                </div>
            </div>
{/if}
        {/if}
    {/foreach}
{/block}
