{block name='productlist-item-box'}
    
	<!-- Product-->
  <div class="card product-card">
    {block name='productlist-item-box-include-productlist-actions'}
			{include file='productlist/productlist_actions.tpl'}
    {/block}
    <a class="card-img-top d-block overflow-hidden text-center" href="{$Artikel->cURLFull}">
    	{block name='productlist-item-box-image'}
        {if isset($Artikel->oSuchspecialBild)}
          {block name='productlist-item-box-include-ribbon'}
            {include file='snippets/ribbon.tpl'}
          {/block}
        {/if}
        {block name="productlist-item-list-image"}
          {if isset($Artikel->Bilder[0]->cAltAttribut)}
            {assign var=alt value=$Artikel->Bilder[0]->cAltAttribut}
          {else}
            {assign var=alt value=$Artikel->cName}
          {/if}
        	{$image = $Artikel->Bilder[0]}
          {if $image->cPfadKlein !== "gfx/keinBild.gif"}
            {image alt=$alt|truncate:60 fluid=true webp=true lazy=true
              src="{$image->cURLKlein}"
              srcset="{$image->cURLMini} {$Einstellungen.bilder.bilder_artikel_mini_breite}w,
               {$image->cURLKlein} {$Einstellungen.bilder.bilder_artikel_klein_breite}w,
               {$image->cURLNormal} {$Einstellungen.bilder.bilder_artikel_normal_breite}w"
              sizes="auto"
            }
          {else}
            <div class="position-relative">
              <div class="card-img ratio ratio-4x3 bg-secondary"></div>
              <i class="ci-image position-absolute top-50 start-50 translate-middle fs-1 text-muted opacity-50"></i>
            </div>
          {/if}
				{/block}
        {if !empty($Artikel->Bilder[0]->cURLNormal)}
					<meta itemprop="image" content="{$Artikel->Bilder[0]->cURLNormal}">
				{/if}
			{/block}
		</a>
    <div class="card-body py-2">
    	{block name='productlist-item-box-caption'}
          {block name='productlist-item-box-caption-short-desc'}
            {get_article_kat Artikel=$Artikel}
            <a class="product-meta d-block fs-xs pb-1" href="{$article_kat->cURLFull}">{$article_kat->cName}</a>
            <h3 class="product-title fs-sm" itemprop="name">
              {link href=$Artikel->cURLFull class="text-clamp-2"}
                {$Artikel->cKurzbezeichnung}
              {/link}
            </h3>
          {/block}
          {block name='productlist-item-box-meta'}
            {if $Artikel->cName !== $Artikel->cKurzbezeichnung}
              <meta itemprop="alternateName" content="{$Artikel->cName}">
            {/if}
            <meta itemprop="url" content="{$Artikel->cURLFull}">
          {/block}
          {block name='productlist-index-include-rating'}
            {if $Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->fDurchschnittsBewertung > 0}
              <div class="d-flex justify-content-between">
                {block name='productlist-index-include-price'}
                  <div class="product-price" itemprop="offers" itemscope itemtype="https://schema.org/Offer">
                  	<link itemprop="businessFunction" href="http://purl.org/goodrelations/v1#Sell" />
                    {include file='productdetails/price.tpl' Artikel=$Artikel tplscope=$tplscope}
                  </div>
                {/block}
              </div>
              {include file='productdetails/rating.tpl' stars=$Artikel->fDurchschnittsBewertung link=$Artikel->cURLFull}
            {else}
            	<div class="d-flex justify-content-between">
                {block name='productlist-index-include-price'}
                  <div class="product-price" itemprop="offers" itemscope itemtype="https://schema.org/Offer">
                  	<link itemprop="businessFunction" href="http://purl.org/goodrelations/v1#Sell" />
                    {include file='productdetails/price.tpl' Artikel=$Artikel tplscope=$tplscope}
                  </div>
                {/block}
							</div>
            {/if}
          {/block}
      {/block}
      
    </div>
    <div class="card-body card-body-hidden">
      {include file='productdetails/merkmal.tpl' Artikel=$Artikel}
      <a class="btn btn-primary btn-sm d-block w-100 mb-2" href="{$Artikel->cURLFull}">
      	{lang key="show_product" section="custom"}
      </a>
      {if false}
        <div class="text-center">
          <a class="nav-link-style fs-ms" href="#quick-view" data-bs-toggle="modal">
            <i class="ci-eye align-middle me-1"></i>{lang key="quick_view" section="custom"}
          </a>
        </div>
      {/if}
    </div>
  </div> 
{if false}
    <div id="{$idPrefix|default:''}result-wrapper_buy_form_{$Artikel->kArtikel}" data-wrapper="true"
         class="productbox productbox-column {if $Einstellungen.template.productlist.hover_productlist === 'Y'} productbox-hover{/if}{if isset($class)} {$class}{/if}">
        <div class="productbox-inner">
            {row}
                {col cols=12}
                    <div class="productbox-image">
                        {if isset($Artikel->Bilder[0]->cAltAttribut)}
                            {assign var=alt value=$Artikel->Bilder[0]->cAltAttribut}
                        {else}
                            {assign var=alt value=$Artikel->cName}
                        {/if}
                        {block name='productlist-item-box-image'}
                            {counter assign=imgcounter print=0}
                            {if isset($Artikel->oSuchspecialBild)}
                                {block name='productlist-item-box-include-ribbon'}
                                    {include file='snippets/ribbon.tpl'}
                                {/block}
                            {/if}
                            <div class="productbox-images list-gallery">
                                {link href=$Artikel->cURLFull}
                                    {block name="productlist-item-list-image"}
                                        {strip}
                                            {$image = $Artikel->Bilder[0]}
                                            <div class="productbox-image square square-image first-wrapper">
                                                <div class="inner">
                                            {image alt=$alt|truncate:60 fluid=true webp=true lazy=true
                                                src="{$image->cURLKlein}"
                                                srcset="{$image->cURLMini} {$Einstellungen.bilder.bilder_artikel_mini_breite}w,
                                                         {$image->cURLKlein} {$Einstellungen.bilder.bilder_artikel_klein_breite}w,
                                                         {$image->cURLNormal} {$Einstellungen.bilder.bilder_artikel_normal_breite}w"
                                                sizes="auto"
                                                data=["id"  => $imgcounter]
                                                class="{if !$isMobile && !empty($Artikel->Bilder[1])} first{/if}"
                                                fluid=true
                                            }</div>
                                            </div>
                                            {if !$isMobile && !empty($Artikel->Bilder[1])}
                                                <div class="productbox-image square square-image second-wrapper">
                                                    <div class="inner">
                                                    {$image = $Artikel->Bilder[1]}
                                                    {if isset($image->cAltAttribut)}
                                                        {$alt=$image->cAltAttribut}
                                                    {else}
                                                        {$alt=$Artikel->cName}
                                                    {/if}
                                                    {image alt=$alt|truncate:60 fluid=true webp=true lazy=true
                                                        src="{$image->cURLKlein}"
                                                        srcset="{$image->cURLMini} {$Einstellungen.bilder.bilder_artikel_mini_breite}w,
                                                                 {$image->cURLKlein} {$Einstellungen.bilder.bilder_artikel_klein_breite}w,
                                                                 {$image->cURLNormal} {$Einstellungen.bilder.bilder_artikel_normal_breite}w"
                                                        sizes="auto"
                                                        data=["id"  => $imgcounter|cat:"_2nd"]
                                                        class='second'
                                                    }
                                                </div>
                                            </div>
                                            {/if}
                                        {/strip}
                                    {/block}
                                {/link}
                                {if !empty($Artikel->Bilder[0]->cURLNormal)}
                                    <meta itemprop="image" content="{$Artikel->Bilder[0]->cURLNormal}">
                                {/if}
                            </div>
                        {/block}

                        {block name='productlist-item-box-include-productlist-actions'}
                            <div class="productbox-quick-actions productbox-onhover d-none d-md-flex">
                                {include file='productlist/productlist_actions.tpl'}
                            </div>
                        {/block}
                    </div>
                {/col}
                {col cols=12}
                    {block name='productlist-item-box-caption'}
                        {block name='productlist-item-box-caption-short-desc'}
                            <div class="productbox-title" itemprop="name">
                                {link href=$Artikel->cURLFull class="text-clamp-2"}
                                    {$Artikel->cKurzbezeichnung}
                                {/link}
                            </div>
                        {/block}
                        {block name='productlist-item-box-meta'}
                            {if $Artikel->cName !== $Artikel->cKurzbezeichnung}
                                <meta itemprop="alternateName" content="{$Artikel->cName}">
                            {/if}
                            <meta itemprop="url" content="{$Artikel->cURLFull}">
                        {/block}
                        {block name='productlist-index-include-rating'}
                            {if $Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->fDurchschnittsBewertung > 0}
                                {include file='productdetails/rating.tpl' stars=$Artikel->fDurchschnittsBewertung
                                    link=$Artikel->cURLFull}
                            {/if}
                        {/block}
                        {block name='productlist-index-include-price'}
                            <div itemprop="offers" itemscope itemtype="https://schema.org/Offer">
                                <link itemprop="businessFunction" href="http://purl.org/goodrelations/v1#Sell" />
                                {include file='productdetails/price.tpl' Artikel=$Artikel tplscope=$tplscope}
                            </div>
                        {/block}
                    {/block}
                {/col}
            {/row}
        </div>
    </div>
{/if}
{/block}
