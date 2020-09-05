{* Список товаров *}

{* Канонический адрес страницы *}
{if $category && $brand}
	{$canonical="/catalog/{$category->url}/{$brand->url}" scope=parent}
{elseif $category}
	{$canonical="/catalog/{$category->url}" scope=parent}
{elseif $brand}
	{$canonical="/brands/{$brand->url}" scope=parent}
{elseif $keyword}
	{$canonical="/products?keyword={$keyword|escape}" scope=parent}
{else}
	{$canonical="/products" scope=parent}
{/if}

<!-- Хлебные крошки /-->
{$level = 1}
<nav class="mt-4" aria-label="breadcrumb">
    <ol itemscope itemtype="https://schema.org/BreadcrumbList" class="breadcrumb bg-light">
		<li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem" class="breadcrumb-item">
			<a itemprop="item" href="/"><span itemprop="name">Главная</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
        {if $category}
        {foreach $category->path as $cat}
        <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem" class="breadcrumb-item">
			<a itemprop="item" href="catalog/{$cat->url}"><span itemprop="name">{$cat->name|escape}</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
        {/foreach}  
        {if $brand}
        <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem" class="breadcrumb-item">
		<a itemprop="item" href="catalog/{$cat->url}/{$brand->url}"><span itemprop="name">{$brand->name|escape}</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
        {/if}
        {elseif $brand}
        <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem" class="breadcrumb-item">
		<a itemprop="item" href="brands/{$brand->url}"><span itemprop="name">{$brand->name|escape}</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
		{elseif $wishlist}
        <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem" class="breadcrumb-item active">
			<a itemprop="item" href="wishlist/"><span itemprop="name">Избранное</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
        {elseif $keyword}
        <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem" class="breadcrumb-item active">
			<a itemprop="item" href="/products?keyword={$keyword|escape}"><span itemprop="name">Поиск</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
        {/if}
	</ol>
</nav>
<!-- Хлебные крошки #End /-->

{* Заголовок страницы *}
{if $keyword}
<h1 class="my-4">Поиск {$keyword|escape}</h1>
{elseif $page}
<h1 class="my-4">{$page->name|escape}</h1>
{else}
<h1 class="my-4">{$category->name|escape} {$brand->name|escape}</h1>
{/if}

{if $products}
{* Фильтр по брендам *}
{if $category->brands}
<div class="my-4">
	<a href="catalog/{$category->url}" class="btn btn-secondary btn-sm mb-1" {if !$brand->id}class="selected"{/if}>Все бренды</a>
	{foreach $category->brands as $b}
	<a data-brand="{$b->id}" class="btn {if $b->id == $brand->id}btn-primary{else}btn-light{/if} btn-sm mb-1" href="catalog/{$category->url}/{$b->url}">{$b->name|escape}</a>
	{/foreach}
</div>
{/if}   
<div class="btn-toolbar justify-content-between mb-4" role="toolbar" aria-label="Toolbar with button groups">
    <a class="btn btn-light dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        Сортировать по:
	</a>
    <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
        <a class="dropdown-item {if $sort=='position'}active{/if}" href="{url sort=position page=null}">Умолчанию</a>
        <a class="dropdown-item {if $sort=='name_asc'}active{/if}" href="{url sort=name_asc page=null}">По имени от А до Я</a>
		<a class="dropdown-item {if $sort=='name_desc'}active{/if}" href="{url sort=name_desc page=null}">По имени от Я до А</a>
        <a class="dropdown-item {if $sort=='price_asc'}active{/if}" href="{url sort=price_asc page=null}">От дешевых к дорогим</a>
		<a class="dropdown-item {if $sort=='price_desc'}active{/if}" href="{url sort=price_desc page=null}">От дорогих к дешевым</a>
		<a class="dropdown-item {if $sort=='rating'}active{/if}" href="{url sort=rating page=null}">По рейтингу</a>
	</div>
    <div class="btn-group" role="group" aria-label="First group">
        <button onclick="document.cookie='view=grid;path=/';document.location.reload();" type="button" class="btn btn-light {if !$smarty.cookies.view || $smarty.cookies.view == 'grid'}active{/if}"><i class="fa fa-th"></i></button>
        <button onclick="document.cookie='view=list;path=/';document.location.reload();" type="button" class="btn btn-light {if $smarty.cookies.view == 'list'}active{/if}"><i class="fa fa-th-list"></i></button>
	</div>
</div>
<div class="row">
    {if $smarty.cookies.view == 'list'}
    <main class="col-md-12">
		{include file='list.tpl'} 
		{include file='pagination.tpl'}
	</main>
    {else} 
    {include file='grid.tpl'}
    <main class="col-md-12">
		{include file='pagination.tpl'}
	</main>
    {/if}
</div>
{else}
<div class="alert alert-warning mt-4" role="alert">
    Товары не найдены
</div>
{/if}

{* Описание страницы (если задана) *}
{$page->body}

{if $current_page_num==1}
{* Описание категории *}
{$category->description}
{/if}

{if $current_page_num==1}
{* Описание бренда *}
{$brand->description}
{/if}