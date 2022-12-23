{block name='account-index'}
		{cz_step step=$step}
    {block name='include-header'}
        {include file='layout/header.tpl'}
    {/block}

    {block name='account-index-content'}

				{opcMountPoint id='opc_before_account'}
        
        <!-- Page Title-->
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
              {if isset($smarty.get.reg)}
                  {block name='account-index-alert'}
                      {container fluid=$Link->getIsFluid() class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
                          <div class="alert alert-info d-flex" role="alert">
                            <div class="alert-icon">
                              <i class="ci-announcement"></i>
                            </div>
                            <div>{lang key='accountCreated' section='global'}</div>
                          </div>
                      {/container}
                  {/block}
              {/if}
              {block name='account-index-include-extension'}
                  {include file='snippets/extension.tpl'}
              {/block}
      
              {if isset($nWarenkorb2PersMerge) && $nWarenkorb2PersMerge === 1}
                  {block name='account-index-script-basket-merge'}
                      {inline_script}<script>
                          eModal.addLabel('{lang key='yes' section='global'}', '{lang key='no' section='global'}');
                          var options = {
                              message: '{lang key='basket2PersMerge' section='login'}',
                              label: '{lang key='yes' section='global'}',
                              title: '{lang key='basket' section='global'}'
                          };
                          eModal.confirm(options).then(
                              function() {
                                  window.location = "{get_static_route id='bestellvorgang.php'}?basket2Pers=1&token={$smarty.session.jtl_token}"
                              }
                          );
                      </script>{/inline_script}
                  {/block}
              {/if}
              <!-- Toolbar-->
              <div class="d-none d-lg-flex justify-content-between align-items-center pt-lg-3 pb-4 pb-lg-5 mb-lg-3">
                {if $cz_step === 'login'}
									{block name='account-login-heading'}
										<h6 class="fs-base text-light mb-0">{lang key='loginForRegisteredCustomers' section='checkout'}</h6>
                    {if !empty($smarty.session.Kunde->kKunde)}
                      <a class="btn btn-primary btn-sm" href="{get_static_route id='jtl.php' secure=true}?logout=1" rel="nofollow" title="{lang key='logOut'}"><i class="ci-sign-out me-2"></i>{lang key='logOut'}</a>
                    {/if}
									{/block}
									</div>
                  {block name='account-index-include-login'}
										{include file='account/login.tpl'}
                  {/block}
                {elseif $cz_step === 'mein Konto'}
                    <h6 class="fs-base text-light mb-0">{lang key='myPersonalData'}</h6>
                    {if !empty($smarty.session.Kunde->kKunde)}
                      <a class="btn btn-primary btn-sm" href="{get_static_route id='jtl.php' secure=true}?logout=1" rel="nofollow" title="{lang key='logOut'}"><i class="ci-sign-out me-2"></i>{lang key='logOut'}</a>
                    {/if}
                  </div>
                  {opcMountPoint id='opc_before_account_page'}
                  {block name='account-index-include-my-account'}
                    {include file='account/my_account.tpl'}
                  {/block}
                {elseif $cz_step === 'rechnungsdaten'}
                    <h6 class="fs-base text-light mb-0">{lang key='myPersonalData'}</h6>
                    {if !empty($smarty.session.Kunde->kKunde)}
                      <a class="btn btn-primary btn-sm" href="{get_static_route id='jtl.php' secure=true}?logout=1" rel="nofollow" title="{lang key='logOut'}"><i class="ci-sign-out me-2"></i>{lang key='logOut'}</a>
                    {/if}
                  </div>
                  {opcMountPoint id='opc_before_account_page'}
                    {block name='account-index-include-address-form'}
                      {include file='account/my_account.tpl'}
                    {/block}
                {elseif $cz_step === 'passwort aendern'}
                    {block name='account-index-include-change-password'}
                        {include file='account/change_password.tpl'}
                    {/block}
                {elseif $cz_step === 'bestellung'}
                    {block name='account-order-details-heading'}
                      <h6 class="fs-base text-light mb-0">{lang key='yourOrderId' section='checkout'}: {$Bestellung->cBestellNr}</h6>
                    {/block}
                    {if !empty($smarty.session.Kunde->kKunde)}
                      <a class="btn btn-primary btn-sm" href="{get_static_route id='jtl.php' secure=true}?logout=1" rel="nofollow" title="{lang key='logOut'}"><i class="ci-sign-out me-2"></i>{lang key='logOut'}</a>
                    {/if}
                  </div>
                  {block name='account-index-include-order-details'}
                      {include file='account/order_details.tpl'}
                  {/block}
                {elseif $cz_step === 'bestellungen'}
                      {block name='heading'}
                        <h6 class="fs-base text-light mb-0">{lang key='yourOrders' section='login'}</h6>
                      {/block}
                      {if !empty($smarty.session.Kunde->kKunde)}
                        <a class="btn btn-primary btn-sm" href="{get_static_route id='jtl.php' secure=true}?logout=1" rel="nofollow" title="{lang key='logOut'}"><i class="ci-sign-out me-2"></i>{lang key='logOut'}</a>
                      {/if}
                    </div>
                    {block name='account-index-include-orders'}
                        {include file='account/orders.tpl'}
                    {/block}
                {elseif $cz_step === 'account loeschen'}
                    {block name='account-index-include-delete-account'}
                        {include file='account/delete_account.tpl'}
                    {/block}
                {elseif $cz_step === 'kunden_werben_kunden'}
                    {block name='account-index-include-customers-recruiting'}
                        {include file='account/customers_recruiting.tpl'}
                    {/block}
                {elseif $cz_step === 'bewertungen'}
                    {block name='account-index-include-feedback'}
                        {include file='account/feedback.tpl'}
                    {/block}
								{elseif $cz_step === 'lieferadressen'}
                    <h6 class="fs-base text-light mb-0">{lang key='addresses' section='account data'}</h6>
                    {if !empty($smarty.session.Kunde->kKunde)}
                      <a class="btn btn-primary btn-sm" href="{get_static_route id='jtl.php' secure=true}?logout=1" rel="nofollow" title="{lang key='logOut'}"><i class="ci-sign-out me-2"></i>{lang key='logOut'}</a>
                    {/if}
									</div>
                  {include file='account/lieferadressen.tpl'}
                {else}
                    {block name='account-index-include-my-account-default'}
                        {include file='account/my_account.tpl'}
                    {/block}
                {/if}
              </div>
						</section>
					</div>
				</div>
    {/block}

    {block name='account-index-include-footer'}
        {include file='layout/footer.tpl'}
    {/block}
{/block}
