{* Страница отдельной записи блога *}

{* Канонический адрес страницы *}
{$canonical="/blog/{$post->url}" scope=parent}

<!-- Хлебные крошки /-->
{$level = 1}
<nav class="mt-4" aria-label="breadcrumb">
	<ol itemscope itemtype="https://schema.org/BreadcrumbList" class="breadcrumb">
		<li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem" class="breadcrumb-item">
			<a itemprop="item" href="/"><span itemprop="name">Главная</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
		<li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem" class="breadcrumb-item">
			<a itemprop="item" href="blog"><span itemprop="name">Блог</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
		<li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem" class="breadcrumb-item active" aria-current="page">
		<a itemprop="item" href="/blog/{$post->url}"><span itemprop="name">{$post->name|escape}</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
	</ol>
</nav>
<!-- Хлебные крошки #End /-->

<div itemscope itemtype="http://schema.org/BlogPosting">
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
	<!-- Заголовок страницы -->
	<h1 data-post="{$post->id}" itemprop="headline name" class="mt-4">{$post->name|escape}</h1>
	<hr>
	<!-- Date/Time -->
	<p><time itemprop="datePublished" content="{$post->date}">{$post->date|date}</time></p>
	<hr>
	<!-- Preview Image -->
	<div class="card mb-4">
		<img itemprop="image" class="img-fluid rounded" src="{$post->image|resize_posts:700:300}" alt="{$post->name|escape}">
	</div>
	<hr>
	<!-- Post Content -->
	<article itemprop="articleBody">{$post->text}</article>
</div>
{if $prev_post || $next_post}
<!-- Соседние записи /-->
<hr>
<div class="row">
	<div class="col-lg-6 col-sm-6 col-6 text-left">
		{if $prev_post}
		<a href="blog/{$prev_post->url}">←&nbsp;{$prev_post->name}</a>
		{/if}
	</div>
	<div class="col-lg-6 col-sm-6 col-6 text-right">
		{if $next_post}
		<a href="blog/{$next_post->url}">{$next_post->name}&nbsp;→</a>
		{/if}
	</div>
</div>
<hr>
{/if}
<!-- Comments Form -->
{if $comments}
<!-- Список с комментариями -->
{foreach $comments as $comment}
<a name="comment_{$comment->id}"></a>
<p><span>{$comment->text|escape|nl2br}</span></p>
<small class="text-muted"><b><span>{$comment->name|escape}</span></b> {$comment->date|date} в {$comment->date|time} {if !$comment->approved}ожидает модерации</b>{/if}</small>
<hr>
{/foreach}
<!-- Список с комментариями (The End)-->
{else}
<p>
	Пока нет комментариев
</p>
{/if}
<a class="btn btn-success mb-4" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">Комментировать</a>
<div class="collapse" id="collapseExample">
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
	<form class="form-horizontal mt-4" id="loginForm" role="form" method="post">
		<div class="form-group">
			<label for="comment">Комментарий</label>
			<textarea class="form-control" rows="4" name="text" placeholder="Введите комментарий" data-format=".+" required="" data-notice="Введите комментарий">{$comment_text}</textarea>
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
				<input class="form-control" type="text" name="captcha_code" placeholder="Введите капчу" value="" required="" autocomplete="off" data-format=".+" data-notice="Введите капчу"/>
				<div class="invalid-feedback">Введите капчу</div>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2">
				<input class="btn btn-primary" type="submit" id="btnLogin" name="comment" value="Отправить" />
			</div>
		</div>
	</form>
</div>			