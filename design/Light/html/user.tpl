{* Шаблон страницы зарегистрированного пользователя *}

<!-- Хлебные крошки /-->
<nav class="mt-4" aria-label="breadcrumb">
    <ol class="breadcrumb bg-light">
		<li class="breadcrumb-item"><a href="/">Главная</a></li>
        <li class="breadcrumb-item active" aria-current="page">{$user->name|escape}</li>
	</ol>
</nav>
<!-- Хлебные крошки #End /-->

<h1 class="mt-4">{$user->name|escape}</h1>

<h5>{if $group->discount>0}Ваша скидка &mdash; {$group->discount}%{/if}</h5>

{if $error}
<div class="alert alert-danger" role="alert">
	{if $error == 'empty_name'}Введите имя
	{elseif $error == 'empty_email'}Введите email
	{elseif $error == 'empty_password'}Введите пароль
	{elseif $error == 'user_exists'}Пользователь с таким email уже зарегистрирован
	{else}{$error}{/if}
</div>
{/if}

<div class="col-md-6 offset-md-3">
	<form class="form-horizontal mt-4" role="form" method="post">
		<div class="form-group">
			<label for="comment_name">Имя</label>
			<input class="form-control" data-format=".+" data-notice="Введите имя" placeholder="Введите имя" value="{$name|escape}" name="name" maxlength="255" type="text"/>
		</div>
		<div class="form-group">
			<label for="comment_name">Email</label>
			<input data-format="email" class="form-control" data-notice="Введите email" placeholder="Введите email" value="{$email|escape}" name="email" maxlength="255" type="text"/>
		</div>
		<div class="form-group">
			<label for="comment_name"><a href='#' onclick="$('#password').show();return false;">Изменить пароль</a></label>
			<input id="password" class="form-control" value="" name="password" type="password" style="display:none;"/>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2">
				<input class="btn btn-primary" type="submit" value="Сохранить" />
			</div>
		</div>
	</form>
</div>

{if $orders}
<h4 class="mt-5">Ваши заказы</h4>
<ul class="list-group list-group-flush">
	{foreach $orders as $order}
	<li class="list-group-item" >
		{$order->date|date} <a href='order/{$order->url}'>Заказ №{$order->id}</a>
		{if $order->paid == 1}оплачен,{/if} 
		{if $order->status == 0}ждет обработки{elseif $order->status == 1}в обработке{elseif $order->status == 2}выполнен{/if}
	</li>
	{/foreach}
</ul>
{/if}