{* Страница товара *}

{if $smarty.server.HTTP_X_REQUESTED_WITH|strtolower == 'xmlhttprequest'}
    {$wrapper = 'quickview.tpl' scope=parent}
{/if}

{* Канонический адрес страницы *}
{$canonical="/products/{$product->url}" scope=parent}

<!-- Хлебные крошки /-->
{$level = 1}
<nav class="mt-4" aria-label="breadcrumb">
    <ol itemscope itemtype="https://schema.org/BreadcrumbList" class="breadcrumb bg-light">
        <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem" class="breadcrumb-item">
			<a itemprop="item" href="/"><span itemprop="name" title="Главная">Главная</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
        {foreach $category->path as $cat}
		<li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem" class="breadcrumb-item">
			<a itemprop="item" href="catalog/{$cat->url}"><span itemprop="name">{$cat->name|escape}</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
		{/foreach}
		{if $brand}
		<li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem" class="breadcrumb-item">
			<a itemprop="item" href="catalog/{$cat->url}/{$brand->url}"><span itemprop="name">{$brand->name|escape}</a>
			 <meta itemprop="position" content="{$level++}" />
		</li>
		{/if}
        <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem" class="breadcrumb-item active" aria-current="page">
			<span itemprop="name">{$product->name|escape}</span>
			<meta itemprop="position" content="{$level++}" />
		</li>
	</ol>
</nav>
<!-- Хлебные крошки #End /-->

<div itemscope itemtype="http://schema.org/Product">
	<link itemprop="image" href="{$product->image->filename|resize:570:570}" />
	<meta itemprop="category" content="{$category->name|escape}" />
	<!-- Заголовок страницы -->
	<h1 data-product="{$product->id}" itemprop="name" class="my-4">{$product->name|escape}</h1>

	<div class="row product">
		<div class="col-md-8">
			<div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel">
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
						<a href="#" data-target="#carouselExampleIndicators" data-slide-to="{$smarty.foreach.images.index}" class="d-block text-center img-thumbnail">
							<img class="img-fluid thumbnail" src="{$image->filename|resize:95:95}" alt="{$product->name|escape}">
						</a>
					</div>
					{/foreach}
				</div>
			</span>
			{/if}
		</div>
		<div class="col-md-4 mb-4">
			<h3 class="my-3">Краткое описание</h3>
			<div rel="{$product->id}" class="rating-wrap mb-2 ratings" itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
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
						{if $product->rating > 0}<span itemprop="ratingValue" class="rater-rating">{$product->rating|string_format:"%.1f"}</span>&#160;(голосов <span itemprop="reviewCount" class="rater-rateCount">{$product->votes|string_format:"%.0f"}</span>){/if}
						<meta itemprop="worstRating" content="1">
						<meta itemprop="bestRating"  content="5">
					</span>
				</div>
			</div> <!-- rating-wrap.// -->
			{if $brand->image}
			<a href="catalog/{$category->url}/{$brand->url}">
				<img class="brand_img" src="{$brand->image|resize_brands:75:23}" alt="{$brand->name|escape}" title="{$brand->name|escape}">
				<span style="display:none;" itemprop="brand">{$brand->name|escape}</span>
			</a>
			{/if}
			<p>{$product->annotation}</p>
			{if $product->variant->sku}<span class="article"><span class="block_title">Артикул: </span><span itemprop="sku" class="value">{$product->variant->sku}</span></span>{/if}
			{if $product->variants|count > 0}
			<div itemprop="offers" itemscope="" itemtype="http://schema.org/Offer">
				<link itemprop="url" href="{$config->root_url}/products/{$product->url}" />
				<!-- Выбор варианта товара -->
				<form class="variants" action="/cart">
					<h3 class="offers_price"><span itemprop="price" content="{$product->variant->price|convert:'':false}" class="price_value">{$product->variant->price|convert}</span> <span itemprop="priceCurrency" content="{$currency->code|escape}">{$currency->sign|escape}</span></h3>
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
						{if $wishlist}
						<a class="btn-lg btn-light"  href='wishlist/remove/{$product->url}'><i class="fa fa-heart text-danger"></i></a>
						{elseif $wishlist_products && in_array($product->url, $wishlist_products)}
						<a class="btn-lg btn-light"  href='wishlist'><i class="fa fa-heart text-danger"></i></a>
						{else}
						<a class="btn-lg btn-light wishlist" href='wishlist/{$product->url}'><i class="fa fa-heart text-secondary"></i></a>
						{/if}
						{if $smarty.session.compared_products && in_array($product->url, $smarty.session.compared_products)}
						<a class="btn-lg btn-light" href='compare'><i class="fa fa-chart-bar text-primary"></i></a>
						{else}
						<a class="btn-lg btn-light compare" href='compare/{$product->url}'><i class="fa fa-chart-bar text-secondary"></i></a>
						{/if}
					</div>
				</form>
				<!-- Выбор варианта товара (The End) -->
				<span style="display:none;">
					<time itemprop="priceValidUntil" datetime="{$product->created|date:'Ymd'}"></time>
					{if $product->variant->stock > 0}
					<link itemprop="availability" href="https://schema.org/InStock" />
					{else}
					<link itemprop="availability" href="http://schema.org/OutOfStock" />
					{/if}
					<link itemprop="itemCondition" href="https://schema.org/NewCondition" />
					<span itemprop="seller" itemscope itemtype="http://schema.org/Organization">
					<span itemprop="name">{$settings->site_name}</span></span>
				</span>
			</div>
			{else}
				Нет в наличии
			{/if}
		</div>
	</div>
	<ul class="nav nav-tabs" id="myTab" role="tablist">
		<li class="nav-item">
			<a class="nav-link active" id="body-tab" data-toggle="tab" href="#body" role="tab" aria-controls="body" aria-selected="true">Описание</a>
		</li>
		{if $product->features}
		<li class="nav-item">
			<a class="nav-link" id="features-tab" data-toggle="tab" href="#features" role="tab" aria-controls="features" aria-selected="false">Характиристики</a>
		</li>
		{/if}
		<li class="nav-item">
			<a class="nav-link" id="comments-tab" data-toggle="tab" href="#comments" role="tab" aria-controls="comments" aria-selected="false">Комментарии ({$comments|count})</a>
		</li>
	</ul>
	<div class="tab-content mt-4" id="myTabContent">
		<div itemprop="description" class="tab-pane fade show active" id="body" role="tabpanel" aria-labelledby="body-tab">{$product->body}</div>
		{if $product->features}
		<div class="tab-pane fade" id="features" role="tabpanel" aria-labelledby="features-tab">
			<table class="table table-striped">
				<tbody>
					{foreach $product->features as $f}
					<tr>
						<th scope="row">{$f->name}</th>
						<td>{$f->value}</td>
					</tr>
					{/foreach}
				</tbody>
			</table>    
		</div>
		{/if}
		<div class="tab-pane fade" id="comments" role="tabpanel" aria-labelledby="comments-tab">
			{if $comments}
			<span itemprop="review" itemscope itemtype="http://schema.org/Review">
			<!-- Список с комментариями -->
			{foreach $comments as $comment}
			<meta itemprop="datePublished" content="{$comment->date|date}">
			<meta itemprop="name" content="{$product->name|escape}">
			<meta itemprop="itemreviewed" content="{$product->name|escape}">
			<a name="comment_{$comment->id}"></a>
			<p><span itemprop="description">{$comment->text|escape|nl2br}</span></p>
			<small class="text-muted"><b><span itemprop="author">{$comment->name|escape}</span></b> {$comment->date|date} в {$comment->date|time} {if !$comment->approved}ожидает модерации</b>{/if}</small>
			<hr>
			{/foreach}
			<!-- Список с комментариями (The End)-->
			{else}
			<p>
				Пока нет комментариев
			</p>
			</span>
			{/if}
			<a class="btn btn-success mb-4" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">Комментировать</a>
			{if $error}
				<div class="alert alert-danger" role="alert">
					{if $error=='captcha'}
						Неверно введена капча
					{elseif $error=='empty_name'}
						Введите имя
					{elseif $error=='empty_comment'}
						Введите комментарий
					{/if}
				</div>
			{/if}
			<div class="collapse" id="collapseExample">
				<form class="form-horizontal mt-4" role="form" id="loginForm" method="post">
					<div class="form-group">
						<label for="comment">Комментарий</label>
						<textarea class="form-control" rows="4" name="text" placeholder="Введите комментарий" required="" data-format=".+" data-notice="Введите комментарий">{$comment_text}</textarea>
						<div class="invalid-feedback">Введите комментарий</div>
					</div>
					<div class="form-group">
						<label for="comment_name">Имя</label>
						<input class="form-control" type="text" id="comment_name" name="name" placeholder="Введите имя" required="" value="{$comment_name}" data-format=".+" data-notice="Введите имя"/>
						<div class="invalid-feedback">Имя</div>
					</div>
					<div class="form-row mt-4">
						<div class="form-group col-md-2">
							{get_captcha var="captcha_code"}
							<div class="secret_number">{$captcha_code[0]|escape} + ? =  {$captcha_code[1]|escape}</div> 
						</div>
						<div class="form-group col-md-10">
							<input class="form-control" type="text" name="captcha_code" placeholder="Введите капчу" required="" autocomplete="off" value="" data-format=".+" data-notice="Введите капчу"/>
							<div class="invalid-feedback">Введите капчу</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2">
							<input class="btn btn-primary" id="btnLogin" type="submit" name="comment" value="Отправить" />
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
{if $prev_product || $next_product}
<!-- Соседние товары /-->
<hr>
<div class="row">
	<div class="col-lg-6 col-sm-6 col-6 text-left">
		{if $prev_product}
		<a href="products/{$prev_product->url}">←&nbsp;{$prev_product->name|escape}</a>
		{/if}
	</div>
	<div class="col-lg-6 col-sm-6 col-6 text-right">
		{if $next_product}
		<a href="products/{$next_product->url}">{$next_product->name|escape}&nbsp;→</a>
		{/if}
	</div>
</div>
<hr>
{/if}
{* Связанные товары *}
{if $related_products}
<h2 class="my-4">Так же советуем посмотреть</h2>
<hr>
<div class="row">
    {foreach $related_products as $product}
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
						<input type="submit" type="submit" data-result-text="В корзине"  class="btn btn-primary" value="Купить" title="Купить" />	
						<div class="btn-group" role="group" aria-label="First group">
							{if $wishlist}
							<a class="btn btn-light"  href='wishlist/remove/{$product->url}'><i class="fa fa-heart text-danger"></i></a>
							{elseif $wishlist_products && in_array($product->url, $wishlist_products)}
							<a class="btn btn-light"  href='wishlist'><i class="fa fa-heart text-danger"></i></a>
							{else}
							<a class="btn btn-light wishlist" href='wishlist/{$product->url}'><i class="fa fa-heart text-secondary"></i></a>
							{/if}
							{if $smarty.session.compared_products && in_array($product->url, $smarty.session.compared_products)}
							<a class="btn btn-light" href='compare'><i class="fa fa-chart-bar text-primary"></i></a>
							{else}
							<a class="btn btn-light compare" href='compare/{$product->url}'><i class="fa fa-chart-bar text-secondary"></i></a>
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