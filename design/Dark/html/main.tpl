{* Главная страница магазина *}

{* Для того чтобы обернуть центральный блок в шаблон, отличный от index.tpl *}
{* Укажите нужный шаблон строкой ниже. Это работает и для других модулей *}
{$wrapper = 'index.tpl' scope=parent}

{* Канонический адрес страницы *}
{$canonical="" scope=parent}

{* Рекомендуемые товары *}
{get_featured_products var=featured_products}
{if $featured_products}
<h2 class="my-2">Рекомендуемые товары</h2>
<hr>
<div class="row">
    {foreach $featured_products as $product}
    <div class="col-lg-4 col-md-6 mb-4">
		<div class="card card-product product">
			<!-- Фото товара -->
			<span class="quickview">
				<span class="icons">
					{if strtotime($product->created) >= strtotime('-1 months')}<span class="notify-badge badge badge-warning">Новинка</span>{/if}
					{if $product->variant->compare_price > 0}<span class="notify-badge badge badge-danger">Акция</span>{/if}
					{if $product->featured}<span class="notify-badge badge btn-primary">Хит</span>{/if}
				</span>
				{if $product->image}
				<div class="image quick">
					<a href="products/{$product->url}"><img src="{$product->image->filename|resize:240:240}" alt="{$product->name|escape}"/></a>
				</div>
				{else}
				<div class="image quick">
					<a href="products/{$product->url}"><i class="fa fa-image fa-10x text-muted"></i></a>
				</div>
				{/if}
			</span>
			<!-- Фото товара (The End) -->
			<div class="card-body">
				<h5 class="card-title"><a data-product="{$product->id}" href="products/{$product->url}">{$product->name|escape}</a></h5>
				<div class="rating-wrap mb-2">
					<ul class="rating-stars">
						<li style="width:{$product->rating*100/5|string_format:"%.0f"}%" class="stars-active"> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
						</li>
						<li>
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
						</li>
					</ul>
					<div class="label-rating">{$product->votes|string_format:"%.0f"} {$product->votes|plural:'голос':'голосов':'голоса'}</div>
				</div> <!-- rating-wrap.// -->
				<p class="card-text">{$product->annotation|strip_tags|truncate:70}</p>
				{if $product->variants|count > 0}
				<!-- Выбор варианта товара -->
				<form class="variants" action="/cart">
					{foreach $product->variants as $v}
					<input id="featured_{$v->id}" name="variant" value="{$v->id}" type="radio" class="variant_radiobutton" {if $v@first}checked{/if} style="display:none;"/>
					{/foreach}
					<h5 class="card-title">{if $product->variant->compare_price > 0}<del class="price-old"><small><span class="compare_price">{$product->variant->compare_price|convert}</span>{$currency->sign|escape}</small></del>{/if}  <span class="prices">{$product->variant->price|convert}</span> <span class="currency">{$currency->sign|escape}</span></h5>
					<span class="btn-toolbar justify-content-between">
						<input type="submit" type="submit" data-result-text="В корзине" class="btn btn-primary" value="Купить" title="Купить" />	
						<div class="btn-group" role="group" aria-label="First group">
							{if $wishlist}
							<a class="btn btn-secondary"  href='wishlist/remove/{$product->url}'><i class="fa fa-heart text-danger"></i></a>
							{elseif $wishlist_products && in_array($product->url, $wishlist_products)}
							<a class="btn btn-secondary"  href='wishlist'><i class="fa fa-heart text-danger"></i></a>
							{else}
							<a class="btn btn-secondary wishlist" href='wishlist/{$product->url}'><i class="fa fa-heart text-white"></i></a>
							{/if}
							{if $smarty.session.compared_products && in_array($product->url, $smarty.session.compared_products)}
							<a class="btn btn-secondary" href='compare'><i class="fa fa-chart-bar text-info"></i></a>
							{else}
							<a class="btn btn-secondary compare" href='compare/{$product->url}'><i class="fa fa-chart-bar text-white"></i></a>
							{/if}
						</div>
					</span>
				</form>
				<!-- Выбор варианта товара (The End) -->
				{else}
				Нет в наличии
				{/if}
			</div>
		</div>
	</div>
    {/foreach}
</div>
{/if} 

{* Новинки *}
{get_new_products var=new_products limit=3}
{if $new_products}
<h2 class="my-2">Новинки</h2>
<hr>
<div class="row">
    {foreach $new_products as $product}
    <div class="col-lg-4 col-md-6 mb-4">
		<div class="card card-product product">
			<!-- Фото товара -->
			<span class="quickview">
				<span class="icons">
					{if strtotime($product->created) >= strtotime('-1 months')}<span class="notify-badge badge badge-warning">Новинка</span>{/if}
					{if $product->variant->compare_price > 0}<span class="notify-badge badge badge-danger">Акция</span>{/if}
					{if $product->featured}<span class="notify-badge badge btn-primary">Хит</span>{/if}
				</span>
				{if $product->image}
				<div class="image quick">
					<a href="products/{$product->url}"><img src="{$product->image->filename|resize:240:240}" alt="{$product->name|escape}"/></a>
				</div>
				{else}
				<div class="image quick">
					<a href="products/{$product->url}"><i class="fa fa-image fa-10x text-muted"></i></a>
				</div>
				{/if}
			</span>
			<!-- Фото товара (The End) -->
			<div class="card-body">
				<h5 class="card-title"><a data-product="{$product->id}" href="products/{$product->url}">{$product->name|escape}</a></h5>
				<div class="rating-wrap  mb-2">
					<ul class="rating-stars">
						<li style="width:{$product->rating*100/5|string_format:"%.0f"}%" class="stars-active"> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
						</li>
						<li>
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
						</li>
					</ul>
					<div class="label-rating">{$product->votes|string_format:"%.0f"} {$product->votes|plural:'голос':'голосов':'голоса'}</div>
				</div> <!-- rating-wrap.// -->
				<p class="card-text">{$product->annotation|strip_tags|truncate:70}</p>
				{if $product->variants|count > 0}
				<!-- Выбор варианта товара -->
				<form class="variants" action="/cart">
					{foreach $product->variants as $v}
					<input id="featured_{$v->id}" name="variant" value="{$v->id}" type="radio" class="variant_radiobutton" {if $v@first}checked{/if} style="display:none;"/>
					{/foreach}
					<h5 class="card-title">{if $product->variant->compare_price > 0}<del class="price-old"><small><span class="compare_price">{$product->variant->compare_price|convert}</span>{$currency->sign|escape}</small></del>{/if}  <span class="prices">{$product->variant->price|convert}</span> <span class="currency">{$currency->sign|escape}</span></h5>
					<span class="btn-toolbar justify-content-between">
						<input type="submit" type="submit" data-result-text="В корзине"  class="btn btn-primary" value="Купить" title="Купить" />	
						<div class="btn-group" role="group" aria-label="First group">
							{if $wishlist}
							<a class="btn btn-secondary"  href='wishlist/remove/{$product->url}'><i class="fa fa-heart text-danger"></i></a>
							{elseif $wishlist_products && in_array($product->url, $wishlist_products)}
							<a class="btn btn-secondary"  href='wishlist'><i class="fa fa-heart text-danger"></i></a>
							{else}
							<a class="btn btn-secondary wishlist" href='wishlist/{$product->url}'><i class="fa fa-heart text-white"></i></a>
							{/if}
							{if $smarty.session.compared_products && in_array($product->url, $smarty.session.compared_products)}
							<a class="btn btn-secondary" href='compare'><i class="fa fa-chart-bar text-info"></i></a>
							{else}
							<a class="btn btn-secondary compare" href='compare/{$product->url}'><i class="fa fa-chart-bar text-white"></i></a>
							{/if}
						</div>
					</span>
				</form>
				<!-- Выбор варианта товара (The End) -->
				{else}
				Нет в наличии
				{/if}
			</div>
		</div>
	</div>
    {/foreach}
</div>
{/if} 

{* Акционные товары *}
{get_discounted_products var=discounted_products limit=9}
{if $discounted_products}
<h2 class="my-2">Акционные товары</h2>
<hr>
<div class="row">
    {foreach $discounted_products as $product}
    <div class="col-lg-4 col-md-6 mb-4">
		<div class="card card-product product">
			<!-- Фото товара -->
			<span class="quickview">
				<span class="icons">
					{if strtotime($product->created) >= strtotime('-1 months')}<span class="notify-badge badge badge-warning">Новинка</span>{/if}
					{if $product->variant->compare_price > 0}<span class="notify-badge badge badge-danger">Акция</span>{/if}
					{if $product->featured}<span class="notify-badge badge btn-primary">Хит</span>{/if}
				</span>
				{if $product->image}
				<div class="image quick">
					<a href="products/{$product->url}"><img src="{$product->image->filename|resize:240:240}" alt="{$product->name|escape}"/></a>
				</div>
				{else}
				<div class="image quick">
					<a href="products/{$product->url}"><i class="fa fa-image fa-10x text-muted"></i></a>
				</div>
				{/if}
			</span>
			<!-- Фото товара (The End) -->
			<div class="card-body">
				<h5 class="card-title"><a data-product="{$product->id}" href="products/{$product->url}">{$product->name|escape}</a></h5>
				<div class="rating-wrap  mb-2">
					<ul class="rating-stars">
						<li style="width:{$product->rating*100/5|string_format:"%.0f"}%" class="stars-active"> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
						</li>
						<li>
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
							<i class="fa fa-star"></i> 
						</li>
					</ul>
					<div class="label-rating">{$product->votes|string_format:"%.0f"} {$product->votes|plural:'голос':'голосов':'голоса'}</div>
				</div> <!-- rating-wrap.// -->
				<p class="card-text">{$product->annotation|strip_tags|truncate:70}</p>
				{if $product->variants|count > 0}
				<!-- Выбор варианта товара -->
				<form class="variants" action="/cart">
					{foreach $product->variants as $v}
					<input id="featured_{$v->id}" name="variant" value="{$v->id}" type="radio" class="variant_radiobutton" {if $v@first}checked{/if} style="display:none;"/>
					{/foreach}
					<h5 class="card-title">{if $product->variant->compare_price > 0}<del class="price-old"><small><span class="compare_price">{$product->variant->compare_price|convert}</span>{$currency->sign|escape}</small></del>{/if}  <span class="prices">{$product->variant->price|convert}</span> <span class="currency">{$currency->sign|escape}</span></h5>
					<span class="btn-toolbar justify-content-between">
						<input type="submit" type="submit" data-result-text="В корзине"  class="btn btn-primary" value="Купить" title="Купить" />	
						<div class="btn-group" role="group" aria-label="First group">
							{if $wishlist}
							<a class="btn btn-secondary"  href='wishlist/remove/{$product->url}'><i class="fa fa-heart text-danger"></i></a>
							{elseif $wishlist_products && in_array($product->url, $wishlist_products)}
							<a class="btn btn-secondary"  href='wishlist'><i class="fa fa-heart text-danger"></i></a>
							{else}
							<a class="btn btn-secondary wishlist" href='wishlist/{$product->url}'><i class="fa fa-heart text-white"></i></a>
							{/if}
							{if $smarty.session.compared_products && in_array($product->url, $smarty.session.compared_products)}
							<a class="btn btn-secondary" href='compare'><i class="fa fa-chart-bar text-info"></i></a>
							{else}
							<a class="btn btn-secondary compare" href='compare/{$product->url}'><i class="fa fa-chart-bar text-white"></i></a>
							{/if}
						</div>
					</span>
				</form>
				<!-- Выбор варианта товара (The End) -->
				{else}
				Нет в наличии
				{/if}
			</div>
		</div>
	</div>
    {/foreach}
</div>
{/if} 

{* Заголовок страницы *}
<h1>{$page->header}</h1>
{* Тело страницы *}
{$page->body}