{* Title *}
{if $coupon->code}
	{$meta_title = $coupon->code scope=parent}
{else}
	{$meta_title = 'Новый купон' scope=parent}
{/if}

<div class="row">
    <div class="col-lg-7 col-md-7">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                {if $coupon->code}
					{$coupon->code}
                {else}
					Новый купон
                {/if}
			</div>
		</div>
	</div>
</div>

{if $message_success}
<div class="row">
	<div class="col-lg-12 col-md-12 col-sm-12">
		<div class="boxed boxed_success">
			<div class="heading_box">
				{if $message_success == 'added'}
					Купон добавлен
				{elseif $message_success == 'updated'}
					Купон изменен
				{/if}
				{if $smarty.get.return}
				<a class="btn btn_return float-xs-right" href="{$smarty.get.return}">
					{include file='svg_icon.tpl' svgId='return'}
					<span>Назад</span>
				</a>
				{/if}
			</div>
		</div>
	</div>
</div>
{/if}

{if $message_error}
<div class="row">
	<div class="col-lg-12 col-md-12 col-sm-12">
		<div class="boxed boxed_warning">
			<div class="heading_box">
				{if $message_error == 'code_exists'}
					Купон с таким кодом уже существует
				{elseif $message_error=='empty_code'}
					Заполните название купона
				{else}
					{$message_error|escape}
				{/if}
				{if $smarty.get.return}
				<a class="btn btn_return float-xs-right" href="{$smarty.get.return}">
					{include file='svg_icon.tpl' svgId='return'}
					<span>Назад</span>
				</a>
				{/if}
			</div>
		</div>
	</div>
</div>
{/if}

<div class="boxed fn_toggle_wrap">
	<form method="post" id="product" class="clearfix" enctype="multipart/form-data">
		<input type="hidden" name="session_id" value="{$smarty.session.id}">
		<div class="turbo_list products_list fn_sort_list turbo_list_order">
			<div class="turbo_list_head">
				<div class="turbo_list_heading turbo_list_coupon_name">Название купона</div>
				<div class="turbo_list_heading turbo_list_coupon_sale">Скидка</div>
				<div class="turbo_list_heading turbo_list_coupon_condit">Для заказов от</div>
				<div class="turbo_list_heading turbo_list_coupon_disposable">Одноразовый</div>
				<div class="turbo_list_heading turbo_list_coupon_validity">Срок действия</div>
				<div class="turbo_list_heading turbo_list_coupon_count">Истекает</div>
				<div class="turbo_list_heading turbo_list_close"></div>
			</div>
			<div class="turbo_list_body">
				<div class="turbo_list_body_item">
					<div class="turbo_list_row ">
						<div class="turbo_list_boding turbo_list_coupon_name">
							<input class="form-control" name="code" type="text" value="{$coupon->code|escape}" placeholder="Введите название купона"/>
							<input name="id" class="name" type="hidden" value="{$coupon->id|escape}"/>	
						</div>
						<div class="turbo_list_boding turbo_list_coupon_sale">
							<div class="input-group">
								<input class="form-control" name="value" type="text" value="{$coupon->value|escape}" />
								<select class="selectpicker form-control" name="type">
									<option value="percentage" {if $coupon->type=='percentage'}selected{/if}>%</option>
									<option value="absolute" {if $coupon->type=='absolute'}selected{/if}>{$currency->sign}</option>
								</select>
							</div>
						</div>
						<div class="turbo_list_boding turbo_list_coupon_condit">
                            <div class="input-group">
                                <input class="form-control" type="text" name="min_order_price" value="{$coupon->min_order_price|escape}" placeholder="Сумма заказа">
								<div class="input-group-addon">
									{$currency->sign}
								</div>
							</div>                           
						</div>
						<div class="turbo_list_boding turbo_list_coupon_disposable">
							<input class="hidden_check" type="checkbox" name="single" id="single" value="1" {if $coupon->single==1}checked{/if} />
							<label class="turbo_ckeckbox" for="single"></label>
						</div>
						<div class="turbo_list_boding turbo_list_coupon_validity">
							<div class="input-group">
								<input class="form-control" type=text name="expire" value="{$coupon->expire|date}">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
							</div>
						</div>
						
						<div class="turbo_list_boding turbo_list_coupon_disposable">
							<input class="hidden_check" type="checkbox" name="expires" id="expires" value="1" {if $coupon->expire}checked{/if} />
							<label class="turbo_ckeckbox" for="expires"></label>
						</div>
						
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12 col-md-12 mt-1">
				<button type="submit" class="btn btn_small btn_green float-md-right">
					{include file='svg_icon.tpl' svgId='checked'}
					<span>Применить</span>
				</button>
			</div>
		</div>
	</form>
	<script>
		$('input[name="expire"]').datepicker({
			regional:'ru'
		});
	</script>
</div>

<script src="design/js/jquery/datepicker/jquery.ui.datepicker-ru.js"></script>
{literal}
<script>
	$(function() {
		var new_coupon = $(".fn_new_coupon").clone(true);
		$(".fn_new_coupon").remove();
		
		$(document).on("click", ".fn_add_coupon", function () {
			$(this).remove();
			new_coupon.find("select").selectpicker();
			new_coupon.find('input[name="expire"]').datepicker({
				regional:'ru'
			});
			$(".fn_coupon_wrap").prepend(new_coupon);
		})
	});
</script>
{/literal}