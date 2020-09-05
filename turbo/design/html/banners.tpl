{* Title *}
{$meta_title= 'Группы баннеров' scope=parent}

<div class="row">
    <div class="col-lg-7 col-md-7">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                Группы баннеров
            </div>
            <div class="box_btn_heading">
                <a class="btn btn_small btn-info" href="{url module=BannerAdmin return=$smarty.server.REQUEST_URI}">
                    {include file='svg_icon.tpl' svgId='plus'}
                    <span>Добавить группу</span>
                </a>
            </div>
        </div>
    </div>
</div>

<div class="boxed fn_toggle_wrap">
    {if $banners}
    <div class="categories">
        <form class="fn_form_list" method="post">
            <input type="hidden" name="session_id" value="{$smarty.session.id}">
            <div class="turbo_list products_list fn_sort_list">
                <div class="turbo_list_head">
                    <div class="turbo_list_heading turbo_list_drag"></div>
                    <div class="turbo_list_heading turbo_list_check">
                        <input class="hidden_check fn_check_all" type="checkbox" id="check_all_1" name="" value=""/>
                        <label class="turbo_ckeckbox" for="check_all_1"></label>
                    </div>
                    <div class="turbo_list_heading turbo_list_features_name">Название группы</div>
                    <div class="turbo_list_heading turbo_list_brands_tag">Отображение</div>
                    <div class="turbo_list_heading turbo_list_status">Активность</div>
                    <div class="turbo_list_heading turbo_list_close"></div>
                </div>
                <div class="banners_groups_wrap turbo_list_body features_wrap sortable">
                    {foreach $banners as $banner}
                    <div class="fn_row turbo_list_body_item fn_sort_item">
                        <div class="turbo_list_row">
                            <input type="hidden" name="positions[{$banner->id}]" value="{$banner->position}">
                            
                            <div class="turbo_list_boding turbo_list_drag move_zone">
                                {include file='svg_icon.tpl' svgId='drag_vertical'}
                            </div>
                            
                            <div class="turbo_list_boding turbo_list_check">
                                <input class="hidden_check" type="checkbox" id="id_{$banner->id}" name="check[]" value="{$banner->id}"/>
                                <label class="turbo_ckeckbox" for="id_{$banner->id}"></label>
                            </div>
                            
                            <div class="turbo_list_boding turbo_list_features_name">
                                <a class="link" href="{url module=BannerAdmin id=$banner->id return=$smarty.server.REQUEST_URI}">
                                    {$banner->name|escape}
                                </a>
                            </div>
                            
                            <div class="turbo_list_boding turbo_list_brands_tag">
                                <div class="wrap_tags">
                                    {if $banner->show_all_pages}
                                    <span class="tag tag-success">На всех страницах</span>
                                    {/if}
                                    {if !$banner->show_all_pages && $banner->category_show}
                                        <div>
                                            <span class="text_dark text_700 font_12">Категории:</span>
                                            {foreach $banner->category_show as $cat_show}
                                                <span class="tag tag-primary">{$cat_show->name|escape}</span>
                                            {/foreach}
                                        </div>
                                    {/if}
                                    {if !$banner->show_all_pages && $banner->brands_show}
                                        <div>
                                            <span class="text_dark text_700 font_12">Бренды</span>
                                            {foreach $banner->brands_show as $brand_show}
                                                <span class="tag tag-warning">{$brand_show->name|escape}</span>
                                            {/foreach}
                                        </div>
                                    {/if}
                                    {if !$banner->show_all_pages && $banner->page_show}
                                    <div>
                                        <span class="text_dark text_700 font_12">Страницы:</span>
                                        {foreach $banner->page_show as $page_show}
                                        <span class="tag tag-pink">{$page_show->name|escape}</span>
                                        {/foreach}
                                    </div>
                                    {/if}
                                </div>
                            </div>
                            
                            <div class="turbo_list_boding turbo_list_status">
                                {*visible*}
                                <div class="col-lg-4 col-md-3">
                                    <label class="switch switch-default">
                                        <input class="switch-input fn_ajax_action {if $banner->visible}fn_active_class{/if}" data-module="banner" data-action="visible" data-id="{$banner->id}" name="visible" value="1" type="checkbox"  {if $banner->visible}checked=""{/if}/>
                                        <span class="switch-label"></span>
                                        <span class="switch-handle"></span>
                                    </label>
                                </div>
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
                        <div class="turbo_list_heading turbo_list_drag"></div>
                        <div class="turbo_list_heading turbo_list_check">
                            <input class="hidden_check fn_check_all" type="checkbox" id="check_all_2" name="" value=""/>
                            <label class="turbo_ckeckbox" for="check_all_2"></label>
                        </div>
                        <div class="turbo_list_option">
                            <select name="action" class="selectpicker col-lg-12 col-md-12">
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
    </div>
    {else}
    <div class="heading_box mt-1">
        <div class="text_grey">Нет банннеров</div>
    </div>
    {/if}
</div>