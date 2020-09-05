{* Шаблон страницы производители *}

{* Канонический адрес страницы *}
{$canonical="/brands" scope=parent}

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

<!-- Заголовок страницы -->
<h1 data-page="{$page->id}" class="my-4">{$page->header|escape}</h1>

{$page->body}

{get_brands var=all_brands}
{if $all_brands}
<div class="row text-center text-lg-left mt-4">
	{foreach $all_brands as $b}
	<div class="col-lg-3 col-md-4 col-xs-4 col-4">
		<a href="brands/{$b->url}" class="d-block mb-4 h-100 text-center">
			{if $b->image}
			<img class="img-fluid img-thumbnail" src="{$config->brands_images_dir}{$b->image}" alt="{$b->name|escape}" title="{$b->name|escape}">
			{else}
			{$b->name}
			{/if}
		</a>
	</div>
	{/foreach}
</div>
{else}
<div class="alert alert-primary" role="alert">
	Производители не найдены
</div>
{/if}