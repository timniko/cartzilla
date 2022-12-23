{block name='layout-header'}
    {block name='layout-header-doctype'}<!DOCTYPE html>{/block}
    <html {block name='layout-header-html-attributes'}lang="{$meta_language}" itemscope {if $nSeitenTyp === $smarty.const.URLART_ARTIKEL}itemtype="https://schema.org/ItemPage"
          {elseif $nSeitenTyp === $smarty.const.URLART_KATEGORIE}itemtype="https://schema.org/CollectionPage"
          {else}itemtype="https://schema.org/WebPage"{/if}{/block}>
    {block name='layout-header-head'}
    <head>
        {block name='layout-header-head-meta'}
            <meta http-equiv="content-type" content="text/html; charset={$smarty.const.JTL_CHARSET}">
            <meta name="description" itemprop="description" content={block name='layout-header-head-meta-description'}"{$meta_description|truncate:1000:"":true}{/block}">
            {if !empty($meta_keywords)}
                <meta name="keywords" itemprop="keywords" content="{block name='layout-header-head-meta-keywords'}{$meta_keywords|truncate:255:'':true}{/block}">
            {/if}
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            {$noindex = $bNoIndex === true  || (isset($Link) && $Link->getNoFollow() === true)}
            <meta name="robots" content="{if $robotsContent}{$robotsContent}{elseif $noindex}noindex{else}index, follow{/if}">

            <meta itemprop="url" content="{$cCanonicalURL}"/>
            {block name='layout-header-head-theme-color'}
                <meta name="theme-color" content="{if $Einstellungen.template.theme.theme_default === 'clear'}#f8bf00{else}#1C1D2C{/if}">
            {/block}
            <meta property="og:type" content="website" />
            <meta property="og:site_name" content="{$meta_title}" />
            <meta property="og:title" content="{$meta_title}" />
            <meta property="og:description" content="{$meta_description|truncate:1000:"":true}" />
            <meta property="og:url" content="{$cCanonicalURL}"/>

            {if $nSeitenTyp === $smarty.const.PAGE_ARTIKEL && !empty($Artikel->Bilder)}
                <meta itemprop="image" content="{$Artikel->Bilder[0]->cURLGross}" />
                <meta property="og:image" content="{$Artikel->Bilder[0]->cURLGross}">
            {elseif $nSeitenTyp === $smarty.const.PAGE_NEWSDETAIL && !empty($newsItem->getPreviewImage())}
                <meta itemprop="image" content="{$imageBaseURL}{$newsItem->getPreviewImage()}" />
                <meta property="og:image" content="{$imageBaseURL}{$newsItem->getPreviewImage()}" />
            {else}
                <meta itemprop="image" content="{$ShopLogoURL}" />
                <meta property="og:image" content="{$ShopLogoURL}" />
            {/if}
        {/block}

        <title itemprop="name">{block name='layout-header-head-title'}{$meta_title|htmlspecialchars_decode|strip_tags:false}{/block}</title>

        {if !empty($cCanonicalURL) && !$noindex}
            <link rel="canonical" href="{$cCanonicalURL}">
        {/if}

        {block name='layout-header-head-base'}{/block}

        {block name='layout-header-head-icons'}
            <link type="image/x-icon" href="{$shopFaviconURL}" rel="icon">
        {/block}

        {block name='layout-header-head-resources'}
            {if empty($parentTemplateDir)}
                {$templateDir = $currentTemplateDir}
            {else}
                {$templateDir = $parentTemplateDir}
            {/if}
            <style id="criticalCSS">
                {block name='layout-header-head-resources-crit'}
                    {file_get_contents("{$currentThemeDir}{$Einstellungen.template.theme.theme_default}_crit.css")}
                {/block}
            </style>
            {* css *}
            {if $Einstellungen.template.general.use_minify === 'N'}
                {foreach $cCSS_arr as $cCSS}
                    <link rel="preload" href="{$ShopURL}/{$cCSS}?v={$nTemplateVersion}" as="style"
                          onload="this.onload=null;this.rel='stylesheet'">
                {/foreach}
                {if isset($cPluginCss_arr)}
                    {foreach $cPluginCss_arr as $cCSS}
                        <link rel="preload" href="{$ShopURL}/{$cCSS}?v={$nTemplateVersion}" as="style"
                              onload="this.onload=null;this.rel='stylesheet'">
                    {/foreach}
                {/if}

                <noscript>
                    {foreach $cCSS_arr as $cCSS}
                        <link rel="stylesheet" href="{$ShopURL}/{$cCSS}?v={$nTemplateVersion}">
                    {/foreach}
                    {if isset($cPluginCss_arr)}
                        {foreach $cPluginCss_arr as $cCSS}
                            <link href="{$ShopURL}/{$cCSS}?v={$nTemplateVersion}" rel="stylesheet">
                        {/foreach}
                    {/if}
                </noscript>
            {else}
                <link rel="preload" href="{$ShopURL}/{$combinedCSS}" as="style" onload="this.onload=null;this.rel='stylesheet'">
                <noscript>
                    <link href="{$ShopURL}/{$combinedCSS}" rel="stylesheet">
                </noscript>
            {/if}

            {if !$isMobile && !$opc->isEditMode() && !$opc->isPreviewMode() && \JTL\Shop::isAdmin(true)}
                <link rel="preload" href="{$ShopURL}/admin/opc/css/startmenu.css" as="style"
                      onload="this.onload=null;this.rel='stylesheet'">
                <noscript>
                    <link type="text/css" href="{$ShopURL}/admin/opc/css/startmenu.css" rel="stylesheet">
                </noscript>
            {/if}
            {foreach $opcPageService->getCurPage()->getCssList($opc->isEditMode()) as $cssFile => $cssTrue}
                <link rel="preload" href="{$cssFile}" as="style" data-opc-portlet-css-link="true"
                      onload="this.onload=null;this.rel='stylesheet'">
                <noscript>
                    <link rel="stylesheet" href="{$cssFile}">
                </noscript>
            {/foreach}
            <script>
                /*! loadCSS rel=preload polyfill. [c]2017 Filament Group, Inc. MIT License */
                (function (w) {
                    "use strict";
                    if (!w.loadCSS) {
                        w.loadCSS = function (){};
                    }
                    var rp = loadCSS.relpreload = {};
                    rp.support                  = (function () {
                        var ret;
                        try {
                            ret = w.document.createElement("link").relList.supports("preload");
                        } catch (e) {
                            ret = false;
                        }
                        return function () {
                            return ret;
                        };
                    })();
                    rp.bindMediaToggle          = function (link) {
                        var finalMedia = link.media || "all";

                        function enableStylesheet() {
                            if (link.addEventListener) {
                                link.removeEventListener("load", enableStylesheet);
                            } else if (link.attachEvent) {
                                link.detachEvent("onload", enableStylesheet);
                            }
                            link.setAttribute("onload", null);
                            link.media = finalMedia;
                        }

                        if (link.addEventListener) {
                            link.addEventListener("load", enableStylesheet);
                        } else if (link.attachEvent) {
                            link.attachEvent("onload", enableStylesheet);
                        }
                        setTimeout(function () {
                            link.rel   = "stylesheet";
                            link.media = "only x";
                        });
                        setTimeout(enableStylesheet, 3000);
                    };

                    rp.poly = function () {
                        if (rp.support()) {
                            return;
                        }
                        var links = w.document.getElementsByTagName("link");
                        for (var i = 0; i < links.length; i++) {
                            var link = links[i];
                            if (link.rel === "preload" && link.getAttribute("as") === "style" && !link.getAttribute("data-loadcss")) {
                                link.setAttribute("data-loadcss", true);
                                rp.bindMediaToggle(link);
                            }
                        }
                    };

                    if (!rp.support()) {
                        rp.poly();

                        var run = w.setInterval(rp.poly, 500);
                        if (w.addEventListener) {
                            w.addEventListener("load", function () {
                                rp.poly();
                                w.clearInterval(run);
                            });
                        } else if (w.attachEvent) {
                            w.attachEvent("onload", function () {
                                rp.poly();
                                w.clearInterval(run);
                            });
                        }
                    }

                    if (typeof exports !== "undefined") {
                        exports.loadCSS = loadCSS;
                    }
                    else {
                        w.loadCSS = loadCSS;
                    }
                }(typeof global !== "undefined" ? global : this));
            </script>
            {* RSS *}
            {if isset($Einstellungen.rss.rss_nutzen) && $Einstellungen.rss.rss_nutzen === 'Y'}
                <link rel="alternate" type="application/rss+xml" title="Newsfeed {$Einstellungen.global.global_shopname}"
                      href="{$ShopURL}/rss.xml">
            {/if}
            {* Languages *}
            {if !empty($smarty.session.Sprachen) && count($smarty.session.Sprachen) > 1}
                {foreach $smarty.session.Sprachen as $language}
                    <link rel="alternate"
                          hreflang="{$language->getIso639()}"
                          href="{if $language->getShopDefault() === 'Y' && isset($Link) && $Link->getLinkType() === $smarty.const.LINKTYP_STARTSEITE}{$ShopURL}/{else}{$language->getUrl()}{/if}">
                {/foreach}
            {/if}
        {/block}

        {if isset($Suchergebnisse) && $Suchergebnisse->getPages()->getMaxPage() > 1}
            {block name='layout-header-prev-next'}
                {if $Suchergebnisse->getPages()->getCurrentPage() > 1}
                    <link rel="prev" href="{$filterPagination->getPrev()->getURL()}">
                {/if}
                {if $Suchergebnisse->getPages()->getCurrentPage() < $Suchergebnisse->getPages()->getMaxPage()}
                    <link rel="next" href="{$filterPagination->getNext()->getURL()}">
                {/if}
            {/block}
        {/if}
        {$dbgBarHead}

        <script>
            window.lazySizesConfig = window.lazySizesConfig || {};
            window.lazySizesConfig.expand  = 50;
        </script>
        <script src="{$ShopURL}/templates/NOVA/js/jquery-3.5.1.min.js"></script>
        <script src="{$ShopURL}/templates/NOVA/js/lazysizes.min.js"></script>
        <script src="{$ShopURL}/templates/cartzilla/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>

        {if $Einstellungen.template.general.use_minify === 'N'}
            {if isset($cPluginJsHead_arr)}
                {foreach $cPluginJsHead_arr as $cJS}
                    <script defer src="{$ShopURL}/{$cJS}?v={$nTemplateVersion}"></script>
                {/foreach}
            {/if}
            {foreach $cJS_arr as $cJS}
                <script defer src="{$ShopURL}/{$cJS}?v={$nTemplateVersion}"></script>
            {/foreach}
            {foreach $cPluginJsBody_arr as $cJS}
                <script defer src="{$ShopURL}/{$cJS}?v={$nTemplateVersion}"></script>
            {/foreach}
        {else}
            {foreach $minifiedJS as $item}
                <script defer src="{$ShopURL}/{$item}"></script>
            {/foreach}
        {/if}

        {if file_exists($currentTemplateDirFullPath|cat:'js/custom.js')}
            <script defer src="{$ShopURL}/{$currentTemplateDir}js/custom.js?v={$nTemplateVersion}"></script>
        {/if}

        {getUploaderLang iso=$smarty.session.currentLanguage->getIso639()|default:'' assign='uploaderLang'}

        {block name='layout-header-head-resources-preload'}
        {/block}
        {block name='layout-header-head-resources-modulepreload'}
            <link rel="modulepreload" href="{$ShopURL}/templates/cartzilla/js/app/globals.js" as="script" crossorigin>
            <link rel="modulepreload" href="{$ShopURL}/templates/cartzilla/js/app/snippets/form-counter.js" as="script" crossorigin>
            <link rel="modulepreload" href="{$ShopURL}/templates/cartzilla/js/app/plugins/navscrollbar.js" as="script" crossorigin>
            <link rel="modulepreload" href="{$ShopURL}/templates/cartzilla/js/app/plugins/tabdrop.js" as="script" crossorigin>
            <link rel="modulepreload" href="{$ShopURL}/templates/cartzilla/js/app/views/header.js" as="script" crossorigin>
            <link rel="modulepreload" href="{$ShopURL}/templates/cartzilla/js/app/views/productdetails.js" as="script" crossorigin>
        {/block}
        {if !empty($oUploadSchema_arr)}
            <script defer src="{$ShopURL}/templates/NOVA/js/fileinput/fileinput.min.js"></script>
            <script defer src="{$ShopURL}/templates/NOVA/js/fileinput/themes/fas/theme.min.js"></script>
            <script defer src="{$ShopURL}/templates/NOVA/js/fileinput/locales/{$uploaderLang}.js"></script>
        {/if}
        {if $Einstellungen.preisverlauf.preisverlauf_anzeigen === 'Y' && !empty($bPreisverlauf)}
            <script defer src="{$ShopURL}/templates/NOVA/js/Chart.bundle.min.js"></script>
        {/if}
				<script type="module" src="{$ShopURL}/templates/cartzilla/js/app/app.js"></script>
    </head>
    {/block}

    {has_boxes position='left' assign='hasLeftPanel'}
    {block name='layout-header-body-tag'}
      <body class="{if $Einstellungen.template.theme.button_animated === 'Y'}btn-animated{/if}
       {if $Einstellungen.template.theme.wish_compare_animation === 'mobile'
          || $Einstellungen.template.theme.wish_compare_animation === 'both'}wish-compare-animation-mobile{/if}
       {if $Einstellungen.template.theme.wish_compare_animation === 'desktop'
          || $Einstellungen.template.theme.wish_compare_animation === 'both'}wish-compare-animation-desktop{/if}
       {if $isMobile}is-mobile{/if}
       {if $nSeitenTyp === $smarty.const.PAGE_BESTELLVORGANG} is-checkout{/if} is-nova handheld-toolbar-enabled"
				data-page="{$nSeitenTyp}" {if isset($Link) && !empty($Link->getIdentifier())} id="{$Link->getIdentifier()}"{/if}>
      
      {if empty($smarty.session.Kunde->kKunde)}
      	{include file='snippets/quick_login.tpl'}
      {/if}
    {/block}
		{if !$bExclusive}
      {if !$isMobile}
        {include file=$opcDir|cat:'tpl/startmenu.tpl'}
      {/if}
  
      {if $bAdminWartungsmodus}
        {block name='layout-header-maintenance-alert'}
          <div class="alert alert-warning d-flex" role="alert">
            <div class="alert-icon">
              <i class="ci-security-announcement"></i>
            </div>
            <div>{lang key='adminMaintenanceMode'}</div>
          </div>
        {/block}
      {/if}
      {if $smarty.const.SAFE_MODE === true}
        {block name='layout-header-safemode-alert'}
          <div class="alert alert-warning d-flex" role="alert">
            <div class="alert-icon">
              <i class="ci-security-announcement"></i>
            </div>
            <div>{lang key='safeModeActive'}</div>
          </div>
        {/block}
      {/if}
      
      <div class="alert alert-warning d-flex" role="alert">
            <div class="alert-icon">
              <i class="ci-security-announcement"></i>
            </div>
            <div>alte Template Version</div>
          </div>
  
      {block name='layout-header-header'}
        <header class="d-print-none sticky-top" id="jtl-nav-wrapper">
          {block name='layout-header-container-inner'}
            {block name='layout-header-branding-top-bar'}
              <div id="header-top-bar" class="">
                {include file='layout/header_top_bar.tpl'}
              </div>
            {/block}
            <nav class="bg-light">
              <div class="navbar navbar-expand-lg navbar-light">
                <div class="container">
                  <a class="navbar-brand d-none d-sm-block flex-shrink-0" href="{$ShopURL}">
                    <img src="{$ShopLogoURL}" width="142" alt="{$Einstellungen.global.global_shopname}">
                  </a>
                  <a class="navbar-brand d-sm-none flex-shrink-0 me-2" href="{$ShopURL}">
                    <img src="{$ShopLogoURL}" width="74" alt="{$Einstellungen.global.global_shopname}">
                  </a>
                  {block name='layout-header-nav-icons-include-header-nav-search'}
                    {include file='layout/header_nav_search.tpl'}
                  {/block}
                  <div class="navbar-toolbar d-flex flex-shrink-0 align-items-center">
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#_mainNavigation">
                      <span class="navbar-toggler-icon"></span>
                    </button>
                    <a class="navbar-tool navbar-stuck-toggler" href="#">
                    	<span class="navbar-tool-tooltip">{lang key='menuName'}</span>
                      <div class="navbar-tool-icon-box">
                        <i class="navbar-tool-icon ci-menu"></i>
                      </div>
                    </a>
                    {if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
                      <a class="navbar-tool d-none d-lg-flex" href="{get_static_route id='wunschliste.php'}">
                        <div class="navbar-tool-icon-box">
                          <span class="navbar-tool-label" id="badge-wl-count">
                            {if isset($smarty.session.Wunschliste) && !empty($smarty.session.Wunschliste->CWunschlistePos_arr|count)}
                              {$smarty.session.Wunschliste->CWunschlistePos_arr|count}
                            {else}
                              0
                            {/if}
                          </span>
                          <i class="navbar-tool-icon ci-heart"></i>
                        </div>
                        <span class="navbar-tool-tooltip">{lang key='wishlist'}</span>
                      </a>
                    {/if}
                    {if $Einstellungen.vergleichsliste.vergleichsliste_anzeigen === 'Y'}
                      <a class="navbar-tool d-none d-lg-flex" href="{get_static_route id='vergleichsliste.php'}" id="shop-nav-compare">
                        <div class="navbar-tool-icon-box">
                          <span class="navbar-tool-label" id="comparelist-badge">
                            {if !empty($smarty.session.Vergleichsliste->oArtikel_arr)}
                              {$smarty.session.Vergleichsliste->oArtikel_arr|count}
                            {else}
                              0
                            {/if}
                          </span>
                          <i class="navbar-tool-icon ci-view-list"></i>
                        </div>
                        <span class="navbar-tool-tooltip">{lang key='compare'}</span>
                      </a>
                    {/if}
                    {if empty($smarty.session.Kunde->kKunde)}
                      {block name='layout-header-shop-nav-account-logged-out'}
                        <a class="navbar-tool ms-1 ms-lg-0 me-n1 me-lg-2" href="#signin-modal" data-bs-toggle="modal">
                          <div class="navbar-tool-icon-box">
                            <i class="navbar-tool-icon ci-user"></i>
                          </div>
                          <div class="navbar-tool-text ms-n3">
                            <small>{lang key='welcome' section='login'}, {lang key='login'}</small>{lang key='myAccount'}
                          </div>
                        </a>
                      {/block}
                    {else}
                      {block name='layout-header-shop-nav-account-logged-in'}
                        <div class="navbar-tool dropdown ms-3">
                          <a class="navbar-tool ms-1 ms-lg-0 me-n1 me-lg-2" href="{get_static_route id='jtl.php' secure=true}">
                            <div class="navbar-tool-icon-box">
                              <i class="navbar-tool-icon ci-user"></i>
                            </div>
                            <div class="navbar-tool-text ms-n3">
                              <small>{lang key='welcome' section='login'}, {$smarty.session.Kunde->cVorname}</small>{lang key='myAccount'}
                            </div>
                          </a>
                          <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-header" href="{get_static_route id='jtl.php' secure=true}" rel="nofollow" title="{lang key='myAccount'}"><h6>{lang key='myAccount'}</h6></a></li>
                            <li><a class="dropdown-item" href="{get_static_route id='jtl.php' secure=true}?bestellungen=1" rel="nofollow" title="{lang key='myOrders'}">{lang key='myOrders'}</a></li>
                            <li><a class="dropdown-item" href="{get_static_route id='jtl.php' secure=true}" rel="nofollow" title="{lang key='myPersonalData'}">{lang key='myPersonalData'}</a></li>
                            {if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
                              <li><a class="dropdown-item" href="{get_static_route id='wunschliste.php' secure=true}" rel="nofollow" title="{lang key='myWishlists'}">{lang key='myWishlists'}</a></li>
                            {/if}
                            <li><a class="dropdown-item" href="{get_static_route id='jtl.php' secure=true}?lieferadressen=1" rel="nofollow" title="{lang key='addresses' section='account data'}">{lang key='addresses' section='account data'}</a></li>
                            {dropdowndivider}
                            <li><a class="dropdown-item" href="{get_static_route id='jtl.php' secure=true}?logout=1" rel="nofollow" title="{lang key='logOut'}">{lang key='logOut'}</a></li>
                          </ul>
                        </div>
                      {/block}
                    {/if}
                    {include file='snippets/cart_dropdown.tpl'}
                  </div>
                </div>
              </div>
              <div class="navbar navbar-expand-lg navbar-light navbar-stuck-menu mt-n2 pt-0 pb-2">
                <div class="container">
                  <div class="collapse navbar-collapse" id="_mainNavigation">
                    <!-- Search-->
                    <div class="input-group d-lg-none my-3">
                      {form action="{get_static_route id='index.php'}" method='get' class='w-100'}
                        <i class="ci-search position-absolute top-50 end-0 translate-middle-y text-muted fs-base me-3"></i>
                        <input class="form-control rounded-start ac_input" type="text" placeholder="{lang key='findProduct'}" name="qs" autocomplete="off">
                      {/form}
                    </div>
                    {block name='layout-header-include-categories-mega'}
                      {block name='layout-header-include-include-categories-body'}
                        <div class="nav-mobile-body d-block d-md-flex">
                          {block name='layout-header-include-include-categories-mega'}
                            {include file='snippets/categories_mega.tpl'}
                          {/block}
                        </div>
                      {/block}
                    {/block}
                  </div>
                </div>
              </div>
            </nav>
          {/block}
        </header>
      {/block}
      
      {block name='layout-header-fluid-banner'}
        {block name='layout-header-fluid-banner-include-banner'}
          {include file='snippets/banner.tpl' isFluid=true}
        {/block}
        {block name='layout-header-fluid-banner-include-slider'}
        	{include file='snippets/slider.tpl' isFluid=true}
        {/block}
      {/block}
      
      {block name='layout-header-main-wrapper-starttag'}
        <main id="main-wrapper" class="flex-shrink-0 mb-5{if $bExclusive} exclusive{/if}{if $hasLeftPanel} aside-active{/if}">
        {opcMountPoint id='opc_before_main' inContainer=false}
      {/block}
  
      {block name='layout-header-content-all-starttags'}
        {block name='layout-header-content-wrapper-starttag'}
          <div id="content-wrapper" class="{if ($Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive) || $smarty.const.PAGE_ARTIKELLISTE === $nSeitenTyp}has-left-sidebar{/if}{if $smarty.const.PAGE_ARTIKELLISTE === $nSeitenTyp} is-item-list{/if}">
        {/block}
  
        {block name='layout-header-content-starttag'}
          <div id="content">
        {/block}
  
        {block name='layout-header-alert'}
          {include file='snippets/alert_list.tpl'}
        {/block}
      {/block}{* /content-all-starttags *}
		{/if}
{/block}
