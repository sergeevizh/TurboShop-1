{* Страница заказа *}
{$meta_title = "Ваш заказ №`$order->id`" scope=parent}

<!-- Хлебные крошки /-->
<nav class="mt-4" aria-label="breadcrumb">
    <ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="/">Главная</a></li>
        <li class="breadcrumb-item active" aria-current="page">Страница заказа</li>
	</ol>
</nav>
<!-- Хлебные крошки #End /-->

{* Заголовок страницы *}
<h1 class="my-4">
	Ваш заказ №{$order->id} 
	{if $order->status == 0}принят{/if}
	{if $order->status == 1}в обработке{elseif $order->status == 2}выполнен{/if}
	{if $order->paid == 1}, оплачен{else}{/if}
</h1>

<fieldset>
	<table class="table cart-table">
		<thead>
			<tr>
				<th>&nbsp;</th>
				<th>Название</th>
				<th>Цена</th>
				<th>Количество</th>
				<th>Сумма</th>
			</tr>
		</thead>
		<tbody>
			{foreach $purchases as $purchase}
			<tr>
				<td>
				{$img_flag=0}
					{$image_array=","|explode:$purchase->variant->images_ids}
						{foreach $purchase->product->images as $image}
							{if $image->id|in_array:$image_array}
								{if $img_flag==0}{$image_toshow=$image}{/if}
								{$img_flag=1}
							{/if}
						{/foreach}
					{if $img_flag ne 0}
						<a href="products/{$purchase->product->url}"><img src="{$image_toshow->filename|resize:116:116}" alt="{$product->name|escape}"></a>
					{else}
						{$image = $purchase->product->images|first}
						{if $image}
						<a href="products/{$purchase->product->url}"><img src="{$image->filename|resize:116:116}" alt="{$product->name|escape}"></a>
						{/if}
					{/if}
				</td>
				<td data-title="Название">
					<a href="products/{$purchase->product->url}">{$purchase->product->name|escape}</a>
					{if $purchase->variant->color}{$purchase->variant->color|escape} / {/if}{$purchase->variant->name|escape}
				</td>
				<td data-title="Цена">{($purchase->price)|convert}&nbsp;{$currency->sign}</td>
				<td data-title="Количество">
					&times; {$purchase->amount}&nbsp;{$settings->units}
				</td>
				<td data-title="Сумма"><b>{($purchase->price*$purchase->amount)|convert}&nbsp;{$currency->sign}</b></td>
			</tr>
			{/foreach}
		</tbody>
	</table>
	{* Скидка, если есть *}
	{if $order->discount > 0}
	<div class="cart-foot text-right">
		<div class="cart-total">
			<div class="order-total">
				<strong>Скидка:</strong>
				<strong>{$order->discount}&nbsp;%</strong>
			</div>
		</div>
	</div>
	{/if}
	{* Купон, если есть *}
	{if $order->coupon_discount > 0}
	<div class="cart-foot text-right">
		<div class="cart-total">
			<div class="order-total">
				<strong>Купон:</strong>
				<strong>&minus;{$order->coupon_discount|convert}&nbsp;{$currency->sign}</strong>
			</div>
		</div>
	</div>
	{/if}
	{* Если стоимость доставки входит в сумму заказа *}
	{if !$order->separate_delivery && $order->delivery_price>0}
	<div class="cart-foot text-right">
		<div class="cart-total">
			<div class="order-total">
				<strong>{$delivery->name|escape}:</strong>
				<strong>{$order->delivery_price|convert}&nbsp;{$currency->sign}</strong>
			</div>
		</div>
	</div>
	{/if}
	{* Итого *}
	<div class="cart-foot text-right">
		<div class="cart-total">
			<div class="order-total">
				<strong>Итого:</strong>
				<strong>{$order->total_price|convert}&nbsp;{$currency->sign}</strong>
			</div>
		</div>
	</div>
	{* Если стоимость доставки не входит в сумму заказа *}
	{if $order->separate_delivery}
	<div class="cart-foot text-right">
		<div class="cart-total">
			<div class="order-total">
				<strong>{$delivery->name|escape}:</strong>
				<strong>{$order->delivery_price|convert}&nbsp;{$currency->sign}</strong>
			</div>
		</div>
	</div>
	{/if}
	{* Детали заказа *}
	<h2>Детали заказа</h2>
	<table class="table table-bordered">
		<tbody>
			<tr>
				<td scope="row">
					Дата заказа
				</td>
				<td>
					{$order->date|date} в
					{$order->date|time}
				</td>
			</tr>
			{if $order->name}
			<tr>
				<td scope="row">
					Имя
				</td>
				<td>
					{$order->name|escape}
				</td>
			</tr>
			{/if}
			{if $order->email}
			<tr>
				<td scope="row">
					Email
				</td>
				<td>
					{$order->email|escape}
				</td>
			</tr>
			{/if}
			{if $order->phone}
			<tr>
				<td scope="row">
					Телефон
				</td>
				<td>
					{$order->phone|escape}
				</td>
			</tr>
			{/if}
			{if $order->address}
			<tr>
				<td scope="row">
					Адрес доставки
				</td>
				<td>
					{$order->address|escape}
				</td>
			</tr>
			{/if}
			{if $order->comment}
			<tr>
				<td scope="row">
					Комментарий
				</td>
				<td>
					{$order->comment|escape|nl2br}
				</td>
			</tr>
			{/if}
		</tbody>
	</table>
	{if !$order->paid}
	{* Выбор способа оплаты *}
	{if $payment_methods && !$payment_method && $order->total_price>0}
	<form method="post">
		<h2>Выберите способ оплаты</h2>
		<div id="accordion">
			{foreach $payment_methods as $payment_method name=foo}
			<div class="card my-2">
				<div class="card-header" id="headingOne">
					<h5 class="mb-0">
						<div class="form-check">
							<label for="payment_{$payment_method->id}" class="form-check-label">
								<input type="radio" class="form-check-input {if !$smarty.foreach.foo.first}collapsed{/if}" name="payment_method_id" value="{$payment_method->id}" data-toggle="collapse" data-target="#collapse{$payment_method->id}" aria-expanded="true" aria-controls="collapse{$payment_method->id}" {if $payment_method@first}checked{/if} id="payment_{$payment_method->id}">
								{$payment_method->name}, к оплате {$order->total_price|convert:$payment_method->currency_id}&nbsp;{$all_currencies[$payment_method->currency_id]->sign}
							</label>
						</div>
					</h5>
				</div>
				<div id="collapse{$payment_method->id}" class="collapse {if $smarty.foreach.foo.first}show{/if}" aria-labelledby="heading{$payment_method->id}" data-parent="#accordion">
					{if $payment_method->description}
					<div class="card-body">
						{$payment_method->description}
					</div>
					{/if}
				</div>
			</div>
			{/foreach}
		</div>
		<input type="submit" class="btn btn-success btn-lg float-right"  value="Закончить заказ">
	</form>
	{* Выбраный способ оплаты *}
	{elseif $payment_method}
	<h2>Способ оплаты &mdash; {$payment_method->name}</h2>
	<form method="post"><input type="submit" class="btn btn-primary" name="reset_payment_method" value="Выбрать другой способ оплаты"></form>	
	<p>
		{$payment_method->description}
	</p>
	<h2>
		К оплате {$order->total_price|convert:$payment_method->currency_id}&nbsp;{$all_currencies[$payment_method->currency_id]->sign}
	</h2>
	{* Форма оплаты, генерируется модулем оплаты *}
	{checkout_form order_id=$order->id module=$payment_method->module}
	{/if}
	{/if}
</fieldset>					