{$meta_title = 'Валюты' scope=parent}

<div class="row">
    <div class="col-lg-7 col-md-7">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                Валюты
            </div>
            <div class="box_btn_heading">
                <a id="add_currency" class="btn btn_small btn-info" href="{url module=FeatureAdmin return=$smarty.server.REQUEST_URI}">
                    {include file='svg_icon.tpl' svgId='plus'}
                    <span>Добавить валюту</span>
                </a>
            </div>
        </div>
    </div>
</div>

{if $message_error}
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="boxed boxed_warning">
                <div class="heading_box">
                    {if $message_error == 'wrong_iso'}
                        Недопустимый код ISO в
                        {foreach $wrong_iso as $w_iso}
                            <div>{$w_iso|escape}</div>
                        {/foreach}
                    {else}
                        {$message_error|escape}
                    {/if}
                </div>
            </div>
        </div>
    </div>
{/if}

<div class="boxed fn_toggle_wrap">
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <form method=post class="fn_form_list">
                <input type="hidden" name="session_id" value="{$smarty.session.id}">
                <div class="turbo_list">
                    <div class="currencies_wrap clearfix">
                        <div class="turbo_list_head">
                            <div class="turbo_list_heading turbo_list_drag"></div>
                            <div class="turbo_list_heading turbo_list_currency_num">ID</div>
                            <div class="turbo_list_heading turbo_list_currency_name">Название валюты</div>
                            <div class="turbo_list_heading turbo_list_currency_sign">Знак</div>
                            <div class="turbo_list_heading turbo_list_currency_iso">Код ISO</div>
                            <div class="turbo_list_heading turbo_list_currency_exchange">Курс</div>
                            <div class="turbo_list_heading turbo_list_status hidden-md-down">Активность</div>
                            <div class="turbo_list_heading cur_settings">Действия</div>
                            <div class="turbo_list_heading turbo_list_close"></div>
                        </div>
                        <div id="currencies_block" class="turbo_list_body sortable">
                            {foreach $currencies as $c}
                                <div class="turbo_list_body_item">
                                    <div class="turbo_list_row">
                                        <div class="turbo_list_boding turbo_list_drag move_zone">
                                            {include file='svg_icon.tpl' svgId='drag_vertical'}
                                        </div>
                                        <div class="turbo_list_boding turbo_list_currency_num">
                                            <span>{$c->id}</span>
                                        </div>
                                        <div class="turbo_list_boding turbo_list_currency_name">
                                            <input class="form-control" name="currency[id][{$c->id}]" type="hidden" value="{$c->id|escape}"/>
                                            <input name="currency[name][{$c->id}]" class="form-control" type="text" value="{$c->name|escape}"/>

                                            {if $c@first}
                                                <span data-hint="Основная валюта" class="currency_name_active hint-bottom-middle-t-info-s-small-mobile  hint-anim">{include file='svg_icon.tpl' svgId='checked'}</span>
                                            {/if}
                                            <div class="hidden-md-up mt-q">
                                                <div class="turbo_list_currency_exchange_item">
                                                    {if !$c@first}
                                                        <div class="input-group">
                                                            <div class="input-group-qw cur_input_exchange">
                                                                <div class="input-group">
                                                                    <input class="form-control"  name="currency[rate_from][{$c->id}]" type="text" value="{$c->rate_from|escape}"/>
                                                                    <span class="input-group-addon">{$c->sign|escape}</span>
                                                                </div>
                                                            </div>

                                                            <div class="input-group-qw"><span class="equality">=</span></div>

                                                            <div class="input-group-qw cur_input_exchange">
                                                                <div class="input-group">
                                                                   <input class="form-control"  name="currency[rate_to][{$c->id}]" type="text" value="{$c->rate_to|escape}"/>
                                                                   <span class="input-group-addon">{$currency->sign|escape}</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    {else}
                                                        <input name="currency[rate_from][{$c->id}]" type="hidden" value="{$c->rate_from|escape}"/>
                                                        <input name="currency[rate_to][{$c->id}]" type="hidden" value="{$c->rate_to|escape}"/>
                                                    {/if}
                                                </div>
                                            </div>
                                        </div>
                                        <div class="turbo_list_boding turbo_list_currency_iso">
                                            <input class="form-control" name="currency[sign][{$c->id}]" type="text" value="{$c->sign|escape}"/>
                                        </div>
                                        <div class="turbo_list_boding turbo_list_currency_sign">
                                            <input class="form-control" name="currency[code][{$c->id}]" type="text" value="{$c->code|escape}"/>
                                        </div>
                                        <div class="turbo_list_boding turbo_list_currency_exchange">
                                            <div class="turbo_list_currency_exchange_item">
                                                {if !$c@first}
                                                    <div class="input-group">
                                                        <div class="input-group-qw cur_input_exchange">
                                                            <div class="input-group">
                                                                <input class="form-control"  name="currency[rate_from][{$c->id}]" type="text" value="{$c->rate_from|escape}"/>
                                                                <span class="input-group-addon">{$c->sign}</span>
                                                            </div>
                                                        </div>

                                                        <div class="input-group-qw"> <span class="equality">=</span> </div>

                                                        <div class="input-group-qw cur_input_exchange">
                                                            <div class="input-group">
                                                               <input class="form-control"  name="currency[rate_to][{$c->id}]" type="text" value="{$c->rate_to|escape}"/>
                                                               <span class="input-group-addon">{$currency->sign}</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                {else}
                                                    <input name="currency[rate_from][{$c->id}]" type="hidden" value="{$c->rate_from|escape}"/>
                                                    <input name="currency[rate_to][{$c->id}]" type="hidden" value="{$c->rate_to|escape}"/>
                                                {/if}
                                            </div>
                                        </div>
                                        <div class="turbo_list_boding turbo_list_status hidden-md-down">
                                            <label class="switch switch-default ">
                                                <input class="switch-input fn_ajax_action {if $c->enabled}fn_active_class{/if}" data-module="currency" data-action="enabled" data-id="{$c->id}" name="enabled" value="1" type="checkbox"  {if $c->enabled}checked=""{/if}/>
                                                <span class="switch-label"></span>
                                                <span class="switch-handle"></span>
                                            </label>
                                        </div>
                                        <div class="cur_settings">
                                            <button data-hint="Отображение копеек" type="button" class="setting_icon setting_icon_yandex hint-bottom-middle-t-info-s-small-mobile hint-anim fn_ajax_action {if $c->cents}fn_active_class{/if}" data-module="currency" data-action="cents" data-id="{$c->id}" name="cents">
                                                <i class="fa fa-database fa-sm m-t-2"></i>
                                            </button>
                                        </div>
                                        <div class="turbo_list_boding turbo_list_close">
                                            {*delete*}
                                            {if !$c@first}
                                                <button data-hint="Удалить валюту" type="button" class=" btn_close fn_remove_currency hint-bottom-right-t-info-s-small-mobile  hint-anim" data-id="{$c->id}">
                                                    {include file='svg_icon.tpl' svgId='delete'}
                                                </button>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            {/foreach}
                            <div id="new_currency" class="turbo_list_body sortable" style="display: none">
                                <div class="turbo_list_body_item">
                                    <div class="turbo_list_row">
                                        <div class="turbo_list_boding turbo_list_drag move_zone">
                                            {include file='svg_icon.tpl' svgId='drag_vertical'}
                                        </div>
                                        <div class="turbo_list_boding turbo_list_currency_num"></div>
                                        <div class="turbo_list_boding turbo_list_currency_name">
                                            <input name="currency[id][]" type="hidden" value=""/>
                                            <input name="currency[name][]" class="form-control" type="text" value=""/>
                                        </div>
                                        <div class="turbo_list_boding turbo_list_currency_iso">
                                            <input class="form-control" name="currency[sign][]" type="text" value=""/>
                                        </div>
                                        <div class="turbo_list_boding turbo_list_currency_sign">
                                            <input class="form-control" name="currency[code][]" type="text" value=""/>
                                        </div>
                                        <div class="turbo_list_boding turbo_list_currency_exchange">
                                            <div class="turbo_list_currency_exchange_item">
                                                <div class="input-group">
                                                    <div class="input-group-qw cur_input_exchange">
                                                        <div class="input-group">
                                                            <input class="form-control"  name="currency[rate_from][]" type="text" value=""/>
                                                            <span class="input-group-addon"></span>
                                                        </div>
                                                    </div>

                                                    <div class="input-group-qw"> <span class="equality">=</span> </div>

                                                    <div class="input-group-qw cur_input_exchange">
                                                        <div class="input-group">
                                                            <input class="form-control"  name="currency[rate_to][]" type="text" value=""/>
                                                            <span class="input-group-addon">{$currency->sign}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="turbo_list_boding turbo_list_status"></div>
                                        <div class="turbo_list_setting cur_settings"></div>
                                        <div class="turbo_list_boding turbo_list_close"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="action" class="turbo_list_footer">
                            <div class="turbo_list_foot_left"></div>
                            <input type=hidden name=recalculate value='0'>
                            <input type=hidden name=action value=''>
                            <input type=hidden name=action_id value=''>
                            <button id="apply_action" type="submit" class="btn btn_small btn_green">
                                {include file='svg_icon.tpl' svgId='checked'}
                                <span>Применить</span>
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-lg-12 col-md-12 col-sm-12">
        <div class="boxed boxed_attention">
            <div class="">
               Количество десятичных знаков дробной части цены влияет только на ОТОБРАЖЕНИЕ цен.
               Все расчеты ведутся с неокругленными данными.
               Это может привести к визуальным ошибкам при конвертации валют и применении скидок.
            </div>
        </div>
    </div>
</div>

<script>
    var general_confirm_delete = 'Подтвердите удаление';
    var сurrency_recalculate = 'Пересчитать все цены в ';
    var сurrency_recalculate_rate = ' по текущему курсу?';
</script>

{* On document load *}
{literal}
<script>
    $(function() {

        // Добавление валюты
        var curr = $('#new_currency').clone(true);
        $('#new_currency').remove().removeAttr('id');
        $('a#add_currency').click(function() {
            $(curr).clone(true).appendTo('#currencies_block').fadeIn('slow').find("input[name*=currency][name*=name]").focus();
            return false;
        });

        $(document).on("click", ".fn_remove_currency ", function () {
            $('input[type="hidden"][name="action"]').val('delete');
            $('input[type="hidden"][name="action_id"]').val($(this).data("id"));
            $(".fn_form_list").submit();
        });

        // Запоминаем id первой валюты, чтобы определить изменение базовой валюты
        var base_currency_id = $('input[name*="currency[id]"]').val();

        $(".fn_form_list").submit(function() {
            if($('input[type="hidden"][name="action"]').val()=='delete' && !confirm(general_confirm_delete)) {
                return false;
            }
            if(base_currency_id != $('input[name*="currency[id]"]:first').val() && confirm(сurrency_recalculate +$('input[name*="name"]:first').val()+ сurrency_recalculate_rate, 'msgBox Title'))
                $('input[name="recalculate"]').val(1);
        });

    });
</script>
{/literal}