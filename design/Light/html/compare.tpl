{* Шаблон страницы cравнение товаров *}

{* Канонический адрес страницы *}
{$canonical="/compare" scope=parent}

<!-- Хлебные крошки /-->
{$level = 1}
<nav class="mt-4" aria-label="breadcrumb">
    <ol itemscope itemtype="http://schema.org/BreadcrumbList" class="breadcrumb bg-light">
		<li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem" class="breadcrumb-item">
			<a itemprop="item" href="/"><span itemprop="name">Главная</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
		<li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem" class="breadcrumb-item active" aria-current="page">
			<a itemprop="item" href="/{$page->url}"><span itemprop="name">{$page->header|escape}</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
	</ol>
</nav>
<!-- Хлебные крошки #End /-->

<!-- Заголовок страницы -->
<h1 data-page="{$page->id}" class="my-4">Сравнение</h1>

{if $products}
<div class="table-responsive mt-4">
    <table class="table table-striped">
        <thead>
			<tr>
				<td></td>
				{foreach from=$products item=product}
				<td class="product">
					<a href='compare/remove/{$product->url}'>
						<button type="button" class="close" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</a>
					<!-- Фото товара -->
					{if $product->image}
					<div class="image">
						<a href="products/{$product->url}"><img src="{$product->image->filename|resize:100:100}" alt="{$product->name|escape}"/></a>
					</div>
					{/if}
					<!-- Фото товара (The End) -->
					<!-- Название товара -->
					<p style="height: 30px;" class="text-center"><a data-product="{$product->id}" href="products/{$product->url}">{$product->name|escape}</a></p>
					<!-- Название товара (The End) -->
					<div class="rating-wrap text-center  mb-2">
						<ul class="rating-stars">
							<li style="width:{$product->rating*100/5|string_format:"%.0f"}%" class="stars-active"> 
								<i class="fa fa-star"></i> <i class="fa fa-star"></i> 
								<i class="fa fa-star"></i> <i class="fa fa-star"></i> 
								<i class="fa fa-star"></i> 
							</li>
							<li>
								<i class="fa fa-star"></i> <i class="fa fa-star"></i> 
								<i class="fa fa-star"></i> <i class="fa fa-star"></i> 
								<i class="fa fa-star"></i> 
							</li>
						</ul>
						<div class="label-rating">{$product->votes|string_format:"%.0f"} {$product->votes|plural:'голос':'голосов':'голоса'}</div>
					</div> <!-- rating-wrap.// -->
				</td>
				{/foreach} 
			</tr>
		</thead>
        {foreach from=$compare_features name=features item=property}
        <tr class="bord {if $smarty.foreach.features.iteration%2 == 0}gray{/if}">
            <td class="feat"> 
                <b>{$property->name}: </b>
			</td>
            {foreach from=$products item=product}
            <td> 
                {foreach $product->features as $f}
                {if $f->name == $property->name}
                <span>{$f->value}</span>
                {/if}
                {/foreach}
			</td>
            {/foreach} 
		</tr>
        {/foreach} 
	</table>
</div>
{else}
<div class="alert alert-warning mt-4" role="alert">
    Нет товаров для сравнения
</div>
{/if}