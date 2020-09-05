{* Страница с формой обратной связи *}

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

<!-- Заголовок страницы -->
<h1 data-page="{$page->id}" class="mt-4">{$page->name|escape}</h1>

{$page->body}

<h2>Обратная связь</h2>
{if $message_sent}
<div class="alert alert-success" role="alert">
	{$name|escape}, ваше сообщение отправлено.
</div>	
{else}
{if $error}
	<div class="alert alert-danger" role="alert">
		{if $error=='captcha'}
			Неверно введена капча
		{elseif $error=='empty_name'}
			Введите имя
		{elseif $error=='empty_email'}
			Введите email
		{elseif $error=='empty_text'}
			Введите сообщение
		{/if}
	</div>
{/if}
<form class="form-horizontal mt-4" role="form" id="loginForm" method="post">
	<div class="form-group">
		<label for="feedback_name">Имя</label>
		<input class="form-control" type="text" id="feedback_name" name="name" placeholder="Введите имя" required="" value="{$name|escape}" data-format=".+" data-notice="Введите имя"/>
		<div class="invalid-feedback">Введите имя</div>
	</div>
	<div class="form-group">
		<label for="feedback_email">Email</label>
		<input type="email" class="form-control" id="feedback_email" placeholder="Введите email" value="{$email|escape}" name="email" maxlength="255" required="" data-format="email" data-notice="Введите email">
		<div class="invalid-feedback">Введите email</div>
	</div>
	<div class="form-group">
		<label for="feedback_message">Сообщение</label>
		<textarea class="form-control" rows="4" id="feedback_message" name="message" placeholder="Введите сообщение" required="" data-format=".+" data-notice="Введите сообщение">{$message|escape}</textarea>
		<div class="invalid-feedback">Введите сообщение</div>
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
			<input class="btn btn-primary" type="submit" id="btnLogin" name="feedback" value="Отправить" />
		</div>
	</div>
</form>
{/if}