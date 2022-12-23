{if !isset($billing)}
	{$billing=true}
{/if}
{block name='checkout-inc-billing-address-form'}
	<div class="row gx-4 gy-3">
  	{block name='checkout-inc-billing-address-form-salutation-title'}
			{if $Einstellungen.kunden.kundenregistrierung_abfragen_anrede !== 'N'}
      	{block name='checkout-inc-billing-address-form-salutation'}
        	<div class="col-sm-6">
            <label class="form-label" for="salutation">{lang key='salutation' section='account data'}{if $Einstellungen.kunden.kundenregistrierung_abfragen_anrede === 'O'}<small class='optional'> - {lang key='optional'}</small>{/if}</label>
            {select name="anrede" id="salutation" class='form-select' required=($Einstellungen.kunden.kundenregistrierung_abfragen_anrede === 'Y') autocomplete="billing sex"}
              <option value="" selected="selected" {if $Einstellungen.kunden.kundenregistrierung_abfragen_anrede === 'Y'}disabled{/if}>
                {if $Einstellungen.kunden.kundenregistrierung_abfragen_anrede === 'Y'}{lang key='salutation' section='account data'}{else}{lang key='noSalutation'}{/if}
              </option>
              <option value="w" {if isset($cPost_arr['anrede']) && $cPost_arr['anrede'] === 'w'}selected="selected"{elseif isset($Kunde->cAnrede) && $Kunde->cAnrede === 'w'}selected="selected"{/if}>{lang key='salutationW'}</option>
              <option value="m" {if isset($cPost_arr['anrede']) && $cPost_arr['anrede'] === 'm'}selected="selected"{elseif isset($Kunde->cAnrede) && $Kunde->cAnrede === 'm'}selected="selected"{/if}>{lang key='salutationM'}</option>
            {/select}
          </div>
        {/block}
      {/if}
		{/block}
    {block name='checkout-inc-billing-address-form-firstname-lastname'}
      <div class="col-sm-6">
       {if isset($cPost_arr['vorname'])}
          {assign var=inputVal_firstName value=$cPost_arr['vorname']}
        {elseif isset($Kunde->cVorname)}
          {assign var=inputVal_firstName value=$Kunde->cVorname}
        {/if}
        {block name='checkout-inc-billing-address-form-first-name'}
          <label class="form-label" for="firstName">{lang key='firstName' section='account data'}</label>
          <input class="form-control" name="vorname" type="text" id="firstName" autocomplete="billing given-name" value="{$inputVal_firstName|default:null}"{if $Einstellungen.kunden.kundenregistrierung_pflicht_vorname === 'Y'} required{/if}>
        {/block}
      </div>
      <div class="col-sm-6">
      	{if isset($cPost_arr['nachname'])}
          {assign var=inputVal_lastName value=$cPost_arr['nachname']}
        {elseif isset($Kunde->cNachname)}
          {assign var=inputVal_lastName value=$Kunde->cNachname}
        {/if}
				{block name='checkout-inc-billing-address-form-last-name'}
          <label class="form-label" for="lastName">{lang key='lastName' section='account data'}</label>
          <input class="form-control" name="nachname" type="text" id="lastName" autocomplete="billing family-name" value="{$inputVal_lastName|default:null}" required>
				{/block}
      </div>
    {/block}
    {block name='checkout-inc-billing-address-form-company-wrap'}
      {if $Einstellungen.kunden.kundenregistrierung_abfragen_firma !== 'N'}
        <div class="col-sm-6">
          {if isset($cPost_arr['firma'])}
            {assign var=inputVal_firm value=$cPost_arr['firma']}
          {elseif isset($Kunde->cFirma)}
            {assign var=inputVal_firm value=$Kunde->cFirma}
          {/if}
          {block name='checkout-inc-billing-address-form-company'}
            <label class="form-label" for="firm">{lang key='firm' section='account data'}{if $Einstellungen.kunden.kundenregistrierung_abfragen_firma === 'O'}<small class='optional'> - {lang key='optional'}</small>{/if}</label>
            <input class="form-control" name="firma" type="text" id="firm" autocomplete="billing organization" value="{$inputVal_firm|default:null}"{if $Einstellungen.kunden.kundenregistrierung_abfragen_firma === 'Y'} required{/if}>
          {/block}
        </div>
      {/if}
  
      {if $Einstellungen.kunden.kundenregistrierung_abfragen_firmazusatz !== 'N'}
        <div class="col-sm-6">
          {if isset($cPost_arr['firmazusatz'])}
            {assign var=inputVal_firmext value=$cPost_arr['firmazusatz']}
          {elseif isset($Kunde->cZusatz)}
            {assign var=inputVal_firmext value=$Kunde->cZusatz}
          {/if}
          {block name='checkout-inc-billing-address-form-company-additional'}
            <label class="form-label" for="firmext">{lang key='firmext' section='account data'}{if $Einstellungen.kunden.kundenregistrierung_abfragen_firmazusatz === 'O'}<small class='optional'> - {lang key='optional'}</small>{/if}</label>
            <input class="form-control" name="firmazusatz" type="text" id="firmext" value="{$inputVal_firmext|default:null}"{if $Einstellungen.kunden.kundenregistrierung_abfragen_firmazusatz === 'Y'} required{/if}>
          {/block}
        </div>
      {/if}
    {/block}
    
    {if $billing ||true}
      {if $Einstellungen.kunden.kundenregistrierung_abfragen_ustid !== 'N'}
        <div class="col-sm-6">
          {block name='checkout-inc-billing-address-form-vat'}
            <label class="form-label" for="ustid">
              {lang key='ustid' section='account data'}{if $Einstellungen.kunden.kundenregistrierung_abfragen_ustid !== 'Y'}<small class='optional'> - {lang key='optional'}</small>{/if}
            </label>
            <input class="form-control" name="ustid" type="text" id="ustid" value="{if isset($cPost_arr['ustid'])}{$cPost_arr['ustid']}{elseif isset($Kunde->cUSTID)}{$Kunde->cUSTID}{/if}"{if $Einstellungen.kunden.kundenregistrierung_abfragen_ustid === 'Y'} required{/if}>  
            {if isset($fehlendeAngaben.ustid)}
              <div class="invalid-tooltip">
                {if $fehlendeAngaben.ustid == 1}
                    {lang key='fillOut' section='global'}
                  {elseif $fehlendeAngaben.ustid == 2}
                    {assign var=errorinfo value=","|explode:$fehlendeAngaben.ustid_err}
                    {if $errorinfo[0] == 100}{lang key='ustIDError100' section='global'}{/if}
                    {if $errorinfo[0] == 110}{lang key='ustIDError110' section='global'}{/if}
                    {if $errorinfo[0] == 120}{lang key='ustIDError120' section='global'}{$errorinfo[1]}{/if}
                    {if $errorinfo[0] == 130}{lang key='ustIDError130' section='global'}{$errorinfo[1]}{/if}
                  {elseif $fehlendeAngaben.ustid == 4}
                    {assign var=errorinfo value=","|explode:$fehlendeAngaben.ustid_err}
                    {lang key='ustIDError200' section='global'}{$errorinfo[1]}
                  {elseif $fehlendeAngaben.ustid == 5}
                    {lang key='ustIDCaseFive' section='global'}
                  {/if}
              </div>
            {/if}
          {/block}
        </div>
      {/if}
    {/if}
    <div class="clearfix"></div>
    {block name='checkout-inc-billing-address-form-mail'}
      <div class="col-sm-6">
        {if isset($cPost_arr['email'])}
          {assign var=inputVal_email value=$cPost_arr['email']}
        {elseif isset($Kunde->cMail)}
          {assign var=inputVal_email value=$Kunde->cMail}
        {/if}
        <label class="form-label" for="email">{lang key='email' section='account data'}</label>
				<input class="form-control" name="email" type="email" id="email" autocomplete="billing email" value="{$inputVal_email|default:null}" required>
      </div>
    {/block}
		{if $Einstellungen.kunden.kundenregistrierung_abfragen_tel !== 'N' || $Einstellungen.kunden.kundenregistrierung_abfragen_mobil !== 'N' || $Einstellungen.kunden.kundenregistrierung_abfragen_www !== 'N'}
			{block name='checkout-inc-billing-address-form-phone-fax'}
				<div class="col-sm-6">  
					{block name='checkout-inc-billing-address-form-mobile-www'}
						{if $Einstellungen.kunden.kundenregistrierung_abfragen_mobil !== 'N'}
              {if isset($cPost_arr['mobil'])}
                {assign var=inputVal_mobile value=$cPost_arr['mobil']}
              {elseif isset($Kunde->cMobil)}
                {assign var=inputVal_mobile value=$Kunde->cMobil}
              {/if}
              {block name='checkout-inc-billing-address-form-contact-mobile'}
                <label class="form-label" for="mobile">
                  {lang key='mobile' section='account data'}{if $Einstellungen.kunden.kundenregistrierung_abfragen_mobil !== 'Y'}<small class='optional'> - {lang key='optional'}</small>{/if}
                </label>
                <input class="form-control" name="mobil" type="tel" id="mobile" autocomplete="billing mobile tel" value="{$inputVal_mobile|default:null}"{if $Einstellungen.kunden.kundenregistrierung_abfragen_mobil === 'Y'} required{/if}>
              {/block}
            {/if}
					{/block}
				</div>
				{if $Einstellungen.kunden.kundenregistrierung_abfragen_tel !== 'N'}
					<div class="col-sm-6">
            {if isset($cPost_arr['tel'])}
              {assign var=inputVal_tel value=$cPost_arr['tel']}
            {elseif isset($Kunde->cTel)}
              {assign var=inputVal_tel value=$Kunde->cTel}
            {/if}
            {block name='checkout-inc-billing-address-form-contact-tel'}
              <label class="form-label" for="tel">
                {lang key='tel' section='account data'}{if $Einstellungen.kunden.kundenregistrierung_abfragen_tel !== 'Y'}<small class='optional'> - {lang key='optional'}</small>{/if}
              </label>
              <input class="form-control" name="tel" type="tel" id="tel" autocomplete="billing home tel" value="{$inputVal_tel|default:null}"{if $Einstellungen.kunden.kundenregistrierung_abfragen_tel === 'Y'} required{/if}>
            {/block}
					</div>
				{/if}
        {if $billing || true}
          {if $Einstellungen.kunden.kundenregistrierung_abfragen_www !== 'N'}
            <div class="col-sm-6">
              {if isset($cPost_arr['www'])}
                {assign var=inputVal_www value=$cPost_arr['www']}
              {elseif isset($Kunde->cWWW)}
                {assign var=inputVal_www value=$Kunde->cWWW}
              {/if}
              {block name='checkout-inc-billing-address-form-contact-www'}
                <label class="form-label" for="www">
                  {lang key='www' section='account data'}{if $Einstellungen.kunden.kundenregistrierung_abfragen_www !== 'Y'}<small class='optional'> - {lang key='optional'}</small>{/if}
                </label>
                <input class="form-control" name="www" type="url" id="www" autocomplete="billing url" value="{$inputVal_www|default:null}" onblur="checkURL(this)"{if $Einstellungen.kunden.kundenregistrierung_abfragen_www === 'Y'} required{/if}>
                <script>
                  function checkURL (abc) {
                    var string = abc.value;
                    if (!~string.indexOf("http")) {
                      string = "https://" + string;
                    }
                    abc.value = string;
                    return abc
                  }
                </script>
              {/block}
            </div>
          {/if}
        {/if}
        {if $billing || true}
					{if isset($oKundenfeld_arr)}
            {if $Einstellungen.kundenfeld.kundenfeld_anzeigen === 'Y' && $oKundenfeld_arr->count() > 0}
              {block name='checkout-inc-billing-address-form-custom-fields'}
                {assign var="customerAttributes" value=$Kunde->getCustomerAttributes()}
                {foreach $oKundenfeld_arr as $oKundenfeld}
                  {block name='checkout-inc-billing-address-form-custom-field'}
                    {assign var="kKundenfeld" value=$oKundenfeld->getID()}
                    {if isset($customerAttributes[$kKundenfeld])}
                      {assign var="cKundenattributWert" value=$customerAttributes[$kKundenfeld]->getValue()}
                      {assign var="isKundenattributEditable" value=$customerAttributes[$kKundenfeld]->isEditable()}
                    {else}
                      {assign var="cKundenattributWert" value=''}
                      {assign var="isKundenattributEditable" value=true}
                    {/if}
                    <label class="form-label" for="custom_{$kKundenfeld}">
                      {$oKundenfeld->getLabel()}{if !$oKundenfeld->isRequired()}<small class='optional'> - {lang key='optional'}</small>{/if}
                    </label>
                    {if $oKundenfeld->getType() === \JTL\Customer\CustomerField::TYPE_SELECT}
                      {select
                        name="custom_{$kKundenfeld}"
                        disabled=!$isKundenattributEditable
                        aria=["label"=>$oKundenfeld->getLabel()]
                        required=$oKundenfeld->isRequired()
                        class='form-select'
                      }
                        <option value="" selected disabled>{lang key='pleaseChoose'}</option>
                        {foreach $oKundenfeld->getValues() as $oKundenfeldWert}
                          <option value="{$oKundenfeldWert}" {if ($oKundenfeldWert == $cKundenattributWert)}selected{/if}>{$oKundenfeldWert}</option>
                        {/foreach}
                      {/select}
                    {else}
                      <input class="form-control" name="custom_{$kKundenfeld}" type="{if $oKundenfeld->getType() === \JTL\Customer\CustomerField::TYPE_DATE}date{elseif $oKundenfeld->getType() === \JTL\Customer\CustomerField::TYPE_NUMBER}number{else}text{/if}" id="custom_{$kKundenfeld}" value="{$cKundenattributWert}"{if $oKundenfeld->isRequired()} required{/if}{if !$isKundenattributEditable} readonly{/if}>
                      {if isset($fehlendeAngaben.custom[$kKundenfeld])}
                        <div class="invalid-tooltip">
                          {if $fehlendeAngaben.custom[$kKundenfeld] === 1}
                            {lang key='fillOut' section='global'}
                          {elseif $fehlendeAngaben.custom[$kKundenfeld] === 2}
                            {lang key='invalidDateformat' section='global'}
                          {elseif $fehlendeAngaben.custom[$kKundenfeld] === 3}
                            {lang key='invalidDate' section='global'}
                          {elseif $fehlendeAngaben.custom[$kKundenfeld] === 4}
                            {lang key='invalidInteger' section='global'}
                          {/if}
                        </div>
                      {/if}
                    {/if}
                  {/block}
                {/foreach}
              {/block}
            {/if}
					{/if}
        {/if}
			{/block}
    {/if}
    {if $billing || true}
      <div class="col-12">
        <hr class="mt-2 mb-3">
        {block name='checkout-inc-billing-address-form-heading-billing-address'}
          <div class="h5">{lang key='billingAdress' section='account data'}</div>
        {/block}
      </div>
    {/if}
    {block name='checkout-inc-billing-address-form-street-wrap'}
      <div class="col-md-8 col-12">
        {if isset($cPost_arr['strasse'])}
          {assign var=inputVal_street value=$cPost_arr['strasse']}
        {elseif isset($Kunde->cStrasse)}
          {assign var=inputVal_street value=$Kunde->cStrasse}
        {/if}
        {block name='checkout-inc-billing-address-form-street'}
          <label class="form-label" for="street">
            {lang key='street' section='account data'}
          </label>
          <input class="form-control" name="strasse" type="text" id="street" autocomplete="billing address-line1" value="{$inputVal_street|default:null}" required>
        {/block}
      </div>

      <div class="col-md-4 col-12">
        {if isset($cPost_arr['hausnummer'])}
          {assign var=inputVal_streetnumber value=$cPost_arr['hausnummer']}
        {elseif isset($Kunde->cHausnummer)}
          {assign var=inputVal_streetnumber value=$Kunde->cHausnummer}
        {/if}
        {block name='checkout-inc-billing-address-form-street-number'}
          <label class="form-label" for="streetnumber">
            {lang key='streetnumber' section='account data'}
          </label>
          <input class="form-control" name="hausnummer" type="text" id="streetnumber" autocomplete="billing address-line2" value="{$inputVal_streetnumber|default:null}" required>
        {/block}
      </div>
      {if $Einstellungen.kunden.kundenregistrierung_abfragen_adresszusatz !== 'N'}
        {block name='checkout-inc-billing-address-form-addition'}
          {col cols=12}
            {if isset($cPost_arr['adresszusatz'])}
              {assign var=inputVal_street2 value=$cPost_arr['adresszusatz']}
            {elseif isset($Kunde->cAdressZusatz)}
              {assign var=inputVal_street2 value=$Kunde->cAdressZusatz}
            {/if}
            {block name='checkout-inc-billing-address-form-street-additional'}
              <label class="form-label" for="street2">
                {lang key='street2' section='account data'}{if $Einstellungen.kunden.kundenregistrierung_abfragen_adresszusatz !== 'Y'}<small class='optional'> - {lang key='optional'}</small>{/if}
              </label>
              <input class="form-control" name="adresszusatz" type="text" id="street2" autocomplete="billing address-line3" value="{$inputVal_street2|default:null}"{if $Einstellungen.kunden.kundenregistrierung_abfragen_adresszusatz === 'Y'} required{/if}>
            {/block}
          {/col}
        {/block}
      {/if}
      <div class="clearfix"></div>
    {/block}
    
    {if isset($cPost_arr['land'])}
      {$countryISO=$cPost_arr['land']}
    {elseif !empty($Kunde->cLand)}
      {$countryISO=$Kunde->cLand}
    {elseif !empty($Einstellungen.kunden.kundenregistrierung_standardland)}
      {$countryISO=$Einstellungen.kunden.kundenregistrierung_standardland}
    {else}
      {$countryISO=$shippingCountry}
    {/if}
    {getCountry iso=$countryISO assign='selectedCountry'}
    {block name='checkout-inc-billing-address-form-country-wrap'}
      {block name='checkout-inc-billing-address-form-country'}
        <div class="col-sm-12">
          <label class="form-label" for="billing_address-country">{lang key='country' section='account data'}</label>
          {select name="land" id="billing_address-country" class="country-input form-select js-country-select" required=true autocomplete="billing country"}
            <option value="" disabled>{lang key='country' section='account data'}</option>
            {foreach $countries as $country}
              {if $country->isPermitRegistration()}
                <option value="{$country->getISO()}" {if $selectedCountry->getISO() === $country->getISO()}selected="selected"{/if}>{$country->getName()}</option>
              {/if}
            {/foreach}
          {/select}
          {if isset($fehlendeAngaben.land)}
          	<div class="invalid-tooltip">
            	{lang key='fillOut' section='global'}
            </div>
          {/if}
        </div>  
      {/block}
		{/block}
    
		{block name='checkout-inc-billing-address-form-city-wrap'}
      {col cols=12 md=4}
        {block name='checkout-inc-billing-address-form-zip'}
          <label class="form-label" for="postcode">
            {lang key='plz' section='account data'}
          </label>
          <input class="form-control postcode_input" name="plz" type="text" id="postcode" autocomplete="billing postal-code" value="{if isset($cPost_arr['plz'])}{$cPost_arr['plz']}{elseif isset($Kunde->cPLZ)}{$Kunde->cPLZ}{/if}" required>
        	{if isset($fehlendeAngaben.plz)}
          	<div class="invalid-tooltip">
              {if $fehlendeAngaben.plz >= 2}
                {lang key='checkPLZCity' section='checkout'}
              {else}
                {lang key='fillOut' section='global'}
              {/if}
            </div>
          {/if}
        {/block}
      {/col}
      {col cols=12 md=8}
        {block name='checkout-inc-billing-address-form-city'}
          <label class="form-label" for="city">
            {lang key='city' section='account data'}
          </label>
          <input class="form-control city_input typeahead" name="ort" type="text" id="city" autocomplete="billing address-level2" value="{if isset($cPost_arr['ort'])}{$cPost_arr['ort']}{elseif isset($Kunde->cOrt)}{$Kunde->cOrt}{/if}" required>
        	{if isset($fehlendeAngaben.ort)}
          	<div class="invalid-tooltip">
              {if $fehlendeAngaben.ort==3}
                 {lang key='cityNotNumeric' section='account data'}
              {else}
                {lang key='fillOut' section='global'}
              {/if}
            </div>
          {/if}
        {/block}
      {/col}
		{/block}
    {if $billing}
      <div class="col-12">
        <hr class="mt-2 mb-3">
        <div class="d-flex flex-wrap justify-content-between align-items-center">
          {if $Einstellungen.kunden.direct_advertising === 'Y'}
            {block name='checkout-inc-billing-address-form-direct-advertising'}
              {capture name=dirAd}
                {lang key='directAdvertising' section='checkout'}
              {/capture}
              {if $smarty.capture.dirAd|count_characters >= 180}
                <small id="dirAdCollsm">
                  {$smarty.capture.dirAd|truncate:180:""}
                  <a href="#dirAdColl" class="" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="dirAdColl">
                    {lang key='more'} ...
                  </a>
                </small>
                <div class="collapse direct-advertising" id="dirAdColl">
                  <small>{$smarty.capture.dirAd}</small>
                </div>
                <script>
                  $("a[href='#dirAdColl']").on("click", function(){
                    $("#dirAdCollsm").hide();
                  });
                </script>
              {else}
                <div class="direct-advertising">
                  <small>{$smarty.capture.dirAd}</small>
                </div>
              {/if}
            {/block}
          {/if}
          
          {block name='account-address-form-form-submit'}
            {input type="hidden" name="editRechnungsadresse" value="1"}
            {input type="hidden" name="edit" value="1"}
            {button type="submit" value="1" block=true variant="primary" class="mt-3 mt-sm-0"}
              {lang key='editCustomerData' section='account data'}
            {/button}
          {/block}
        </div>
      </div>
    {/if}
  </div>
    {if !isset($fehlendeAngaben)}
        {assign var=fehlendeAngaben value=array()}
    {/if}
    {if !isset($cPost_arr)}
        {assign var=cPost_arr value=array()}
    {/if}
    {hasCheckBoxForLocation nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$fehlendeAngaben cPost_arr=$cPost_arr bReturn='bHasCheckbox'}
    {if $bHasCheckbox}
        {block name='checkout-inc-billing-address-form-checkboxes'}
            <fieldset>
                {row}
                    {col cols=8 offset-md=4}
                        {include file='snippets/checkbox.tpl' nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$fehlendeAngaben cPost_arr=$cPost_arr}
                    {/col}
                {/row}
            </fieldset>
        {/block}
    {/if}

    {if (!isset($smarty.session.bAnti_spam_already_checked) || $smarty.session.bAnti_spam_already_checked !== true)
    && isset($Einstellungen.kunden.registrieren_captcha) && $Einstellungen.kunden.registrieren_captcha !== 'N' && empty($Kunde->kKunde)}
        {block name='checkout-inc-billing-address-form-captcha'}
            {row}
                {col cols=8 offset=4}
                    {formgroup class="simple-captcha-wrapper {if isset($fehlendeAngaben.captcha) && $fehlendeAngaben.captcha != false} has-error{/if}"}
                        {captchaMarkup getBody=true}
                    {/formgroup}
                {/col}
            {/row}
        {/block}
		{/if}
{/block}
