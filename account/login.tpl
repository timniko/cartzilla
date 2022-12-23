{block name='account-login'}
    {if !$bCookieErlaubt}
      {block name='account-login-alert-no-cookie'}
          <div class="alert alert-danger d-none" role="alert" id="no-cookies-warning">
            <div class="alert-icon">
              <i class="ci-close-circle"></i>
            </div>
            <div>
            	<span class="fw-medium">{lang key='noCookieHeader' section='errorMessages'}</span> {lang key='noCookieDesc' section='errorMessages'}
            </div>
          </div>
      {/block}
      {block name='account-login-script-no-cookie'}
        {inline_script}<script>
				 $(function() {
					 if (navigator.cookieEnabled === false) {
						 $('#no-cookies-warning').removeClass("d-none").addClass("d-flex");
					 }
				 });
        </script>{/inline_script}
      {/block}
    {elseif !$alertNote}
      {block name='account-login-alert'}
        <div class="alert alert-info d-flex" role="alert">
          <div class="alert-icon">
            <i class="ci-announcement"></i>
          </div>
          <div>
            <span class="fw-medium">{lang key='loginDesc' section='login'}</span> {if isset($oRedirect->cName) && $oRedirect->cName}{lang key='redirectDesc1'} {$oRedirect->cName} {lang key='redirectDesc2'}.{/if}
          </div>
        </div>
      {/block}
    {/if}

    {block name='account-login-form'}
        {opcMountPoint id='opc_before_login'}
        {row class="login-form"}
            {col sm=8 lg=6}
                {form id="login_form" action="{get_static_route id='jtl.php'}" method="post" role="form" class="jtl-validate" slide=true}
                    <fieldset>
                        {block name='account-login-form-submit-legend-login'}{/block}
                        {block name='account-login-form-submit-body'}
                            {include file='snippets/form_group_simple.tpl'
                                options=[
                                    'email', 'email', 'email', null,
                                    {lang key='emailadress'}, true, null, "email"
                                ]
                            }

                            {include file='snippets/form_group_simple.tpl'
                                options=[
                                    'password', 'password', 'passwort', null,
                                    {lang key='password' section='account data'}, true, null, "current-password"
                                ]
                            }

                            {if isset($showLoginCaptcha) && $showLoginCaptcha}
                                {block name='account-login-form-submit-captcha'}
                                   {formgroup class="simple-captcha-wrapper"}
                                        {captchaMarkup getBody=true}
                                   {/formgroup}
                                {/block}
                            {/if}

                            {block name='account-login-form-submit'}
                                {formgroup class="login-form-submit mb-3"}
                                    {input type="hidden" name="login" value="1"}
                                    {if !empty($oRedirect->cURL)}
                                        {foreach $oRedirect->oParameter_arr as $oParameter}
                                            {input type="hidden" name=$oParameter->Name value=$oParameter->Wert}
                                        {/foreach}
                                        {input type="hidden" name="r" value=$oRedirect->nRedirect}
                                        {input type="hidden" name="cURL" value=$oRedirect->cURL}
                                    {/if}
                                    {block name='account-login-form-submit-button'}
                                        {button type="submit" value="1" block=true variant="primary"}
                                            {lang key='login' section='checkout'}
                                        {/button}
                                    {/block}
                                {/formgroup}
                            {/block}
                            {block name='account-login-form-submit-register'}
                                <span class="register-wrapper">
                                    {lang key='newHere'}
                                    {link class="register" href="{get_static_route id='registrieren.php'}"}
                                        {lang key='registerNow'}
                                    {/link}
                                </span>
                            {/block}
                            {block name='account-login-form-submit-resetpw'}
                                <span class="resetpw-wrapper">
                                   {link class="resetpw" href="{get_static_route id='pass.php'}"}
                                       <span class="fa fa-question-circle"></span> {lang key='forgotPassword'}
                                   {/link}
                                </span>
                            {/block}
                        {/block}
                    </fieldset>
                {/form}
            {/col}
        {/row}
    {/block}
{/block}
