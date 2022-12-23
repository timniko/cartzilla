<!-- Hero slider-->
{block name='snippets-slider'}
	{if isset($oSlider) && count($oSlider->getSlides()) > 0}
    {if $oSlider->getTheme() === "cartzilla"}
        <section class="tns-carousel tns-controls-lg mb-4 mb-lg-5">
            {opcMountPoint id='opc_before_slider'}
            <div class="tns-carousel-inner" data-carousel-options="{literal}{&quot;mode&quot;: &quot;gallery&quot;, &quot;responsive&quot;: {&quot;0&quot;:{&quot;nav&quot;:true, &quot;controls&quot;: false},&quot;992&quot;:{&quot;nav&quot;:false, &quot;controls&quot;: true}}}{/literal}">
                {block name='snippets-slider-slide-captions'}
                    {foreach $oSlider->getSlides() as $oSlide}
                        {if isset($oSlide->getTitle())}
													{sliderText text=$oSlide->getTitle() cAssign="h3h2p"}
                          <!-- Item-->
                          <div class="px-lg-5" style="{if !empty($oSlide->getText())}{$oSlide->getText()}{/if}">
                            <div class="d-lg-flex justify-content-between align-items-center ps-lg-4">
                              {block name='snippets-slider-slide-image'}
                                  {image alt=$h3h2p["h2"]
                                      title=$h3h2p["h2"]
                                      src=$oSlide->getAbsoluteImage()
                                      class='d-block order-lg-2 me-lg-n5 flex-shrink-0'
                                      data=["thumb" => "{if !empty($oSlide->getAbsoluteThumbnail())}{$oSlide->getAbsoluteThumbnail()}{/if}"]}
                              {/block}
                              <div class="position-relative mx-auto me-lg-n5 py-5 px-4 mb-lg-5 order-lg-1" style="max-width: 42rem; z-index: 10;">
                                <div class="pb-lg-5 mb-lg-5 text-center text-lg-start text-lg-nowrap">
                                  {block name='snippets-slider-slide-captions-title'}
                                    {if $h3h2p["h3"] != ""}<h3 class="h2 text-light fw-light pb-1 from-bottom">{$h3h2p["h3"]}</h3>{/if}
                                    {if $h3h2p["h2"] != ""}<h2 class="text-light display-5 from-bottom delay-1">{$h3h2p["h2"]}</h2>{/if}
                                    {if $h3h2p["p"] != ""}<p class="fs-lg text-light pb-3 from-bottom delay-2">{$h3h2p["p"]}</p>{/if}
                                  {/block}
                                  {if !empty($oSlide->getLink())}
                                    <div class="d-table scale-up delay-4 mx-auto mx-lg-0">
                                      <a class="btn btn-primary" href="{$oSlide->getLink()}">{lang key='show' section='custom'}<i class="ci-arrow-right ms-2 me-n1"></i></a>
                                    </div>
                                  {/if}
                                </div>
                              </div>
                            </div>
                          </div>
												{/if}
                    {/foreach}
                {/block}
            </div>
        </section>
    {else}
    	<section class="tns-carousel tns-controls-static tns-nav-enabled tns-nav-light tns-nav-inside mb-4 mb-lg-5">
            {opcMountPoint id='opc_before_slider'}
            <div class="tns-carousel-inner" data-carousel-options="{literal}{&quot;mode&quot;: &quot;gallery&quot;, &quot;responsive&quot;: {&quot;0&quot;:{&quot;nav&quot;:true, &quot;controls&quot;: true},&quot;992&quot;:{&quot;nav&quot;:true, &quot;controls&quot;: true}}}{/literal}">
                {block name='snippets-slider-slide-captions'}
                    {foreach $oSlider->getSlides() as $oSlide}
                        {if isset($oSlide->getTitle())}
													{assign value=$oSlide->getTitle() var="slideTitle"}
                          {block name='snippets-slider-slide-image'}
                            {if !empty($oSlide->getLink())}
                              <a href="{$oSlide->getLink()}" class="d-block order-lg-2 me-lg-n5 flex-shrink-0"{if !empty($oSlide->getText())} title="{$oSlide->getText()|strip_tags}"{/if}>
                              	{image alt=$slideTitle
                                title=$slideTitle
                                src=$oSlide->getAbsoluteImage()
                                class='w-100'
                                data=["thumb" => "{if !empty($oSlide->getAbsoluteThumbnail())}{$oSlide->getAbsoluteThumbnail()}{/if}"]}
                              </a>
                            {else}
                              {image alt=$slideTitle
                              title=$slideTitle
                              src=$oSlide->getAbsoluteImage()
                              class='d-block order-lg-2 me-lg-n5 flex-shrink-0'
                              data=["thumb" => "{if !empty($oSlide->getAbsoluteThumbnail())}{$oSlide->getAbsoluteThumbnail()}{/if}"]}
                            {/if}
                          {/block}
												{/if}
                    {/foreach}
                {/block}
            </div>
        </section>
    {/if}
    {block name='snippets-slider-script'}
        {inline_script}<script>
        </script>{/inline_script}
    {/block}
	{/if}
{/block}
