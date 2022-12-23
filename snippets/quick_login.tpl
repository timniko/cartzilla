<!-- Sign in / sign up modal-->
<div class="modal fade" id="signin-modal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header bg-secondary">
        <i class="ci-unlocked me-2 mt-n1"></i><span class="fw-medium">{lang key='login'}</span>
        <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body py-4">
        {form action="{get_static_route id='jtl.php' secure=true}" method="post" class="jtl-validate needs-validatione"}
          {block name='layout-header-shop-nav-account-form-content'}
            {block name='layout-header-nav-account-form-email'}
              <div class="mb-3">
                <label class="form-label" for="email_quick">{lang key='emailadress'}</label>
                <input class="form-control" type="email" id="email_quick" name="email" placeholder="max@mustermann.de" autocomplete="email" required>
                <div class="invalid-feedback">Please provide a valid email address.</div>
              </div>
            {/block}
            {block name='layout-header-nav-account-form-password'}
              <div class="mb-3">
                <label class="form-label" for="password_quick">{lang key='password'}</label>
                <div class="password-toggle">
                  <input class="form-control" type="password" id="password_quick" name="passwort" autocomplete="current-password" required>
                  <label class="password-toggle-btn" aria-label="Show/hide password">
                    <input class="password-toggle-check" type="checkbox"><span class="password-toggle-indicator"></span>
                  </label>
                </div>
              </div>
            {/block}
            
            <div class="mb-3 d-flex flex-wrap justify-content-between">
              {block name='layout-header-nav-account-link-register'}
                {link href="{get_static_route id='registrieren.php'}" rel="nofollow" title="{lang key='registerNow'}"}
                  <i class="ci-user me-2 mt-n1"></i>{lang key='registerNow'}
                {/link}
              {/block}
              {block name='layout-header-nav-account-link-forgot-password'}
                {link href="{get_static_route id='pass.php'}" rel="nofollow" title="{lang key='forgotPassword'}" class="fs-sm"}
                  {lang key='forgotPassword'}
                {/link}
              {/block}
            </div>
            
            {block name='layout-header-nav-account-form-captcha'}
              {if isset($showLoginCaptcha) && $showLoginCaptcha}
                {formgroup class="simple-captcha-wrapper"}
                  {captchaMarkup getBody=true}
                {/formgroup}
              {/if}
            {/block}
            {block name='layout-header-shop-nav-account-form-submit'}
              {formgroup}
                {input type="hidden" name="login" value="1"}
                {if !empty($oRedirect->cURL)}
                  {foreach $oRedirect->oParameter_arr as $oParameter}
                    {input type="hidden" name=$oParameter->Name value=$oParameter->Wert}
                  {/foreach}
                  {input type="hidden" name="r" value=$oRedirect->nRedirect}
                  {input type="hidden" name="cURL" value=$oRedirect->cURL}
                {/if}
                <button class="btn btn-primary btn-shadow d-block w-100" id="submit-btn" type="submit">{lang key='login'}</button>
              {/formgroup}
            {/block}
          {/block}
        {/form}
      </div>
    </div>
  </div>
</div>