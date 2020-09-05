{* Шаблон корзины *}
{$meta_title = "Корзина" scope=parent}

<!-- Хлебные крошки /-->
{$level = 1}
<nav class="mt-4" aria-label="breadcrumb">
	<ol itemscope itemtype="https://schema.org/BreadcrumbList" class="breadcrumb bg-light">
		<li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem" class="breadcrumb-item">
			<a itemprop="item" href="/"><span itemprop="name">Главная</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
		<li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem" class="breadcrumb-item active" aria-current="page">
			<a itemprop="item" href="cart/"><span itemprop="name">Корзина</span></a>
			<meta itemprop="position" content="{$level++}" />
		</li>
	</ol>
</nav>
<!-- Хлебные крошки #End /-->

{* Заголовок страницы *}
<h1 class="my-4">{if $cart->purchases}В корзине {$cart->total_products} {$cart->total_products|plural:'товар':'товаров':'товара'}
{else}Корзина пуста{/if}</h1>

<fieldset>
    {if $cart->purchases}
	<form method="post" id="loginForm" name="cart">
		<table class="table cart-table">
			<thead>
				<tr>
					<th>&nbsp;</th>
					<th>Название</th>
					<th>Цена</th>
					<th>Количество</th>
					<th>Сумма</th>
					<th>&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				{foreach $cart->purchases as $purchase}
				<tr>
					<td>
						{$image = $purchase->product->images|first}
						{if $image}
						<a href="products/{$purchase->product->url}"><img src="{$image->filename|resize:116:116}" alt="{$product->name|escape}"></a>
						{/if}
					</td>
					<td data-title="Название">
						<a href="products/{$purchase->product->url}">{$purchase->product->name|escape}</a>
						{$purchase->variant->name|escape}
					</td>
					<td data-title="Цена">{($purchase->variant->price)|convert} {$currency->sign}</td>
					<td data-title="Количество">
						<select  class="custom-select" name="amounts[{$purchase->variant->id}]" onchange="document.cart.submit();">
							{section name=amounts start=1 loop=$purchase->variant->stock+1 step=1}
							<option value="{$smarty.section.amounts.index}" {if $purchase->amount==$smarty.section.amounts.index}selected{/if}>{$smarty.section.amounts.index} {$settings->units}</option>
							{/section}
						</select>
					</td>
					<td data-title="Сумма"><b>{($purchase->variant->price*$purchase->amount)|convert}&nbsp;{$currency->sign}</b></td>
					<td data-title="Удалить"><a href="cart/remove/{$purchase->variant->id}"><i class="fa fa-trash-alt"></i></a></td>
				</tr>
				{/foreach}
			</tbody>
		</table>
		{if $coupon_error}
		<div class="alert alert-danger" role="alert">
			{if $coupon_error == 'invalid'}Купон недействителен{/if}
		</div>
		{/if}
		{if $cart->coupon->min_order_price>0}
		<div class="alert alert-warning" role="alert">
			купон {$cart->coupon->code|escape} действует для заказов от {$cart->coupon->min_order_price|convert} {$currency->sign}
		</div>
		{/if}
		<div class="form-inline">
			<input class="form-control mr-sm-2" placeholder="Введите код купона..." type="text" name="coupon_code" value="{$cart->coupon->code|escape}" class="coupon_code">
			<input type="button" class="btn btn-primary my-2" name="apply_coupon"  value="Применить купон" onclick="document.cart.submit();">
		</div>
		{literal}
		<script>
			$("input[name='coupon_code']").keypress(function(event){
				if(event.keyCode == 13){
					$("input[name='name']").attr('data-format', '');
					$("input[name='email']").attr('data-format', '');
					document.cart.submit();
				}
			});
		</script>
		{/literal}
		{if $user->discount}
		<div class="cart-foot text-right">
			<div class="cart-total">
				<div class="order-total">
					<strong>Скидка:</strong>
					<strong>{$user->discount}&nbsp;%</strong>
				</div>
			</div>
		</div>
		{/if}
		{if $cart->coupon_discount>0}
		<div class="cart-foot text-right">
			<div class="cart-total">
				<div class="order-total">
					<strong>Купон:</strong>
					<strong>&minus;{$cart->coupon_discount|convert}&nbsp;{$currency->sign}</strong>
				</div>
			</div>
		</div>
		{/if}
		<div class="cart-foot text-right">
			<div class="cart-total">
				<div class="order-total">
					<strong>Итого:</strong>
					<strong>{$cart->total_price|convert}&nbsp;{$currency->sign}</strong>
				</div>
			</div>
		</div>
		{* Доставка *}
		{if $deliveries}
		<h3 class="my-4">Выберите способ доставки:</h3>
		<div id="accordion">
			{foreach $deliveries as $delivery name=foo}
			<div class="card my-2">
				<div class="card-header" id="headingOne">
					<h5 class="mb-0">
						<div class="form-check">
							<label class="form-check-label">
								<input type="radio" class="form-check-input {if !$smarty.foreach.foo.first}collapsed{/if}" name="delivery_id" value="{$delivery->id}" data-toggle="collapse" data-target="#collapse{$delivery->id}" aria-expanded="true" aria-controls="collapse{$delivery->id}" {if $delivery_id==$delivery->id}checked{elseif $delivery@first}checked{/if} id="deliveries_{$delivery->id}">
								{$delivery->name}
								{if $cart->total_price < $delivery->free_from && $delivery->price>0}
								({$delivery->price|convert}&nbsp;{$currency->sign})
								{elseif $cart->total_price >= $delivery->free_from}
								(бесплатно)
								{/if}
							</label>
						</div>
					</h5>
				</div>
				<div id="collapse{$delivery->id}" class="collapse {if $smarty.foreach.foo.first}show{/if}" aria-labelledby="heading{$delivery->id}" data-parent="#accordion">
					{if $delivery->description}
					<div class="card-body">
						{$delivery->description}
					</div>
					{/if}
				</div>
			</div>
			{/foreach}
		</div>
		{/if}
		<h3 class="my-3">Адрес получателя</h3>
		{if $error}
		<div class="alert alert-danger" role="alert">
			{if $error == 'empty_name'}Введите имя{/if}
			{if $error == 'empty_email'}Введите email{/if}
			{if $error == 'captcha'}Капча введена неверно{/if}
		</div>
		{/if}
		<div class="form-group">
			<label for="order_name">Имя, фамилия</label>
			<input name="name" id="order_name" class="form-control" type="text" value="{$name|escape}" placeholder="Введите имя" required="" data-format=".+" data-notice="Введите имя"/>
			<div class="invalid-feedback">Введите имя</div>
		</div>
		<div class="form-group">
			<label for="order_email">Email</label>
			<input name="email" id="order_email" class="form-control" type="text" value="{$email|escape}" placeholder="Введите email" required="" data-format="email" data-notice="Введите email" />
			<div class="invalid-feedback">Введите email</div>
		</div>
		<div class="form-group">
			<label for="order_phone">Телефон</label>
			<input name="phone" id="order_phone" class="form-control" type="text" value="{$phone|escape}" placeholder="Введите номер телефона"/>
		</div>
		<div class="form-group">
			<label for="order_address">Адрес доставки</label>
			<input name="address" id="order_address" class="form-control" type="text" value="{$address|escape}" placeholder="Введите адрес доставки" />
		</div>
		<div class="form-group">
			<label for="order_comment">Комментарий к&nbsp;заказу</label>
			<textarea class="form-control" rows="4" id="order_comment" name="comment" placeholder="Введите комментарий">{$comment|escape}</textarea>
			<div class="invalid-feedback">Введите комментарий</div>
		</div>
		<div class="form-row mt-4">
			<div class="form-group col-md-2">
				{get_captcha var="captcha_code"}
				<div class="secret_number">{$captcha_code[0]|escape} + ? =  {$captcha_code[1]|escape}</div> 
			</div>
			<div class="form-group col-md-10">
				<input class="form-control" type="text" name="captcha_code" placeholder="Введите капчу"  required="" autocomplete="off" value="" data-format=".+" data-notice="Введите капчу"/>
				<div class="invalid-feedback">Введите капчу</div>
			</div>
		</div>
		<button name="checkout" id="btnLogin" class="btn btn-primary btn-lg float-right" type="submit">Оформить заказ</button>
	</form>
	{else}
	<div class="alert alert-warning" role="alert">
		В корзине нет товаров
	</div>
	{/if}
</fieldset>						