{block name='checkout-step1-edit-customer-address'}
    {if isset($editRechnungsadresse) && $editRechnungsadresse === 1 && !empty($smarty.session.Kunde->kKunde)}
        {assign var=unreg_form value=0}
        {assign var=unreg_step value=$step}
    {else}
        {assign var=unreg_form value=1}
        {assign var=unreg_step value='formular'}
    {/if}
    {if !empty($fehlendeAngaben) && !$alertNote}
        {block name='checkout-step1-edit-customer-address-alert'}
            {alert variant="danger"}{lang key='mandatoryFieldNotification' section='errorMessages'}{/alert}
        {/block}
    {/if}
    {row}
        {col cols=12}
            <div id="order-proceed-as-guest">
                {block name='checkout-step1-edit-customer-address-form'}
                    {form id="neukunde" method="post" action="{get_static_route id='bestellvorgang.php'}" class="jtl-validate" slide=true}
                        {block name='include-inc-billing-address-form'}
                            {include file='checkout/inc_billing_address_form.tpl' step=$unreg_step billing=false}
                        {/block}
                        {block name='include-inc-shipping-address'}
                            {include file='checkout/inc_shipping_address.tpl'}
                        {/block}
                        {block name='checkout-step1-edit-customer-address-form-submit'}
                            {input type="hidden" name="unreg_form" value=$unreg_form}
                            {input type="hidden" name="editRechnungsadresse" value=$editRechnungsadresse}
                            <input type="submit" class="d-none" name="submitButton">
                        {/block}
                    {/form}
                {/block}
            </div>
        {/col}
    {/row}
{/block}
