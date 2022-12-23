{block name='productdetails-review-item'}
	{block name='productdetails-review-item-content'}
    <div class="product-review pb-4 mb-4 border-bottom" itemprop="review" itemscope=true itemtype="https://schema.org/Review">
      <div class="d-flex mb-3">
        <div class="d-flex align-items-center me-4 pe-2">
          {getAvatar kKunde=$oBewertung->kKunde}
          {if $Avatar != ""}
            <img class="rounded-circle cz_avatar m50" src="{$Avatar}" width="50" alt="{$oBewertung->cName}">
          {else}
            <div class="position-relative">
              <div class="ratio ratio-1x1 rounded-circle cz_avatar m50 bg-secondary"></div>
              <i class="ci-user position-absolute top-50 start-50 translate-middle fs-4 text-muted opacity-50"></i>
            </div>
          {/if}
          {block name='productdetails-review-item-title'}
						<span itemprop="name" class="d-none">{$oBewertung->cTitel}</span>
						<div class="ps-3">
              <h6 class="fs-sm mb-0" itemprop="author" itemscope=true itemtype="https://schema.org/Person">
              	<span itemprop="name">{$oBewertung->cName}</span>
              </h6>
              <meta itemprop="datePublished" content="{$oBewertung->dDatum}" />
              <span class="fs-ms text-muted">{$oBewertung->Datum}</span>
            </div>
            <meta itemprop="thumbnailURL" content="{$Artikel->cVorschaubildURL}">
          {/block}
        </div>
        <div itemprop="reviewRating" itemscope=true itemtype="https://schema.org/Rating">
					{block name='productdetails-review-item-rating'}
						{block name='productdetails-review-item-include-rating'}
							{include file='productdetails/rating.tpl' stars=$oBewertung->nSterne}
              <small class="d-none">
                <span itemprop="ratingValue">{$oBewertung->nSterne}</span> {lang key='from'}
                <span itemprop="bestRating">5</span>
                <meta itemprop="worstRating" content="1">
              </small>
						{/block}
					{/block}
          <div class="fs-ms text-muted">
             {lang|sprintf:$oBewertung->nHilfreich:$oBewertung->nAnzahlHilfreich section='custom' key='rating_helpful'}
					</div>
        </div>
      </div>
      {block name='productdetails-review-item-review'}
        {ratingProCons txt=$oBewertung->cText}        
        <blockquote class="blockquote">
        {if isset($rating_pro_con->txt) && $rating_pro_con->txt != ""}
        	<p class="fs-md mb-2">{$rating_pro_con->txt}</p>
          <ul class="list-unstyled fs-ms pt-1">
            {if $rating_pro_con->pros != ""}<li class="mb-1"><span class="fw-medium">Pros: </span>{$rating_pro_con->pros}</li>{/if}
            {if $rating_pro_con->cons != ""}<li class="mb-1"><span class="fw-medium">Cons: </span>{$rating_pro_con->cons}</li>{/if}
          </ul>
        {/if}
        {if !empty($oBewertung->cAntwort)}
          <footer class="blockquote-footer review-reply">
            {$oBewertung->cAntwort} <cite title="Source Title">({$cShopName}, {$oBewertung->AntwortDatum})</cite>
          </footer>
        {/if}
        </blockquote>
      {/block}
      {if $Einstellungen.bewertung.bewertung_hilfreich_anzeigen === 'Y'}
        <div class="text-nowrap">
          {$cLD=false}
          {if isset($smarty.session.Kunde->kKunde)}
            {$cLD=true}
            {if $smarty.session.Kunde->kKunde === $oBewertung->kKunde}
              {$cLD=false}
            {/if}
          {/if}
          <button class="btn-like" type="submit" title="{lang key='yes'}" name="hilfreich_{$oBewertung->kBewertung}" data-review-id="{$oBewertung->kBewertung}"{if !$cLD || isset($showHilfreich)} disabled{/if}>{$oBewertung->nHilfreich}</button>
          <button class="btn-dislike" type="submit" title="{lang key='no'}" name="nichthilfreich_{$oBewertung->kBewertung}" data-review-id="{$oBewertung->kBewertung}"{if !$cLD || isset($showHilfreich)} disabled{/if}>{$oBewertung->nNichtHilfreich}</button>
        </div>
      {/if}
    </div>
  {/block}
{/block}