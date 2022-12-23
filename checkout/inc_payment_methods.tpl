{block name='checkout-inc-payment-methods'}
  <div class="table-responsive">
    <table class="table table-hover fs-sm border-top">
      <thead>
        <tr>
          <th class="align-middle"></th>
          <th class="align-middle">{lang key='paymentOptions'}</th>
          <th class="align-middle">{lang key='fees' section='custom'} / {lang key='discount'}</th>
          <th class="align-middle">{lang key='note' section='custom'}</th>
        </tr>
      </thead>
      <tbody>
				{foreach $Zahlungsarten as $zahlungsart}
          <tr>
            <td class="align-middle">
              <div class="form-check checkout-payment-method m-0" id="{$zahlungsart->cModulId}">
                <input class="form-check-input" type="radio" id="payment{$zahlungsart->kZahlungsart}" name="Zahlungsart" value="{$zahlungsart->kZahlungsart}"{if $AktiveZahlungsart === $zahlungsart->kZahlungsart || $Zahlungsarten|@count === 1} checked{/if}{if $zahlungsart@first} required{/if}>
              </div>
            </td>
            <td class="align-middle">
            	<label class="form-check-label" for="payment{$zahlungsart->kZahlungsart}">
                {block name='checkout-inc-payment-methods-image-title'}
                  {if $zahlungsart->cBild && false}
                    {image src=$zahlungsart->cBild alt=$zahlungsart->angezeigterName|trans fluid=true class="img-sm"}
                  {else}
                    <span class="text-dark fw-medium">{$zahlungsart->angezeigterName|trans}</span>
                  {/if}
                {/block}
              </label>
            </td>
            <td class="align-middle">
            	{if $zahlungsart->fAufpreis != 0}
                {block name='checkout-inc-payment-methods-badge'}
                  {$zahlungsart->cPreisLocalized}
                  {if $zahlungsart->cGebuehrname|has_trans}
                    <br>
                    <span class="text-muted">{$zahlungsart->cGebuehrname|trans}</span>
                  {/if}
                {/block}
              {/if}
            </td>
            <td class="align-middle">
            	{if $zahlungsart->cHinweisText|has_trans}
                {block name='checkout-inc-payment-methods-note'}
									<span class="text-muted checkout-payment-method-note">{$zahlungsart->cHinweisText|trans}</span>
                {/block}
              {/if}
            </td>
          </tr>
        {/foreach}
      </tbody>
    </table>
  </div>
{/block}
