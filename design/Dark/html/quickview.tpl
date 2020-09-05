<div class='tqv'>
	<div class="row product">
		<div class="col-md-8">
			<div id="carouselExampleIndicators2" class="carousel slide my-4" data-ride="carousel">
				<div class="carousel-inner" role="listbox">
					{foreach $product->images as $i=>$image name=foo}
					<div class="carousel-item image {if $smarty.foreach.foo.first}active{/if}">
						<a data-fancybox="gallery" href="{$image->filename|resize:800:800:w}">
							<img src="{$image->filename|resize:300:300}" alt="{$product->name|escape}">
							<span class="icon-focus"><i class="fa fa-search-plus"></i></span>
						</a>
					</div>
					{/foreach}
				</div>
			</div>
			{if $product->images|count>1}
			<span class="d-sm-none d-md-block d-none">
				<div class="row text-center text-lg-left">
					{foreach $product->images as $i=>$image name=images}
					<div class="col-lg-3 col-md-4 col-xs-6 mb-4">
						<a href="#" data-target="#carouselExampleIndicators2" data-slide-to="{$smarty.foreach.images.index}" class="d-block text-center img-thumbnail">
							<img class="img-fluid thumbnail" src="{$image->filename|resize:95:95}" alt="{$product->name|escape}">
						</a>
					</div>
					{/foreach}
				</div>
			</span>
			{/if}
		</div>
		<div class="col-md-4 mb-4">
			<h4 class="my-3">Краткое описание</h4>
			<div rel="{$product->id}" class="rating-wrap mb-2 ratings">
				<ul class="rating-stars rater-starsOff" style="width:100px;">
					<li style="width:{$product->rating*100/5|string_format:"%.0f"}%" class="stars-active rater-starsOn"> 
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
				<div class="label-rating">
					<span class="test-text">
						<span class="rater-rating">{$product->rating|string_format:"%.1f"}</span>&#160;(голосов <span class="rater-rateCount">{$product->votes|string_format:"%.0f"}</span>)
					</span>
				</div>
			</div> <!-- rating-wrap.// -->
			<p>{$product->annotation}</p>
			{if $product->variant->sku}<span class="article"><span class="block_title">Артикул: </span><span class="value">{$product->variant->sku}</span></span>{/if}
			{if $product->variants|count > 0}
			<!-- Выбор варианта товара -->
			<form class="variants" action="/cart">
				<h3 class="offers_price"><span class="price_value">{$product->variant->price|convert}</span> {$currency->sign|escape}</h3>
				{if $product->variant->compare_price > 0}<h5 class="mb-3 text-secondary offers_price_old"><del><span class="price_value">{$product->variant->compare_price|convert}</span> {$currency->sign|escape}</del></h5>{/if}
				<select name="variant" id="{$prefix}variant_{$product->id}" class="orderby custom-select mb-4" data-productid="{$product->id}" {if $product->variants|count == 1} hidden{/if}>
					{foreach $product->variants as $v}
					<option value="{$v->id}" 
					data-price="{$v->price|convert}" 
					{if $v->compare_price} data-compare="{$v->compare_price|convert}"{/if}
						{if $v->name} data-name="{$v->name}"{/if}
						{if $v->sku} data-sku="{$v->sku}"{/if}
						{if $product->variant->id==$v->id}selected{/if}
					>{$v->name}</option>
					{/foreach}
				</select>
				<input data-result-text="Добавлен" type="submit" class="btn btn-primary btn-lg" value="В корзину" />
				<div class="btn-group ml-3" role="group" aria-label="First group">
					{if $wishlist_products && in_array($product->url, $wishlist_products)}
						<a class="btn-lg btn-secondary mr-2"  href='wishlist'><i class="fa fa-heart text-danger"></i></a>
					{else}
						<a class="btn-lg btn-secondary wishlist mr-2" href='wishlist/{$product->url}'><i class="fa fa-heart text-white"></i></a>
					{/if}
					{if $smarty.session.compared_products && in_array($product->url, $smarty.session.compared_products)}
						<a class="btn-lg btn-secondary" href='compare'><i class="fa fa-chart-bar text-info"></i></a>
					{else}
						<a class="btn-lg btn-secondary compare" href='compare/{$product->url}'><i class="fa fa-chart-bar text-white"></i></a>
					{/if}
				</div>
			</form>
			<!-- Выбор варианта товара (The End) -->
			{else}
				Нет в наличии
			{/if}
		</div>
	</div>
</div>
<script src="design/{$settings->theme}/js/ajax_cart.js"></script>
<script src="js/jquery.rater.js" type="text/javascript"></script>