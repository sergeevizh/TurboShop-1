<!DOCTYPE html>
{*
Общий вид страницы
Этот шаблон отвечает за общий вид страниц без центрального блока.
*}
<html lang="ru">
<head>
	<base href="{$config->root_url}/"/>
	<title>{$meta_title|escape}</title>
	
	{* Метатеги *}
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="{$meta_description|escape}" />
	<meta name="keywords" content="{$meta_keywords|escape}" />
	<meta name="author" content="Turbo CMS">
	<meta name="generator" content="Turbo CMS">
	
	{if $module=='ProductView'}
	<meta property="og:url" content="{$config->root_url}{$canonical}">
	<meta property="og:type" content="website">
	<meta property="og:title" content="{$product->name|escape}">
	<meta property="og:description" content='{$product->annotation|strip_tags|escape}'>
	<meta property="og:image" content="{$product->image->filename|resize:330:300}">
	<link rel="image_src" href="{$product->image->filename|resize:330:300}">
	{*twitter*}
	<meta name="twitter:card" content="product"/>
	<meta name="twitter:url" content="{$config->root_url}{$canonical}">
	<meta name="twitter:site" content="{$settings->site_name|escape}">
	<meta name="twitter:title" content="{$product->name|escape}">
	<meta name="twitter:description" content="{$product->annotation|strip_tags|escape}">
	<meta name="twitter:image" content="{$product->image->filename|resize:330:300}">
	<meta name="twitter:label1" content="{$product->variant->price|convert:null:false} {$currency->code|escape}">
	<meta name="twitter:label2" content="{$settings->site_name|escape}">
	{elseif $module=='BlogView'}
	<meta property="og:url" content="{$config->root_url}{$canonical}">
	<meta property="og:type" content="article">
	<meta property="og:title" content="{$post->name|escape}">
	{if $post->image}
	<meta property="og:image" content="{$post->image|resize_posts:400:300}">
	<link rel="image_src" href="{$post->image|resize_posts:400:300}">
	{else}
	<meta property="og:image" content="{$config->root_url}/design/{$settings->theme|escape}/images/logo.png">
	<meta name="twitter:image" content="{$config->root_url}/design/{$settings->theme|escape}/images/logo.png">
	{/if}
	<meta property="og:description" content='{$post->annotation|strip_tags|escape}'>
	{*twitter*}
	<meta name="twitter:card" content="summary">
	<meta name="twitter:title" content="{$post->name|escape}">
	<meta name="twitter:description" content="{$post->annotation|strip_tags|escape}">
	<meta name="twitter:image" content="{$post->image|resize_posts:400:300}">
	{else}
	<meta property="og:title" content="{$settings->site_name|escape}">
	<meta property="og:type" content="website">
	<meta property="og:url" content="{$config->root_url}">
	<meta property="og:image" content="{$config->root_url}/design/{$settings->theme|escape}/images/logo.png">
	<meta property="og:site_name" content="{$settings->site_name|escape}">
	<meta property="og:description" content="{$meta_description|escape}">
	<link rel="image_src" href="{$config->root_url}/design/{$settings->theme|escape}/images/logo.png">
	{*twitter*}
	<meta name="twitter:card" content="summary">
	<meta name="twitter:title" content="{$settings->site_name|escape}">
	<meta name="twitter:description" content="{$meta_description|escape}">
	<meta name="twitter:image" content="{$config->root_url}/design/{$settings->theme|escape}/images/logo.png">
	{/if}
	
	{* Канонический адрес страницы *}
	{if isset($canonical)}<link rel="canonical" href="{$config->root_url}{$canonical}"/>{/if}
	
	{* Стили *}
	<!-- Bootstrap core CSS -->
	<link href="design/{$settings->theme|escape}/css/bootstrap.min.css" rel="stylesheet">
	<!-- Fancybox -->
	<link rel="stylesheet" href="design/{$settings->theme}/css/jquery.fancybox.min.css" />
	<!-- Custom styles for this template -->
	<link href="design/{$settings->theme|escape}/css/style.css" rel="stylesheet">
	{if $module=='CartView' || $module=='OrderView' }
	<link href="design/{$settings->theme|escape}/css/cart.css" rel="stylesheet">
	{/if}
	<!-- Custom styles for this template -->
	<link href="design/{$settings->theme|escape}/css/fontawesome-all.min.css" rel="stylesheet">
	<link href="design/{$settings->theme|escape}/images/favicon.ico" rel="icon" type="image/x-icon"/>
	<link href="design/{$settings->theme|escape}/images/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
	<!-- Custom styles for this template -->
</head>
<body itemscope itemtype="https://schema.org/WebPage">
	<!-- Navigation -->
	<nav itemscope itemtype="https://schema.org/SiteNavigationElement" class="navbar navbar-expand-lg navbar-dark bg-dark rounded fixed-top">
		<div class="container">
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample09" aria-controls="navbarsExample09" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarsExample09">
				<a class="navbar-brand" href="/"><i class="fa fa-home"></i></a>
				<ul class="navbar-nav mr-auto">
					{foreach $pages as $p}
					{if $p->menu_id == 1}
					{if $p->visible}
					{if $p->subpages}
					<li itemprop="name" class="nav-item dropdown {if $page && $page->id == $p->id}active{/if}">
						<a itemprop="url" class="nav-link dropdown-toggle" href="{$p->url}" id="dropdown{$p->id}" data-page="{$p->id}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">{$p->header}</a>
						<div class="dropdown-menu" aria-labelledby="dropdown{$p->id}">
							{foreach $p->subpages as $p2}
							<a itemprop="url" data-page="{$p2->id}" class="dropdown-item" href="{$p2->url}">{$p2->header}</a>
							{/foreach}
						</div>
					</li>
					{else}
					<li itemprop="name" class="nav-item {if $page && $page->id == $p->id}active{/if}">
						<a itemprop="url" data-page="{$p->id}" class="nav-link" href="{$p->url}">{$p->header}</a>
					</li>
					{/if}
					{/if}
					{/if}
					{/foreach}
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="nav-link">
						<span id="wishlist_informer">
							{include file='wishlist_informer.tpl'}
						</span>
					</li>
					<li class="nav-link">
						<span id="compare_informer">
							{include file='compare_informer.tpl'}
						</span>
					</li>
					{if $user}
					<li class="nav-link"><i class="fa fa-user"></i> <a class="text-white card-link" href="user">{$user->name}</a></li>
					<li class="nav-link"><i class="fa fa-sign-in-alt"></i> <a class="text-white card-link" href="user/logout">Выйти</a></li>
					{else}
					<li class="nav-link"><i class="fa fa-sign-in-alt"></i> <a class="text-white card-link" href="user/login"> Вход</a></li>
					<li class="nav-link"><i class="fa fa-user-plus"></i> <a class="text-white card-link" href="user/register">Регистрация</a></li>
					{/if}
				</ul>
			</div>
			<!-- Корзина -->
			<div id="cart_informer">
				{* Обновляемая аяксом корзина должна быть в отдельном файле *}
				{include file='cart_informer.tpl'}
			</div>
			<!-- Корзина (The End)-->
		</div> 
	</nav>
	<div class="container">
		<div class="row">
			<div class="col-lg-6 mt-2">
				<h1 class="mt-4"><a class="text-white card-link" href="/">Turbo Shop</a></h1>
			</div>
			<div class="col-lg-6 mt-4">
				<p class="text-right">(123) 456-7890</br>
					Мой город, ул. Фруктовая 47, офис 217
					<div class="callback float-right">
						<a class="btn btn-success btn-sm" href="javascript:void(0)" data-toggle="modal" data-target="#exampleModal" role="button"><i class="fa fa-phone"></i>  <span>Заказать звонок</span></a>
					</div>
				</p>
			</div>
		</div>
	</div>
	<!-- Page Content -->
	<div class="container">
		<div class="row">
			<div class="mobile-offcanvas col-lg-3" id="sidebar" style="background-color: #222;">
				<div class="offcanvas-header my-4">  
					<button class="btn btn-danger btn-close float-right"> &times Закрыть </button>
					<h5 class="py-2">Каталог</h5>
				</div>
				<!-- Поиск-->
				<form class="input-group my-4" action="products">
					<input class="input_search form-control" type="text" name="keyword" value="{$keyword|escape}" placeholder="Поиск товара..." aria-label="Recipient's username" aria-describedby="basic-addon2"/>
					<div class="input-group-append">
						<button class="btn btn-secondary" type="submit"><i class="fa fa-search"></i></button>
					</div>    
				</form>
				<!-- Поиск (The End)-->
				{if $categories}
				<div class="list-group">
					{foreach $categories as $c}
					{if $c->visible}
					<span class="hidden-sm-down list-group-item {if $category->id == $c->id}bg-primary{/if}">
						<a data-category="{$c->id}" href="catalog/{$c->url}">
							{$c->name|escape}
						</a>
						{if $c->subcategories}
						<a data-toggle="collapse" data-parent="#sidebar" href="#menu{$c->id}">
							<i class="fa fa-caret-down"></i>
						</a>
						{/if}
					</span> 
					{if $c->subcategories}
					<div class="collapse cat {if in_array($category->id, $c->children)}show{/if}" id="menu{$c->id}">
						{foreach $c->subcategories as $cat}
						{if $c->visible}
						<span class="hidden-sm-down list-group-item {if $category->id == $cat->id}bg-primary{/if}">
							<a data-category="{$cat->id}" href="catalog/{$cat->url}">
								{$cat->name|escape}
							</a>
							{if $cat->subcategories}
							<a data-toggle="collapse" aria-expanded="false" href="#menusub{$cat->id}">
								<i class="fa fa-caret-down"></i>
							</a>
							{/if}
						</span> 
						{if $cat->subcategories}
						<div class="collapse cat3 {if in_array($category->id, $cat->children)}show{/if}" id="menusub{$cat->id}">
							{foreach $cat->subcategories as $cat3}
							{if $cat3->visible}
							<a href="catalog/{$cat3->url}" class="list-group-item {if $category->id == $cat3->id}bg-primary text-white{/if}" data-category="{$cat3->id}" data-parent="#menusub{$cat->id}">{$cat3->name|escape}</a>
							{/if}
							{/foreach}
						</div>
						{/if}
						{/if}
						{/foreach}
					</div>
					{/if}
					{/if}
					{/foreach}
					<span class="hidden-sm-down list-group-item"><a href="/products">Все товары</a></span>
				</div>
				{/if}
				{if $module!=='ProductsView'}
				<!-- Все бренды -->
				{* Выбираем в переменную $all_brands все бренды *}
				{get_brands var=all_brands}
				{if $all_brands}
				<div id="all_brands">
					<h4 class="my-4">Все Бренды:</h4>
					{foreach $all_brands as $b}	
					<a class="btn btn-secondary btn-sm mb-1" href="brands/{$b->url}">{$b->name}</a>
					{/foreach}
				</div>
				{/if}
				<!-- Все бренды (The End)-->
				{/if}
				{if $module=='ProductsView'}
				{include file='filter.tpl'}
				{/if}
				<!-- Выбор валюты -->
				{* Выбор валюты только если их больше одной *}
				{if $currencies|count>1}
				<div class="mt-4" id="currencies">
					<h4 class="mt-4">Валюта</h4>
					{foreach $currencies as $c}
					{if $c->enabled} 
					<a class="badge {if $c->id==$currency->id}badge-success{else}badge-secondary{/if}" href='{url currency_id=$c->id}'>{$c->name|escape}</a>
					{/if}
					{/foreach}
				</div> 
				{/if}
				<!-- Выбор валюты (The End) -->	
			</div>
			<div class="col-lg-9 order-lg-2 order-1">
				<nav class="navbar navbar-expand-lg navbar-dark bg-primary d-lg-none mt-4 rounded">
					<a class="navbar-brand" href="#">Каталог</a>
					<button class="navbar-toggler" type="button" data-trigger="#sidebar">
						<span class="navbar-toggler-icon"></span>
					</button>
				</nav>
				{if !$is_mobile}
				{* Слайдер *}
				{include file='slider.tpl'}
				{/if}
				{$content}
			</div>
			<!-- /.col-lg-9 -->
		</div>
		<!-- /.row -->
	</div>
	<!-- /.container -->
	<div class="container mt-5">
		{*  Просмотренные товары *}
		{get_browsed_products var=browsed_products limit=8}
		{if $browsed_products}
		<h2 class="my-2">Просмотренные товары</h2>
		<hr>
		<div class="row">
			{foreach $browsed_products as $product}
			<div class="col-lg-3 col-md-6 mb-4">
				<div class="card card-product product">
					<!-- Фото товара -->
					<span class="quickview">
						<span class="icons">
						{if strtotime($product->created) >= strtotime('-1 months')}<span class="notify-badge badge badge-warning">Новинка</span>{/if}
						{if $product->variant->compare_price > 0}<span class="notify-badge badge badge-danger">Акция</span>{/if}
						{if $product->featured}<span class="notify-badge badge btn-secondary">Хит</span>{/if}
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
							<h5 class="card-title">{if $product->variant->compare_price > 0}<del class="price-old"><small><span class="compare_price">{$product->variants[0]->compare_price|convert}</span>{$currency->sign|escape}</small></del>{/if}  <span class="prices">{$product->variants[0]->price|convert}</span> <span class="currency">{$currency->sign|escape}</span></h5>
							<span class="btn-toolbar justify-content-between">
								<input type="submit" type="submit" data-result-text="В корзине"  class="btn btn-primary" value="Купить" title="Купить" />	
								<div class="btn-group" role="group" aria-label="First group">
                                    {if $wishlist_products && in_array($product->url, $wishlist_products)}
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
		<!-- /.row -->
		{/if}
		{if $module=='MainView'}
		{get_posts var=last_posts limit=5}
		{if $last_posts}
		<h2 class="my-2">Блог</h2>
		<hr>
		<div class="row">
			{foreach $last_posts as $post}
			<div class="col-md-4 mb-5">
				<div class="card h-100">
					<img class="card-img-top" src="{$post->image|resize_posts:750:300}" alt="{$post->name|escape}">
					<div class="card-body">
						<h5 class="card-title"><a data-post="{$post->id}" href="blog/{$post->url}">{$post->name|escape}</a></h5>
						<p class="card-text"><small class="text-muted">{$post->date|date}</small></p>
						<p class="card-text">{$post->annotation|strip_tags|truncate:150}</p>
					</div>
					<div class="card-footer">
						<a href="blog/{$post->url}" class="btn btn-primary btn-sm">Подробнее</a>
					</div>
				</div>
			</div>
			<!-- /.col-md-4 -->
			{/foreach}
		</div>
		{/if}
		{/if}
	</div>
	<!-- Подписаться на новости-->
	<div class="container-fluid bg-dark">
		<div class="row">
			<div class="col-md-6 offset-md-3">  
				<form class="form-group mt-5" id="loginForm" novalidate="" method="POST">
					{if $subscribe_error}
					<label class="error text-danger">
						{if $subscribe_error == 'email_exist'}
						Вы уже подписаны
						{/if}
						{if $subscribe_error == 'empty_email'}
						Введите email
						{/if}
					</label>
					{/if}
					{if $subscribe_success}
					<label class="success text-success">
						Вы были успешно подписаны
					</label>
					{/if}
					<div class="input-group mb-2">
						<input type="email" name="subscribe_email"  class="form-control {if $subscribe_error}border-danger{/if} {if $subscribe_success}border-success{/if}" required size="20" value="" placeholder="Оставьте свой e-mail">
						<div class="input-group-append">
							<button type="submit" name="subscribe" value="Подписаться" id="btnLogin" class="btn btn-secondary"><i class="fa fa-envelope"></i></button>
						</div>    
					</div>  
				</form>
			</div>
		</div>
	</div>
	<!-- Подписаться на новости (The End)-->
	<a href="#" id="back-to-top" class="btn-secondary" title="Back to top"><i class="fa fa-angle-double-up"></i></a>
	<!-- Footer -->
	<footer itemscope itemtype="https://schema.org/WPFooter" class="page-footer font-small bg-dark text-white pt-4">
		<hr>
		<!-- Footer Links -->
		<div class="container text-center text-md-left">
			<!-- Footer links -->
			<div class="row text-center text-md-left mt-3 pb-3">
				<!-- Grid column -->
				<div class="col-md-3 col-lg-3 col-xl-3 mx-auto mt-3">
					<h6 class="text-uppercase mb-4 font-weight-bold">{$settings->company_name|escape}</h6>
					<p>Этот магазин является демонстрацией скрипта интернет-магазина Turbo CMS. Все материалы на этом сайте присутствуют исключительно в демострационных целях.</p>
				</div>
				<!-- Grid column -->
				<hr class="w-100 clearfix d-md-none">
				<!-- Grid column -->
				<div class="col-md-2 col-lg-2 col-xl-2 mx-auto mt-3">
					<h6 class="text-uppercase mb-4 font-weight-bold">О магазине</h6>
					{foreach $pages as $p}
					{* Выводим только страницы из первого меню *}
					{if $p->menu_id == 1}
					<p {if $page && $page->id == $p->id}class="selected"{/if}>
						<a data-page="{$p->id}" href="{$p->url}">{$p->header|escape}</a>
					</p>
					{/if}
					{/foreach}
				</div>
				<!-- Grid column -->
				<hr class="w-100 clearfix d-md-none">
				<!-- Grid column -->
				<div class="col-md-3 col-lg-2 col-xl-2 mx-auto mt-3">
					<h6 class="text-uppercase mb-4 font-weight-bold">Информация</h6>
					{foreach $pages as $p}
					{* Выводим только страницы из первого меню *}
					{if $p->menu_id == 3}
					<p {if $page && $page->id == $p->id}class="selected"{/if}>
						<a data-page="{$p->id}" href="{$p->url}">{$p->header|escape}</a>
					</p>
					{/if}
					{/foreach}
				</div>
				<!-- Grid column -->
				<hr class="w-100 clearfix d-md-none">
				<!-- Grid column -->
				<div class="col-md-4 col-lg-3 col-xl-3 mx-auto mt-3">
					<h6 class="text-uppercase mb-4 font-weight-bold">Контакты</h6>
					<p>
					<i class="fas fa-home mr-3"></i>г. Мой город, ул. Фруктовая 47, офис 217</p>
					<p>
					<i class="fas fa-envelope mr-3"></i> info@gmail.com</p>
					<p>
					<i class="fas fa-phone mr-3"></i> (123) 456-7890</p>
					<p>
					<i class="fas fa-print mr-3"></i> (123) 456-7890</p>
				</div>
				<!-- Grid column -->
			</div>
			<!-- Footer links -->
			<hr>
			<!-- Grid row -->
			<div class="row d-flex align-items-center">
				<!-- Grid column -->
				<div class="col-md-7 col-lg-8">
					<!--Copyright-->
					<p class="text-center text-md-left">© <span itemprop="copyrightYear">{$smarty.now|date_format:"%Y"}</span>
						<a href="https://turbo-cms.com">
							<strong>Turbo CMS</strong>
						</a>
					</p>
				</div>
				<!-- Grid column -->
				<!-- Grid column -->
				<div class="col-md-5 col-lg-4 ml-lg-0">
					<!-- Social buttons -->
					<div class="text-center text-md-right">
						<ul class="list-unstyled list-inline">
							<li class="list-inline-item">
								<a href="#" class="btn-floating btn-sm rgba-white-slight mx-1">
									<i class="fab fa-facebook-f"></i>
								</a>
							</li>
							<li class="list-inline-item">
								<a href="#" class="btn-floating btn-sm rgba-white-slight mx-1">
									<i class="fab fa-twitter"></i>
								</a>
							</li>
							<li class="list-inline-item">
								<a href="#" class="btn-floating btn-sm rgba-white-slight mx-1">
									<i class="fab fa-google-plus-g"></i>
								</a>
							</li>
							<li class="list-inline-item">
								<a href="#" class="btn-floating btn-sm rgba-white-slight mx-1">
									<i class="fab fa-linkedin-in"></i>
								</a>
							</li>
						</ul>
					</div>
				</div>
				<!-- Grid column -->
			</div>
			<!-- Grid row -->
		</div>
		<!-- Footer Links -->
	</footer>
	<!-- Footer -->
	
	<!-- Jquery -->
	<script src="design/{$settings->theme}/js/jquery.min.js"></script>
	{* Всплывающие подсказки для администратора *}
	{if $smarty.session.admin == 'admin'}
	<script src ="js/admintooltip/admintooltip.js" type="text/javascript"></script>
	<link   href="js/admintooltip/css/admintooltip.css" rel="stylesheet" type="text/css" /> 
	{/if}
	<!-- Bootstrap core JavaScript -->
	<script src="design/{$settings->theme}/js/bootstrap.bundle.min.js"></script>
	<!-- Fancybox -->
	<script src="design/{$settings->theme}/js/jquery.fancybox.min.js"></script>
	{if $module=='ProductView'}
	{* Рейтинг *}
	<script src="js/jquery.rater.js" type="text/javascript"></script>
	{/if}
	{if $module=='ProductsView'}
	<!-- Price slider -->
	<link rel="stylesheet" href="design/{$settings->theme}/js/ion.rangeSlider/ion.rangeSlider.css" />
	<link rel="stylesheet" href="design/{$settings->theme}/js/ion.rangeSlider/ion.rangeSlider.skinHTML5.css" />
	<!-- Price slider -->
	<script src="design/{$settings->theme}/js/ion.rangeSlider/ion.rangeSlider.min.js"></script>
	<script src="design/{$settings->theme|escape}/js/customs.js"></script>
	{/if}
	{* Ctrl-навигация на соседние товары *}
	<script type="text/javascript" src="js/ctrlnavigate.js"></script>    
	{* Аяксовая корзина *}
	<script src="design/{$settings->theme}/js/jquery-ui.min.js"></script>
	<script src="design/{$settings->theme}/js/ajax_cart.js"></script>
	{* js-проверка форм *}
	<script src="js/baloon/js/baloon.js" type="text/javascript"></script>
	<link   href="js/baloon/css/baloon.css" rel="stylesheet" type="text/css" /> 
	{* Автозаполнитель поиска *}
	{literal}
	<script src="js/autocomplete/jquery.autocomplete-min.js" type="text/javascript"></script>
	<style>
		.autocomplete-suggestions{
		background-color: #ffffff;
		color: #444;
		overflow: hidden;
		border: 1px solid #e0e0e0;
		overflow-y: auto;
		}
		.autocomplete-suggestions .autocomplete-suggestion{cursor: default;}
		.autocomplete-suggestions .selected { background:#F0F0F0; }
		.autocomplete-suggestions div { padding:2px 5px; white-space:nowrap; }
		.autocomplete-suggestions strong { font-weight:normal; color:#3399FF; }
	</style>	
	<script>
		$(function() {
			//  Автозаполнитель поиска
			$(".input_search").autocomplete({
				serviceUrl:'ajax/search_products.php',
				minChars:1,
				noCache: false, 
				onSelect:
				function(suggestion){
					$(".input_search").closest('form').submit();
				},
				formatResult:
				function(suggestion, currentValue){
					var reEscape = new RegExp('(\\' + ['/', '.', '*', '+', '?', '|', '(', ')', '[', ']', '{', '}', '\\'].join('|\\') + ')', 'g');
					var pattern = '(' + currentValue.replace(reEscape, '\\$1') + ')';
					return (suggestion.data.image?"<img align=absmiddle src='"+suggestion.data.image+"'> ":'') + suggestion.value.replace(new RegExp(pattern, 'gi'), '<strong>$1<\/strong>');
				}	
			});
		});
	</script>
	<script>
		$(function() {
			if ($('#back-to-top').length) {
				var scrollTrigger = 100, // px
				backToTop = function () {
					var scrollTop = $(window).scrollTop();
					if (scrollTop > scrollTrigger) {
						$('#back-to-top').addClass('show');
						} else {
						$('#back-to-top').removeClass('show');
					}
				};
				backToTop();
				$(window).on('scroll', function () {
					backToTop();
				});
				$('#back-to-top').on('click', function (e) {
					e.preventDefault();
					$('html,body').animate({
						scrollTop: 0
					}, 700);
				});
			}
		});
	</script>
	{/literal}
	<script>
		$("#btnLogin").click(function(event) {
			var form = $("#loginForm");
			if (form[0].checkValidity() === false) {
				event.preventDefault();
				event.stopPropagation();
			}
			form.addClass('was-validated');
		});
	</script>
	<!-- Modal -->
	<div class="modal fade bd-example-modal-sm" id="exampleModal"  tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Заказать звонок</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form class="form feedback_form" method="post">
					<div class="modal-body">
						{if $call_sent}
						<div id="elasto_callback_s1_alert" class="alert alert-success" style="display: block;">
							Сообщение отправлено
						</div>
						{/if}
						<span class="modal-caption">Оставьте свой номер телефона</span>
						<div class="form-group has-feedback">									
							<div class="input-group">
								<div class="input-group-prepend">
									<div class="input-group-text text-white"><i class="fv-icon-no-has fa fa-user"></i></div>
								</div>
								<input type="text" name="name" value="{$comment_name}" data-format=".+" data-notice="Введите имя" required id="nickname_field" value="" class="form-control" placeholder="Имя" style=""/>
							</div>
						</div>							
						<div class="form-group has-feedback">									
							<div class="input-group">
								<div class="input-group-prepend"> 
									<div class="input-group-text text-white"><i class="fv-icon-no-has fa fa-phone"></i></div>
								</div>
								<input data-format=".+" data-notice="Введите номер телефона" required value="" name="phone" maxlength="255" type="text" class="form-control" placeholder="Телефон"/>
							</div>
						</div>							
					</div>					
					<div class="modal-footer">
						<input class="btn btn-primary mx-auto" type="submit" name="callback" value="Отправить сообщение" />
					</div>
				</form>
			</div>
		</div>
	</div>
	{if $module=='ProductView'}
	<div class="modal fade bd-example-modal-sm" id="fast_order"  tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Купить в один клик</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form class="form feedback_form" method="post">
					<input id="fast-order-product-id" class="fast-order-inputarea" value="" name="variant_id" type="hidden"/>
					<input type="hidden" name="IsFastOrder" value="true">
					<div class="modal-body">
						{if $call_sent}
						<div id="elasto_callback_s1_alert" class="alert alert-success" style="display: block;">
							Сообщение отправлено
						</div>
						{/if}
						<p id="fast-order-product-name" class="modal-caption"></p>
						<div class="form-group has-feedback">									
							<div class="input-group">
								<div class="input-group-prepend">
									<div class="input-group-text text-white"><i class="fv-icon-no-has fa fa-user"></i></div>
								</div>
								<input type="text" name="name" value="{$comment_name}" data-format=".+" data-notice="Введите имя" required id="nickname_field" value="" class="form-control" placeholder="Имя" style=""/>
							</div>
						</div>							
						<div class="form-group has-feedback">									
							<div class="input-group">
								<div class="input-group-prepend"> 
									<div class="input-group-text text-white"><i class="fv-icon-no-has fa fa-phone"></i></div>
								</div>
								<input data-format=".+" data-notice="Введите номер телефона" required value="" name="phone" maxlength="255" type="text" class="form-control" placeholder="Телефон"/>
							</div>
						</div>							
					</div>					
					<div class="modal-footer">
						<input class="btn btn-success mx-auto" type="submit" name="checkout" value="Отправить" />
					</div>
				</form>
			</div>
		</div>
	</div>
	{/if}
	<div class="modal fade bd-example-modal-sm" id="rate" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content bg-success text-white">
				<div class="modal-body">
					Спасибо! Ваш голос учтен.
					<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade bd-example-modal-sm" id="subscribe" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content {if $subscribe_error}bg-danger{/if}{if $subscribe_success}bg-success{/if} text-white">
				<div class="modal-body">
					{if $subscribe_error}
						{if $subscribe_error == 'email_exist'}
							Вы уже подписаны
						{/if}
						{if $subscribe_error == 'empty_email'}
							Введите email
						{/if}
					{/if}
					{if $subscribe_success}
						Вы были успешно подписаны
					{/if}
					<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="rate_danger" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content text-white bg-danger">
				<div class="modal-body">
					Вы уже голосовали за данный товар!
					<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
			</div>
		</div>
	</div>
	{if $call_sent}
	<script type='text/javascript'>		
		$( window ).on("load", function() {
			$('#exampleModal').modal('show');
		});	
	</script>
	{/if}
	{if $subscribe_success || $subscribe_error}
	<script type='text/javascript'>		
		$( window ).on("load", function() {
			$('#subscribe').modal('show');
		});	
	</script>
	{/if}
	{literal}
	<script type="text/javascript">
		$(function() {
			$('.quickview').each(function(k,v)
			{
				$('<div class="quick_view"><a id="a_quick_view" rel="group" href="'+$(this).find('a').attr('href')+'"><i class="far fa-eye fa-lg"></i></a></div>').appendTo($(this).find('.quick'));
			});
			$(".quickview").hover(
			function() {
				$(this).find(".quick_view").show();
				}, function() {
				$(this).find(".quick_view").hide();
			}
			);
			$("a#a_quick_view").fancybox({
				type: 'ajax'
			});
		});
	</script>
	{/literal}
	<script type="text/javascript">
		/// some script

		// jquery ready start
		$(document).ready(function() {
			// jQuery code

			$("[data-trigger]").on("click", function(e){
				e.preventDefault();
				e.stopPropagation();
				var offcanvas_id =  $(this).attr('data-trigger');
				$(offcanvas_id).toggleClass("show");
				$('body').toggleClass("offcanvas-active");
				$(".screen-overlay").toggleClass("show");
			}); 

			// Close menu when pressing ESC
			$(document).on('keydown', function(event) {
				if(event.keyCode === 27) {
				   $(".mobile-offcanvas").removeClass("show");
				   $("body").removeClass("overlay-active");
				}
			});

			$(".btn-close, .screen-overlay").click(function(e){
				$(".screen-overlay").removeClass("show");
				$(".mobile-offcanvas").removeClass("show");
				$("body").removeClass("offcanvas-active");


			}); 
			
		}); // jquery end
	</script>
</body>
</html>