{block name='snippets-suggestion'}
	{if !isset($type)}
  	{$type='product'}
  {/if}
  {if $type === "product"}
    <div class="snippets-suggestion">
      {link href=$result->cURLFull title=$result->cName class='btn btn-hover-light d-flex align-items-center gap-3 py-2 px-3 lh-sm'}
        {if !empty($result->cVorschaubild)}
          {image lazy=true
            webp=true
            src=$result->cVorschaubild
            alt=$result->cName
            fluid-grow=true
            thumbnail=true
          }
        {/if}
        <div class="text-start text-wrap">
          <strong class="d-block">{$result->cName}</strong>
          {if $result->cKurzBeschreibung|strlen > 0}
            <small>
              <span class="d-block">{$result->cKurzBeschreibung|truncate}</span>
              <span class="d-block"><strong>{lang key='productNo'}:</strong> {$result->cArtNr}</span>
            </small>
          {/if}
        </div>
      {/link}
    </div>
  {elseif $type === "category"}
  	<div class="snippets-suggestion">
      {link href=$result->getURL() title=$result->getName() class='btn btn-hover-light d-flex align-items-center gap-3 py-2 px-3 lh-sm'}
        {assign var=bild value=$result->getImageURL(true)}
        {if !empty($bild)}
          {image lazy=true
            webp=false
            src=$bild
            alt=$result->getImageAlt()
            fluid-grow=true
            thumbnail=true
          }
        {/if}
        <div class="text-start text-wrap">
          <strong class="d-block">{$result->getName()}</strong>
            <small>
            	<span class="d-block">{lang key='category'}</span>
              {if $result->getDescription()|strlen > 0}
                <span class="d-block">{$result->getDescription()|truncate}</span>
              {/if}
              <span class="d-block">{$result->getMetaKeywords()}</span>
            </small>
        </div>
      {/link}
    </div>
  {/if}
{/block}