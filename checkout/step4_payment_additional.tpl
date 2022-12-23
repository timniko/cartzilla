{block name='checkout-step4-payment-additional'}
    {form id="form_payment_extra" class="form payment_extra" method="post" action="{get_static_route id='bestellvorgang.php'}" slide=true}
        {block name='checkout-step4-payment-additional-form-content'}
            <div id="order-additional-payment" class="checkout-additional-payment form-group">
                {block name='checkout-step4-payment-include-additional-steps'}
                    {include file=$Zahlungsart->cZusatzschrittTemplate}
                {/block}
                {input type="hidden" name="zahlungsartwahl" value="1"}
                {input type="hidden" name="zahlungsartzusatzschritt" value="1"}
                {input type="hidden" name="Zahlungsart" value=$Zahlungsart->kZahlungsart}
            </div>
            {block name='checkout-step4-payment-include-form-submit'}
								<input type="submit" class="d-none" name="submitButton" value="1">
            {/block}
        {/block}
    {/form}
{/block}
