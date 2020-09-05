{* Список избранное *}

{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}

<!-- Хлебные крошки /-->
{$level = 1}
<nav class="mt-4" aria-label="breadcrumb">
    <ol itemscope itemtype="http://schema.org/BreadcrumbList" class="breadcrumb">
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

{* Заголовок страницы *}
<h1 class="my-4">{$page->name|escape}</h1>

{if $products}  
<div class="btn-toolbar justify-content-between mb-4" role="toolbar" aria-label="Toolbar with button groups">
    <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        Сортировать по:
	</a>
    <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
        <a class="dropdown-item {if $sort=='position'}active{/if}" href="{url sort=position page=null}">Умолчанию</a>
        <a class="dropdown-item {if $sort=='name'}active{/if}" href="{url sort=name page=null}">Названию</a>
        <a class="dropdown-item {if $sort=='price'}active{/if}" href="{url sort=price page=null}">Цене</a>
	</div>
    <div class="btn-group" role="group" aria-label="First group">
        <button onclick="document.cookie='view=grid;path=/';document.location.reload();" type="button" class="btn btn-secondary {if $smarty.cookies.view == 'grid'}active{/if}"><i class="fa fa-th"></i></button>
        <button onclick="document.cookie='view=list;path=/';document.location.reload();" type="button" class="btn btn-secondary {if $smarty.cookies.view == 'list'}active{/if}"><i class="fa fa-th-list"></i></button>
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
<div class="alert alert-primary mt-4" role="alert">
    Список избраного пуст
</div>
{/if}

{* Описание страницы (если задана) *}
{$page->body}