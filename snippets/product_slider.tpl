{block name='snippets-product-slider'}
  {strip}
    {$isOPC=$isOPC|default:false}
    {if $productlist|@count > 0}
      {if !isset($tplscope)}
        {assign var=tplscope value='slider'}
      {/if}
      {if !empty($title)}
        <h2 class="h3 pb-4">{$title}</h2>
      {/if}
      <div class="tns-carousel tns-controls-static tns-controls-outside">
        <div class="tns-carousel-inner" data-carousel-options="{literal}{&quot;items&quot;: {/literal}{$productlist|@count}{literal}, &quot;controls&quot;: true, &quot;nav&quot;: false, &quot;responsive&quot;: {&quot;0&quot;:{&quot;items&quot;:1},&quot;500&quot;:{&quot;items&quot;:2, &quot;gutter&quot;: 18},&quot;768&quot;:{&quot;items&quot;:3, &quot;gutter&quot;: 20}, &quot;1100&quot;:{&quot;items&quot;:4, &quot;gutter&quot;: 30}}}{/literal}">
          {include file='snippets/slider_items.tpl' items=$productlist type='product'}
        </div>
      </div>
    {/if}
  {/strip}
{/block}
