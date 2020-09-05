{$meta_title = "Настройки" scope=parent}

<div class="row">
    <div class="col-lg-7 col-md-7">
        <div class="heading_page">Настройки сайта</div>
    </div>
    <div class="col-lg-5 col-md-5 text-xs-right float-xs-right"></div>
</div>

{if $message_success}
<div class="row">
    <div class="col-lg-12 col-md-12 col-sm-12">
        <div class="boxed boxed_success">
            <div class="heading_box">
                {if $message_success == 'saved'}
                Настройки сохранены
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

<form method="post" enctype="multipart/form-data">
    <input type=hidden name="session_id" value="{$smarty.session.id}">
    <div class="row">
        <div class="col-lg-6 col-md-12 pr-0 ">
            <div class="boxed fn_toggle_wrap">
                <div class="heading_box">
                    Параметры
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
                    </div>
                </div>
                <div class="toggle_body_wrap on fn_card">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="heading_label">Название сайта</div>
                            <div class="mb-1">
                                <input name="site_name" class="form-control" type="text" value="{$settings->site_name|escape}" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="heading_label">Название компании</div>
                            <div class="mb-1">
                                <input name="company_name" class="form-control" type="text" value="{$settings->company_name|escape}" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="heading_label">Формат даты</div>
                            <div class="mb-1">
                                <input name="date_format" class="form-control" type="text" value="{$settings->date_format|escape}" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6 col-md-12">
            <div class="boxed fn_toggle_wrap">
                <div class="heading_box">
                    Оповещения
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
                    </div>
                </div>
                <div class="toggle_body_wrap on fn_card">
                    <div class="row">
                         <div class="col-md-6">
                            <div class="heading_label">Оповещение о заказах</div>
                            <div class="mb-1">
                                 <input name="order_email" class="form-control" type="text" value="{$settings->order_email|escape}" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="heading_label">Оповещение о комментариях</div>
                            <div class="mb-1">
                                <input name="comment_email" class="form-control" type="text" value="{$settings->comment_email|escape}" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="heading_label">Обратный адрес оповещений</div>
                            <div class="mb-1">
                                <input name="notify_from_email" class="form-control" type="text" value="{$settings->notify_from_email|escape}" />
                            </div>
                        </div>
						<div class="col-md-6">
                            <div class="heading_label">Восстановление пароля</div>
                            <div class="mb-1">
                                <input name="admin_email" class="form-control" type="text" value="{$settings->admin_email|escape}" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12 col-md-12">
            <div class="boxed fn_toggle_wrap ">
                <div class="heading_box">
                    Настройки каталога товаров
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
                    </div>
                </div>
                <div class="toggle_body_wrap on fn_card">
                    <div class="row">
                        <div class="col-lg-4 col-md-6">
                            <div class="heading_label">Товаров на странице сайта</div>
                            <div class="mb-1">
                                <input name="products_num" class="form-control" type="text" value="{$settings->products_num|escape}" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="heading_label">Максимум товаров в заказе</div>
                            <div class="mb-1">
                                <input name="max_order_amount" class="form-control" type="text" value="{$settings->max_order_amount|escape}" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="heading_label">Товаров на странице админки</div>
                            <div class="mb-1">
                                <input name="products_num_admin" class="form-control" type="text" value="{$settings->products_num_admin|escape}" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="heading_label">Единицы измерения товаров</div>
                            <div class="mb-1">
                                <input name="units" class="form-control" type="text" value="{$settings->units|escape}" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="heading_label">Разделитель копеек</div>
                            <div class="mb-1">
                                <select name="decimals_point" class="selectpicker">
                                    <option value='.' {if $settings->decimals_point == '.'}selected{/if}>точка: 12.45 {$currency->sign|escape}</option>
                                    <option value=',' {if $settings->decimals_point == ','}selected{/if}>запятая: 12,45 {$currency->sign|escape}</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="heading_label">Разделитель тысяч</div>
                            <div class="mb-1">
                                <select name="thousands_separator" class="selectpicker">
                                    <option value='' {if $settings->thousands_separator == ''}selected{/if}>без разделителя: 1245678 {$currency->sign|escape}</option>
                                    <option value=' ' {if $settings->thousands_separator == ' '}selected{/if}>пробел: 1 245 678 {$currency->sign|escape}</option>
                                    <option value=',' {if $settings->thousands_separator == ','}selected{/if}>запятая: 1,245,678 {$currency->sign|escape}</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12 col-md-12">
            <div class="boxed fn_toggle_wrap ">
                <div class="heading_box">
                    Настройки водяного знака
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
                    </div>
                </div>
                <div class="toggle_body_wrap on fn_card">
                    <div class="row">
                        <div class="col-lg-6 col-md-6">
                            <div class="boxed">
                                {if $config->watermark_file}
                                <div class="fn_parent_image">
                                    <div class="banner_image fn_image_wrapper text-xs-center">
                                        <a href="javascript:;" class="fn_delete_item remove_image"></a>
                                        <img class="watermark_image" src="{$config->root_url}/{$config->watermark_file}?{math equation='rand(10,10000)'}" alt="" />
                                    </div>
                                </div>
                                {else}
                                <div class="fn_parent_image"></div>
                                {/if}
                                <div class="fn_upload_image dropzone_block_image text-xs-center {if $config->watermark_file} hidden{/if}">
                                    <i class="fa fa-plus font-5xl" aria-hidden="true"></i>
                                    <input class="dropzone_image" name="watermark_file" type="file" />
                                </div>
                                <div class="image_wrapper fn_image_wrapper fn_new_image text-xs-center">
                                    <a href="javascript:;" class="fn_delete_item delete_image remove_image"></a>
                                    <img src="" alt="" />
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6">
                            <div class="row">
                                <div class="col-xs-12 fn_range_wrap">
                                    <div class="heading_label">
                                        Горизонтальное положение водяного знака
                                        <span class="font-weight-bold fn_show_range">{$settings->watermark_offset_x|escape}</span>
                                    </div>
                                    <div class="raiting_boxed">
                                        <input class="fn_range_value" type="hidden" value="{$settings->watermark_offset_x|escape}" name="watermark_offset_x" />
                                        <input class="fn_rating range_input" type="range" min="0" max="100" step="1" value="{$settings->watermark_offset_x|escape}" />
                                        <div class="raiting_range_number">
                                            <span class="float-xs-left">1%</span>
                                            <span class="float-xs-right">100%</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-12 fn_range_wrap">
                                    <div class="heading_label">
                                        Вертикальное положение водяного знака
                                        <span class="font-weight-bold fn_show_range">{$settings->watermark_offset_y|escape}</span>
                                    </div>
                                    <div class="raiting_boxed">
                                        <input class="fn_range_value" type="hidden" value="{$settings->watermark_offset_y|escape}" name="watermark_offset_y" />
                                        <input class="fn_rating range_input" type="range" min="0" max="100" step="1" value="{$settings->watermark_offset_y|escape}" />
                                        <div class="raiting_range_number">
                                            <span class="float-xs-left">1</span>
                                            <span class="float-xs-right">100</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-12 fn_range_wrap">
                                    <div class="heading_label">
                                        Прозрачность знака
                                        <span class="font-weight-bold fn_show_range">{$settings->watermark_transparency}</span>
                                    </div>
                                    <div class="raiting_boxed">
                                        <input class="fn_range_value" type="hidden" value="{$settings->watermark_transparency}" name="watermark_transparency" />
                                        <input class="fn_rating range_input" type="range" min="0" max="100" step="1" value="{$settings->watermark_transparency|escape}" />
                                        <div class="raiting_range_number">
                                            <span class="float-xs-left">1</span>
                                            <span class="float-xs-right">100</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-12 fn_range_wrap">
                                    <div class="heading_label">
                                        Резкость изображений (рекомендуется 20%)
                                        <span class="font-weight-bold fn_show_range">{$settings->images_sharpen}</span>
                                    </div>
                                    <div class="raiting_boxed">
                                        <input class="fn_range_value" type="hidden" value="{$settings->images_sharpen}" name="images_sharpen" />
                                        <input class="fn_rating range_input" type="range" min="0" max="100" step="1" value="{$settings->images_sharpen|escape}" />
                                        <div class="raiting_range_number">
                                            <span class="float-xs-left">1</span>
                                            <span class="float-xs-right">100</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12 col-md-12 ">
                            <button type="submit" class="btn btn_small btn_green float-md-right">
                                {include file='svg_icon.tpl' svgId='checked'}
                                <span>Применить</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
<script>
    $(document).on("input", ".fn_rating", function () {
        $(this).closest(".fn_range_wrap").find(".fn_show_range").html($(this).val());
        $(this).closest(".fn_range_wrap").find(".fn_range_value").val($(this).val());
    });
</script>