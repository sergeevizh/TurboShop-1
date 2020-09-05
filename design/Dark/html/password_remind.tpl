{* Письмо пользователю для восстановления пароля *}

{* Канонический адрес страницы *}
{$canonical="/user/password_remind" scope=parent}

<!-- Хлебные крошки /-->
<nav class="mt-4" aria-label="breadcrumb">
    <ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="/">Главная</a></li>
        <li class="breadcrumb-item active" aria-current="page">Напоминание пароля</li>
	</ol>
</nav>
<!-- Хлебные крошки #End /-->

{if $email_sent}
<h1 class="my-4">Вам отправлено письмо</h1>
<div class="alert alert-success" role="alert">
	На {$email|escape} отправлено письмо для восстановления пароля.
</div>
{else}
<h1 class="my-4">Напоминание пароля</h1>
{if $error}
<div class="alert alert-danger" role="alert">
	{if $error == 'user_not_found'}Пользователь не найден
	{else}{$error}{/if}
</div>
{/if}
<div class="col-md-6 offset-md-3">
	<span class="anchor" id="formResetPassword"></span>
	<div class="card card-outline-secondary">
		<div class="card-header">
			<h3 class="mb-0">Напоминание пароля</h3>
		</div>
		<div class="card-body">
			<form autocomplete="off" method="post" id="loginForm" class="form" role="form">
				<div class="form-group">
                    <label for="inputResetPasswordEmail">Email</label> 
					<input type="text" class="form-control" id="inputResetPasswordEmail" required="" name="email" data-format="email" data-notice="Введите email" value="{$email|escape}"  maxlength="255"/>
					<div class="invalid-feedback">Введите email</div>
					<span class="form-text small text-muted" id="helpResetPasswordEmail">Введите email, который вы указывали при регистрации</span>
				</div>
				<div class="form-group">
                    <input class="btn btn-success btn-lg float-right" type="submit" id="btnLogin" class="button_submit" value="Вспомнить" />
				</div>
			</form>
		</div>
	</div>
</div>
{/if}