{$linkgroup = $linkgroups->getLinkGroupByTemplate($linkgroupname)}
{if $linkgroup !== null}
	{get_navigation linkgroupIdentifier=$linkgroupname assign='links'}
  {if count($links) > 0}
    <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" data-bs-auto-close="outside">{$linkgroup->getName()}</a>
      <ul class="dropdown-menu">
        {foreach $links as $Link}
          {$childLinks = $Link->getChildLinks()}
          {if count($childLinks) > 0}
            <li class="dropdown">
              <a class="dropdown-item dropdown-toggle{if $Link->getIsActive()} active{/if}" href="{$Link->getURL()}" title="{$Link->getTitle()}">{$Link->getName()}</a>
              <ul class="dropdown-menu">
                {foreach $childLinks as $childLink}
                  <li>
                    <a class="dropdown-item{if $childLink->getIsActive()} active{/if}" href="{$childLink->getURL()}" title="{$childLink->getTitle()}">{$childLink->getName()}</a>
                  </li>
                {/foreach}
              </ul>
            </li>
          {else}
            <li>
              <a class="dropdown-item{if $Link->getIsActive()} active{/if}" href="{$Link->getURL()}" title="{$Link->getTitle()}">{$Link->getName()}</a>
            </li>
          {/if}
        {/foreach}
      </ul>
    </li>
  {/if}
{/if}