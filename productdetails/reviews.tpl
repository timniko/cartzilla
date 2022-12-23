{block name='productdetails-reviews'}
  <div class="reviews my-lg-3 py-5">
		<div class="container pt-md-2" id="reviews">
      {block name='productdetails-reviews-content'}
				<div class="row pb-3">
					{block name='productdetails-reviews-overview'}
          	{if $Artikel->Bewertungen->oBewertungGesamt->nAnzahl >= 0}
              <div class="col-lg-4 col-md-5" id="reviews-overview">
                <h2 class="h3 mb-4">{$Artikel->Bewertungen->oBewertungGesamt->nAnzahl} Reviews</h2>
                <div class="star-rating me-2">
                	{include file='productdetails/rating.tpl' stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt color='blue'}
                </div>
                <span class="d-inline-block align-middle">{lang key='averageProductRating' section='product rating'}</span>
                {ratingHelpful reviews=$Artikel->Bewertungen->oBewertung_arr}
                <p class="pt-3 fs-sm text-muted">
                  {if $ratingHelpful > 1}
                    {lang|sprintf:$ratingHelpful section='custom' key='ratings_helpful'}
                  {/if}
                </p>
              </div>

							{block name='productdetails-reviews-votes'}
              	<div class="col-lg-8 col-md-7">
                  {foreach name=sterne from=$Artikel->Bewertungen->nSterne_arr item=nSterne key=i}
                    {assign var=int1 value=5}
                    {math equation='x - y' x=$int1 y=$i assign='schluessel'}
                    {assign var=int2 value=100}
                    {if $nSterne > 0 & $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0}
                      {math equation='a/b*c' a=$nSterne b=$Artikel->Bewertungen->oBewertungGesamt->nAnzahl c=$int2 assign='percent'}
                    {else}
                    	{$percent = 0}
                    {/if}
                    <div class="d-flex align-items-center mb-2">
                      <div class="text-nowrap me-3">
                        <span class="d-inline-block align-middle text-muted">{$schluessel}</span>
                        <i class="ci-star-filled fs-xs ms-1"></i>
                      </div>
                      <div class="w-100">
                        <div class="progress" style="height: 4px;">
                          <div class="progress-bar{if $schluessel == 5} bg-success{else if $schluessel == 1} bg-danger{/if}" role="progressbar" style="width: {$percent|round}%;{if $schluessel == 4} background-color: #a7e453;{else if $schluessel == 3} background-color: #ffda75;{else if $schluessel == 2} background-color: #fea569;{/if}" aria-valuenow="{$percent|round}" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                      </div>
                      <span class="text-muted ms-3">
                      	{if !empty($nSterne)}
                          {$nSterne}
                        {else}
                          0
                        {/if}
                      </span>
                    </div>
                  {/foreach}
                </div>
							{/block}
						{/if}
					{/block}
				</div>
				<hr class="mt-4 mb-3">
        
				<!-- Reviews list-->
				<div class="row pt-4">
          <div class="col-md-7">
						{if $ratingPagination->getPageItemCount() >= 0}
							<div class="d-flex justify-content-end pb-4"> 
                {block name='productdetails-reviews-form'}
                  {form action="{$Artikel->cURLFull}#reviews" method="get" class="d-flex align-items-center flex-nowrap"}
                    <input type="hidden" name="{$ratingPagination->getId()}_nItemsPerPage" value="{$ratingPagination->getItemsPerPageOption(0)}" id="nItemsPerPage" />
                    <label class="fs-sm text-muted text-nowrap me-2 d-none d-sm-block" for="sort-reviews">{lang key='sorting' section='productOverview'}:</label>
                    <select class="form-select form-select-sm" id="sort-reviews" name="ratings_nSortByDir">
                      {foreach $ratingPagination->getSortByOptions() as $i => $cSortByOption}
                        <option value="{$i * 2}"{if $i * 2 == $ratingPagination->getSortByDir()} selected="selected"{/if}>
                          {$cSortByOption[1]} {lang key='asc'}
                        </option>
                        <option value="{$i * 2 + 1}"{if $i * 2 + 1 == $ratingPagination->getSortByDir()} selected="selected"{/if}>
                          {$cSortByOption[1]} {lang key='desc'}
                        </option>
                      {/foreach}
                    </select>
                  {/form}
                  <script>
                    $("#sort-reviews").on("change", function(){
                      $(this).closest("form")[0].submit();
                    });
                  </script>
                {/block}
							</div>
              {form id="reviews-list" method="post" action="{get_static_route id='bewertung.php'}" class="reviews-list" slide=true}
                {input type="hidden" name="bhjn" value="1"}
                {input type="hidden" name="a" value=$Artikel->kArtikel}
                {input type="hidden" name="btgsterne" value=$BlaetterNavi->nSterne}
                {input type="hidden" name="btgseite" value=$BlaetterNavi->nAktuelleSeite}
                {if count($ratingPagination->getPageItems()) > 0}
                  {foreach $ratingPagination->getPageItems() as $oBewertung}
                    {block name='productdetails-reviews-form-include-review-item'}
                      {include file='productdetails/review_item.tpl'}
                    {/block}
                  {/foreach}
                {else}
                	{if $Einstellungen.template.general.reviews_muster === 'Y'}
                    {block name='productdetails-reviews-form-include-review-item'}
                      {MusterBewertung}
                      {include file='productdetails/review_item.tpl' showHilfreich=false}
                    {/block}
                  {/if}
                {/if}
              {/form}
              {if $ratingPagination->getItemsPerPage() !== -1 && count($ratingPagination->getPageItems()) > 0}
                <div class="text-center">
                  <a class="btn btn-outline-accent" id="loadMoreReviews" href="#">
                    <i class="ci-reload me-2"></i>{lang section='custom' key='loadMoreReviews'}
                  </a>
                  <script>
                    $("#loadMoreReviews").on("click", function(e){
                      e.preventDefault();
                      $("#nItemsPerPage").val("-1");
                      $("#nItemsPerPage").closest("form")[0].submit();
                    });
                  </script>
                </div>
              {/if}
            {/if}
					</div>
          <div class="col-md-5 mt-2 pt-4 mt-md-0 pt-md-0">
            {$disableForm=true}
            {if !empty($smarty.session.Kunde->kKunde)}
            	{$disableForm=false}
              {checkProductWasPurchased aid=$Artikel->kArtikel conf=$Einstellungen.bewertung.bewertung_artikel_gekauft}
              {if !$ProductWasPurchased}
              	{$disableForm=true}
                <div class="alert alert-warning d-flex" role="alert">
                  <div class="alert-icon">
                    <i class="ci-security-announcement"></i>
                  </div>
                  <div>{lang key='productNotBuyed' section='product rating'}</div>
                </div>
              {/if}
            {else}
              <div class="alert alert-warning d-flex" role="alert">
                <div class="alert-icon">
                  <i class="ci-security-announcement"></i>
                </div>
                <div>{lang key='loginFirst' section='product rating'}</div>
              </div>
            {/if}
            {include file='productdetails/review_form.tpl' disableForm=$disableForm}
          </div>
        </div>
        
			{/block}
		</div>
	</div>
{/block}