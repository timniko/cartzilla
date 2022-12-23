{block name='productdetails-review-form'}
  {block name='productdetails-review-form-content'}
    <form action="{get_static_route id='bewertung.php'}" class="jtl-validate needs-validation label-slide" method="post" novalidate>
      <div class="bg-secondary py-grid-gutter px-grid-gutter rounded-3">
        <h3 class="h4 pb-2">{lang key='shareYourRatingGuidelines' section='product rating'}</h3>
        <input type="hidden" name="cTitel" value=" " />
        <div class="mb-3">
          {block name='productdetails-review-form-rating'}
            <label class="form-label" for="review-rating">{lang key='productRating' section='product rating'}<span class="text-danger">*</span></label>
            {select name="nSterne" class='form-select' required=true id="review-rating"}
              {$ratings = [5,4,3,2,1]}
              {foreach $ratings as $rating}
                <option value="{$rating}">
                  {$rating}
                  {if (int)$rating === 1}
                    {lang key='starSingular' section='product rating'}
                  {else}
                    {lang key='starPlural' section='product rating'}
                  {/if}
                </option>
              {/foreach}
            {/select}
          {/block}
          <div class="invalid-feedback">Please choose rating!</div>
        </div>
        <div class="mb-3">
          <label class="form-label" for="review-text">{lang key='comment' section='product rating'}<span class="text-danger">*</span></label>
          <textarea class="form-control" rows="6" required id="review-text" name="cText"></textarea>
          <div class="invalid-feedback">Please write a review!</div><small class="form-text text-muted">Your review must be at least 50 characters.</small>
        </div>
        <div class="mb-3">
          <label class="form-label" for="review-pros">Pros</label>
          <textarea class="form-control" name="pros" rows="2" placeholder="Separated by commas" id="review-pros"></textarea>
        </div>
        <div class="mb-3 mb-4">
          <label class="form-label" for="review-cons">Cons</label>
          <textarea class="form-control" name="cons"  rows="2" placeholder="Separated by commas" id="review-cons"></textarea>
        </div>
        {input type="hidden" name="bfh" value="1"}
        {input type="hidden" name="a" value=$Artikel->kArtikel}
        <button class="btn btn-primary btn-shadow d-block w-100" type="submit"{if $disableForm} disabled{/if}>{lang key='submitRating' section='product rating'}</button>
      </div>
    </form>
  {/block}
{/block}
