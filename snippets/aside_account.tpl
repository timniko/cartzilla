<aside class="col-lg-4 pt-4 pt-lg-0 pe-xl-5{if !isset($smarty.session.Kunde->kKunde)} blr disable-links{/if}" id="accSidebar">
  <div class="bg-white rounded-3 shadow-lg pt-1 mb-5 mb-lg-0">
    <div class="d-md-flex justify-content-between align-items-center text-center text-md-start p-4">
      <div class="d-md-flex align-items-center">
				{if isset($smarty.session.Kunde->kKunde)}
					{getAvatar}
          <div class="img-thumbnail rounded-circle position-relative flex-shrink-0 mx-auto mb-2 mx-md-0 mb-md-0{if $Avatar == ""} text-center{/if}" style="width: 6.375rem;">
						<span class="badge bg-warning position-absolute end-0 mt-n2" data-bs-toggle="tooltip" title="{lang key='yourMoneyOnAccount' section='login'}">{$smarty.session.Kunde->cGuthabenLocalized}</span>
            {if $Avatar != ""}
              <img class="rounded-circle cz_avatar m90" src="{$Avatar}" alt="{$smarty.session.Kunde->cVorname} {$smarty.session.Kunde->cNachname}">
            {else}
              <i class="ci-user rounded-circle display-1"></i>
            {/if}
					</div>
				{else}
        	<div class="img-thumbnail rounded-circle position-relative flex-shrink-0 mx-auto mb-2 mx-md-0 mb-md-0 text-center" style="width: 6.375rem;">
						<i class="ci-user rounded-circle display-1"></i>
					</div>
        {/if}
        <div class="ps-md-3">
          <h3 class="fs-base mb-0 text-break">{if isset($smarty.session.Kunde->kKunde)}{$smarty.session.Kunde->cVorname} {$smarty.session.Kunde->cNachname}{else}Max Mustermann{/if}</h3>
          <span class="text-accent fs-sm text-break">{if isset($smarty.session.Kunde->kKunde)}{$smarty.session.Kunde->cMail}{else}max@mustergmbh.de{/if}</span>
        </div>
      </div>
      <a class="btn btn-primary d-lg-none mb-2 mt-3 mt-md-0" href="#account-menu" data-bs-toggle="collapse" aria-expanded="false">
        <i class="ci-menu me-2"></i>{lang key='menuName'}
      </a>
    </div>
    <div class="d-lg-block collapse" id="account-menu">
      <div class="bg-secondary px-4 py-3">
        <h3 class="fs-sm mb-0 text-muted">{lang key='accountOverview' section='account data'}</h3>
      </div>
      <ul class="list-unstyled mb-0">
        <li class="border-bottom mb-0">
          <a class="nav-link-style d-flex align-items-center px-4 py-3{if $cz_step === 'bestellungen'} active{/if}" href="{get_static_route id='jtl.php' secure=true}?bestellungen=1" rel="nofollow">
            <i class="ci-bag opacity-60 me-2"></i>
            {getBestellungen}
            {lang key='orders' section='account data'}<span class="fs-sm text-muted ms-auto">{$BestellCnt}</span>
          </a>
        </li>
        {if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
          <li class="border-bottom mb-0">
            <a class="nav-link-style d-flex align-items-center px-4 py-3{if $cz_step === 'cz'} active{/if}" href="{get_static_route id='wunschliste.php'}" rel="nofollow">
              <i class="ci-heart opacity-60 me-2"></i>
              {getWunschzettel}
              {lang key='wishlists' section='account data'}<span class="fs-sm text-muted ms-auto">{$WunschCnt}</span>
            </a>
          </li>
        {/if}
      </ul>
      <div class="bg-secondary px-4 py-3">
        <h3 class="fs-sm mb-0 text-muted">{lang key='contactInformation' section='account data'}</h3>
      </div>
      <ul class="list-unstyled mb-0">
        <li class="border-bottom mb-0">
          <a class="nav-link-style d-flex align-items-center px-4 py-3{if $cz_step === 'mein Konto'} active{/if}" href="{get_static_route id='jtl.php' secure=true}" rel="nofollow">
            <i class="ci-user opacity-60 me-2"></i>{lang key='editCustomerData' section='account data'}
          </a>
        </li>
        <li class="border-bottom mb-0">
          <a class="nav-link-style d-flex align-items-center px-4 py-3{if $cz_step === 'lieferadressen'} active{/if}" href="{get_static_route id='jtl.php' secure=true}?lieferadressen=1" rel="nofollow">
            <i class="ci-location opacity-60 me-2"></i>
            {getAdressen}
            {lang key='addresses' section='account data'}<span class="fs-sm text-muted ms-auto">{$AdressCnt}</span>
          </a>
        </li>
        {if false}
          <li class="mb-0">
            <a class="nav-link-style d-flex align-items-center px-4 py-3" href="account-payment.html" rel="nofollow">
              <i class="ci-card opacity-60 me-2"></i>{lang key='modifyPaymentOption' section='checkout'}
            </a>
          </li>
        {/if}
        {if !empty($smarty.session.Kunde->kKunde)}
          <li class="d-lg-none border-top mb-0"><a class="nav-link-style d-flex align-items-center px-4 py-3" href="{get_static_route id='jtl.php' secure=true}?logout=1" rel="nofollow"><i class="ci-sign-out opacity-60 me-2"></i>{lang key='logOut'}</a></li>
        {/if}
      </ul>
    </div>
  </div>
</aside>