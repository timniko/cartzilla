{block name='productdetails-rating'}
  {block name='productdetails-rating-main'}
    {if isset($total) && $total > 1}
      {lang key='averageProductRating' section='product rating' assign='ratingLabelText'}
    {else}
      {lang key='productRating' section='product rating' assign='ratingLabelText'}
    {/if}
    {if !isset($color)}
      {$fullStarActive = 'star-rating-icon ci-star-filled active'}
      {$fullStar = 'star-rating-icon ci-star-filled'}
      {$halfStar = 'star-rating-icon ci-star-half active'}
    {else}
      {$fullStarActive = 'ci-star-filled fs-sm text-accent me-1'}
      {$fullStar = 'ci-star fs-sm text-muted me-1'}
      {$halfStar = 'ci-star-half fs-sm text-accent me-1'}
    {/if}
    {if isset($link)}
      <a class="rating" href="{$link}#tab-votes" title="{$ratingLabelText}: {$stars}/5" aria-label={lang key='Votes'}>
    {else}
      <span class="rating" title="{$ratingLabelText}: {$stars}/5">
    {/if}
		{if $stars > 0}
      {strip}
        <div class="star-rating">
          {if $stars >= 5}
            <i class="{$fullStarActive}"></i>
            <i class="{$fullStarActive}"></i>
            <i class="{$fullStarActive}"></i>
            <i class="{$fullStarActive}"></i>
            <i class="{$fullStarActive}"></i>
          {elseif $stars >= 4}
            <i class="{$fullStarActive}"></i>
            <i class="{$fullStarActive}"></i>
            <i class="{$fullStarActive}"></i>
            <i class="{$fullStarActive}"></i>
            {if $stars > 4}
              <i class="{$halfStar}"></i>
            {else}
              <i class="{$fullStar}"></i>
            {/if}
          {elseif $stars >= 3}
            <i class="{$fullStarActive}"></i>
            <i class="{$fullStarActive}"></i>
            <i class="{$fullStarActive}"></i>
            {if $stars > 3}
              <i class="{$halfStar}"></i>
              <i class="{$fullStar}"></i>
            {else}
            	<i class="{$fullStar}"></i>
              <i class="{$fullStar}"></i>
            {/if}
          {elseif $stars >= 2}
            <i class="{$fullStarActive}"></i>
            <i class="{$fullStarActive}"></i>
            {if $stars > 2}
              <i class="{$halfStar}"></i>
              <i class="{$fullStar}"></i>
              <i class="{$fullStar}"></i>
            {else}
            	<i class="{$fullStar}"></i>
              <i class="{$fullStar}"></i>
              <i class="{$fullStar}"></i>
            {/if}
          {elseif $stars >= 1}
            <i class="{$fullStarActive}"></i>
            {if $stars > 1}
              <i class="{$halfStar}"></i>
              <i class="{$fullStar}"></i>
              <i class="{$fullStar}"></i>
              <i class="{$fullStar}"></i>
            {else}
            	<i class="{$fullStar}"></i>
              <i class="{$fullStar}"></i>
              <i class="{$fullStar}"></i>
              <i class="{$fullStar}"></i>
            {/if}
          {elseif $stars > 0}
            <i class="{$halfStar}"></i>
            <i class="{$fullStar}"></i>
            <i class="{$fullStar}"></i>
            <i class="{$fullStar}"></i>
            <i class="{$fullStar}"></i>
          {/if}
        </div>
      {/strip}
      {if isset($total)}
        <span class="d-inline-block fs-sm text-body align-middle mt-1 ms-1">{$total} {lang key='rating'}</span>
      {/if}
    {/if}
    {if isset($link)}
      </a>
    {else}
      </span>
    {/if}
	{/block}
{/block}
