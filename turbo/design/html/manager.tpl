{if $m->login}
	{$meta_title = $m->login scope=parent}
{else}
	{$meta_title = 'Новый менеджер' scope=parent}
{/if}

<div class="row">
    <div class="col-lg-7 col-md-7">
        {if !$m->id}
		<div class="heading_page">Новый менеджер</div>
        {else}
		<div class="heading_page">{$m->name|escape}</div>
        {/if}
	</div>
    <div class="col-lg-4 col-md-3 text-xs-right float-xs-right"></div>
</div>

{if $message_success}
<div class="row">
	<div class="col-lg-12 col-md-12 col-sm-12">
		<div class="boxed boxed_success">
			<div class="heading_box">
				{if $message_success=='added'}Менеджер добавлен{elseif $message_success=='updated'}Менеджер обновлен{else}{$message_success|escape}{/if}
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
				{if $message_error=='login_exists'}Менеджер с таким логином уже существует
				{elseif $message_error=='empty_login'}Введите логин
				{elseif $message_error=='not_writable'}Установите права на запись для файла /turbo/.passwd
				{else}{$message_error|escape}{/if}
			</div>
		</div>
	</div>
</div>
{/if}

<form method="post" enctype="multipart/form-data" class="fn_fast_button">
    <input type="hidden" name="session_id" value="{$smarty.session.id}">
    <div class="row">
        <div class="col-lg-12 col-md-12">
            <div class="boxed fn_toggle_wrap">
                <div class="heading_box">
                    Основая информация
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
					</div>
				</div>
                <div class="toggle_body_wrap on fn_card">
                    <div class="mb-1">
                        <div class="heading_label" >Логин</div>
                        <div class="">
                            <input class="form-control" name="login" autocomplete="off" type="text" value="{$m->login|escape}"/>
                            <input name="old_login" type="hidden" value="{$m->login|escape}"/>
                            <input name="id" type="hidden" value="{$m->id|escape}"/>
						</div>
					</div>
                    <div class="mb-1">
                        <div class="heading_label" >Пароль</div>
                        <div class="">
                            <input class="form-control" autocomplete="off" name="password" type="password" value="" placeholder="******" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	{$perms = [
		'products'   =>'Товары',
		'categories' =>'Категории',
		'brands'     =>'Бренды',
		'features'   =>'Свойства товаров',
		'orders'     =>'Заказы',
		'labels'     =>'Метки заказов',
		'users'      =>'Покупатели',
		'groups'     =>'Группы покупателей',
		'coupons'    =>'Купоны',
		'pages'      =>'Страницы',
		'menus'      =>'Меню',
		'blog'       =>'Блог',
		'comments'   =>'Комментарии',
		'feedbacks'  =>'Обратная связь',
		'callbacks'  =>'Обратный звонок',
		'subscribes' =>'E-mail подписчики',
		'import'     =>'Импорт',
		'export'     =>'Экспорт',
		'backup'     =>'Бекап',
		'stats'      =>'Статистика',
		'design'     =>'Дизайн',
		'banners'    =>'Баннеры',
		'settings'   =>'Настройки',
		'currency'   =>'Валюты',
		'delivery'   =>'Способы доставки',
		'payment'    =>'Способы оплаты',
		'managers'   =>'Менеджеры',
		'license'    =>'Управление лицензией'
	]}
	<div class="row">
        <div class="col-lg-12 col-md-12">
            <div class="boxed fn_toggle_wrap min_height_230px">
                <div class="heading_box">
                    Права доступа
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
					</div>
                    <span class="font_14 text_600">Все права</span>
                    <label class="switch switch-default">
                        <input class="switch-input fn_all_perms" value="" type="checkbox"/>
                        <span class="switch-label"></span>
                        <span class="switch-handle"></span>
					</label>
				</div>
                <div class="toggle_body_wrap on fn_card">
                    {foreach $perms as $title=>$items}
					<div class="permission_block">
						<div class="permission_boxes row">
							{foreach $items as $key=>$item}
							<div class="col-xl-3 col-lg-4 col-md-6 {if $m->login==$manager->login}text-muted{/if}">
								<div class="permission_box">
									<span>{$item|escape}</span>
									<label class="switch switch-default">
										<input id="{$title}" name="permissions[]" class="switch-input fn_item_perm" type="checkbox" value="{$title}" {if $m->permissions && in_array($title, $m->permissions)}checked{/if} {if $m->login==$manager->login}disabled{/if}/>
										<span class="switch-label"></span>
										<span class="switch-handle"></span>
									</label>
								</div>
							</div>
							{/foreach}
						</div>
					</div>
					<div class="col-xs-12 clearfix"></div>
                    {/foreach}
				</div>
                <div class="row">
                    <div class="col-lg-12 col-md-12 ">
                        <button type="submit" class="btn btn_small btn_green float-md-right">
                            {include file='svg_icon.tpl' svgId='checked'}
                            <span>Применить</span>
						</button>
                        {if $m->cnt_try >= 10}
						<button type="submit" name="unlock_manager" class="btn btn_small btn_green">
							<i class="fa fa-magic"></i>
							&nbsp; Разблокировать
						</button>
                        {/if}
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
<script>
    $(document).on("change", ".fn_all_perms", function () {
        if($(this).is(":checked")) {
            $('.fn_item_perm').each(function () {
                if(!$(this).is(":checked")) {
                    $(this).trigger("click");
				}
			});
			} else {
            $('.fn_item_perm').each(function () {
                if($(this).is(":checked")) {
                    $(this).trigger("click");
				}
			})
		}
	})
</script>