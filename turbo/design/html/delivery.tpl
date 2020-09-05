{if $delivery->id}
    {$meta_title = $delivery->name scope=parent}
{else}
    {$meta_title = 'Новый способ доставки' scope=parent}
{/if}

<div class="row">
    <div class="col-lg-12 col-md-12">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                {if !$delivery->id}
                    Добавление способа доставки
                {else}
                    {$delivery->name|escape}
                {/if}
            </div>
        </div>
    </div>
    <div class="col-md-12 col-lg-12 col-sm-12 float-xs-right"></div>
</div>

{if $message_success}
<div class="row">
    <div class="col-lg-12 col-md-12 col-sm-12">
        <div class="boxed boxed_success">
            <div class="heading_box">
                {if $message_success == 'added'}
                    Способ доставки добавлен
                {elseif $message_success == 'updated'}
                    Способ доставки изменен
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
                {if $message_error=='empty_name'}
                    Введите название
                {else}
                    {$message_error|escape}
                {/if}
            </div>
        </div>
    </div>
</div>
{/if}

<form method="post" enctype="multipart/form-data" class="fn_fast_button">
    <input type=hidden name="session_id" value="{$smarty.session.id}">
    
    <div class="row">
        <div class="col-xs-12">
            <div class="boxed">
                <div class="row d_flex">
                    <div class="col-lg-10 col-md-9 col-sm-12">
                        <div class="heading_label">
                            Название
                        </div>
                        <div class="form-group">
                            <input class="form-control mb-h" name="name" type="text" value="{$delivery->name|escape}"/>
                            <input name="id" type="hidden" value="{$delivery->id|escape}"/>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-3 col-sm-12">
                        <div class="activity_of_switch">
                            <div class="activity_of_switch_item"> {* row block *}
                                <div class="turbo_switch clearfix">
                                    <label class="switch_label">Активность</label>
                                    <label class="switch switch-default">
                                        <input class="switch-input" name="enabled" value='1' type="checkbox" id="visible_checkbox" {if $delivery->enabled}checked=""{/if}/>
                                        <span class="switch-label"></span>
                                        <span class="switch-handle"></span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-lg-6 col-md-12 pr-0">
            <div class="boxed fn_toggle_wrap min_height_335px">
                <div class="heading_box">
                    Тип доставки
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
                    </div>
                </div>
                
                <div class="toggle_body_wrap on fn_card">
                    <button type="button" class="btn btn-small btn-outline-warning fn_type_delivery delivery_type {if $delivery->price > 0}active{/if}" data-type="paid">
                        Платная
                    </button>
                    <button type="button" class="btn btn-small btn-outline-warning fn_type_delivery delivery_type {if $delivery->price == 0 && !$delivery->separate_payment}active{/if}" data-type="free">
                        Бесплатная
                    </button>
                    <button type="button" class="btn btn-small btn-outline-warning fn_type_delivery delivery_type {if $delivery->separate_payment}active{/if}" data-type="delivery">
                        Оплачивается отдельно
                    </button>
                    <div class="row fn_delivery_option {if $delivery->price == 0}hidden{/if} mt-1">
                        <div class="col-lg-12 col-md-12">
                            <div class="delivery_inline_block mt-1">
                                <div class="input-group">
                                    <span class="boxes_inline heading_label">Стоимость</span>
                                    <span class="boxes_inline bnr_dl_price">
                                        <div class="input-group">
                                            <input name="price" class="form-control" type="text" value="{$delivery->price|escape}" />
                                            <span class="input-group-addon">{$currency->sign|escape}</span>
                                        </div>
                                    </span>
                                </div>
                            </div>
                            <div class="delivery_inline_block mt-1">
                                <div class="input-group">
                                    <span class="boxes_inline heading_label">Бесплатна от</span>
                                    <span class="boxes_inline bnr_dl_price">
                                        <div class="input-group">
                                            <div class="input-group">
                                                <input name="free_from" class="form-control" type="text" value="{$delivery->free_from|escape}" />
                                                <span class="input-group-addon">{$currency->sign|escape}</span>
                                            </div>
                                        </div>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <input class="hidden" name="separate_payment" type="checkbox" value="1" {if $delivery->separate_payment}checked{/if} />
                </div>
            </div>
        </div>
        <div class="col-lg-6 col-md-12">
            <div class="boxed fn_toggle_wrap min_height_335px">
                <div class="heading_box">
                    Доступные способы оплаты
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
                    </div>
                </div>
                <div class="toggle_body_wrap on fn_card">
                    <div class="row wrap_payment_item">
                        {foreach $payment_methods as $payment_method}
                        <div class="col-lg-4 col-md-6 col-sm-12">
                            <div class="payment_item">
                                <input class="hidden_check" id="id_{$payment_method->id}" value="{$payment_method->id}" {if in_array($payment_method->id, $delivery_payments)}checked{/if} type="checkbox" name="delivery_payments[]">
                                <label for="id_{$payment_method->id}" class="turbo_ckeckbox {if in_array($payment_method->id, $delivery_payments)}active_payment{/if}">
                                    <span class="payment_name_wrap">{$payment_method->name|escape}</span>
                                </label>
                            </div>
                        </div>
                        {/foreach}
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-lg-12 col-md-12">
            <div class="boxed match fn_toggle_wrap tabs">
                <div class="heading_box">
                    Описание
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
                    </div>
                </div>
            <div class="toggle_body_wrap on fn_card">
                <div class="tab_container">
                    <div id="tab1" class="tab">
                        <textarea name="description" class="editor_small">{$delivery->description|escape}</textarea>
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
        </div>
    </div>
</div>
</form>
{* Подключаем Tiny MCE *}
{include file='tinymce_init.tpl'}
<script>
    $(document).on("click", ".fn_type_delivery", function () {
        var action = $(this).data("type");
        $(".delivery_type").removeClass("active");

        switch(action) {
            case 'paid':
                $(".fn_delivery_option").removeClass("hidden");
                $("input[name=separate_payment]").removeAttr("checked");
                $(this).addClass("active");
               break;
            case 'free':
                $(".fn_delivery_option").addClass("hidden");
                $(".fn_delivery_option").find("input").val(0);
                $("input[name=separate_payment]").removeAttr("checked");
                $(this).addClass("active");
                break;
            case 'delivery':
                $(".fn_delivery_option").addClass("hidden");
                $(".fn_delivery_option").find("input").val(0);
                $("input[name=separate_payment]").trigger("click");
                $(this).addClass("active");
                break;
        }
    });
</script>