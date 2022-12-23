{block name='account-orders'}
  {block name='account-orders-content'}
    {if $Bestellungen|@count > 0}
      {block name='account-orders-orders'}
        <div class="table-responsive fs-md mb-4">
          <table class="table table-hover mb-0">
            <thead>
              <tr>
                <th>{lang key='orderNo' section='login'}</th>
                <th>{lang key='orderDate' section='login'}</th>
                <th>{lang key='orderStatus' section='login'}</th>
                <th>{lang key='totalSum'}</th>
              </tr>
            </thead>
            <tbody>
              {foreach $orderPagination->getPageItems() as $order}
              	{bestellStatusBadge Bestellung=$order}
                <tr>
                  <td class="py-3">
                    {link href="{get_static_route id='jtl.php'}?bestellung={$order->kBestellung}" class="nav-link-style fw-medium fs-sm"
                      title="{lang key='showOrder' section='login'}: {lang key='orderNo' section='login'} {$order->cBestellNr}"
                      data=["toggle" => "tooltip", "placement" => "bottom"]
                    }
                    	<i class="ci-eye me-3"></i>{$order->cBestellNr}
                    {/link}
                  </td>
                  <td class="py-3">{$order->dBestelldatum}</td>
                  <td class="py-3">{$StatusBadge}</td>
                  <td class="py-3">{$order->cBestellwertLocalized}</td>
                </tr>
              {/foreach}
            </tbody>
          </table>
        </div>
      {/block}
      {block name='account-orders-include-pagination'}
        {include file='snippets/pagination.tpl' oPagination=$orderPagination cThisUrl='jtl.php' cParam_arr=['bestellungen' => 1] parts=['pagi', 'label']}
      {/block}
    {else}
      {block name='account-orders-alert'}
        {alert variant="info"}{lang key='noEntriesAvailable'}{/alert}
      {/block}
    {/if}
    {block name='account-orders-actions'}
    {/block}
  {/block}
{/block}
