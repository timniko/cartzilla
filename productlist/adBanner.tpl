{block name='snippets-banner'}
  {if isset($banner->oArea_arr[0])}
  	{opcMountPoint id='opc_before_banner'}
    <div class="col-12 px-2 mb-4 py-sm-2">
      <div class="d-sm-flex justify-content-between align-items-center overflow-hidden mb-4 rounded-3 bg-size-cover bg-position-center"{if $banner->oArea_arr[0]->cStyle|@strlen > 0} style="{$banner->oArea_arr[0]->cStyle}"{/if}>
        <div class="py-4 my-2 my-md-0 py-md-5 px-4 ms-md-3 text-center text-sm-start">
          {if $banner->oArea_arr[0]->cTitel|@strlen > 0}
          	<h4 class="fs-lg fw-light mb-2">{$banner->oArea_arr[0]->cTitel}</h4>
          {/if}
          {if $banner->oArea_arr[0]->cBeschreibung|@strlen > 0}
          	<h3 class="mb-4">{$banner->oArea_arr[0]->cBeschreibung}</h3>
          {/if}
          {if $banner->oArea_arr[0]->cUrl|@strlen > 0}
          	<a class="btn btn-primary btn-shadow btn-sm" href="{$banner->oArea_arr[0]->cUrl}">{lang key='show' section='custom'}</a>
          {/if}
        </div>
        {if $banner->oArea_arr[0]->cStyle|@strlen < 1 || strpos($banner->oArea_arr[0]->cStyle, 'url') === false}
          {block name='snippets-banner-image'}
            {image class='d-block ms-auto' fluid=false square=false lazy=true src=$banner->cBildPfad alt=$banner->oArea_arr[0]->cTitel}
          {/block}
        {/if}
      </div>
    </div>
  {/if}
{/block}