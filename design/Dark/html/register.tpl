{* Страница регистрации *}

{* Канонический адрес страницы *}
{$canonical="/user/register" scope=parent}

{$meta_title = "Регистрация" scope=parent}

<!-- Хлебные крошки /-->
{$level = 1}
<nav class="mt-4" aria-label="breadcrumb">
    <ol itemscope itemtype="http://schema.org/BreadcrumbList" class="breadcrumb">
		<li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem" class="breadcrumb-item">
			<a itemprop="item" href="/"><span itemprop="name">Главная</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
		<li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem" class="breadcrumb-item active" aria-current="page">
			<a itemprop="item" href="/user/register"><span itemprop="name">Регистрация</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
	</ol>
</nav>
<!-- Хлебные крошки #End /-->

<h1 class="my-4">Регистрация</h1>

{if $error}
<div class="alert alert-danger" role="alert">
	{if $error == 'empty_name'}Введите имя
	{elseif $error == 'empty_email'}Введите email
	{elseif $error == 'empty_password'}Введите пароль
	{elseif $error == 'user_exists'}Пользователь с таким email уже зарегистрирован
	{elseif $error == 'captcha'}Неверно введена капча
	{else}{$error}{/if}
</div>
{/if}

<div class="col-md-6 offset-md-3">
	<span class="anchor" id="formLogin"></span>
	<div class="card card-outline-secondary">
		<div class="card-header">
			<h3 class="mb-0">Регистрация</h3>
		</div>
		<div class="card-body">
			<form class="form" role="form" autocomplete="off" id="loginForm" novalidate="" method="POST">
				<div class="form-group">
					<label for="uname1">Имя</label>
					<input type="text" class="form-control" name="name" data-format=".+" data-notice="Введите имя" value="{$name|escape}" maxlength="255" id="uname1" required="">
					<div class="invalid-feedback">Введите имя</div>
				</div>
				<div class="form-group">
					<label for="uname1">Email</label>
					<input type="text" class="form-control" id="uname1" required="" name="email" data-format="email" data-notice="Введите email" value="{$email|escape}" maxlength="255">
					<div class="invalid-feedback">Введите email</div>
				</div>
				<div class="form-group">
					<label>Пароль</label>
					<input type="password" class="form-control" id="pwd1" required="" autocomplete="new-password" name="password" data-format=".+" data-notice="Введите пароль" value="">
					<div class="invalid-feedback">Введите пароль</div>
				</div>
				<div class="row mt-4">
					<div class="col-sm-6 pb-3">
						{get_captcha var="captcha_code"}
						<div class="secret_number">{$captcha_code[0]|escape} + ? =  {$captcha_code[1]|escape}</div>
					</div>
					<div class="col-sm-6 pb-3">
						<input class="form-control" type="text" name="captcha_code" required="" placeholder="Введите капчу" value="" data-format=".+" data-notice="Введите капчу"/>
						<div class="invalid-feedback">Введите капчу</div>
					</div>
				</div>
				<a href="user">Вход</a>
				<input type="submit" class="btn btn-success btn-lg float-right" id="btnLogin" name="register" value="Отправить">
			</form>
		</div>
	</div>
</div>