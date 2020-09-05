{* Список записей блога *}

{* Канонический адрес страницы *}
{$canonical="/blog" scope=parent}

<!-- Хлебные крошки /-->
{$level = 1}
<nav class="mt-4" aria-label="breadcrumb">
    <ol itemscope itemtype="http://schema.org/BreadcrumbList" class="breadcrumb bg-light">
		<li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem" class="breadcrumb-item">
			<a itemprop="item" href="/"><span itemprop="name">Главная</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
		<li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem" class="breadcrumb-item active" aria-current="page">
			<a itemprop="item" href="/blog"><span itemprop="name">Блог</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
	</ol>
</nav>
<!-- Хлебные крошки #End /-->

<!-- Заголовок страницы -->
<h1 data-page="{$page->id}" class="my-4">Блог</h1>

{foreach $posts as $post}
<!-- Blog Post -->
<div itemscope itemtype="http://schema.org/Blog" class="card mb-4">
	<article itemprop="blogPosts" itemscope itemtype="http://schema.org/BlogPosting">
		<div itemprop="publisher" itemscope itemtype="https://schema.org/Organization">
		<meta itemprop="name" content="{$settings->site_name|escape}">
		<span itemprop="logo" itemscope itemtype="https://schema.org/ImageObject">
			<meta itemprop="image url" content="{$config->root_url}/design/{$settings->theme|escape}/images/logo.png" />
			<meta property="url" content="{$config->root_url}/" />
		</span>
		</div>
		<meta itemprop="dateModified" content="{$post->date}">
		<meta itemprop="author" content="{$settings->site_name|escape}">
		<meta itemscope itemprop="mainEntityOfPage" itemType="https://schema.org/WebPage" itemid="/blog/{$post->url}"/>
		<link itemprop="url" href="/blog/{$post->url}" />
		{if $post->image}<img itemprop="image" class="card-img-top" src="{$post->image|resize_posts:750:300}" alt="{$post->name|escape}">{/if}
		<div class="card-body">
			<h2 data-post="{$post->id}" class="card-title" itemprop="name headline">{$post->name|escape}</h2>
			<p itemprop="description" class="card-text">{$post->annotation}</p>
			<a href="blog/{$post->url}" class="btn btn-primary">Далее →</a>
		</div>
		<div class="card-footer text-muted">
			<time itemprop="datePublished" content="{$post->date}">{$post->date|date}</time>
		</div>
	</article>
</div>
{/foreach}

<!-- Pagination -->
{include file='pagination.tpl'}