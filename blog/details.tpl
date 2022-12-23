{block name='blog-details'}
  {block name='blog-details-include-extension'}
      {include file='snippets/extension.tpl'}
  {/block}
  
  {if !empty($cNewsErr)}
    {container fluid=$Link->getIsFluid() class="blog-details pb-5 {if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
      {block name='blog-details-alert'}
        {alert variant="danger"}{lang key='newsRestricted' section='news'}{/alert}
      {/block}
    {/container}
  {else}
    {block name='blog-details-article'}
      <article itemprop="mainEntity" itemscope itemtype="https://schema.org/BlogPosting">
        <meta itemprop="mainEntityOfPage" content="{$newsItem->getURL()}">
        <div class="bg-secondary py-4">
					<div class="container d-lg-flex justify-content-between py-2 py-lg-3">
						{include file='layout/breadcrumb.tpl' dark=true}
            <div class="order-lg-1 pe-lg-4 text-center text-lg-start">
              {block name='blog-details-heading'}
                {opcMountPoint id='opc_before_heading'}
                <h1 class="h3 mb-0">{$newsItem->getTitle()}</h1>
              {/block}
            </div>
          </div>
				</div>
        
        {blogItemData newsItem=$newsItem}
        {assign var=dDate value=$newsItem->getDateValidFrom()->format('Y-m-d')}
        {container fluid=$Link->getIsFluid() class="blog-details py-5 mt-md-2 {if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
					{assign var=author value=$newsItem->getAuthor()}
          <div class="d-flex flex-wrap justify-content-between align-items-center pb-4 mt-n1">
            <div class="d-flex align-items-center fs-sm mb-2">
              {if $entryData->author !== null}
                {block name='blog-details-include-author'}
                  <div class="blog-entry-meta-link" itemprop="author" itemscope itemtype="https://schema.org/Person">
                    {if isset($entryData->author->cAvatarImgSrcFull) && !empty($entryData->author->cAvatarImgSrcFull)}
                      <div class="blog-entry-author-ava">
                        <img class="cz_avatar" src="{$entryData->author->cAvatarImgSrcFull}" alt="{$entryData->author->cName}">
                        <meta itemprop="image" content="{$entryData->author->cAvatarImgSrcFull}">
                      </div>
                    {/if}
                    <span itemprop="name">
                      {$entryData->author->cName}
                    </span>
                    <div id="author-{$entryData->author->kContentAuthor}" class="d-none">
                      {block name='snippets-author-modal-content'}
                        {if !empty($entryData->author->cVitaShort)}
                          <div itemprop="description">
                            {$entryData->author->cVitaShort}
                          </div>
                        {/if}
                      {/block}
                    </div>
                  </div>
                  <div itemprop="publisher" itemscope itemtype="https://schema.org/Organization" class="d-none">
                    <span itemprop="name">{$meta_publisher}</span>
                    <meta itemprop="url" content="{$ShopURL}">
                    <meta itemprop="logo" content="{$ShopLogoURL}">
                  </div>
                {/block}
              {else}
                {block name='blog-details-noauthor'}
									<div itemprop="author publisher" itemscope itemtype="https://schema.org/Organization" class="d-none">
                    <span itemprop="name">{$meta_publisher}</span>
                    <meta itemprop="logo" content="{$ShopLogoURL}" />
                  </div>
                  <time itemprop="datePublished" datetime="{$dDate}" class="d-none">{$dDate}</time>
                {/block}
              {/if}
              <time itemprop="datePublished" datetime="{$dDate}" class="d-none">{$dDate}</time>
							{if isset($newsItem->getDateCreated()->format('Y-m-d H:i:s'))}
                <time itemprop="dateModified" class="d-none">{$newsItem->getDateCreated()->format('Y-m-d H:i:s')}</time>
              {/if}
              
              <span class="blog-entry-meta-divider"></span>
              <span class="blog-entry-meta-link">{$entryData->dateValidFrom}</span>
            </div>
            <div class="fs-sm mb-2">
              <a class="blog-entry-meta-link text-nowrap" href="#comments" data-scroll="">
                <i class="ci-message"></i>{$newsItem->getCommentCount()}
              </a>
            </div>
          </div>
          {if count($entryData->avail_imgs) > 0}
            <div class="row gallery mb-4 g-0">
							{foreach $entryData->avail_imgs as $bild}
                <div class="col-xl-4 col-sm-6">
                  <a href="{$bild->cURLFull}" class="gallery-item" data-sub-html='<h6 class="fs-sm text-light">{$bild->cName}</h6>'>
                    <img src="{$bild->cURLFull}" alt="{$bild->cName}">
                    <span class="gallery-item-caption">{$bild->cName}</span>
                  </a>
                </div>
              {/foreach}
            </div>
					{else}
          	{if $newsItem->getPreviewImage() !== ''}
              {block name='blog-details-image'}
                <div class="gallery mb-4">
                  <a href="{$newsItem->getPreviewImage()}" class="gallery-item rounded-3" data-sub-html='<h6 class="fs-sm text-light">Gallery image caption</h6>'>
                    <img src="{$newsItem->getPreviewImage()}" alt="{$newsItem->getTitle()|escape:'quotes'} - {$newsItem->getMetaTitle()|escape:'quotes'}">
                    <span class="gallery-item-caption">{$newsItem->getTitle()|escape:'quotes'}</span>
                  </a>
                </div>
                <meta itemprop="image" content="{$imageBaseURL}{$newsItem->getPreviewImage()}">
              {/block}
            {/if}
          {/if}
          
          {block name='blog-details-article-content'}
              {opcMountPoint id='opc_before_content'}
              {row itemprop="articleBody" class="blog-details-content"}
                  {col cols=12}
                    {$newsItem->getContent()}
                  {/col}
              {/row}
              {opcMountPoint id='opc_after_content'}
          {/block}
          
          <div class="d-flex flex-wrap justify-content-between pt-2 pb-4 mb-1">
            {assign var=kwords value=","|explode:$newsItem->getMetaKeyword()}
            {if $kwords|count > 0}
              <div class="mt-3 me-3">
                {foreach $kwords as $kword}
                	{if $kword !== ""}
                  	<span class="btn-tag me-2 mb-2">#{$kword|trim}</span>
                  {/if}
                {/foreach}
              </div>
            {/if}
            <div class="mt-3">
              <span class="d-inline-block align-middle text-muted fs-sm me-3 mt-1 mb-2">{lang key='social_share' section='custom'}:</span>
              <span class="me-2 my-2">
                <a data-pin-do="buttonBookmark" data-pin-tall="true" href="https://www.pinterest.com/pin/create/button/"></a>
              </span>
              <script async defer src="//assets.pinterest.com/js/pinit.js"></script>
              
              <a href="https://twitter.com/share?ref_src=twsrc%5Etfw" class="btn-share btn-twitter me-2 my-2" data-show-count="false" target="_blank">
                <i class="ci-twitter"></i>Twitter
              </a>
              <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
              
              <script async defer crossorigin="anonymous" src="https://connect.facebook.net/es_ES/sdk.js#xfbml=1&version=v15.0" nonce="Ry8EcbbP"></script>
              <span class="fb-share-button" data-href="{$newsItem->getURL()}" data-layout="button" data-size="large">
                <a target="_blank" href="https://www.facebook.com/sharer/sharer.php?u={$newsItem->getURL()|escape:'url'}&amp;src=sdkpreparse" class="fb-xfbml-parse-ignore btn-share btn-facebook my-2" target="_blank">
                  <i class="ci-facebook"></i>Facebook
                </a>
              </span>
              <div id="fb-root"></div>
              
            </div>
          </div>
          
          {if isset($Einstellungen.news.news_kommentare_nutzen) && $Einstellungen.news.news_kommentare_nutzen === 'Y'}
              {block name='blog-details-article-comments'}
              		<div class="pt-2 mt-5" id="comments">
                    <h2 class="h4">
                      {lang key='newsComments' section='news'}
                      <span class="badge bg-secondary fs-sm text-body align-middle ms-2">{$comments|count}</span>
                    </h2>
                    {if $comments|@count > 0}
                    	{if $newsItem->getURL() !== ''}
                        {assign var=articleURL value=$newsItem->getURL()}
                        {assign var=cParam_arr value=[]}
                      {else}
                        {assign var=articleURL value='news.php'}
                        {assign var=cParam_arr value=['kNews'=>$newsItem->getID(),'n'=>$newsItem->getID()]}
                      {/if}
                    	{foreach $comments as $comment}
                      	{if $comment->isActive()}
                          {commentData commentItem=$comment}
                          <div class="d-flex align-items-start py-4">
                            {if $commentData->avatar != ""}
                              <img class="rounded-circle cz_avatar m50" src="{$commentData->avatar}" width="50" alt="{$comment->getName()}">
                            {/if}
                            <div class="ps-3" itemprop="comment">
                              <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="fs-md mb-0">{$comment->getName()}</h6>
                              </div>
                              <p class="fs-md mb-1">{$comment->getText()}</p>
                              <span class="fs-ms text-muted">
                                <i class="ci-time align-middle me-2"></i>
                                {$comment->getDateCreated()->format('d M, Y')}
                              </span>
                              {assign var=ChildComments value=$comment->getChildComments()}
                              {if $ChildComments|count > 0}
                                {foreach $ChildComments as $childComment}
                                  {commentData commentItem=$childComment}
                                  <div class="d-flex align-items-start border-top pt-4 mt-4">
                                    {if $commentData->avatar != ""}
                                    <img class="rounded-circle cz_avatar m50" src="{$commentData->avatar}" width="50" alt="{$childComment->getName()}">
                                    {/if}
                                    <div class="ps-3">
                                      <div class="d-flex justify-content-between align-items-center mb-2">
                                        <h6 class="fs-md mb-0">{$childComment->getName()}</h6>
                                      </div>
                                      <p class="fs-md mb-1">{$childComment->getText()}</p>
                                      <span class="fs-ms text-muted">
                                        <i class="ci-time align-middle me-2"></i>
                                        {$childComment->getDateCreated()->format('d M, Y')}
                                      </span>
                                    </div>
                                  </div>
                                {/foreach}
                              {/if}
                            </div>
                          </div>
                        {/if}
                      {/foreach}
                    {/if}
                    {if $userCanComment === true && isset($smarty.session.Kunde->kKunde)}
                      {block name='blog-details-form-comment'}
                        <div class="card border-0 shadow mt-2 mb-4">
                          <div class="card-body">
                            <div class="d-flex align-items-start">
                            	{getAvatar}
															{if $Avatar != ""}
                                <img class="rounded-circle cz_avatar m50" src="{$Avatar}" width="50" alt="{$smarty.session.Kunde->cVorname} {$smarty.session.Kunde->cNachname}">
                              {/if}
                             	{form method="post"
                              action="{if !empty($newsItem->getSEO())}{$newsItem->getURL()}{else}{get_static_route id='news.php'}{/if}"
                              class="w-100 ms-3 form"
                              id="news-addcomment"
                              slide=true
                              novalidate=true}
                                {input type="hidden" name="kNews" value=$newsItem->getID()}
                                {input type="hidden" name="kommentar_einfuegen" value="1"}
                                {input type="hidden" name="n" value=$newsItem->getID()}
                                <div class="mb-3">
                                  <textarea class="form-control" rows="4" placeholder="{lang key='newsComment' section='news'}" id="comment-text" name="cKommentar" required=""></textarea>
                                  {if $Einstellungen.news.news_kommentare_freischalten === 'Y'}
                                    <div class="form-text">{lang key='commentWillBeValidated' section='news'}</div>
                                  {/if}
                                  <div class="invalid-feedback">Please write your comment.</div>
                                </div>
                                {button block=true variant="primary" class="btn-sm" name="speichern" type="submit"}
																	{lang key='newsCommentSave' section='news'}
																{/button}
                              {/form}
                            </div>
                          </div>
                        </div>
                      {/block}
                    {else}
                    	{block name='blog-details-alert-login'}
                        <div class="alert alert-warning d-flex" role="alert">
                          <div class="alert-icon">
                            <i class="ci-security-announcement"></i>
                          </div>
                          <div>{lang key='newsLogin' section='news'}</div>
                        </div>
                      {/block}
                    {/if}
                  </div>
              
              
{if false}
                  {if $userCanComment === true}
                      {block name='blog-details-form-comment'}
                          {block name='blog-details-form-comment-hr-top'}{/block}
                          {row}
                              {col cols=12}
                                  {block name='blog-details-form-comment-heading'}
                                      <div class="h2">{lang key='newsCommentAdd' section='news'}</div>
                                  {/block}
                                  {block name='blog-details-form-comment-form'}
                                      {form method="post"
                                          action="{if !empty($newsItem->getSEO())}{$newsItem->getURL()}{else}{get_static_route id='news.php'}{/if}"
                                          class="form jtl-validate"
                                          id="news-addcomment"
                                          slide=true}
                                          {input type="hidden" name="kNews" value=$newsItem->getID()}
                                          {input type="hidden" name="kommentar_einfuegen" value="1"}
                                          {input type="hidden" name="n" value=$newsItem->getID()}

                                          {block name='blog-details-form-comment-logged-in'}
                                              {formgroup
                                                  id="commentText"
                                                  class="{if $nPlausiValue_arr.cKommentar > 0} has-error{/if}"
                                                  label="<strong>{lang key='newsComment' section='news'}</strong>"
                                                  label-for="comment-text"
                                                  label-class="commentForm"
                                              }
                                                  {if $nPlausiValue_arr.cKommentar > 0}
                                                      <div class="form-error-msg"><i class="fas fa-exclamation-triangle"></i>
                                                          {lang key='fillOut' section='global'}
                                                      </div>
                                                  {/if}
                                                  {if $Einstellungen.news.news_kommentare_freischalten === 'Y'}
                                                      <small class="form-text text-muted-util">{lang key='commentWillBeValidated' section='news'}</small>
                                                  {/if}
                                                  {textarea id="comment-text" name="cKommentar" required=true}{/textarea}
                                              {/formgroup}
                                              {row}
                                                  {col md=4 xl=3 class='blog-details-save'}
                                                      {button block=true variant="primary" name="speichern" type="submit"}
                                                          {lang key='newsCommentSave' section='news'}
                                                      {/button}
                                                  {/col}
                                              {/row}
                                          {/block}
                                      {/form}
                                  {/block}
                              {/col}
                          {/row}
                      {/block}
                  {else}
                      {block name='blog-details-alert-login'}
                          {alert variant="warning"}{lang key='newsLogin' section='news'}{/alert}
                      {/block}
                  {/if}
                  {if $comments|@count > 0}
                      {block name='blog-details-comments-content'}
                          {if $newsItem->getURL() !== ''}
                              {assign var=articleURL value=$newsItem->getURL()}
                              {assign var=cParam_arr value=[]}
                          {else}
                              {assign var=articleURL value='news.php'}
                              {assign var=cParam_arr value=['kNews'=>$newsItem->getID(),'n'=>$newsItem->getID()]}
                          {/if}
                          {block name='blog-details-form-comment-hr-middle'}
                              <hr class="blog-details-hr">
                          {/block}
                          <div id="comments">
                              {row class="blog-comments-header"}
                                  {col cols="auto"}
                                      {block name='blog-details-comments-content-heading'}
                                          <div class="h2 section-heading">{lang key='newsComments' section='news'}
                                              <span itemprop="commentCount">
                                                  ({$comments|count})
                                              </span>
                                          </div>
                                      {/block}
                                  {/col}
                                  {col cols="12" md=6 class="ml-auto-util"}
                                      {block name='blog-details-include-pagination'}
                                          {include file='snippets/pagination.tpl' oPagination=$oPagiComments cThisUrl=$articleURL cParam_arr=$cParam_arr noWrapper=true}
                                      {/block}
                                  {/col}
                              {/row}
                              {block name='blog-details-comments'}
                                  {listgroup class="blog-details-comments-list list-group-flush"}
                                      {foreach $comments as $comment}
                                          {listgroupitem class="blog-details-comments-list-item" itemprop="comment"}
                                              <p>
                                                  {$comment->getName()}, {$comment->getDateCreated()->format('d.m.y H:i')}
                                              </p>
                                              {$comment->getText()}
                                               {foreach $comment->getChildComments() as $childComment}
                                                  <div class="review-reply">
                                                      <span class="subheadline">{lang key='commentReply' section='news'}:</span>
                                                      <blockquote>
                                                          {$childComment->getText()}
                                                          <div class="blockquote-footer">{$childComment->getName()}, {$childComment->getDateCreated()->format('d.m.y H:i')}</div>
                                                      </blockquote>
                                                  </div>
                                               {/foreach}
                                          {/listgroupitem}
                                      {/foreach}
                                  {/listgroup}
                              {/block}
                          </div>
                      {/block}
                  {/if}
                  
                  
{/if}
              {/block}
          {/if}
				{/container}
      </article>
      {if $oNews_arr|count > 0}
        {block name='blog-details-form-comment-hr-bottom'}{/block}
        <div class="bg-secondary py-5" style="margin-bottom: -3rem !important;">
          <div class="container py-3">
            <h2 class="h4 text-center pb-4">{lang key='also_like' section='custom'}</h2>
            {block name='blog-details-latest-news'}
              <div class="tns-carousel">
                <div class="tns-carousel-inner" {literal}data-carousel-options='{"items": {/literal}{$oNews_arr|count}{literal}, "controls": false, "autoHeight": true, "responsive": {"0":{"items":1},"740":{"items":2, "gutter": 20},"900":{"items":3, "gutter": 20}, "1100":{"items":3, "gutter": 30}}}'{/literal}>
                  {foreach $oNews_arr as $oNews}
                  	{blogItemData newsItem=$oNews basic=true cAssign='News'}
                    <article itemprop="about" itemscope=true itemtype="https://schema.org/Blog">
                      {if !empty($oNews->getPreviewImage())}
                        <a class="blog-entry-thumb mb-3" href="{$oNews->getURL()}">
                          <img class="rounded" src="{$oNews->getPreviewImage()}" alt="{$oNews->getTitle()|strip_tags}">
                        </a>
                      {else}
                      	<div class="position-relative">
                          <div class="card-img ratio ratio-4x3 bg-faded-accent mb-3"></div>
                          <i class="ci-image position-absolute top-50 start-50 translate-middle fs-1 text-muted opacity-50"></i>
                        </div>
                      {/if}
                      <div class="d-flex align-items-center fs-sm mb-2">
                        {if $entryData->author !== null}
                          <span class="blog-entry-meta-link">by {$entryData->author->cName}</span>
                          <span class="blog-entry-meta-divider"></span>
                        {/if}
                        <span class="blog-entry-meta-link">{$News->dateValidFrom}</span>
                      </div>
                      <h3 class="h6 blog-entry-title">
                        <a href="{$oNews->getURL()}">{$oNews->getTitle()}</a>
                      </h3>
                    </article>
                  {/foreach} 
                </div>
              </div>
            {/block}
          </div>
        </div>
      {/if}
		{/block}
  {/if}
{/block}
