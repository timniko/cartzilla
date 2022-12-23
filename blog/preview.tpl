{block name='blog-preview'}
  {$title = $newsItem->getTitle()|escape:'quotes'}
  <article class="masonry-grid-item" itemprop="blogPost" itemscope=true itemtype="https://schema.org/BlogPosting">
    <meta itemprop="mainEntityOfPage" content="{$newsItem->getURL()}">
    <div class="card">
      {block name='blog-preview-news-header'}
        {if !empty($newsItem->getPreviewImage())}
          {block name='blog-preview-news-image'}
            {link href=$newsItem->getURL() title=$title class="blog-entry-thumb"}
              {include file='snippets/image.tpl'
              item=$newsItem
              square=false
              class="card-img-top"
              alt="{$title} - {$newsItem->getMetaTitle()|escape:'quotes'}"}
              <meta itemprop="image" content="{$imageBaseURL}{$newsItem->getPreviewImage()}">
            {/link}
          {/block}
        {/if}
      {/block}
      {block name='blog-preview-news-body'}
        <div class="card-body">
          {block name='blog-preview-heading'}
            <h2 class="h6 blog-entry-title">
              {link itemprop="url" href=$newsItem->getURL() title=$title}
                <span itemprop="headline">{$title}</span>
              {/link}
            </h2>
          {/block}
          {block name='blog-preview-description'}
            <p itemprop="description" class="fs-sm">
              {if $newsItem->getPreview()|strip_tags|strlen > 0}
                {$newsItem->getPreview()|strip_tags}
              {else}
                {$newsItem->getContent()|strip_tags|truncate:200:''}
              {/if}
            </p>
          {/block}
          {assign var=kwords value=","|explode:$newsItem->getMetaKeyword()}
          {if $kwords|count > 0}
            {foreach $kwords as $kword}
              {if $kword !== ""}
                <span class="btn-tag me-2 mb-2">#{$kword|trim}</span>
              {/if}
            {/foreach}
          {/if}
        </div>
      {/block}
      <div class="card-footer d-flex align-items-center fs-xs">
        {assign var=dDate value=$newsItem->getDateValidFrom()->format('Y-m-d')}
        {blogItemData newsItem=$newsItem}
        {block name='blog-preview-author'}
          {if $entryData->author !== null}
            <div class="newsbox-author">
              {block name='blog-preview-include-author'}
                {if isset($entryData->author->cAvatarImgSrcFull) && !empty($entryData->author->cAvatarImgSrcFull)}
                  <div class="blog-entry-author-ava">
                    <img class="cz_avatar" src="{$entryData->author->cAvatarImgSrcFull}" alt="{$entryData->author->cName}">
                    <meta itemprop="image" content="{$entryData->author->cAvatarImgSrcFull}">
                  </div>
                {/if}
                <span itemprop="name">
                  {$entryData->author->cName}
                </span>
              {/block}
            </div>
          {else}
            <div itemprop="author publisher" itemscope itemtype="https://schema.org/Organization" class="d-none">
              <span itemprop="name">{$meta_publisher}</span>
              <meta itemprop="url" content="{$ShopURL}">
              <meta itemprop="logo" content="{$ShopLogoURL}">
            </div>
          {/if}
          <time itemprop="dateModified" class="d-none">{$newsItem->getDateCreated()->format('Y-m-d')}</time>
          <time itemprop="datePublished" datetime="{$dDate}" class="d-none">{$dDate}</time>
          <span class="align-middle d-none">{$newsItem->getDateValidFrom()->format('d.m.Y')}</span>
        {/block}
        
        <div class="ms-auto text-nowrap">
          {link href=$newsItem->getURL() title=$title class="blog-entry-meta-link text-nowrap"}
            {$entryData->dateValidFrom}
          {/link}
          {if isset($Einstellungen.news.news_kommentare_nutzen) && $Einstellungen.news.news_kommentare_nutzen === 'Y'}
            {block name='blog-preview-comments'}
              <span class="blog-entry-meta-divider mx-2"></span>
              {link href=$newsItem->getURL()|cat:'#comments' title=$title class="blog-entry-meta-link text-nowrap"}
                <i class="ci-message"></i><span itemprop="commentCount">{$newsItem->getCommentCount()}</span>
              {/link}
            {/block}
          {/if}
        </div>
      </div>
    </div>
  </article>
{/block}