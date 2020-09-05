{* Title *}
{$meta_title='Заказы' scope=parent}

<div class="row">
    <div class="col-lg-7 col-md-7">
        <div class="wrap_heading">
            {if $orders_count}
			<div class="box_heading heading_page">
				{$orders_count} заказ{$orders_count|plural:'':'ов':'а'}
			</div>
            {else}
			<div class="box_heading heading_page">Нет заказов</div>
            {/if}
            <div class="box_btn_heading">
                <a class="btn btn_small btn-info" href="{url module=OrderAdmin}">
                    {include file='svg_icon.tpl' svgId='plus'}
                    <span>Добавить заказ</span>
				</a>
			</div>
		</div>
	</div>
	<div class="col-md-12 col-lg-5 col-xs-12 float-xs-right">
        <div class="boxed_search">
            <form class="search" method="get">
                <input type="hidden" name="module" value="OrdersAdmin">
                <div class="input-group">
                    <input name="keyword" class="form-control" placeholder="поиск..." type="text" value="{$keyword|escape}" >
                    <span class="input-group-btn">
                        <button type="submit" class="btn btn_green"><i class="fa fa-search"></i> <span class="hidden-md-down"></span></button>
					</span>
				</div>
			</form>
		</div>
	</div>
</div>

{if $message_error}
<div class="row">
	<div class="col-lg-12 col-md-12 col-sm-12">
		<div class="boxed boxed_warning">
			<div class="heading_box">
				{if $message_error=='error_closing'}
				В заказах
				{foreach $error_orders as $error_order_id}
				<div>
					№ {$error_order_id}
				</div>
				{/foreach}
					Нехватка некоторых товаров на складе
				{else}
					{$message_error|escape}
				{/if}
			</div>
		</div>
	</div>
</div>
{/if}

<div class="boxed fn_toggle_wrap">
	{if $orders}
	<div class="row">
		<div class="col-lg-12 col-md-12 ">
			<div class="hidden-md-up">
				<div class="row mb-1">
					<div class=" col-md-6 col-sm-12">
						<select name="status" class="selectpicker"  onchange="location = this.value;">
							<option value="{url module=OrdersAdmin status=0 keyword=null id=null page=null label=null}" {if $status==0}selected=""{/if} >Новые</option>
							<option value="{url module=OrdersAdmin status=1 keyword=null id=null page=null label=null}" {if $status==1}selected=""{/if} >Приняты</option>
							<option value="{url module=OrdersAdmin status=2 keyword=null id=null page=null label=null}" {if $status==2}selected=""{/if} >Выполнены</option>
							<option value="{url module=OrdersAdmin status=3 keyword=null id=null page=null label=null}" {if $status==3}selected=""{/if} >Удалены</option>
							<option value="{url module=OrdersAdmin status='all' keyword=null id=null page=null label=null from_date=null to_date=null}" {if $smarty.get.status && $status == "all" || !$status}selected{/if}>Все</option>
						</select>
					</div>
				</div>
			</div>
			<div class="boxed_sorting">
				<div class="row">
					<div class="col-md-11 col-lg-11 col-xl-7 col-sm-12 mb-1">
						<div class="date">
							<form class="date_filter row" method="get">
								<input type="hidden" name="module" value="OrdersAdmin">
								<input type="hidden" name="status" value="{$status}">
								<div class="col-md-5 col-lg-5 pr-0 pl-0">
									<div class="input-group">
										<span class="input-group-addon-date">c</span>
										<input type="text" class="fn_from_date form-control" name="from_date" value="{$from_date}" autocomplete="off" >
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
								<div class="col-md-5 col-lg-5 pr-0 pl-0">
									<div class="input-group">
										<span class="input-group-addon-date">по</span>
										<input type="text" class="fn_to_date form-control" name="to_date" value="{$to_date}" autocomplete="off" >
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
								<div class="col-md-2 col-lg-2 pr-0">
									<button class="btn btn_green" type="submit">Применить</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6 col-lg-4 col-sm-12">
						<select name="status" class="selectpicker"  onchange="location = this.value;">
							<option value="{url module=OrdersAdmin status=0 keyword=null id=null page=null label=null from_date=null to_date=null}" {if $smarty.get.status && $status == 0 || !$status}selected{/if} >Новые</option>
							<option value="{url module=OrdersAdmin status=1 keyword=null id=null page=null label=null from_date=null to_date=null}" {if $status==1}selected{/if} >Приняты</option>
							<option value="{url module=OrdersAdmin status=2 keyword=null id=null page=null label=null from_date=null to_date=null}" {if $status==2}selected{/if} >Выполнены</option>
							<option value="{url module=OrdersAdmin status=3 keyword=null id=null page=null label=null from_date=null to_date=null}" {if $status==3}selected{/if} >Удалены</option>
						</select>
					</div>
					{if $labels}
					<div class="col-md-6 col-lg-4 col-sm-12">
						<select class="selectpicker" onchange="location = this.value;">
							<option value="{url label=null}" {if $label->id != $l->id} selected{/if}>Все метки</option>
							{foreach $labels as $l}
							<option value="{url label=$l->id}" {if $label->id == $l->id}selected{/if}>{$l->name|escape}</option>
							{/foreach}
						</select>
					</div>
					{/if}
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12">
			<form class="fn_form_list" method="post">
				<input type="hidden" name="session_id" value="{$smarty.session.id}">
				<div class="orders_list turbo_list products_list">
					<div class="turbo_list_head">
						<div class="turbo_list_heading turbo_list_check">
							<input class="hidden_check fn_check_all" type="checkbox" id="check_all_1" name="" value=""/>
							<label class="turbo_ckeckbox" for="check_all_1"></label>
						</div>
						<div class="turbo_list_heading turbo_list_order_number">№ </div>
						<div class="turbo_list_heading turbo_list_orders_name">ФИО</div>
						<div class="turbo_list_heading turbo_list_order_status">Статус</div>
						<div class="turbo_list_heading turbo_list_order_product_count">Товары</div>
						<div class="turbo_list_heading turbo_list_orders_price">Сумма продаж</div>
						<div class="turbo_list_heading turbo_list_order_marker">Метка</div>
						<div class="turbo_list_heading turbo_list_close"></div>
					</div>
					<div class="turbo_list_body">
						{foreach $orders as $order}
						<div class="fn_row turbo_list_body_item">
							<div class="turbo_list_row">
								<div class="turbo_list_boding turbo_list_check">
									<input class="hidden_check" type="checkbox" id="id_{$order->id}" name="check[]" value="{$order->id}"/>
									<label class="turbo_ckeckbox" for="id_{$order->id}"></label>
								</div>
								<div class="turbo_list_boding turbo_list_boding_order turbo_list_order_number">
									<a href="{url module=OrderAdmin id=$order->id return=$smarty.server.REQUEST_URI}">Заказ №{$order->id}</a>
									{if $order->paid}
									<div class="order_paid">
										<span class="tag tag-success">Оплачен</span>
									</div>
									{else}
									<div class="order_paid">
										<span class="tag tag-default">Не оплачен</span>
									</div>
									{/if}
								</div>
								<div class="turbo_list_boding turbo_list_orders_name">
									<span class="text_dark text_bold">{$order->name|escape}</span>
									{if $order->note}
									<div class="note">{$order->note|escape}</div>
									{/if}
									<div class="hidden-lg-up mt-q">
										<span class="tag tag-warning">
											{if $order->status == 0}
												Новый
											{/if}
											{if $order->status == 1}
												Принят
											{/if}
											{if $order->status == 2}
												Выполнен
											{/if}
											{if $order->status == 3}
												Удалён
											{/if}
										</span>
									</div>
									<div class="mt-q"><span class="hidden-md-down">Заказал</span>
									<span class="tag tag-default">{$order->date|date} l {$order->date|time}</span></div>
								</div>
								<div class="turbo_list_boding turbo_list_order_status">
									{if $order->status == 0}
										Новый
									{/if}
									{if $order->status == 1}
										Принят
									{/if}
									{if $order->status == 2}
										Выполнен
									{/if}
									{if $order->status == 3}
										Удалён
									{/if}
								</div>
								<div class="turbo_list_boding turbo_list_order_product_count">
									<span>{$order->purchases|count}</span>
									<span  class="fn_orders_toggle">
										<i class="fn_icon_arrow fa fa-angle-down fa-lg m-t-2 "></i>
									</span>
								</div>
								<div class="turbo_list_boding turbo_list_orders_price">
									<div class="input-group">
										<span class="form-control">
											{$order->total_price|escape}
										</span>
										<span class="input-group-addon">
											{$currency->sign|escape}
										</span>
									</div>
								</div>
								<div class="turbo_list_boding turbo_list_order_marker">
									<span class="fn_ajax_label_wrapper">
										<div class="fn_order_labels orders_labels">
											{if $order->labels}
											{foreach $order->labels as $l}
											<span class="tag" style="background-color:#{$l->color};" >{$l->name|escape}</span>
											{/foreach}
											{else}
											<span class="tag tag-default">нет метки</span>
											{/if}
										</div>
									</span>
								</div>
								<div class="turbo_list_boding turbo_list_close">
									{*delete*}
									<button data-hint="Удалить заказ" type="button" class="btn_close fn_remove hint-bottom-right-t-info-s-small-mobile hint-anim" data-toggle="modal" data-target="#fn_action_modal" onclick="success_action($(this));" >
										{include file='svg_icon.tpl' svgId='delete'}
									</button>
								</div>
							</div>
							<div class="turbo_list_row purchases_block">
								<div class="orders_purchases_block" style="display: none">
									<div class="purchases_table">
										<div class="purchases_head">
											<div class="purchases_heading purchases_table_orders_num">№</div>
											<div class="purchases_heading purchases_table_orders_sku">Артикул</div>
											<div class="purchases_heading purchases_table_orders_name">Название</div>
											<div class="purchases_heading purchases_table_orders_price">Цена</div>
											<div class="purchases_heading col-lg-2 purchases_table_orders_unit">Кол-во</div>
											<div class="purchases_heading purchases_table_orders_total">Сумма</div>
										</div>
										<div class="purchases_body">
											{foreach $order->purchases as $purchase}
											<div class="purchases_body_items">
												<div class="purchases_body_item">
													<div class="purchases_bodyng purchases_table_orders_num">{$purchase@iteration}</div>
													<div class="purchases_bodyng purchases_table_orders_sku">{$purchase->sku|default:"&mdash;"}</div>
													<div class="purchases_bodyng purchases_table_orders_name">
														{$purchase->product_name|escape}
														{if $purchase->variant_name}({$purchase->variant_name|escape}){/if}
													</div>
													<div class="purchases_bodyng purchases_table_orders_price">{$purchase->price|convert} {$currency->sign|escape}</div>
													<div class="purchases_bodyng purchases_table_orders_unit"> {$purchase->amount}{$settings->units|escape}</div>
													<div class="purchases_bodyng purchases_table_orders_total"> {($purchase->amount*$purchase->price)|convert} {$currency->sign|escape}</div>
												</div>
											</div>
											{/foreach}
										</div>
									</div>
								</div>
							</div>
						</div>
						{/foreach}
					</div>
					<div class="turbo_list_footer">
						<div class="turbo_list_foot_left">
							<div class="turbo_list_heading turbo_list_check">
								<input class="hidden_check fn_check_all" type="checkbox" id="check_all_2" name="" value=""/>
								<label class="turbo_ckeckbox" for="check_all_2"></label>
							</div>
							<div class="turbo_list_option">
								<select name="action" class="selectpicker fn_change_orders">
									<option value="0">Выберите действие</option>
									{if $status!==0}<option value="set_status_0">В новые</option>{/if}
									{if $status!==1}<option value="set_status_1">В принятые</option>{/if}
									{if $status!==2}<option value="set_status_2">В выполненные</option>{/if}
									{foreach $labels as $l}
									<option value="set_label_{$l->id}">Отметить &laquo;{$l->name}&raquo;</option>
									{/foreach}
									{foreach $labels as $l}
									<option value="unset_label_{$l->id}">Снять &laquo;{$l->name}&raquo;</option>
									{/foreach}
									<option value="delete">Удалить выбранные заказы</option>
								</select>
							</div>
						</div>
						<button type="submit" class=" btn btn_small btn_green">
							{include file='svg_icon.tpl' svgId='checked'}
							<span>Применить</span>
						</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm 12 txt_center">
			{include file='pagination.tpl'}
		</div>
	</div>
	{else}
	<div class="heading_box mt-1">
		<div class="text_grey">Нет заказов</div>
	</div>
	{/if}
</div>
{* On document load *}
{literal}
<script>
	$(function() {
		// Сортировка списка
		$("#labels").sortable({
			items:             "li",
			tolerance:         "pointer",
			scrollSensitivity: 40,
			opacity:           0.7
		});
		$("#main_list #list .row").droppable({
			activeClass: "drop_active",
			hoverClass: "drop_hover",
			tolerance: "pointer",
			drop: function(event, ui){
				label_id = $(ui.helper).attr('data-label-id');
				$(this).find('input[type="checkbox"][name*="check"]').attr('checked', true);
				$(this).closest("form").find('select[name="action"] option[value=set_label_'+label_id+']').attr("selected", "selected");
				$(this).closest("form").submit();
				return false;	
			}		
		});
		$(document).on('click','.fn_orders_toggle',function(){
			$(this).find('.fn_icon_arrow').toggleClass('rotate_180');
			$(this).parents('.fn_row').find('.orders_purchases_block').slideToggle();
		});
		$(".fn_labels_show").click(function(){
			$(this).next('.fn_labels_hide').toggleClass("active_labels");
		});
		$(".fn_delete_labels_hide").click(function(){
			$(this).closest('.box_labels_hide').removeClass("active_labels");
		});
		if($(window).width() >= 1199 ){
			$(".fn_from_date, .fn_to_date ").datepicker({
				dateFormat: 'dd-mm-yy'
			});
		}
		$(document).on("change", ".fn_change_orders", function () {
			console.log($(this));
			var item = $(this).find("option:selected").data("item");
			if(item == "status") {
				$(".fn_show_label").hide();
				$(".fn_show_status").show();
				} else if (item == "label") {
				$(".fn_show_label").show();
				$(".fn_show_status").hide();
				} else {
				$(".fn_show_label").hide();
				$(".fn_show_status").hide();
			}
		});
		$(document).on("change", ".fn_ajax_labels input", function () {
			elem = $(this);
			var order_id = parseInt($(this).closest(".fn_ajax_labels").data("order_id"));
			var state = "";
			session_id = '{/literal}{$smarty.session.id}{literal}';
			var label_id = parseInt($(this).closest(".fn_ajax_labels").find("input").val());
			if($(this).closest(".fn_ajax_labels").find("input").is(":checked")){
				state = "add";
				} else {
				state = "remove";
			}
			$.ajax({
				type: "POST",
				dataType: 'json',
				url: "ajax/update_order.php",
				data: {
					order_id : order_id,
					state : state,
					label_id : label_id,
					session_id : session_id
				},
				success: function(data){
					var msg = "";
					if(data){
						elem.closest(".fn_ajax_label_wrapper").find(".fn_order_labels").html(data.data);
						toastr.success(msg, "Готово");
						} else {
						toastr.error(msg, "Ошибка");
					}
				}
			});
		});
	});
</script>
{/literal}