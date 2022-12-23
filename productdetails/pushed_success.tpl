{block name='productdetails-pushed-success'}
  <div id="pushed-success">
		{assign var=showXSellingCart value=isset($Xselling->Kauf) && count($Xselling->Kauf->Artikel) > 0}
    {block name='productdetails-pushed-success-cart-note-heading'}
      {if isset($cartNote)}
        <div class="alert alert-info d-flex" role="alert">
          <div class="alert-icon">
            <i class="ci-announcement"></i>
          </div>
          <div>{$cartNote}</div>
        </div>
      {/if}
    {/block}

    {row}
      {block name='productdetails-pushed-success-x-sell'}
        {if $showXSellingCart}
          {col cols=12 class="x-selling"}
            {row}
              {col cols=12}
                {block name='productdetails-pushed-success-x-sell-heading'}
                  <h2 class="h3 mb-4 pb-2">{lang key='customerWhoBoughtXBoughtAlsoY' section='productDetails'}</h2>
                {/block}
              {/col}
              {col cols=12}
                {block name='productdetails-pushed-success-include-product-slider'}
                  {include file='snippets/product_slider.tpl' id='' productlist=$Xselling->Kauf->Artikel title='' tplscope='half'}
                {/block}
              {/col}
            {/row}
          {/col}
        {/if}
      {/block}
    {/row}
  </div>
{/block}
