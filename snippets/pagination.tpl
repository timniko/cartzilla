{block name='snippets-pagination'}
  {assign var=cParam_arr value=$cParam_arr|default:[]}
  {assign var=noWrapper value=$noWrapper|default:false}
  {assign var=cUrlAppend value=$cParam_arr|http_build_query}
  {* parts list to display: label, pagination, items-per-page-options, sort-options *}
  {assign var=parts value=$parts|default:['label','pagi','count','sort']}

  {if !empty($cAnchor)}
    {assign var=cAnchor value='#'|cat:$cAnchor}
  {else}
    {assign var=cAnchor value=''}
  {/if}
  {assign var=showFilter value=$showFilter|default:true}

  {if !empty($cUrlAppend)}
    {assign var=cUrlAppend value='&'|cat:$cUrlAppend}
  {/if}

  {assign var=cThisUrl value=$cThisUrl|default:''}

  {get_static_route id=$cThisUrl assign=cThisUrl}
  {block name='snippets-pagination-content'}
		{if $oPagination->getPageCount() > 1}
			{if in_array('label', $parts) || in_array('pagi', $parts)}
        {block name='snippets-pagination-page-count-multiple'}
          {nav tag='nav' class='d-flex justify-content-between pt-2' aria=["label"=>"pagination"]}
            {if in_array('pagi', $parts)}
                {block name='snippets-pagination-page-link-previous'}
                  <ul class="pagination">
                    <li class="page-item">
                      {link class="page-link"
                        href="{$cThisUrl}?{$oPagination->getId()}_nPage={$oPagination->getPrevPage()}{$cUrlAppend}{$cAnchor}"
                        aria=["label"=>{lang key='previous'}]
                      }
                        <i class="ci-arrow-left me-2"></i>
                      {/link}
                    </li>
                  </ul>
                {/block}
                <ul class="pagination">
                  {if $oPagination->getLeftRangePage() > 0}
                    <li class="page-item">
                      {link class="page-link"  href="{$cThisUrl}?{$oPagination->getId()}_nPage=0{$cUrlAppend}{$cAnchor}"}
                        1
                      {/link}
                    </li>
                  {/if}
                  {if $oPagination->getLeftRangePage() > 1}
                    <li class="page-item">
                      <span class="page-text">&hellip;</span>
                    </li>
                  {/if}
                  {for $i=$oPagination->getLeftRangePage() to $oPagination->getRightRangePage()}
                    <li class="page-item {if $oPagination->getPage() === $i}active{/if}">
                      {link class="page-link {if $oPagination->getPage() === $i}active{elseif $i > 0 && $i < $oPagination->getPageCount() - 1}d-none d-sm-block{/if}" href="{$cThisUrl}?{$oPagination->getId()}_nPage={$i}{$cUrlAppend}{$cAnchor}"}
                        {$i+1}
                      {/link}
                    </li>
                  {/for}
                  {if $oPagination->getRightRangePage() < $oPagination->getPageCount() - 2}
                    <li class="page-item">
                      <span class="page-text">&hellip;</span>
                    </li>
                  {/if}
                  {if $oPagination->getRightRangePage() < $oPagination->getPageCount() - 1}
                    <li class="page-item">
                      {link class="page-link" href="{$cThisUrl}?{$oPagination->getId()}_nPage={$oPagination->getPageCount() - 1}{$cUrlAppend}{$cAnchor}"}
                        {$oPagination->getPageCount()}
                      {/link}
                    </li>
                  {/if}
                </ul>
                <ul class="pagination">
                  <li class="page-item">
                    {block name='snippets-pagination-page-link-next'}
                      {link class="page-link btn btn-link{if $oPagination->getPage() >= $oPagination->getPageCount() - 1} disabled{/if}"
                        href="{$cThisUrl}?{$oPagination->getId()}_nPage={$oPagination->getNextPage()}{$cUrlAppend}{$cAnchor}"
                        aria=["label"=>{lang key='next'}]
                      }
                        <i class="ci-arrow-right ms-2"></i>
                      {/link}
                    {/block}
                  </li>
                </ul>
              {/if}
						</ul>
          {/nav}
          {if false}
            {if in_array('label', $parts)}
              {lang key='paginationEntryPagination' printf={$oPagination->getFirstPageItem() + 1}|cat:':::'|cat:{$oPagination->getFirstPageItem() + $oPagination->getPageItemCount()}|cat:':::'|cat:{$oPagination->getItemCount()}}
            {/if}
          {/if}
        {/block}
			{/if}
		{else}
      {block name='snippets-pagination-page-count-one'}
        {lang key='paginationTotalEntries'} {$oPagination->getItemCount()}
      {/block}
		{/if}

            {if $showFilter === true && (in_array('count', $parts) || in_array('sort', $parts))}
                {block name='snippets-pagination-form'}
                        {form action="{$cThisUrl}{$cAnchor}" method="get"}
                            {block name='snippets-pagination-form-content'}
                                {row}
                                {block name='snippets-pagination-form-hidden'}
                                    {foreach $cParam_arr as $cParamName => $cParamValue}
                                        {input type="hidden" name=$cParamName value=$cParamValue}
                                    {/foreach}
                                {/block}
                                {if in_array('count', $parts)}
                                    {col cols=12 md='auto'}
                                        {block name='snippets-pagination-form-items-pre-page'}
                                            {select class="pagination-selects-entries custom-select"
                                                    name="{$oPagination->getId()}_nItemsPerPage"
                                                    id="{$oPagination->getId()}_nItemsPerPage"
                                                    title="{lang key='paginationEntriesPerPage'}"}
                                                <option disabled>{lang key='paginationEntriesPerPage'}</option>
                                                {foreach $oPagination->getItemsPerPageOptions() as $nItemsPerPageOption}
                                                    <option value="{$nItemsPerPageOption}"{if $oPagination->getItemsPerPage() == $nItemsPerPageOption} selected="selected"{/if}>
                                                        {$nItemsPerPageOption}
                                                    </option>
                                                {/foreach}
                                                <option value="-1"{if $oPagination->getItemsPerPage() == -1} selected="selected"{/if}>
                                                    {lang key='showAll'}
                                                </option>
                                            {/select}
                                        {/block}
                                    {/col}
                                {/if}
                                {if $oPagination->getSortByOptions()|@count > 0 && in_array('sort', $parts)}
                                    {col cols=12 md='auto'}
                                        {block name='snippets-pagination-form-sort'}
                                            {select class="custom-select pagination-selects-sort col-md-auto"
                                                    name="{$oPagination->getId()}_nSortByDir"
                                                    id="{$oPagination->getId()}_nSortByDir"
                                                    title="{lang key='sorting' section='productOverview'}"}
                                                <option disabled>{lang key='sorting' section='productOverview'}</option>
                                                {foreach $oPagination->getSortByOptions() as $i => $cSortByOption}
                                                    <option value="{$i * 2}"
                                                            {if $i * 2 == $oPagination->getSortByDir()} selected="selected"{/if}>
                                                        {$cSortByOption[1]} {lang key='asc'}
                                                    </option>
                                                    <option value="{$i * 2 + 1}"
                                                            {if $i * 2 + 1 == $oPagination->getSortByDir()} selected="selected"{/if}>
                                                        {$cSortByOption[1]} {lang key='desc'}
                                                    </option>
                                                {/foreach}
                                            {/select}
                                        {/block}
                                    {/col}
                                {/if}
                                {/row}
                            {/block}
                        {/form}
                {/block}
            {/if}
    {/block}
{/block}
