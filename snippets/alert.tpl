{block name='snippets-alert'}
    <div class="alert alert-{$alert->getCssType()} d-flex alert-dismissible {$alert->getFadeOut()} show" role="alert"{if $alert->getId()} id="{$alert->getId()}"{/if}>
    	<div class="alert-icon">
      	{if $alert->getCssType() == "primary"}
        	<i class="ci-bell"></i>
        {elseif $alert->getCssType() == "secondary"}
        	<i class="ci-time"></i>
        {elseif $alert->getCssType() == "success"}
        	<i class="ci-check-circle"></i>
        {elseif $alert->getCssType() == "danger"}
        	<i class="ci-close-circle"></i>
        {elseif $alert->getCssType() == "warning"}
        	<i class="ci-security-announcement"></i>
        {elseif $alert->getCssType() == "info"}
        	<i class="ci-announcement"></i>
        {elseif $alert->getCssType() == "light"}
        	<i class="ci-unlocked"></i>
        {elseif $alert->getCssType() == "dark"}
        	<i class="ci-location"></i>
        {/if}
      </div>
      <div>
        {if !empty($alert->getLinkHref()) && empty($alert->getLinkText())}
            {link href=$alert->getLinkHref() class="alert-link"}{$alert->getMessage()}{/link}
        {elseif !empty($alert->getLinkHref()) && !empty($alert->getLinkText())}
            {$alert->getMessage()}
            {link href=$alert->getLinkHref() class="alert-link"}{$alert->getLinkText()}{/link}
        {else}
            {$alert->getMessage()}
        {/if}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    </div>
{/block}
