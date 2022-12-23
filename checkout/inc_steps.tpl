{block name='checkout-inc-steps'}
  <div class="steps steps-light pt-2 pb-3 mb-5">
    {block name='checkout-inc-steps-first'}
      <a class="step-item active{if $step == 'accountwahl' || $step == 'edit_customer_address' || $step == 'Lieferadresse'} current{/if}" href="{get_static_route id='bestellvorgang.php'}?editRechnungsadresse=1" title="{lang section='account data' key='billingAndDeliveryAddress'}">
        <div class="step-progress">
          <span class="step-count">1</span>
        </div>
        <div class="step-label">
          <i class="ci-user-circle d-none d-md-inline-block"></i>{lang section='account data' key='address'}
        </div>
      </a>
    {/block}
    {block name='checkout-inc-steps-second'}
      <a class="step-item{if $step == 'Zahlung' || $step == 'ZahlungZusatzschritt' || $step == 'Bestaetigung' || $step == 'Versand'} active{/if}{if $step == 'Versand'} current{/if}" href="{get_static_route id='bestellvorgang.php'}?editVersandart=1">
        <div class="step-progress">
          <span class="step-count">2</span>
        </div>
        <div class="step-label">
          <i class="ci-package d-none d-md-inline-block"></i>{lang section='basket' key='shipping'}
        </div>
      </a>
    {/block}
    <a class="step-item{if $step == 'Zahlung' || $step == 'ZahlungZusatzschritt' || $step == 'Bestaetigung'} active{/if}{if $step == 'Zahlung' || $step == 'ZahlungZusatzschritt'} current{/if}" href="{get_static_route id='bestellvorgang.php'}?editZahlungsart=1">
      <div class="step-progress">
        <span class="step-count">3</span>
      </div>
      <div class="step-label">
        <i class="ci-card d-none d-md-inline-block"></i>{lang section='checkout' key='paymentMethod'}
      </div>
    </a>
    {block name='checkout-inc-steps-third'}
      <a class="step-item{if $step == 'Bestaetigung'} active{/if}{if $step == 'Bestaetigung'} current{/if}" href="{get_static_route id='bestellvorgang.php'}">
        <div class="step-progress">
          <span class="step-count">4</span>
        </div>
        <div class="step-label">
          <i class="ci-check-circle d-none d-md-inline-block"></i>{lang section='custom' key='summary'}
        </div>
      </a>
    {/block}
  </div>
{/block}
