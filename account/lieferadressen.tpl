{form method="post" action="{get_static_route id='jtl.php' params=['czlfaed' => 1]}" class="needs-validation modal fade" id="add-address" slide=false novalidate=true}
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title modAddress d-none">{lang key='modifyShippingAdress' section='checkout'}</h5>
        <h5 class="modal-title newAddress">{lang key='createNewShippingAdress' section='account data'}</h5>
        <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="lfa_notice alert alert-primary d-flex d-none" role="alert">
          <div class="alert-icon">
            <i class="ci-bell"></i>
          </div>
          <div>{lang key='lfa_notice' section='custom'}</div>
        </div>
        {block name='account-address-form-include-inc-billing-address-form'}
          {include file='checkout/inc_billing_address_form.tpl' billing=false}
        {/block}
        <input type="hidden" name="id" value="" />
      </div>
      <div class="modal-footer border-0">
        <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">{lang key='close' section='consent'}</button>
        <button class="btn btn-primary btn-shadow" type="submit" value="1">{lang key='saveConfiguration' section='productDetails'}</button>
      </div>
    </div>
  </div>
{/form}
{if isset($lfa_saved)}
	<div class="alert alert-info alert-dismissible fade show d-flex" role="alert">
    <div class="alert-icon">
      <i class="ci-announcement"></i>
    </div>
    <div>
    	{lang key='dataEditSuccessful' section='login'}
    	<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
  </div>
{/if}
{getLieferAdressen}
<div class="table-responsive fs-md">
  <table class="table table-hover mb-0">
    <thead>
      <tr>
      	<th></th>
        <th>{lang key='address' section='account data'}</th>
        <th>{lang key='edit'}</th>
      </tr>
    </thead>
    <tbody>
      {foreach $LieferAdressen as $lfa}
        <tr data-lfa-cStrasse="{$lfa->cStrasse}"
        data-lfa-cHausnummer="{$lfa->cHausnummer}"
        data-lfa-cPLZ="{$lfa->cPLZ}"
        data-lfa-cOrt="{$lfa->cOrt}"
        data-lfa-cLand="{$lfa->cLand}"
        data-lfa-cAnrede="{$lfa->cAnrede}"
        data-lfa-cVorname="{$lfa->cVorname}"
        data-lfa-cNachname="{$lfa->cNachname}"
        data-lfa-cFirma="{$lfa->cFirma}"
        data-lfa-cZusatz="{$lfa->cZusatz}"
        data-lfa-cAdressZusatz="{$lfa->cAdressZusatz}"
        data-lfa-cBundesland="{$lfa->cBundesland}"
        data-lfa-cMail="{$lfa->cMail}"
        data-lfa-cTel="{$lfa->cTel}"
        data-lfa-cMobil="{$lfa->cMobil}"
        data-lfa-id="{$lfa->kLieferadresse}">
          <td class="py-3 align-middle">{if $lfa->kLieferadresse > 0}{$lfa->kLieferadresse}{else}-{/if}</td>
          <td class="py-3 align-middle">
          	{$lfa->cStrasse} {$lfa->cHausnummer}, {$lfa->cPLZ} {$lfa->cOrt}, {$lfa->cLand}
          </td>
          <td class="py-3 align-middle">
            <a class="nav-link-style me-2 lfa_edit" href="#add-address" data-bs-toggle="modal" title="{lang key='edit'}">
              <i class="ci-edit"></i>
            </a>
            {if $lfa->kLieferadresse > 0}
              <a class="nav-link-style text-danger" href="{get_static_route id='jtl.php' secure=true}?czlfadl={$lfa->kLieferadresse}" data-bs-toggle="tooltip" title="{lang key='wishlisteDelete' section='login'}">
                <div class="ci-trash"></div>
              </a>
            {/if}
          </td>
        </tr>
			{/foreach}
    </tbody>
  </table>
</div>
<div class="text-sm-end pt-4">
  <a class="btn btn-primary addModal" href="#add-address" data-bs-toggle="modal">{lang key='createNewShippingAdress' section='account data'}</a>
</div>
<script>
function fillForm(form, data){
	var key = "";
	$.each(data, function(i, v){
		key = i.replace("lfaC", "");
		key = key.replace("lfa", "");
		key = key.toLowerCase();
		if(key == "Id")key = "id";
		if(key == "mail")key = "email";
		var inp = form.find("input[name='" + key + "']");
		if(inp.length){
			if(inp.attr("type") == "checkbox"){
				if(v){
					inp.prop("checked", true);
				}
			}else{
				inp.val(v);
				if(key == "id" && v == 0){
					form.find(".lfa_notice").removeClass("d-none");
				}
			}
		}else{
			var sel = form.find("select[name='" + key + "'] option[value='" + v + "']");
			if(sel.length){
				sel.prop("selected", true);
			}
		}
	});
}
function resetForm(form){
	form.find(".lfa_notice").addClass("d-none");
	form.find("input").each(function(){
		$(this).val("");
		$(this).prop("checked", false);
		$(this).prop("selected", false);
	});
}
$(".addModal").on("click", function(e){
	e.preventDefault();
	var adModal = $("#add-address .modal-body");
	resetForm(adModal);
	$("#add-address input[name='id']").val(0);
	$("#add-address .newAddress").removeClass("d-none");
	$("#add-address .modAddress").addClass("d-none");
	return false;
});
$(".lfa_edit").on("click", function(e){
	e.preventDefault();
	var tr = $(this).closest("tr");
	var adModal = $("#add-address .modal-body");
	resetForm(adModal);
	fillForm(adModal, tr.data());
	$("#add-address .modAddress").removeClass("d-none");
	$("#add-address .newAddress").addClass("d-none");
	return false;
});
</script>