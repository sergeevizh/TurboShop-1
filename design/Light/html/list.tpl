{foreach $products as $product}
<article class="card card-product mb-4 list">
	<div class="card-body product">
		<div class="row">
			<aside class="col-sm-3">
				<div class="img-wrap quickview">
					<!-- Фото товара -->
					{if $product->image}
					<span class="icons">
						{if strtotime($product->created) >= strtotime('-1 months')}<span class="notify-badge badge badge-warning">Новинка</span>{/if}
						{if $product->variant->compare_price > 0}<span class="notify-badge badge badge-danger">Акция</span>{/if}
						{if $product->featured}<span class="notify-badge badge btn-primary">Хит</span>{/if}
					</span>
					<div class="image quick">
						<a href="products/{$product->url}"><img src="{$product->image->filename|resize:240:240}" alt="{$product->name|escape}"/></a>
					</div>
					{/if}
					<!-- Фото товара (The End) -->
				</div>
			</aside> 
			<article class="col-sm-6">
				<h4 class="title"><a data-product="{$product->id}" href="products/{$product->url}">{$product->name|escape}</a></h4>
				<div class="rating-wrap  mb-2">
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
				{$product->annotation}
			</article> 
			<aside class="col-sm-3 border-left">
				<div class="action-wrap">
					{if $product->variants|count > 0}
					<form class="variants" action="/cart">
						{foreach $product->variants as $v}
						<input id="featured_{$v->id}" name="variant" value="{$v->id}" type="radio" class="variant_radiobutton" {if $v@first}checked{/if} style="display:none;"/>
						{/foreach}
						<div class="price-wrap h4">  
							<span class="price"> {$product->variant->price|convert} {$currency->sign|escape}</span>	 
							{if $product->variant->compare_price > 0}<del class="price-old"> {$product->variant->compare_price|convert} {$currency->sign|escape}</del>{/if} 
						</div> <!-- info-price-detail // -->
						<p class="text-success">В наличии</p>
						<p>
							<input type="submit" type="submit" data-result-text="Готово"  class="btn btn-primary mb-1" value="Купить" title="Купить" />
							<a href="products/{$product->url}" class="btn btn-secondary mb-1">Далее</a>
						</p>
					</form>
					{else}
					<p class="text-danger">Нет в наличии</p>
					<br>
					{/if}
					{if $wishlist}
						<a href="wishlist/remove/{$product->url}"><i class="fa fa-heart text-danger"></i> Удалить</a>
					{elseif $wishlist_products && in_array($product->url, $wishlist_products)}
						<a href="wishlist"><i class="fa fa-heart text-danger"></i> В избранном</a>
					{else}
						<a class="wishlist-list" href="wishlist/{$product->url}"><i class="fa fa-heart text-secondary"></i> В избранное</a>
					{/if}
					</br>
					{if $smarty.session.compared_products && in_array($product->url, $smarty.session.compared_products)}
						<a href="compare"><i class="fa fa-chart-bar text-primary"></i> В сравнении</a>
					{else}
						<a class="compare-list" href="compare/{$product->url}"><i class="fa fa-chart-bar text-secondary"></i> В сравнение</a>
					{/if}
				</div> 
			</aside> 
		</div> 
	</div> 
</article>
{/foreach}