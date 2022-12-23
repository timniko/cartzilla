{block name='productdetails-details'}
  {block name='productdetails-details-form'}
    {opcMountPoint id='opc_before_buy_form' inContainer=false}
    {include file='productdetails/product.tpl'}
  {/block}
  
  {$useVotes = $Einstellungen.bewertung.bewertung_anzeigen === 'Y'}
  {$useQuestionOnItem = $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'Y'}
	{$useAvailabilityNotification = ($verfuegbarkeitsBenachrichtigung !== 0)}
  
  {if $useVotes}
    {$show_reviews=true}
    {if isset($Artikel->Bewertungen->oBewertungGesamt->nAnzahl) && $Artikel->Bewertungen->oBewertungGesamt->nAnzahl <= 0}
      {if isset($Einstellungen.template.general.reviews_form_always) && $Einstellungen.template.general.reviews_form_always === "N"}
        {if isset($Einstellungen.template.general.reviews_muster) && $Einstellungen.template.general.reviews_muster === "N"}
          {$show_reviews=false}
        {/if}
      {/if}
    {/if}
    {if $show_reviews}
      {block name='productdetails-tabs-tab-votes'}
        <hr class="mb-5">
        <div id="votes">
          {opcMountPoint id='opc_before_tab_votes'}
          {include file='productdetails/reviews.tpl' stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt}
          {opcMountPoint id='opc_after_tab_votes'}
        </div>
      {/block}
		{/if}
    
    {if $useQuestionOnItem}
      {block name='productdetails-tabs-tab-question-on-item'}
        <div class="modal fade" id="modalQuestionOnItem" tabindex="-1" aria-labelledby="modalQuestionOnItemLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="modalQuestionOnItemLabel">{lang key="productQuestion" section="productDetails"}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                {opcMountPoint id='opc_before_tab_question'}
                {include file='productdetails/question_on_item.tpl' position="tab"}
                {opcMountPoint id='opc_after_tab_question'}
              </div>
            </div>
          </div>
				</div>
			{/block}
    {/if}
    {if $useAvailabilityNotification}
      {block name='productdetails-tabs-tab-availability-notification'}
        <div class="modal fade" id="modalAvailability" tabindex="-1" aria-labelledby="modalAvailabilityLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="modalAvailabilityLabel">{lang key="notifyMeWhenProductAvailableAgain"}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                {opcMountPoint id='opc_before_tab_availability'}
                {include file='productdetails/availability_notification_form.tpl' position='tab' tplscope='artikeldetails'}
                {opcMountPoint id='opc_after_tab_availability'}
              </div>
            </div>
          </div>
				</div>
      {/block}
    {/if}
  {/if}

{/block}