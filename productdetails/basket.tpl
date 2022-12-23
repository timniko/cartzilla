{block name='productdetails-basket'}
  <div class="mb-3 d-flex align-items-center">
  	{if ($Artikel->inWarenkorbLegbar == 1 || $Artikel->nErscheinendesProdukt == 1) || $Artikel->Variationen}
      <div id="add-to-cart" class="product-buy{if $Artikel->nErscheinendesProdukt} coming_soon{/if}">
        {if $Artikel->nErscheinendesProdukt}
          {block name='productdetails-basket-coming-soon'}
            <div class="{if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y'}alert alert-warning coming_soon{/if} text-center-util">
              {lang key='productAvailableFrom' section='global'}: <strong>{$Artikel->Erscheinungsdatum_de}</strong>
              {if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y' && $Artikel->inWarenkorbLegbar == 1}
                ({lang key='preorderPossible' section='global'})
              {/if}
            </div>
          {/block}
        {/if}
        {if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0}
          {block name='productdetails-basket-alert-choose'}
            <div class="alert alert-info d-flex alert-dismissible" role="alert">
              <div class="alert-icon">
                <i class="ci-announcement"></i>
              </div>
              <div>{lang key='chooseVariations' section='messages'}</div>
              <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
          {/block}
        {/if}
        {if $Artikel->inWarenkorbLegbar == 1 }
          {if !$showMatrix}
            {block name='productdetails-basket-form-inline'}
              {row class="basket-form-inline mb-3"}
								{if $Artikel->Preise->fVKNetto == 0 && isset($Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_VOUCHER_FLEX])}
                  {block name='productdetails-basket-voucher-flex'}
                    {col cols=12 md=6}
                      {inputgroup class="form-counter"}
                        {input type="number"
                          step=".01"
                          value="{if isset($voucherPrice)}{$voucherPrice}{/if}"
                          name="{$smarty.const.FKT_ATTRIBUT_VOUCHER_FLEX}Value"
                          required=true
                          placeholder="{lang key='voucherFlexPlaceholder' section='productDetails' printf=$smarty.session.Waehrung->getName()}"}
                        {inputgroupappend}
                          {inputgrouptext class="form-control"}
                            {$smarty.session.Waehrung->getName()}
                          {/inputgrouptext}
                        {/inputgroupappend}
                      {/inputgroup}
                    {/col}
                    {if isset($kEditKonfig)}
                      <input type="hidden" name="kEditKonfig" value="{$kEditKonfig}"/>
                    {/if}
                    {input type="hidden" id="quantity" class="quantity" name="anzahl" value="1"}
                  {/block}
                {else}
                  {block name='productdetails-basket-quantity'}
                    {col cols=12 md=12}
                      {inputgroup id="quantity-grp" class="form-counter flex-nowrap mb-3 w-100"}
                          {button variant="secondary"
                            data=["count-down"=>""]
                            aria=["label"=>{lang key='decreaseQuantity' section='aria'}]}
                            <span class="ci-minus fw-bolder">&#8212;</span>
                          {/button}
                        {input type="number"
                          min="{if $Artikel->fMindestbestellmenge}{$Artikel->fMindestbestellmenge}{else}1{/if}"
                          max=$Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE]|default:''
                          required=($Artikel->fAbnahmeintervall > 0)
                          step="{if $Artikel->cTeilbar === 'Y' && $Artikel->fAbnahmeintervall == 0}any{elseif $Artikel->fAbnahmeintervall > 0}{$Artikel->fAbnahmeintervall}{else}1{/if}"
                          id="quantity"
                          class="quantity text-center"
                          name="anzahl"
                          aria=["label"=>"{lang key='quantity'}"]
                          value="{if $Artikel->fAbnahmeintervall > 0 || $Artikel->fMindestbestellmenge > 1}{if $Artikel->fMindestbestellmenge > $Artikel->fAbnahmeintervall}{$Artikel->fMindestbestellmenge}{else}{$Artikel->fAbnahmeintervall}{/if}{else}1{/if}"
                          data=["decimals"=>{getDecimalLength quantity=$Artikel->fAbnahmeintervall}]
                        }
                          {if $Artikel->cEinheit}
                            <span class="unit input-group-text fw-bold">
                              {$Artikel->cEinheit}
                            </span>
                          {/if}
                          {button variant="secondary"
                            data=["count-up"=>""]
                            aria=["label"=>{lang key='increaseQuantity' section='aria'}]}
                            <span class="ci-add"></span>
                          {/button}
                      {/inputgroup}
                    {/col}
                  {/block}
                {/if}
                {block name='productdetails-basket-add-to-cart'}
                  {col cols=12 md=12}
                    {button aria=["label"=>"{lang key='addToCart'}"]
                      block=true name="inWarenkorb"
                      type="submit"
                      value="{lang key='addToCart'}"
                      variant="primary"
                      disabled=$Artikel->bHasKonfig && !$isConfigCorrect|default:false
                      class="js-cfg-validate btn btn-primary btn-shadow d-block w-100"}
                      <span class="btn-basket-check">
                        <span>
                          {if isset($kEditKonfig)}
                            {lang key='applyChanges'}
                          {else}
                            {lang key='addToCart'}
                          {/if}
                        </span>
                      </span>
                    {/button}
                  {/col}
                {/block}
              {/row}
            {/block}
          {/if}
        {/if}
        {if $Artikel->inWarenkorbLegbar == 1
        && ($Artikel->fMindestbestellmenge > 1
          || ($Artikel->fMindestbestellmenge > 0 && $Artikel->cTeilbar === 'Y')
          || ($Artikel->fAbnahmeintervall > 0 && $Einstellungen.artikeldetails.artikeldetails_artikelintervall_anzeigen === 'Y')
          || $Artikel->cTeilbar === 'Y'
          || $Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE]|default:0 > 0)}
          {block name='productdetails-basket-alert-purchase-info'}
            <div class="alert alert-info d-flex" role="alert">
              <div class="alert-icon">
                <i class="ci-announcement"></i>
              </div>
              <div>
              	{assign var=units value=$Artikel->cEinheit}
                {if empty($Artikel->cEinheit) || $Artikel->cEinheit|@count_characters == 0}
                  <p>{lang key='units' section='productDetails' assign='units'}</p>
                {/if}
  
                {if $Artikel->fMindestbestellmenge > 1 || ($Artikel->fMindestbestellmenge > 0 && $Artikel->cTeilbar === 'Y')}
                  {lang key='minimumPurchase' section='productDetails' assign='minimumPurchase'}
                  <p>{$minimumPurchase|replace:"%d":$Artikel->fMindestbestellmenge|replace:"%s":$units}</p>
                {/if}
  
                {if $Artikel->fAbnahmeintervall > 0}
                  {lang key='takeHeedOfInterval' section='productDetails' assign='takeHeedOfInterval'}
                  <p id="intervall-notice" {if $Einstellungen.artikeldetails.artikeldetails_artikelintervall_anzeigen !== 'Y'}class="d-none"{/if}>{$takeHeedOfInterval|replace:"%d":$Artikel->fAbnahmeintervall|replace:"%s":$units}</p>
                {/if}
  
                {if $Artikel->cTeilbar === 'Y'}
                  <p>{lang key='integralQuantities' section='productDetails'}</p>
                {/if}
                {if $Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE]|default:0 > 0}
                  {lang key='maximalPurchase' section='productDetails' assign='maximalPurchase'}
                  <p>{$maximalPurchase|replace:"%d":$Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE]|replace:"%s":$units}</p>
                {/if}
              </div>
            </div>
          {/block}
        {/if}
      </div>
    {/if}
  </div>
  {$useQuestionOnItem = $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'Y'}
	{$useAvailabilityNotification = ($verfuegbarkeitsBenachrichtigung !== 0)}
  {if $useQuestionOnItem}
    <a class="btn btn-secondary mb-3" data-bs-toggle="modal" href="#modalQuestionOnItem" role="button">
      {lang key="productQuestion" section="productDetails"}
    </a>
  {/if}
  {if $useAvailabilityNotification}
		<a class="btn btn-secondary mb-3" data-bs-toggle="modal" href="#modalAvailability" role="button">
			{lang key="notifyMeWhenProductAvailableAgain"}
		</a>
  {/if}
{/block}
