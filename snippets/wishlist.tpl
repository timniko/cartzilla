{block name='snippets-wishlist'}
	{cz_step step=$step}
  {block name='snippets-wishlist-header'}
    {include file='layout/header.tpl'}
  {/block}
  
  <div class="page-title-overlap bg-dark pt-4">
    <div class="container d-lg-flex justify-content-between py-2 py-lg-3">
      {block name='layout-header-breadcrumb'}
        {include file='layout/breadcrumb.tpl'}
      {/block}
      {block name='heading'}
        <div class="order-lg-1 pe-lg-4 text-center text-lg-start">
          <h1 class="h3 text-light mb-0">{lang key='welcome' section='login'}</h1>
        </div>
      {/block}
    </div>
  </div>

  <div class="container pb-5 mb-2 mb-md-4">
    <div class="row">
      {include file='snippets/aside_account.tpl'}
      {if !isset($smarty.session.Kunde->kKunde)}
        <script>
          $("#accSidebar a").css("pointer-events", "none");
        </script>
      {/if}
      <section class="col-lg-8">
        {block name='snippets-wishlist-content'}
          {block name='snippets-wishlist-include-extension'}
            {include file='snippets/extension.tpl'}
          {/block}
          
          <div class="d-none d-lg-flex justify-content-between align-items-center pt-lg-3 pb-4 pb-lg-5 mb-lg-3">
            {if $step === 'wunschliste versenden' && $Einstellungen.global.global_wunschliste_freunde_aktiv === 'Y'}
              {block name='snippets-wishlist-content-heading-email'}
                <div class="h2">{lang key='wishlistViaEmail' section='login'}</div>
              {/block}
            {else}
            	{block name='snippets-wishlist-content-heading'}
                <h6 class="fs-base text-light mb-0">
                  {if $isCurrenctCustomer === false && isset($CWunschliste->oKunde->cVorname)}
                    {$CWunschliste->cName} {lang key='from' section='product rating' alt_section='login,productDetails,productOverview,global,'} {$CWunschliste->oKunde->cVorname}
                  {else}
                    {lang key='myWishlists'}
                  {/if}
                </h6>
              {/block}
            {/if}
            {if !empty($smarty.session.Kunde->kKunde)}
              <a class="btn btn-primary btn-sm" href="{get_static_route id='jtl.php' secure=true}?logout=1" rel="nofollow" title="{lang key='logOut'}"><i class="ci-sign-out me-2"></i>{lang key='logOut'}</a>
            {/if}
					</div>
					{container fluid=$Link->getIsFluid() class="snippets-wishlist {if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
            {if $step === 'wunschliste versenden' && $Einstellungen.global.global_wunschliste_freunde_aktiv === 'Y'}
              {block name='snippets-wishlist-content-form-outer'}
                {row}
                  {col cols=12}
                    {block name='snippets-wishlist-form-subheading'}
                      <div class="subheadline">{$CWunschliste->cName}</div>
                    {/block}
                    {block name='snippets-wishlist-form'}
                      {form method="post" action="{get_static_route id='wunschliste.php'}" name="Wunschliste"}
                        {block name='snippets-wishlist-form-inner'}
                          {block name='snippets-wishlist-form-inputs-hidden'}
                            {input type="hidden" name="wlvm" value="1"}
                            {input type="hidden" name="kWunschliste" value=$CWunschliste->kWunschliste}
                            {input type="hidden" name="send" value="1"}
                          {/block}
                          {block name='snippets-wishlist-form-textarea'}
                            {formgroup
                              label-for="wishlist-email"
                              label="{lang key='wishlistEmails' section='login'}{if $Einstellungen.global.global_wunschliste_max_email > 0} | {lang key='wishlistEmailCount' section='login'}: {$Einstellungen.global.global_wunschliste_max_email}{/if}"}
                              {textarea id="wishlist-email" name="email" rows="5" style="width:100%"}{/textarea}
                            {/formgroup}
                          {/block}
                          {block name='snippets-wishlist-form-submit'}
                            {row}
                              {col md=4 xl=3 class='ml-auto-util'}
                                {button name='action' block=true type='submit' value='sendViaMail' variant='primary'}
                                  {lang key='wishlistSend' section='login'}
                                {/button}
                              {/col}
                            {/row}
                          {/block}
                        {/block}
                      {/form}
                    {/block}
                  {/col}
                {/row}
              {/block}
            {else}
              {row class="wishlist-actions mb-3"}
                {if $isCurrenctCustomer === true}
                  {block name='snippets-wishlist-actions'}
                      {col class="col-auto"}
                          <div class="dropdown" aria-label="{lang key='rename' section='wishlistOptions'}">
                            <a class="btn btn-primary" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
                              <i class="ci-settings"></i>
                            </a>
                            <div class="dropdown-menu">
                              <a href="#" class="dropdown-item">
                                {block name='snippets-wishlist-actions-rename'}
                                  <button type="submit" class="btn btn-light w-100" data-bs-toggle="collapse" data-bs-target="#edit-wishlist-name">
                                    {lang key='rename'}
                                  </button>
                                {/block}
                              </a>
                              <a href="#" class="dropdown-item">
                                {block name='snippets-wishlist-actions-remove-products'}
                                  {form
                                    method="post"
                                    action="{get_static_route id='wunschliste.php'}{if $CWunschliste->nStandard != 1}?wl={$CWunschliste->kWunschliste}{/if}"
                                    name="Wunschliste"
                                  }
                                    {input type="hidden" name="wla" value="1"}
                                    {input type="hidden" name="kWunschliste" value=$CWunschliste->kWunschliste}
                                    {input type="hidden" name="action" value="removeAll"}
                                    {button type="submit" variant="light" class="w-100"}
                                      {lang key='wlRemoveAllProducts' section='wishlist'}
                                    {/button}
                                  {/form}
                                {/block}
                              </a>
                              <a href="#" class="dropdown-item">
                                {block name='snippets-wishlist-actions-add-all-cart'}
                                  {form
                                    method="post"
                                    action="{get_static_route id='wunschliste.php'}{if $CWunschliste->nStandard != 1}?wl={$CWunschliste->kWunschliste}{/if}"
                                    name="Wunschliste"
                                  }
                                    {input type="hidden" name="wla" value="1"}
                                    {input type="hidden" name="kWunschliste" value=$CWunschliste->kWunschliste}
                                    {input type="hidden" name="action" value="addAllToCart"}
                                    {button type="submit" variant="light" class="w-100"}
                                      {lang key='wishlistAddAllToCart' section='login'}
                                    {/button}
                                  {/form}
                                {/block}
                                </a>
                                <a href="#" class="dropdown-item">
                                  {block name='snippets-wishlist-actions-delete-wl'}
                                    {form method="post" action="{get_static_route id='wunschliste.php'}" slide=true}
                                      {input type="hidden" name="kWunschliste" value=$CWunschliste->kWunschliste}
                                      {input type="hidden" name="kWunschlisteTarget" value=$CWunschliste->kWunschliste}
                                      {input type="hidden" name="action" value="delete"}
                                      {button type="submit" variant="light" class="w-100"}
                                        {lang key='wlDelete' section='wishlist'}
                                      {/button}
                                    {/form}
                                  {/block}
                                </a>
                                {if $CWunschliste->nStandard != 1}
                                  <a href="#" class="dropdown-item">
                                    {block name='snippets-wishlist-actions-set-active'}
                                      {form method="post" action="{get_static_route id='wunschliste.php'}" slide=true}
                                        {input type="hidden" name="kWunschliste" value=$CWunschliste->kWunschliste}
                                        {input type="hidden" name="kWunschlisteTarget" value=$CWunschliste->kWunschliste}
                                        {input type="hidden" name="action" value="setAsDefault"}
                                        <button type="submit" class="btn btn-light w-100" title="{lang key='setAsStandardWishlist' section='wishlist'}" data-bs-toggle="tooltip" data-bs-placement="bottom">
                                          {lang key='activate'}
                                        </button>
                                      {/form}
                                    {/block}
                                  </a>
                                {/if}
                                <a href="#" class="dropdown-item">
                                  {block name='snippets-wishlist-actions-add-new'}
                                    <button type="submit" class="btn btn-light w-100" title="{lang key='setAsStandardWishlist' section='wishlist'}" data-bs-toggle="collapse" data-bs-target="#create-new-wishlist">
                                      {lang key='wishlistAddNew' section='login'}
                                    </button>
                                  {/block}
                                </a>
														</div>
                          </div>
                      {/col}
                  {/block}
                  {block name='snippets-wishlist-wishlists'}
                    {col class="col-md-auto"}
                      <div class="dropdown" id="wlName">
                        <a class="btn btn-outline-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
                          {$CWunschliste->cName}
                        </a>
                        <div class="dropdown-menu">
                          {foreach $oWunschliste_arr as $wishlist}
                            <a href="{get_static_route id='wunschliste.php'}{if $wishlist->nStandard != 1}?wl={$wishlist->kWunschliste}{/if}" class="dropdown-item" rel="nofollow">
                              {$wishlist->cName}
                            </a>
                          {/foreach}
                        </div>
                      </div>
                    {/col}
                  {/block}
                {/if}
                {/row}
                {if $isCurrenctCustomer === true}
                    {block name='snippets-wishlist-visibility'}
                        {block name='snippets-wishlist-visibility-hr-top'}
                            <hr>
                        {/block}
                        {row class='wishlist-privacy-count'}
                        {block name='snippets-wishlist-visibility-form'}
                            {col class='col-xl wishlist-privacy'}
                                <div class="d-inline-flex flex-nowrap">
                                    <div class="form-check form-switch">
                                        <input type='checkbox'
                                               class='form-check-input wl-visibility-switch'
                                               id="wl-visibility-{$CWunschliste->kWunschliste}"
                                               data-wl-id="{$CWunschliste->kWunschliste}"
                                               {if $CWunschliste->nOeffentlich == 1}checked{/if}
                                               aria-label="{if $CWunschliste->nOeffentlich == 1}{lang key='wishlistNoticePublic' section='login'}{else}{lang key='wishlistNoticePrivate' section='login'}{/if}"
                                        >
                                        <label class="form-check-label" for="wl-visibility-{$CWunschliste->kWunschliste}">
                                            <span data-switch-label-state="public-{$CWunschliste->kWunschliste}" class="{if $CWunschliste->nOeffentlich != 1}d-none{/if}">
                                                {lang key='wishlistNoticePublic' section='login'}
                                            </span>
                                            <span data-switch-label-state="private-{$CWunschliste->kWunschliste}" class="{if $CWunschliste->nOeffentlich == 1}d-none{/if}">
                                                {lang key='wishlistNoticePrivate' section='login'}
                                            </span>
                                        </label>
                                    </div>
                                </div>
                            {/col}
                        {/block}
                        {block name='snippets-wishlist-visibility-count'}
                            {col class='col-auto wishlist-count'}
                                {count($CWunschliste->CWunschlistePos_arr)} {lang key='products'}
                            {/col}
                        {/block}
                        {/row}
                    {/block}
                    {block name='snippets-wishlist-link'}
                        {row class="wishlist-url mt-2 {if $CWunschliste->nOeffentlich != 1}d-none{/if}" id='wishlist-url-wrapper'}
                            {col cols=12}
                                {form method="post" action="{get_static_route id='wunschliste.php'}"}
                                    {block name='snippets-wishlist-link-inputs-hidden'}
                                        {input type="hidden" name="kWunschliste" value=$CWunschliste->kWunschliste}
                                    {/block}
                                    {block name='snippets-wishlist-link-inputs'}
                                        {inputgroup}
                                        {block name='snippets-wishlist-link-name'}
                                            {input type="text"
                                                id="wishlist-url"
                                                name="wishlist-url"
                                                readonly=true
                                                aria=["label"=>"{lang key='wishlist'}-URL"]
                                                data=["static-route" => "{get_static_route id='wunschliste.php'}?wlid="]
                                                value="{get_static_route id='wunschliste.php'}?wlid={$CWunschliste->cURLID}"}
                                        {/block}
                                        {if $Einstellungen.global.global_wunschliste_freunde_aktiv === 'Y'}
                                            {block name='snippets-wishlist-link-envelop'}
                                                {inputgroupaddon append=true}
                                                    {button type="submit"
                                                        variant="link"
                                                        name="action"
                                                        class="btn-primary rounded-0"
                                                        value="sendViaMail"
                                                        disabled=(!$hasItems)
                                                        title="{lang key='wishlistViaEmail' section='login'}"
                                                        aria=["label"=>{lang key='wishlistViaEmail' section='login'}]
                                                    }
                                                        <i class="ci-mail"></i>
                                                    {/button}
                                                {/inputgroupaddon}
                                            {/block}
                                        {/if}
                                        {/inputgroup}
                                    {/block}
                                {/form}
                            {/col}
                        {/row}
                    {/block}
    
                    {block name='snippets-wishlist-form-rename'}
                        {block name='snippets-wishlist-form-rename-hr-top'}
                            <hr>
                        {/block}
                        {row}
                            {col cols=12}
                                {collapse id="edit-wishlist-name" visible=false class="wishlist-collapse mt-3"}
                                    {form
                                        method="post"
                                        action="{get_static_route id='wunschliste.php'}{if $CWunschliste->nStandard != 1}?wl={$CWunschliste->kWunschliste}{/if}"
                                        name="Wunschliste"
                                    }
                                    {block name='snippets-wishlist-form-content-rename'}
                                        {block name='snippets-wishlist-form-content-rename-inputs-hidden'}
                                            {input type="hidden" name="wla" value="1"}
                                            {input type="hidden" name="kWunschliste" value=$CWunschliste->kWunschliste}
                                            {input type="hidden" name="action" value="update"}
                                        {/block}
                                        {block name='snippets-wishlist-form-content-rename-submit'}
                                            {inputgroup}
                                                {inputgroupaddon prepend=true}
                                                    {inputgrouptext class="bg-secondary rounded-0"}
                                                        {lang key='name' section='global'}
                                                    {/inputgrouptext}
                                                {/inputgroupaddon}
                                            {input id="wishlist-name" type="text" placeholder="name" name="WunschlisteName" value=$CWunschliste->cName}
                                                {inputgroupaddon append=true}
                                                    {input type="submit" value="{lang key='rename'}" class="btn btn-primary rounded-0"}
                                                {/inputgroupaddon}
                                            {/inputgroup}
                                        {/block}
                                    {/block}
                                    {/form}
                                {/collapse}
                            {/col}
                        {/row}
                    {/block}
                    {block name='snippets-wishlist-form-new'}
                        {row}
                            {col cols=12}
                                {collapse id="create-new-wishlist" visible=($newWL === 1) class="wishlist-collapse mt-3"}
                                    {form method="post" action="{get_static_route id='wunschliste.php'}" slide=true}
                                        {block name='snippets-wishlist-form-content-new'}
                                            {block name='snippets-wishlist-form-content-new-inputs-hidden'}
                                                {input type="hidden" name="kWunschliste" value=$CWunschliste->kWunschliste}
                                            {/block}
                                            {block name='snippets-wishlist-form-content-new-submit'}
                                                {inputgroup}
                                                    {input name="cWunschlisteName" type="text"
                                                        class="input-sm"
                                                        placeholder="{lang key='wishlistAddNew' section='login'}"
                                                        size="35"}
                                                    {inputgroupaddon append=true}
                                                        {button type="submit" name="action" value="createNew" variant="primary" class="rounded-0"}
                                                            <i class="ci-check"></i>
                                                        {/button}
                                                    {/inputgroupaddon}
                                                {/inputgroup}
                                            {/block}
                                        {/block}
                                    {/form}
                                {/collapse}
                            {/col}
                        {/row}
                    {/block}
                {/if}
    
                {block name='snippets-wishlist-form-basket'}
                    {form method="post"
                        action="{get_static_route id='wunschliste.php'}{if $CWunschliste->nStandard != 1}?wl={$CWunschliste->kWunschliste}{/if}"
                        name="Wunschliste"
                        class="basket_wrapper mt-3{if $hasItems === true} has-items{/if}"
                        id="wl-items-form"}
                    {block name='snippets-wishlist-form-basket-content'}
                        {block name='snippets-wishlist-form-basket-inputs-hidden'}
                            {input type="hidden" name="wla" value="1"}
                            {input type="hidden" name="kWunschliste" value=$CWunschliste->kWunschliste}
                            {if $CWunschliste->nOeffentlich == 1 && !empty($cURLID)}
                                {input type="hidden" name="wlid" value=$cURLID}
                            {/if}
                            {if !empty($wlsearch)}
                                {input type="hidden" name="wlsearch" value="1"}
                                {input type="hidden" name="cSuche" value=$wlsearch}
                            {/if}
                        {/block}
                        {if !empty($CWunschliste->CWunschlistePos_arr)}
                            {block name='snippets-wishlist-form-basket-products'}
                                {foreach $wishlistItems as $wlPosition}
                                        <div id="result-wrapper_buy_form_{$wlPosition->kWunschlistePos}" data-wrapper="true" class="d-sm-flex justify-content-between mt-lg-4 mb-4 pb-3 pb-sm-2 border-bottom">
                                            <div class="d-block d-sm-flex align-items-start text-center text-sm-start">
                                                {block name='snippets-wishlist-form-basket-image'}
                                                  {assign var=image value=$wlPosition->Artikel->Bilder[0]}
                                                  {strip}
                                                    {link href=$wlPosition->Artikel->cURLFull style='width: 10rem;'}
                                                      {include file='snippets/image.tpl'
                                                        fluid=false
                                                        item=$wlPosition->Artikel
                                                        squareClass='first-wrapper'
                                                        srcSize='sm'
                                                        class="d-block flex-shrink-0 mx-auto me-sm-4 {if !$isMobile && !empty($wlPosition->Artikel->Bilder[1])} first{/if}"}
                                                    {/link}
                                                  {/strip}
                                                {/block}
                                                <div class="pt-2">
                                                  <h3 class="product-title fs-base mb-2">
                                                    {block name='snippets-wishlist-form-basket-name'}
                                                      {link href=$wlPosition->Artikel->cURL class="productbox-title text-clamp-2"}
                                                        {$wlPosition->cArtikelName}
                                                      {/link}
                                                    {/block}
                                                  </h3>
                                                  {block name='snippets-wishlist-form-basket-price'}
                                                      {if $wlPosition->Artikel->getOption('nShowOnlyOnSEORequest', 0) === 1}
                                                          <p class="caption">{lang key='productOutOfStock' section='productDetails'}</p>
                                                      {elseif $wlPosition->Artikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === 'N'}
                                                          <p class="caption">{lang key='priceOnApplication' section='global'}</p>
                                                      {else}
                                                          {block name='snippets-wishlist-form-basket-include-price'}
                                                              {include file='productdetails/price.tpl' Artikel=$wlPosition->Artikel tplscope='detail'}
                                                          {/block}
                                                      {/if}
                                                  {/block}
                                                  {block name='snippets-wishlist-form-basket-delivery-status'}
                                                      {block name='snippets-wishlist-item-list-include-delivery-status'}
                                                          {include file='productlist/item_delivery_status.tpl'
                                                          Artikel=$wlPosition->Artikel
                                                          tplscope='wishlist'}
                                                      {/block}
                                                  {/block}
                                                </div>
                                                <div class="pt-2 ps-sm-3 mx-auto mx-sm-0 text-center">
                                                  {block name='snippets-wishlist-form-basket-characteristics'}
                                                      <div class="product-characteristics productbox-onhover d-none">
                                                          {block name='snippets-wishlist-form-basket-characteristics-include-item-details'}
                                                              {include file='productlist/item_details.tpl'
                                                                  Artikel=$wlPosition->Artikel
                                                                  tplscope='wishlist'
                                                                  small=true}
                                                          {/block}
                                                          {block name='snippets-wishlist-form-basket-characteristics-selected'}
                                                              {formrow tag='dl' class="formrow-small"}
                                                                  {foreach $wlPosition->CWunschlistePosEigenschaft_arr as $CWunschlistePosEigenschaft}
                                                                      {if $CWunschlistePosEigenschaft->cFreifeldWert}
                                                                          {col tag='dt' cols=6}{$CWunschlistePosEigenschaft->cEigenschaftName}:{/col}
                                                                          {col tag='dd' cols=6}{$CWunschlistePosEigenschaft->cFreifeldWert}{/col}
                                                                      {else}
                                                                          {col tag='dt' cols=6}{$CWunschlistePosEigenschaft->cEigenschaftName}:{/col}
                                                                          {col tag='dd' cols=6}{$CWunschlistePosEigenschaft->cEigenschaftWertName}{/col}
                                                                      {/if}
                                                                  {/foreach}
                                                              {/formrow}
                                                          {/block}
                                                      </div>
                                                  {/block}
                                                  {block name='snippets-wishlist-form-basket-main'}
                                                      <div class="productbox-onhover productbox-options">
                                                          {block name='snippets-wishlist-form-basket-textarea'}
                                                              {textarea
                                                                  placeholder={lang key='yourNote'}
                                                                  readonly=($isCurrenctCustomer !== true)
                                                                  rows="5"
                                                                  name="Kommentar_{$wlPosition->kWunschlistePos}"
                                                                  class="js-update-wl auto-expand"
                                                                  aria=["label"=>"{lang key='wishlistComment' section='login'} {$wlPosition->cArtikelName}"]
                                                              }{$wlPosition->cKommentar}{/textarea}
                                                          {/block}
                                                      </div>
                                                  {/block}
                                                </div>
                                            </div>
                                        </div>
                                {/foreach}
                            {/block}
                            {block name='snippets-wishlist-form-basket-submit'}
                                <div class="wishlist-all-to-cart sticky-bottom">
                                {row}
                                    {col cols=12 md="auto"}
                                        {if $isCurrenctCustomer === true}
                                            {button type="submit"
                                                title="{lang key='addCurrentProductsToCart' section='wishlist'}"
                                                name="action"
                                                value="addAllToCart"
                                                block=true
                                                variant="primary"
                                            }
                                                <i class="fa fa-shopping-cart"></i>
                                                {if !empty($wlsearch)}
                                                    {lang key='addCurrentProductsToCart' section='wishlist'}
                                                {else}
                                                    {lang key='wishlistAddAllToCart' section='login'}
                                                {/if}
                                            {/button}
                                        {/if}
                                    {/col}
                                {/row}
                                </div>
                            {/block}
                        {else}
                            {block name='snippets-wishlist-alert'}
                                {alert variant="info"}{lang key='noEntriesAvailable' section='global'}{/alert}
                            {/block}
                        {/if}
                    {/block}
                    {/form}
                {/block}
            {/if}
					{/container}
        {/block}
      </section>
    </div>
  </div>
  {block name='snippets-wishlist-include-footer'}
    {include file='layout/footer.tpl'}
  {/block}
{/block}
