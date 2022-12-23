{block name='blog-overview'}
  {block name='blog-overview-include-extension'}
    {include file='snippets/extension.tpl'}
  {/block}
  
  {block name='blog-overview-heading'}
    {opcMountPoint id='opc_before_heading' inContainer=false}
    <div class="bg-secondary py-4">
      <div class="container d-lg-flex justify-content-between py-2 py-lg-3">
        {include file='layout/breadcrumb.tpl' dark=true}
				<div class="order-lg-1 pe-lg-4 text-center text-lg-start">
          {block name='blog-details-heading'}
            {opcMountPoint id='opc_before_heading'}
            <h1 class="h3 mb-0">{lang key='news' section='news'}</h1>
          {/block}
        </div>
      </div>
    </div>
  {/block}

  {opcMountPoint id='opc_before_filter' inContainer=false}
  {container fluid=$Link->getIsFluid() class="blog-overview pb-5 mb-2 mb-md-4 {if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
		{splitBlogPosts posts=$newsItems}
    {if $BlogPosts->featured|count >= 2}
      <div class="row pt-5">
      	{foreach $BlogPosts->featured as $newsItem}
          {$title = $newsItem->getTitle()|escape:'quotes'}
          {blogItemData newsItem=$newsItem}
          {assign var=dDate value=$newsItem->getDateValidFrom()->format('Y-m-d')}
          <article class="col-12 col-md-6" itemprop="blogPost" itemscope=true itemtype="https://schema.org/BlogPosting">
            <meta itemprop="mainEntityOfPage" content="{$newsItem->getURL()}">
            {block name='blog-preview-news-header'}
              {if !empty($newsItem->getPreviewImage())}
                {block name='blog-preview-news-image'}
                  {link href=$newsItem->getURL() title=$title class="blog-entry-thumb mb-3"}
                    <span class="blog-entry-meta-label fs-sm">
                      <i class="ci-time"></i>{$entryData->dateValidFrom}
                    </span>
                    {include file='snippets/image.tpl'
                    item=$newsItem
                    square=false
                    srcSize='lg'
                    width='600px'
                    alt="{$title} - {$newsItem->getMetaTitle()|escape:'quotes'}"}
                    <meta itemprop="image" content="{$imageBaseURL}{$newsItem->getPreviewImage()}">
                  {/link}
                {/block}
              {/if}
            {/block}
            {block name='blog-preview-news-body'}
              <div class="d-flex justify-content-between mb-2 pt-1">
                {block name='blog-preview-heading'}
                  <h2 class="h5 blog-entry-title mb-0">
                    {link itemprop="url" href=$newsItem->getURL() title=$title}
                      <span itemprop="headline">{$title}</span>
                    {/link}
                  </h2>
                {/block}
                {if isset($Einstellungen.news.news_kommentare_nutzen) && $Einstellungen.news.news_kommentare_nutzen === 'Y'}
                  {block name='blog-preview-comments'}
                    {link href=$newsItem->getURL()|cat:'#comments' title=$title class="blog-entry-meta-link fs-sm text-nowrap ms-3 pt-1"}
                      <i class="ci-message"></i><span itemprop="commentCount">{$newsItem->getCommentCount()}</span>
                    {/link}
                  {/block}
                {/if}
              </div>
              {block name='blog-preview-description'}
                <p itemprop="description" class="d-none">
                  {if $newsItem->getPreview()|strip_tags|strlen > 0}
                    {$newsItem->getPreview()|strip_tags}
                  {else}
                    {$newsItem->getContent()|strip_tags|truncate:200:''}
                  {/if}
                </p>
              {/block}
            {/block}
            {block name='blog-preview-author'}
              {if $entryData->author !== null}
                <div class="d-flex align-items-center fs-sm">
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
          </article>
				{/foreach}
      </div>
      <hr class="mt-5">
    {/if}
    <div class="row pt-5 mt-md-2">
			<section class="col-lg-8">
      	{opcMountPoint id='opc_before_news_list'}
				{block name='blog-overview-previews'}
          <div class="masonry-grid" data-columns="2">
            {foreach $BlogPosts->rest as $newsItem}
              {block name='blog-overview-include-preview'}
                {include file='blog/preview.tpl'}
              {/block}
            {/foreach}
          </div>
				{/block}
        {opcMountPoint id='opc_after_news_list'}
        {block name='blog-overview-hr-top'}
        	<hr class="mb-4">
        {/block}
        {block name='blog-overview-include-pagination-bottom'}
          {include file='snippets/pagination.tpl' oPagination=$oPagination cThisUrl='news.php' parts=['pagi']}
        {/block}
      </section>
      
      <aside class="col-lg-4">
        <div class="offcanvas offcanvas-collapse offcanvas-end border-start ms-lg-auto widget widget-categories" id="shop-sidebar" style="max-width: 22rem;">
          <div class="offcanvas-header align-items-center shadow-sm">
            <h2 class="h5 mb-0">{lang key='filter'}</h2>
            <button class="btn-close ms-auto" type="button" data-bs-dismiss="offcanvas" aria-label="Close"></button>
          </div>
          <div class="offcanvas-body py-grid-gutter py-lg-1 px-lg-4" data-simplebar data-simplebar-auto-hide="true">
            {getBlogCats}
            {if $BlogCats|count > 0}
              <div class="widget widget-links widget-filter mb-grid-gutter pb-grid-gutter mx-lg-2">
                <h3 class="widget-title">{lang key='newsCategorie' section='news'}</h3>
                
                <div class="input-group input-group-sm mb-2">
                  <input type="text" class="widget-filter-search form-control rounded-end" placeholder="{lang key='find'}">
                  <i class="ci-search position-absolute top-50 end-0 translate-middle-y fs-sm me-3"></i>
                </div>
                
                <ul class="widget-list widget-filter-list" data-simplebar data-simplebar-auto-hide="false">
                 	<li class="widget-list-item widget-filter-item{if $kNewsKategorie == "-1"} active{/if}">
                    <a class="widget-list-link d-flex justify-content-between align-items-center" href="#" data-kNewsKategorie="-1">
                      <span class="widget-filter-item-text">{lang key='newsCategorie' section='news'}</span>
                      <span class="fs-xs text-muted ms-3">{$BlogCats_totalCNT}</span>
                    </a>
                  </li>
                  {foreach $BlogCats as $blogCat}
                    <li class="widget-list-item widget-filter-item{if $kNewsKategorie == $blogCat->kNewsKategorie} active{/if}">
                      <a class="widget-list-link d-flex justify-content-between align-items-center" href="#" data-kNewsKategorie="{$blogCat->kNewsKategorie}">
                        <span class="widget-filter-item-text">{$blogCat->name}</span>
                        <span class="fs-xs text-muted ms-3">{$blogCat->PostCNT}</span>
                      </a>
                    </li>
                  {/foreach}
                </ul>
              </div>
              {inline_script}<script>
								$("a[data-kNewsKategorie]").on("click", function(e){
									e.preventDefault();
									$("select[name='nNewsKat'] option[value='" + $(this).attr('data-kNewsKategorie') + "']").prop("selected", true);
									$("select[name='nNewsKat']").trigger("change");
								});
							</script>{/inline_script}
            {/if}
            <div class="widget pb-grid-gutter mx-lg-2">
              <h3 class="widget-title">{lang key='newsSort' section='news'}</h3>
              {get_static_route id='news.php' assign=routeURL}
              {block name='blog-overview-form'}
                  {form id="frm_filter" name="frm_filter" action=$routeURL slide=true}
                      {block name='blog-overview-form-sort'}
                          {select name="nSort" class="onchangeSubmit form-select" aria=["label"=>"{lang key='newsSort' section='news'}"]}
                              <option value="-1"{if $nSort === -1} selected{/if}>{lang key='newsSort' section='news'}</option>
                              <option value="1"{if $nSort === 1} selected{/if}>{lang key='newsSortDateDESC' section='news'}</option>
                              <option value="2"{if $nSort === 2} selected{/if}>{lang key='newsSortDateASC' section='news'}</option>
                              <option value="3"{if $nSort === 3} selected{/if}>{lang key='newsSortHeadlineASC' section='news'}</option>
                              <option value="4"{if $nSort === 4} selected{/if}>{lang key='newsSortHeadlineDESC' section='news'}</option>
                              <option value="5"{if $nSort === 5} selected{/if}>{lang key='newsSortCommentsDESC' section='news'}</option>
                              <option value="6"{if $nSort === 6} selected{/if}>{lang key='newsSortCommentsASC' section='news'}</option>
                          {/select}
                      {/block}
                      {lang key='newsCategorie' section='news' assign='cCurrentKategorie'}
                      {if $oNewsCat->getID() > 0}
                          {assign var=kNewsKategorie value=$oNewsCat->getID()}
                      {else}
                          {assign var=kNewsKategorie value=$kNewsKategorie|default:0}
                      {/if}
                      {block name='blog-overview-form-categories'}
                          {select name="nNewsKat" class="onchangeSubmit form-select d-none" aria=["label"=>"{lang key='newsCategorie' section='news'}"]}
                              <option value="-1"{if $kNewsKategorie === -1} selected{/if}>{lang key='newsCategorie' section='news'}</option>
                              {if !empty($oNewsKategorie_arr)}
                                  {assign var=selectedCat value=$kNewsKategorie}
                                  {block name='blog-overview-include-newscategories-recursive'}
                                      {include file='snippets/newscategories_recursive.tpl' i=0 selectedCat=$selectedCat}
                                  {/block}
                              {/if}
                          {/select}
                      {/block}
                  {/form}
              {/block}
            </div>
            {getBanner nSeitenTyp=$nSeitenTyp}
            {if $adBanner|count > 0}
            	<div class="row">
                {include file='productlist/adBanner.tpl' banner=$adBanner[0]}
              </div>
						{/if}
          </div>
        </div>
      </aside>
	{/container}
{/block}
