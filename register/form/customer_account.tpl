{block name='register-form-customer-account'}
    {block name='register-form-customer-account-include-inc-billing-address-form'}
        {include file='checkout/inc_billing_address_form.tpl' billing=false}
    {/block}
    {block name='register-form-customer-account-content'}
        {if !$editRechnungsadresse}
            {row class="register-form-account"}
                {block name='register-form-customer-account-unreg'}
                    {col cols=12 md=12}
                        {if !$smarty.session.Warenkorb->hasDigitalProducts() && isset($checkout)
                            && $Einstellungen.kaufabwicklung.bestellvorgang_unregistriert === 'Y'}
                            <div class="form-group checkbox register-form-account-unreg control-toggle form-check mt-3">
                                {input type="hidden" name="unreg_form" value="1"}
                                <input class="form-check-input" type="checkbox" id="checkout_create_account_unreg" value="0" name="unreg_form" data-bs-toggle="collapse" data-bs-target="#create_account_data"{if ($unregForm !== 1 && !empty($fehlendeAngaben))} checked{/if}>																<label for="checkout_create_account_unreg" class="form-check-label">
																	{lang key='createNewAccount' section='account data'}
                                </label>
                            </div>
                        {else}
                            {input type="hidden" name="unreg_form" value="0"}
                        {/if}
                    {/col}
                {/block}
                {block name='register-form-customer-account-password'}
                    {col cols=12 md=12}
                        {formrow id="create_account_data" class="row collapse collapse-non-validate {if empty($checkout)
                        || $smarty.session.Warenkorb->hasDigitalProducts()
                        || $Einstellungen.kaufabwicklung.bestellvorgang_unregistriert === 'N'
                        || ($unregForm !== 1 && !empty($fehlendeAngaben))}show{else}hidden{/if}" aria-expanded="true"}
                            {block name='register-form-customer-account-password-first'}
                                {col cols=12 md=6}
                                    <div class="form-group register-form-account-password d-flex flex-column {if isset($fehlendeAngaben.pass_zu_kurz) || isset($fehlendeAngaben.pass_ungleich) || isset($fehlendeAngaben.pass_zu_lang)} has-error{/if}" role="group">
                                        <label for="password" class="form-label">
                                            {lang key='password' section='account data'}
                                        </label>
                                        {input type="password"
                                            placeholder=" "
                                            id="password"
                                            required=true
                                            value=""
                                            name="pass"
                                            aria-autocomplete="none"
                                            autocomplete="new-password"
                                            maxlength="255"
                                            disabled=($unregForm === 1)
                                            class="form-control"
                                        }
                                        {if isset($fehlendeAngaben.pass_zu_kurz)}
                                            <div class="form-error-msg"><i class="fa fa-exclamation-triangle"></i>
                                                {lang key='passwordTooShort' section='login' printf=$Einstellungen.kunden.kundenregistrierung_passwortlaenge}
                                            </div>
                                        {elseif isset($fehlendeAngaben.pass_zu_lang)}
                                            <div class="form-error-msg"><i class="fa fa-exclamation-triangle"></i>
                                                {lang key='passwordTooLong' section='login'}
                                            </div>
                                        {/if}
                                    </div>
                                    {block name='account-change-password-include-password-check'}
                                        {include file='snippets/password_check.tpl' id='#password' loadScript=true}
                                    {/block}
                                {/col}
                            {/block}
                            {block name='register-form-customer-account-password-repeat'}
                                {col cols=12 md=6}
                                    <div class="form-group register-form-account-password-repeat {if isset($fehlendeAngaben.pass_zu_kurz) || isset($fehlendeAngaben.pass_ungleich) || isset($fehlendeAngaben.pass_zu_lang)} has-error{/if}" role="group">
                                        <label for="password2" class="form-label">
                                            {lang key='passwordRepeat' section='account data'}
                                        </label>
                                        {input
                                            type="password"
                                            name="pass2"
                                            id="password2"
                                            placeholder=" "
                                            required=true
                                            data=["must-equal-to"=>"#create_account_data input[name='pass']",
                                                "custom-message"=>"{lang key='passwordsMustBeEqual' section='account data'}"]
                                            autocomplete="new-password"
                                            aria-autocomplete="none"
                                            maxlength="255"
                                            disabled=($unregForm === 1)
                                            value=""
                                            class="form-control"
                                        }
                                        {if isset($fehlendeAngaben.pass_ungleich)}
                                            <div class="form-error-msg"><i class="fa fa-exclamation-triangle"></i>
                                                {lang key='passwordsMustBeEqual' section='account data'}
                                            </div>
                                        {/if}
                                    </div>
                                {/col}
                            {/block}
                        {/formrow}
                    {/col}
                {/block}
            {/row}
        {/if}
    {/block}
{/block}
