{block name='productdetails-image'}
  <!-- Product gallery-->
  {block name='productdetails-image-main'}
    <div class="col-lg-7 pe-lg-0 pt-lg-4">
      <div class="product-gallery">
        <div class="product-gallery-preview order-sm-2">
          {block name='productdetails-image-images'}
            {foreach $Artikel->Bilder as $image name=pr_images}
            	<div class="text-center product-gallery-preview-item{if $smarty.foreach.pr_images.first} active{/if}" id="pr_img_{$smarty.foreach.pr_images.iteration}">
                {strip}
                  {image alt=$image->cAltAttribut
                    class="image-zoom"
                    fluid=false
                    lazy=true
                    webp=true
                    src="{$image->cURLMini}"
                    srcset="{$image->cURLMini} {$Einstellungen.bilder.bilder_artikel_mini_breite}w,
                      {$image->cURLKlein} {$Einstellungen.bilder.bilder_artikel_klein_breite}w,
                      {$image->cURLNormal} {$Einstellungen.bilder.bilder_artikel_normal_breite}w,
                      {$image->cURLGross} {$Einstellungen.bilder.bilder_artikel_gross_breite}w"
                    data=["list"=>"{$image->galleryJSON|escape:"html"}", "index"=>$image@index, "sizes"=>"auto", "zoom"=>"{$image->cURLGross}"]
                  }
                {/strip}
                <div class="image-zoom-pane"></div>
              </div>
            {/foreach}
          {/block}
        </div>
        {block name='productdetails-image-preview'}
          <div class="product-gallery-thumblist order-sm-1">
            {if $Artikel->Bilder|count > 1}
              {foreach $Artikel->Bilder as $image name=pr_images}
                <a class="product-gallery-thumblist-item{if $smarty.foreach.pr_images.first} active{/if}" id="pr_img_{$smarty.foreach.pr_images.iteration}" href="#pr_img_{$smarty.foreach.pr_images.iteration}">
                  {image alt=$image->cAltAttribut
                    class=""
                    fluid=false
                    lazy=true
                    webp=true
                    src="{$image->cURLKlein}"
                  }
                </a>
              {/foreach}
            {/if}
            {if $Artikel->oMedienDatei_arr|count > 0}
            	{foreach $Artikel->oMedienDatei_arr as $media}
              	{if $media->cName|lower == "video"}
                  {$mediaURL=$media->cURL}
                  {if $mediaURL == ""}
                    {$mediaURL=$media->cPfad}
                  {/if}
                  <a class="product-gallery-thumblist-item video-item" href="{$mediaURL}">
                    <div class="product-gallery-thumblist-item-text">
                      <i class="ci-video"></i>Video
                    </div>
                  </a>
                {/if}
              {/foreach}
            {/if}
          </div>
        {/block}
        {block name='productdetails-image-meta'}
          {foreach $Artikel->Bilder as $image}
            <meta itemprop="image" content="{$image->cURLNormal}">
          {/foreach}
        {/block}
      </div>
    </div>
  {/block}
{/block}