{* Title *}
{$meta_title='Купоны' scope=parent}

<div class="row">
    <div class="col-lg-7 col-md-7">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                {if $coupons_count}
                   {$coupons_count|plural:'Купон':'Купонов':'Купона'} - {$coupons_count}
                {/if}
            </div>
            <div class="box_btn_heading">
                <a class="btn btn_small btn-info" href="{url module=CouponAdmin return=$smarty.server.REQUEST_URI}">
                    {include file='svg_icon.tpl' svgId='plus'}
                    <span>Новый купон</span>
                </a>
            </div>
        </div>
    </div>
</div>

{if $coupons}
    <div class="boxed fn_toggle_wrap">
        <form class="fn_form_list" method="post">
            <input type="hidden" name="session_id" value="{$smarty.session.id}">

            <div class="turbo_list products_list fn_sort_list">
                <div class="turbo_list_head">
                    <div class="turbo_list_heading turbo_list_check">
                        <input class="hidden_check fn_check_all" type="checkbox" id="check_all_1" name="" value=""/>
                        <label class="turbo_ckeckbox" for="check_all_1"></label>
                    </div>
                    <div class="turbo_list_heading turbo_list_coupon_name">Название купона</div>
                    <div class="turbo_list_heading turbo_list_coupon_sale">Скидка</div>
                    <div class="turbo_list_heading turbo_list_coupon_condit">Условия</div>
                    <div class="turbo_list_heading turbo_list_coupon_validity">Срок действия</div>
                    <div class="turbo_list_heading turbo_list_coupon_disposable">Одноразовый</div>
                  
                    <div class="turbo_list_heading turbo_list_close"></div>
                </div>
                
                <div class="turbo_list_body fn_coupon_wrap">
                    {foreach $coupons as $coupon}
                        <div class="fn_row turbo_list_body_item body_narrow">
                            <div class="turbo_list_row narrow">
                                <div class="turbo_list_boding turbo_list_check">
                                    <input class="hidden_check" type="checkbox" id="id_{$coupon->id}" name="check[]" value="{$coupon->id}"/>
                                    <label class="turbo_ckeckbox" for="id_{$coupon->id}"></label>
                                </div>
                                <div class="turbo_list_boding turbo_list_coupon_name">
                                    <span class="text_dark">
                                        <a href="{url module=CouponAdmin id=$coupon->id return=$smarty.server.REQUEST_URI}">{$coupon->code}</a>
                                    </span>
                                    <div class="hidden-lg-up mt-q">
                                        {if $coupon->expire}
                                            {if $smarty.now|date_format:'%Y%m%d' <= $coupon->expire|date_format:'%Y%m%d'}
                                                <span class="tag tag-primary">
                                                    Действует до {$coupon->expire|date}
                                                </span>
                                            {else}
                                                <span class="tag tag-danger">
                                                    Истёк {$coupon->expire|date}
                                                </span>
                                            {/if}
                                        {else}
                                            <span class="tag tag-warning">
                                                {include file='svg_icon.tpl' svgId='infinity'}
                                            </span>
                                        {/if}
                                        {if $coupon->min_order_price>0}
                                            <span class="tag tag-success">
                                                Для заказов от {$coupon->min_order_price|escape} {$currency->sign|escape}
                                            </span>
                                        {/if}
                                        <div class="mt-q">
                                            {if $coupon->single}
                                                Одноразовый
                                            {else}
                                                Многоразовый
                                            {/if}
                                        </div>

                                    </div>
                                </div>
                                <div class="turbo_list_boding turbo_list_coupon_sale">
                                    {$coupon->value*1}
                                    {if $coupon->type=='absolute'}
                                        {$currency->sign|escape}
                                    {else}
                                        %
                                    {/if}
                                </div>
                                <div class="turbo_list_boding turbo_list_coupon_condit">
                                    {if $coupon->min_order_price>0}
                                        <div class="">
                                            Для заказов от {$coupon->min_order_price|escape} {$currency->sign|escape}
                                        </div>
                                    {else}
                                       <div class="">
                                          -
                                        </div>
                                    {/if}
                                </div>
                                <div class="turbo_list_boding turbo_list_coupon_validity">
                                    <div class="">
                                        {if $coupon->expire}
                                            {if $smarty.now|date_format:'%Y%m%d' <= $coupon->expire|date_format:'%Y%m%d'}
                                                Действует до {$coupon->expire|date}
                                            {else}
                                                Истёк {$coupon->expire|date}
                                            {/if}
                                        {else}
                                            {include file='svg_icon.tpl' svgId='infinity'}
                                        {/if}
                                    </div>
                                </div>
                                <div class="turbo_list_boding turbo_list_coupon_disposable">
                                    {if $coupon->single}
                                        Да
                                    {else}
                                        Нет
                                    {/if}
                                </div>
                              
                                <div class="turbo_list_boding turbo_list_close">
                                    {*delete*}
                                    <button data-hint="Удалить купон" type="button" class="btn_close fn_remove hint-bottom-right-t-info-s-small-mobile  hint-anim" data-toggle="modal" data-target="#fn_action_modal" onclick="success_action($(this));">
                                        {include file='svg_icon.tpl' svgId='delete'}
                                    </button>
                                </div>
                            </div>
                        </div>
                    {/foreach}
                </div>
                <div class="turbo_list_footer fn_action_block">
                    <div class="turbo_list_foot_left">
                        <div class="turbo_list_heading turbo_list_check">
                            <input class="hidden_check fn_check_all" type="checkbox" id="check_all_2" name="" value=""/>
                            <label class="turbo_ckeckbox" for="check_all_2"></label>
                        </div>
                        <div class="turbo_list_option">
                            <select name="action" class="selectpicker">
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
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm 12 txt_center">
				{include file='pagination.tpl'}
			</div>
		</div>
    </div>
{/if}