<div class="navbar-tool dropdown ms-3">
	{block name='basket-cart-dropdown-label'}
    <a class="navbar-tool-icon-box bg-secondary dropdown-toggle" href="{get_static_route id='warenkorb.php'}" rel="nofollow">
      {block name='basket-cart-dropdown-label-count'}
      	<span class="navbar-tool-label">{$WarenkorbArtikelPositionenanzahl}</span>
      {/block}
      <i class="navbar-tool-icon ci-cart"></i>
    </a>
    <a class="navbar-tool-text" href="{get_static_route id='warenkorb.php'}" rel="nofollow">
			{block name='basket-cart-dropdown-labelprice'}
    		<small>{lang key='basket'}</small><span class="text-nowrap">{$WarensummeLocalized[0]}</span>
      {/block}
    </a>
    {block name='basket-cart-dropdown-label-include-cart-dropdown'}
      <!-- Cart dropdown-->
      <div class="dropdown-menu dropdown-menu-end">
        <div class="widget widget-cart px-3 pt-2 pb-3" style="width: 25rem;">
					{block name='basket-cart-dropdown'}
						{if $smarty.session.Warenkorb->PositionenArr|@count > 0}
            	<div style="height: 15rem;" data-simplebar data-simplebar-auto-hide="false">
								{block name='basket-cart-dropdown-cart-items-content'}
                  {block name='basket-cart-dropdown-cart-item'}
                    {form method="post" action="{get_static_route id='warenkorb.php'}" class="jtl-validate" slide=true}
											{input type="hidden" name="wka" value="1"}
                      {foreach $smarty.session.Warenkorb->PositionenArr as $oPosition}
                        {if !$oPosition->istKonfigKind()}
                          {if $oPosition->nPosTyp == C_WARENKORBPOS_TYP_ARTIKEL || $oPosition->nPosTyp == C_WARENKORBPOS_TYP_GRATISGESCHENK}
                            <div class="widget-cart-item py-2 border-bottom">
                              <button class="btn-close text-danger" type="submit" name="dropPos" value="{$oPosition@index}" aria-label="{lang key='delete'}" title="{lang key='delete'}"><span aria-hidden="true">&times;</span></button>
                              <div class="d-flex align-items-center">
                                {block name='basket-cart-dropdown-cart-item-item-link'}
                                  {if !empty($oPosition->Artikel->cVorschaubild)}
                                    <a class="flex-shrink-0" href="{$oPosition->Artikel->cURLFull}" title="{$oPosition->cName|trans|escape:'html'}">
                                      {if isset($oPosition->Artikel->Bilder[0]->cPfadKlein) && $oPosition->Artikel->Bilder[0]->cPfadKlein !== "gfx/keinBild.gif"}
                                        {image lazy=true
                                          webp=true
                                          src=$oPosition->Artikel->cVorschaubild
                                          alt=$oPosition->Artikel->cName
                                          fluid-grow=false
                                          thumbnail=false
                                          width="80px"
                                        }
                                      {else}
                                        <div class="position-relative" style="width: 80px;">
                                          <div class="card-img ratio ratio-4x3 bg-secondary"></div>
                                          <i class="ci-image position-absolute top-50 start-50 translate-middle fs-1 text-muted opacity-50"></i>
                                        </div>
                                      {/if}
                                    </a>
                                  {/if}
                                  <div class="ps-2">
                                    <h6 class="widget-product-title">
                                      <a href="{$oPosition->Artikel->cURLFull}" title="{$oPosition->cName|trans|escape:'html'}">{$oPosition->cName|trans}</a>
                                    </h6>
                                    <div class="widget-product-meta">
                                      {block name='basket-cart-dropdown-cart-item-item-price'}
                                        <span class="text-accent me-1">
                                          {if $oPosition->istKonfigVater()}
                                            {$oPosition->cKonfigpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                          {else}
                                            {$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                          {/if}
                                        </span>
                                      {/block}
                                      <span class="text-muted">x {$oPosition->nAnzahl|replace_delim}</span>
                                    </div>
                                  </div>
                                {/block}
                              </div>
                            </div>
                          {else}
                            {block name='basket-cart-dropdown-cart-item-no-item-count'}
                              <div class="ps-2">
                                <h6 class="widget-product-title">{$oPosition->cName|trans|escape:'htmlall'}</h6>
                                <div class="widget-product-meta">
                                  {block name='basket-cart-dropdown-cart-item-noitem-price'}
                                    <span class="text-accent me-1">
                                      {$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                    </span>
                                  {/block}
                                  <span class="text-muted">x {$oPosition->nAnzahl|replace_delim}</span>
                                </div>
                              </div>
                            {/block}
                          {/if}
                        {/if}
                      {/foreach}
										{/form}
                  {/block}
								{/block}
							</div>
              {block name='basket-cart-dropdown-total'}
                <div class="d-flex flex-wrap justify-content-between align-items-center py-3">
                  {block name='basket-cart-dropdown-cart-item-total'}
                    <div class="fs-sm me-2 py-2">
                      <span class="text-muted">
                        {if empty($smarty.session.Versandart)}
                          {lang key='subtotal' section='account data'}
                        {else}
                          {lang key='totalSum'}
                        {/if}
                      </span>
                      <span class="text-accent fs-base ms-1">{$WarensummeLocalized[0]}</span>
                    </div>
                  {/block}
                  <a class="btn btn-outline-secondary btn-sm" href="{get_static_route id='warenkorb.php'}" title="{lang key='gotoBasket'}">{lang key='gotoBasket'}<i class="ci-arrow-right ms-1 me-n1"></i></a>
                </div>
                {block name='basket-cart-dropdown-buttons'}
                  <a class="btn btn-primary btn-sm d-block w-100" href="{get_static_route id='bestellvorgang.php'}?wk=1" title="{lang key='nextStepCheckout' section='checkout'}"><i class="ci-card me-2 fs-base align-middle"></i>{lang key='nextStepCheckout' section='checkout'}</a>
                {/block}
                
                {if !empty($WarenkorbVersandkostenfreiHinweis)}
                  {block name='basket-cart-dropdown-shipping-free-hint'}
                    <hr>
                    <ul class="cart-dropdown-shipping-notice list-unstyled fs-sm mt-2">
                      <li>
                        <a class="text-dark"
                         href="{if !empty($oSpezialseiten_arr) && isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}{$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL()}{else}#{/if}"
                         data-toggle="tooltip"
                         data-placement="bottom"
                         title="{lang key='shippingInfo' section='login'}">
                          <i class="ci-delivery me-1 align-middle"></i>
                        	{$WarenkorbVersandkostenfreiHinweis|truncate:160:"..."}
                        </a>
                      </li>
                    </ul>
                  {/block}
                {/if}
              {/block}
            {else}
            	{block name='basket-cart-dropdown-hint-empty'}
              	<a class="dropdown-item cart-dropdown-empty" href="{{get_static_route id='warenkorb.php'}}" rel="nofollow" title="{lang section='checkout' key='emptybasket'}">{lang section='checkout' key='emptybasket'}</a>
              {/block}
            {/if}
					{/block}
        </div>
      </div>
    {/block}
  {/block}
</div>