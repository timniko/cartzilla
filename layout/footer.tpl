{block name='layout-footer'}
	{if empty($parentTemplateDir)}
      {$templateDir = $currentTemplateDir}
  {else}
      {$templateDir = $parentTemplateDir}
  {/if}
	</div></div></main>
	{block name='layout-footer-content'}
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
    <footer class="footer bg-dark pt-5 mt-auto" id="footer">
      <div class="container">
        <div class="row pb-2">
					{if $Einstellungen.template.megamenu.show_categories !== 'N' && ($Einstellungen.global.global_sichtbarkeit != 3 || \JTL\Session\Frontend::getCustomer()->getID() > 0)}
						{get_category_array categoryId=0 assign='categories'}
						{if !empty($categories)}
              <div class="col-md-4 col-sm-6">
                <div class="widget widget-links widget-light pb-2 mb-4">
                  <h3 class="widget-title text-light">{lang key='allCategories' section='global'}</h3>
                  <ul class="widget-list">
                    {foreach $categories as $category}
                      <li class="widget-list-item">
                      	<a class="widget-list-link{if $category->getID() === $activeId}active{/if}" href="{$category->getURL()}" title="{$category->getShortName()}">{$category->getShortName()}</a>
                      </li>
                    {/foreach}
                  </ul>
                </div>
              </div>
						{/if}
					{/if}
          <div class="col-md-4 col-sm-6">
          	{$linkgroup = $linkgroups->getLinkGroupByTemplate('Informationen')}
          	{if $linkgroup !== null}
            	{get_navigation linkgroupIdentifier='Informationen' assign='links'}
              {if count($links) > 0}
                <div class="widget widget-links widget-light pb-2 mb-4">
                  <h3 class="widget-title text-light">{$linkgroup->getName()}</h3>
                  <ul class="widget-list">
                    {foreach $links as $Link}
                      <li class="widget-list-item"><a class="widget-list-link{if $Link->getIsActive()} active{/if}" href="{$Link->getURL()}" title="{$Link->getTitle()}">{$Link->getName()}</a></li>
                    {/foreach}
                  </ul>
                </div>
              {/if}
            {/if}
            {$linkgroup = $linkgroups->getLinkGroupByTemplate('Kopf')}
          	{if $linkgroup !== null}
            	{get_navigation linkgroupIdentifier='Kopf' assign='links'}
              {if count($links) > 0}
                <div class="widget widget-links widget-light pb-2 mb-4">
                  <h3 class="widget-title text-light">{$linkgroup->getName()}</h3>
                  <ul class="widget-list">
                    {foreach $links as $Link}
                      <li class="widget-list-item"><a class="widget-list-link{if $Link->getIsActive()} active{/if}" href="{$Link->getURL()}" title="{$Link->getTitle()}">{$Link->getName()}</a></li>
                    {/foreach}
                  </ul>
                </div>
              {/if}
            {/if}
          </div>
          <div class="col-md-4">
						{if $Einstellungen.template.footer.newsletter_footer === 'Y' && $Einstellungen.newsletter.newsletter_active === 'Y'}
              {block name='layout-footer-newsletter'}
                <div class="widget pb-2 mb-4">
                  {block name='layout-footer-newsletter-heading'}
										<h3 class="widget-title text-light pb-1 newsletter-footer-heading">{lang key='newsletterSubscribe' section='newsletter'}</h3>
                  {/block}
                  {block name='layout-footer-form'}
                    <form class="subscription-form validate" action="{get_static_route id='newsletter.php'}" method="post" name="mc-embedded-subscribe-form" target="_blank" novalidate>
                      {block name='layout-footer-form-content'}
                        {input type="hidden" name="abonnieren" value="2"}
                        <div class="input-group flex-nowrap">
                          <i class="ci-mail position-absolute top-50 translate-middle-y text-muted fs-base ms-3"></i>
                          <input class="form-control rounded-start" type="email" name="cEmail" placeholder="{lang key='emailadress'}" id="newsletter_email" aria-label="{lang key='emailadress'}" required>
                          <button class="btn btn-primary" type="submit">{lang key='newsletterSendSubscribe' section='newsletter'}</button>
                        </div>
                      {/block}
                      {block name='layout-footer-form-captcha'}
                        <div class="{if !empty($plausiArr.captcha) && $plausiArr.captcha === true} has-error{/if}">
                          {captchaMarkup getBody=true}
                        </div>
                      {/block}
                      {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ])}
                        {block name='layout-footer-newsletter-info'}
                          <div class="form-text text-light opacity-50">{lang key='newsletterInformedConsent' section='newsletter' printf=$oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ]->getURL()}</div>
                        {/block}
                      {/if}
                      <div class="subscription-status"></div>
                    </form>
                  {/block}
								</div>
							{/block}
						{/if}
            {opcMountPoint id='opc_footer_after_newsletter' inContainer=false}
          </div>
        </div>
      </div>
      <div class="pt-5 bg-darker">
        <div class="container">
        	{opcMountPoint id='opc_footer_extra' inContainer=false}
          <div class="row pb-2">
            <div class="col-md-8 text-center text-md-start mb-4">
              <div class="text-nowrap mb-4">
              	{if isset($Einstellungen.template.footer.footer_logo) && $Einstellungen.template.footer.footer_logo !== ''}
                  <a class="d-inline-block align-middle mt-n1 me-3" href="{$ShopURL}">
                    <img class="d-block" src="{$ShopURL}/templates/cartzilla/{$Einstellungen.template.footer.footer_logo}" width="117" alt="{$Einstellungen.global.global_shopname}">
                  </a>
                {/if}
                <div class="btn-group dropdown disable-autohide">
                	{$btn_class = 'btn btn-outline-light border-light btn-sm dropdown-toggle px-2'}
                  {include file='snippets/curr_lang_dropdown.tpl'}
                </div>
              </div>
              <div class="widget widget-links widget-light">
                {if $linkgroups->getLinkGroupByTemplate('Fuss') !== null}
                  <ul class="widget-list d-flex flex-wrap justify-content-center justify-content-md-start">
										{foreach $linkgroups->getLinkGroupByTemplate('Fuss')->getLinks() as $Link}
											<li class="widget-list-item me-4"><a class="widget-list-link{if $Link->getIsActive()} active{/if}" href="{$Link->getURL()}" title="{$Link->getTitle()}">{$Link->getName()}</a></li>
                    {/foreach}
                  </ul>
                {/if}
              </div>
            </div>
            
            {block name='layout-footer-additional'}
              <div class="col-md-4 text-center text-md-end mb-4">
                {if $Einstellungen.template.footer.socialmedia_footer === 'Y'}
                  {block name='layout-footer-socialmedia'}
                    <div class="mb-3">
                      {if !empty($Einstellungen.template.footer.twitter)}
                        <a class="btn-social bs-light bs-twitter ms-2 mb-2" href="{if $Einstellungen.template.footer.twitter|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.twitter}" title="{lang key='visit_us_on' section='aria' printf='Twitter'}" target="_blank" rel="noopener"><i class="ci-twitter"></i></a>
                      {/if}
                      {if !empty($Einstellungen.template.footer.facebook)}
                        <a class="btn-social bs-light bs-facebook ms-2 mb-2" href="{if $Einstellungen.template.footer.facebook|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.facebook}" title="{lang key='visit_us_on' section='aria' printf='Facebook'}" target="_blank" rel="noopener"><i class="ci-facebook"></i></a>
                      {/if}
                      {if !empty($Einstellungen.template.footer.instagram)}
                        <a class="btn-social bs-light bs-instagram ms-2 mb-2" href="{if $Einstellungen.template.footer.instagram|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.instagram}" title="{lang key='visit_us_on' section='aria' printf='Instagram'}" target="_blank" rel="noopener"><i class="ci-instagram"></i></a>
                      {/if}
                      {if !empty($Einstellungen.template.footer.pinterest)}
                        <a class="btn-social bs-light bs-pinterest ms-2 mb-2" href="{if $Einstellungen.template.footer.pinterest|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.pinterest}" title="{lang key='visit_us_on' section='aria' printf='Pinterest'}" target="_blank" rel="noopener"><i class="ci-pinterest"></i></a>
                      {/if}
                      {if !empty($Einstellungen.template.footer.youtube)}
                        <a class="btn-social bs-light bs-youtube ms-2 mb-2" href="{if $Einstellungen.template.footer.youtube|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.youtube}" title="{lang key='visit_us_on' section='aria' printf='YouTube'}" target="_blank" rel="noopener"><i class="ci-youtube"></i></a>
                      {/if}
                      {if !empty($Einstellungen.template.footer.linkedin)}
                        <a class="btn-social bs-light bs-linkedin ms-2 mb-2" href="{if $Einstellungen.template.footer.linkedin|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.linkedin}" title="{lang key='visit_us_on' section='aria' printf='LinkedIn'}" target="_blank" rel="noopener"><i class="ci-linkedin"></i></a>
                      {/if}
                      {if !empty($Einstellungen.template.footer.vimeo)}
                        <a class="btn-social bs-light bs-vimeo ms-2 mb-2" href="{if $Einstellungen.template.footer.vimeo|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.vimeo}" title="{lang key='visit_us_on' section='aria' printf='Vimeo'}" target="_blank" rel="noopener"><i class="ci-vimeo"></i></a>
                      {/if}
                      {if !empty($Einstellungen.template.footer.skype)}
                        <a class="btn-social bs-light bs-skype ms-2 mb-2" href="{if $Einstellungen.template.footer.v|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.skype}" title="{lang key='visit_us_on' section='aria' printf='Skype'}" target="_blank" rel="noopener"><i class="ci-skype"></i></a>
                      {/if}
                      {if !empty($Einstellungen.template.footer.whatsapp)}
                        <a class="btn-social bs-light bs-whatsapp ms-2 mb-2" href="{if $Einstellungen.template.footer.whatsapp|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.whatsapp}" title="{lang key='visit_us_on' section='aria' printf='WhatsApp'}" target="_blank" rel="noopener"><i class="ci-whatsapp"></i></a>
                      {/if}
                    </div>
                  {/block}
                {/if}
                {if isset($Einstellungen.template.footer.zahlungsmethoden_bild) && $Einstellungen.template.footer.zahlungsmethoden_bild !== ''}
                	<img class="d-inline-block" src="{$ShopURL}/templates/cartzilla/{$Einstellungen.template.footer.zahlungsmethoden_bild}" width="187" alt="{lang key='paymentOptions' section='global'}">
                {/if}
              </div>
            {/block}
          </div>
          <div class="pb-4 fs-xs text-light opacity-50 text-center text-md-start">
          	<span class="footnote-vat me-2">
                {if $NettoPreise == 1}
                    {lang key='footnoteExclusiveVat' assign='footnoteVat'}
                {else}
                    {lang key='footnoteInclusiveVat' assign='footnoteVat'}
                {/if}
                {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}
                    {if $Einstellungen.global.global_versandhinweis === 'zzgl'}
                        {lang key='footnoteExclusiveShipping' printf=$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() assign='footnoteShipping'}
                    {elseif $Einstellungen.global.global_versandhinweis === 'inkl'}
                        {lang key='footnoteInclusiveShipping' printf=$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() assign='footnoteShipping'}
                    {/if}
                {/if}
                {block name='footer-vat-notice'}
                    * {$footnoteVat}{if isset($footnoteShipping)}{$footnoteShipping}{/if}
                {/block}
            </span>
          
						{block name='layout-footer-copyright-copyright'}
              {if !empty($meta_copyright)}
              	<span class="icon-mr-2" itemprop="copyrightHolder">&copy; {$meta_copyright}</span>
              {/if}
              {if $Einstellungen.global.global_zaehler_anzeigen === 'Y'}
                {lang key='counter'}: {$Besucherzaehler}
              {/if}
              {if !empty($Einstellungen.global.global_fusszeilehinweis)}
                <span class="ms-2">{$Einstellungen.global.global_fusszeilehinweis}</span>
              {/if}
            {/block}
            {if !JTL\Shop::isBrandfree()}
              {block name='layout-footer-copyright-brand'}
                <span class="ms-2" id="system-credits">
                  Powered by {link href="https://jtl-url.de/jtlshop" class="text-white text-decoration-underline" title="JTL-Shop" target="_blank" rel="noopener nofollow"}JTL-Shop{/link}
                </span>
              {/block}
            {/if}
          </div>
        </div>
      </div>
    </footer>
    
    <div class="handheld-toolbar">
      <div class="d-table table-layout-fixed w-100">
				 {if ($smarty.const.PAGE_ARTIKELLISTE === $nSeitenTyp || $smarty.const.PAGE_NEWS === $nSeitenTyp)}
          <a class="d-table-cell handheld-toolbar-item" href="#" data-bs-toggle="offcanvas" data-bs-target="#shop-sidebar">
            <span class="handheld-toolbar-icon">
              <i class="ci-filter-alt"></i>
            </span>
            <span class="handheld-toolbar-label">{lang key='filter'}</span>
          </a>
        {/if}
        {if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
          <a class="d-table-cell handheld-toolbar-item" href="{get_static_route id='wunschliste.php'}">
            <span class="handheld-toolbar-icon">
              <i class="ci-heart"></i>
            </span>
            <span class="handheld-toolbar-label">{lang key='wishlist'}</span>
          </a>
        {/if}
        {if $Einstellungen.vergleichsliste.vergleichsliste_anzeigen === 'Y'}
          <a class="d-table-cell handheld-toolbar-item" href="{get_static_route id='vergleichsliste.php'}">
            <span class="handheld-toolbar-icon">
              <i class="ci-view-list"></i>
            </span>
            <span class="handheld-toolbar-label">{lang key='compare'}</span>
          </a>
        {/if}
        <a class="d-table-cell handheld-toolbar-item" href="javascript:void(0)" data-bs-toggle="collapse" data-bs-target="#_mainNavigation" onclick="window.scrollTo(0, 0)">
          <span class="handheld-toolbar-icon">
            <i class="ci-menu"></i>
          </span>
          <span class="handheld-toolbar-label">{lang key='menuName'}</span>
        </a>
      </div>
    </div>
    
	{/block}
  {block name='layout-footer-io-path'}
		<div id="jtl-io-path" data-path="{$ShopURL}" class="d-none"></div>
	{/block}
    {block name='layout-footer-js'}
    {$dbgBarBody}
    {captchaMarkup getBody=false}
    <script src="{$ShopURL}/templates/cartzilla/vendor/simplebar/dist/simplebar.min.js"></script>
    <script src="{$ShopURL}/templates/cartzilla/vendor/tiny-slider/dist/min/tiny-slider.js"></script>
    <script src="{$ShopURL}/templates/cartzilla/vendor/smooth-scroll/dist/smooth-scroll.polyfills.min.js"></script>
    <script src="{$ShopURL}/templates/cartzilla/vendor/nouislider/dist/nouislider.min.js"></script>
    <script src="{$ShopURL}/templates/cartzilla/vendor/drift-zoom/dist/Drift.min.js"></script>
    <script src="{$ShopURL}/templates/cartzilla/vendor/imagesloaded/imagesloaded.pkgd.min.js"></script>
    <script src="{$ShopURL}/templates/cartzilla/vendor/shufflejs/dist/shuffle.min.js"></script>
    <script src="{$ShopURL}/templates/cartzilla/vendor/lightgallery.js/dist/js/lightgallery.min.js"></script>
    <script src="{$ShopURL}/templates/cartzilla/vendor/lg-video.js/dist/lg-video.min.js"></script>
    <script src="{$ShopURL}/templates/cartzilla/js/theme.js"></script>
  {/block}
  {block name='layout-footer-consent-manager'}
    {if $Einstellungen.consentmanager.consent_manager_active === 'Y' && !$isAjax && $consentItems->isNotEmpty()}
      <input id="consent-manager-show-banner" type="hidden" value="{$Einstellungen.consentmanager.consent_manager_show_banner}">
      {include file='snippets/consent_manager.tpl'}
      {inline_script}
				<script>
					setTimeout(function() {
							$('#consent-manager, #consent-settings-btn').removeClass('d-none');
					}, 100)
					document.addEventListener('consent.updated', function(e) {
							$.post('{$ShopURLSSL}/', {
											'action': 'updateconsent',
											'jtl_token': '{$smarty.session.jtl_token}',
											'data': e.detail
									}
							);
					});
					{if !isset($smarty.session.consents)}
							document.addEventListener('consent.ready', function(e) {
									document.dispatchEvent(new CustomEvent('consent.updated', { detail: e.detail }));
							});
					{/if}

					window.CM = new ConsentManager({
							version: 1
					});
					var trigger = document.querySelectorAll('.trigger')
					var triggerCall = function(e) {
							e.preventDefault();
							let type = e.target.dataset.consent;
							if (CM.getSettings(type) === false) {
									CM.openConfirmationModal(type, function() {
											let data = CM._getLocalData();
											if (data === null ) {
													data = { settings: {} };
											}
											data.settings[type] = true;
											document.dispatchEvent(new CustomEvent('consent.updated', { detail: data.settings }));
									});
							}
					}
					for(let i = 0; i < trigger.length; ++i) {
							trigger[i].addEventListener('click', triggerCall)
					}
        </script>
      {/inline_script}
    {/if}
  {/block}
  </body>
</html>
{/block}