{* Title *}
{$meta_title='Способы оплаты' scope=parent}

<div class="row">
    <div class="col-lg-7 col-md-7">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                Способы оплаты
            </div>
            <div class="box_btn_heading">
                <a class="btn btn_small btn-info" href="{url module=PaymentMethodAdmin}">
                    {include file='svg_icon.tpl' svgId='plus'}
                    <span>Добавить способ оплаты</span>
                </a>
            </div>
        </div>
    </div>
</div>

<div class="boxed fn_toggle_wrap">
    {if $payment_methods}
        <form class="fn_form_list" method="post">
            <div class="turbo_list products_list fn_sort_list">
                <input type="hidden" name="session_id" value="{$smarty.session.id}">
                <div class="turbo_list_head">
                    <div class="turbo_list_boding turbo_list_drag"></div>
                    <div class="turbo_list_heading turbo_list_check">
                        <input class="hidden_check fn_check_all" type="checkbox" id="check_all_1" name="" value=""/>
                        <label class="turbo_ckeckbox" for="check_all_1"></label>
                    </div>
                    <div class="turbo_list_heading turbo_list_delivery_name">Название</div>
                    <div class="turbo_list_heading turbo_list_delivery_photo"></div>
                    <div class="turbo_list_heading turbo_list_delivery_condit"></div>
                    <div class="turbo_list_heading turbo_list_status">Активность</div>
                    <div class="turbo_list_heading turbo_list_close"></div>
                </div>
                <div class="deliveries_wrap turbo_list_body sortable">
                    {foreach $payment_methods as $payment_method}
                        <div class="fn_row turbo_list_body_item fn_sort_item body_narrow">
                            <div class="turbo_list_row narrow">
                                <input type="hidden" name="positions[{$payment_method->id}]" value="{$payment_method->position}">

                                <div class="turbo_list_boding turbo_list_drag move_zone">
                                    {include file='svg_icon.tpl' svgId='drag_vertical'}
                                </div>

                                <div class="turbo_list_boding turbo_list_check">
                                    <input class="hidden_check" type="checkbox" id="id_{$payment_method->id}" name="check[]" value="{$payment_method->id}"/>
                                    <label class="turbo_ckeckbox" for="id_{$payment_method->id}"></label>
                                </div>

                                <div class="turbo_list_boding turbo_list_delivery_name">
                                    <a href="{url module=PaymentMethodAdmin id=$payment_method->id return=$smarty.server.REQUEST_URI}">
                                        {$payment_method->name|escape}
                                    </a>
                                </div>
                                
                                <div class="turbo_list_boding turbo_list_delivery_photo"></div>
                                
                                <div class="turbo_list_boding turbo_list_delivery_condit"></div>
                                <div class="turbo_list_boding turbo_list_status">
                                    {*visible*}
                                    <label class="switch switch-default">
                                        <input class="switch-input fn_ajax_action {if $payment_method->enabled}fn_active_class{/if}" data-module="payment" data-action="enabled" data-id="{$payment_method->id}" name="visible" value="1" type="checkbox"  {if $payment_method->enabled}checked=""{/if}/>
                                        <span class="switch-label"></span>
                                        <span class="switch-handle"></span>
                                    </label>
                                </div>

                                <div class="turbo_list_boding turbo_list_close">
                                    {*delete*}
                                    <button data-hint="Удалить" type="button" class="btn_close fn_remove hint-bottom-right-t-info-s-small-mobile  hint-anim" data-toggle="modal" data-target="#fn_action_modal" onclick="success_action($(this));">
                                        {include file='svg_icon.tpl' svgId='delete'}
                                    </button>
                                </div>
                            </div>
                        </div>
                    {/foreach}
                </div>
                <div class="turbo_list_footer fn_action_block">
                    <div class="turbo_list_foot_left">
                        <div class="turbo_list_boding turbo_list_drag"></div>
                        <div class="turbo_list_heading turbo_list_check">
                            <input class="hidden_check fn_check_all" type="checkbox" id="check_all_2" name="" value=""/>
                            <label class="turbo_ckeckbox" for="check_all_2"></label>
                        </div>
                        <div class="turbo_list_option">
                            <select name="action" class="selectpicker">
                                <option value="enable">Включить</option>
                                <option value="disable">Выключить</option>
                                <option value="delete">Удалить</option>
                            </select>
                        </div>
                    </div>
                    <button type="submit" class="btn btn_small btn_green">
                        {include file='svg_icon.tpl' svgId='checked'}
                        <span>Применить</span>
                    </button>
                </div>
            </div>
        </form>
    {else}
        <div class="heading_box mt-1">
            <div class="text_grey">Нет способов оплаты</div>
        </div>
    {/if}
</div>
