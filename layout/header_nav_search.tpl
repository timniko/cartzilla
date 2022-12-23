{block name='layout-header-nav-search'}
  {block name='layout-header-nav-search-search'}
    <div class="input-group d-none d-lg-flex mx-4" id="search">
    	{form action="{get_static_route id='index.php'}" method='get' class='w-100'}
      	<input class="form-control rounded-end pe-5 ac_input" type="text" placeholder="{lang key='findProduct'}" name="qs" id="search-header" autocomplete="off">
        <i class="ci-search position-absolute top-50 end-0 translate-middle-y text-muted fs-base me-3"></i>
   		{/form}
    </div>
  {/block}
{/block}
