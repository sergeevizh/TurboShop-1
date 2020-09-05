{* Страница входа пользователя *}

{* Канонический адрес страницы *}
{$canonical="/user/login" scope=parent}

{$meta_title = "Вход" scope=parent}

<!-- Хлебные крошки /-->
{$level = 1}
<nav class="mt-4" aria-label="breadcrumb">
    <ol itemscope itemtype="http://schema.org/BreadcrumbList" class="breadcrumb">
		<li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem" class="breadcrumb-item">
			<a itemprop="item" href="/"><span itemprop="name">Главная</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
		<li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem" class="breadcrumb-item active" aria-current="page">
			<a itemprop="item" href="/user/login"><span itemprop="name">Вход</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
	</ol>
</nav>
<!-- Хлебные крошки #End /-->

<h1 class="my-4">Вход</h1>

{if $error}
<div class="alert alert-danger" role="alert">
	{if $error == 'login_incorrect'}Неверный логин или пароль
	{elseif $error == 'user_disabled'}Ваш аккаунт еще не активирован.
	{else}{$error}{/if}
</div>
{/if}

<div class="col-md-6 offset-md-3">
	<span class="anchor" id="formLogin"></span>
	<div class="card card-outline-secondary">
		<div class="card-header">
			<h3 class="mb-0">Вход</h3>
		</div>
		<div class="card-body">
			<form class="form login_form" role="form" autocomplete="off" id="loginForm" novalidate="" method="POST">
				<div class="form-group">
					<label for="login_email">Email</label>
					<input type="text" class="form-control" id="login_email" name="email" data-format="email" data-notice="Введите email" value="{$email|escape}" maxlength="255"required="">
					<div class="invalid-feedback">Введите email</div>
				</div>
				<div class="form-group">
					<label for="login_password">Пароль</label>
					<input type="password" class="form-control" id="login_password" name="password" data-format=".+" data-notice="Введите пароль" value="" required="" autocomplete="off">
					<div class="invalid-feedback">Введите пароль</div>
				</div>
				<a href="user/password_remind">Забыли пароль?</a>
				<input type="submit" class="btn btn-success btn-lg float-right" name="login" id="btnLogin" value="Войти">
			</form>
		</div>
	</div>
</div>