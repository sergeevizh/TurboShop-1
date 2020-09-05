{if $minprice != $maxprice || $category->brands || $features}
<div class="card card-filter mt-4">
    {if ($minprice != 0 && $maxprice != 0) && ($minprice != $maxprice)}
    <article class="card-group-item">
        <header class="card-header">
            <a class="" aria-expanded="true" href="#" data-toggle="collapse" data-target="#collapse22">
                <i class="icon-action fa fa-chevron-down"></i>
                <h6 class="title">Фильтр по цене</h6>
			</a>
		</header>
        <div style="" class="filter-content collapse show" id="collapse22">
            <div class="card-body">
                <div class="sidebar-block filter-price">
                    <input type="hidden" value="{$minprice|convert|regex_replace:'/[ ]/':''|regex_replace:'/[,]/':'.'|floor}" id="f_minPrice">
                    <input type="hidden" value="{$maxprice|convert|regex_replace:'/[ ]/':''|regex_replace:'/[,]/':'.'|ceil}" id="f_maxPrice">
                    <input type="hidden" value="{$current_minprice|convert|regex_replace:'/[ ]/':''|regex_replace:'/[,]/':'.'|floor}" id="f_currentMinPrice">
                    <input type="hidden" value="{$current_maxprice|convert|regex_replace:'/[ ]/':''|regex_replace:'/[,]/':'.'|ceil}" id="f_currentMaxPrice">
                    <input type="hidden" value="10{if $currency->code == 'RUR'}0{/if}" id="f_priceStep">
                    <input type="hidden" value=" {$currency->sign}" id="f_postfix">
                    <span type="text" id="price-slider"></span>
                    <form class="mcf_form" method="post">
                        <input type="hidden" name="rate_from" id="rate_from" value="{$currency->rate_from}"/>
                        <input type="hidden" name="rate_to"   id="rate_to"   value="{$currency->rate_to}"/>
                        <input type="hidden" name="min_price" id="min_price" value="{$current_minprice|convert|regex_replace:'/[ ]/':''|regex_replace:'/[,]/':'.'|floor}">
                        <input type="hidden" name="max_price" id="max_price" value="{$current_maxprice|convert|regex_replace:'/[ ]/':''|regex_replace:'/[,]/':'.'|ceil}">
                        <button type="submit" class="btn btn-block btn-outline-primary mt-2">Применить</button>
					</form>
				</div>
			</div> 
		</div> 
	</article> 
    {/if}
    <form method="get" action="{url page=null}">
		{if !$brand}
		{if $category->brands}
		<article class="card-group-item">
			<header class="card-header">
				<a href="#" data-toggle="collapse" data-target="#collapse_brands">
					<i class="icon-action fa fa-chevron-down"></i>
					<h6 class="title">Бренды</h6>
				</a>
			</header>
			<div class="filter-content collapse {if $is_mobile === false && $is_tablet === false}show{/if}" id="collapse_brands">
				<div class="card-body">
					{foreach name=brands item=b from=$category->brands}
					<label class="form-check">
						<input type="checkbox" class="form-check-input" onchange="submit(this.form);" name="b[]" value="{$b->id}"{if $smarty.get.b && $b->id|in_array:$smarty.get.b} checked{/if}>
						<span class="form-check-label">
							{$b->name|escape}
						</span>
					</label>  
					{/foreach}    
				</div> 
			</div> 
		</article> 
		{/if}
		{/if}
		{if $features}
		{foreach $features as $f}
        <article class="card-group-item">
            <header class="card-header">
                <a href="#" data-toggle="collapse" data-target="#collapse{$f->id}">
                    <i class="icon-action fa fa-chevron-down"></i>
                    <h6 class="title">{$f->name}</h6>
				</a>
			</header>
            <div class="filter-content collapse {if $is_mobile === false && $is_tablet === false}show{/if}" id="collapse{$f->id}">
                <div class="card-body">
                    {foreach $f->options as $k=>$o}
                    <label class="form-check">
                        <input type="checkbox" class="form-check-input" name="{$f->id}[]" onchange="submit(this.form);" {if $filter_features.{$f->id} && in_array($o->value,$filter_features.{$f->id})}checked="checked"{/if} value="{$o->value|escape}" />
                        <span class="form-check-label">
                            {$o->value|escape}
						</span>
					</label> 
                    {/foreach}    
				</div> 
			</div> 
		</article> 
        {/foreach}
		{/if}
	</form>
</div> 
<div class="card-body">
    <a class="btn btn-block btn-outline-secondary mcf_button" href="catalog/{$category->url}">Сбросить</a>
</div> 
{/if}