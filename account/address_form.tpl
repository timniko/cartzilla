{block name='account-address-form'}
  {block name='account-address-form-form-rechnungsdaten'}
    {form method="post" id='rechnungsdaten' action="{get_static_route params=['editRechnungsadresse' => 1]}" class="needs-validation" slide=false novalidate=true enctype="multipart/form-data"}
      <div class="bg-secondary rounded-3 p-4 mb-4">
        <div class="d-flex align-items-center">
          <div class="file-drop-area w-100 bg-none">
            <div class="file-drop-icon ci-cloud-upload"></div>
            <span class="file-drop-message">Drag and drop here to upload</span>
            <input type="file" name="avatar" class="file-drop-input">
            <div class="ps-3">
              <button class="file-drop-btn btn btn-primary btn-sm mb-2" type="button">
                <i class="ci-loading me-2"></i>Change avatar
              </button>
            	<div class="p mb-0 fs-ms text-muted">Upload JPG, GIF or PNG image. 300 x 300 required.</div>
          	</div>
          </div>
        </div>
      </div>
      <div id="panel-address-form">
        {block name='account-address-form-include-inc-billing-address-form'}
          {include file='checkout/inc_billing_address_form.tpl'}
        {/block}
      </div>
    {/form}
  {/block}
{/block}