{* Title *}
{if $banner}
    {$meta_title=$banner->name scope=parent}
{else}
    {$meta_title='Баннеры'  scope=parent}
{/if}

<div class="row">
    <div class="col-lg-7 col-md-7">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                {if $banners_images_count}
                    Баннеры - {$banners_images_count}
                {elseif $keyword}
                    Баннеры - {$banners_images_count}
                {else}
                    Нет баннеров
                {/if}
            </div>
            <div class="box_btn_heading">
                <a class="btn btn_small btn-info" href="{url module=BannersImageAdmin return=$smarty.server.REQUEST_URI}">
                    {include file='svg_icon.tpl' svgId='plus'}
                    <span>Добавить баннер</span>
                </a>
            </div>
        </div>
    </div>
</div>

<div class="boxed fn_toggle_wrap">
    <div class="row">
        <div class="col-lg-12 col-md-12 ">
            <div class="boxed_sorting">
                <div class="row">
                    <div class="col-md-4 col-lg-4 col-sm-12">
                        <div>
                            <select class="selectpicker" onchange="location = this.value;">
                                <option value="{url brand_id=null banner_id=null keyword=null page=null filter=null}" {if !$filter}{/if}>Все баннеры</option>
                                <option value="{url keyword=null brand_id=null banner_id=null page=null filter='visible'}" {if $filter=='visible'}selected{/if}>Включенные баннера</option>
                                <option value="{url keyword=null brand_id=null banner_id=null page=null filter='hidden'}" {if $filter=='hidden'}selected{/if}>Выключенные баннера</option>
                            </select>
                        </div>
                    </div>
                    {if $banners}
                    <div class="col-md-4 col-lg-4 col-sm-12">
                        <select class="selectpicker" onchange="location = this.value;">
                            <option value="{url banner_id=null brand_id=null}" {if !$banner->id}selected{/if}>Все группы</option>
                            {foreach $banners as $b}
                            <option value="{url keyword=null page=null banner_id=$b->id}" {if $banner->id == $b->id}selected{/if}>{$b->name|escape}</option>
                            {/foreach}
                        </select>
                    </div>
                    {/if}
                </div>
            </div>
        </div>
    </div>
    {if $banners_images}
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <form class="fn_form_list" method="post">
                <div id="main_list" class=" turbo_list products_list fn_sort_list">
                    <input type="hidden" name="session_id" value="{$smarty.session.id}" />
                    <div class="turbo_list_head">
                        <div class="turbo_list_heading turbo_list_drag"></div>
                        <div class="turbo_list_heading turbo_list_check">
                            <input class="hidden_check fn_check_all" type="checkbox" id="check_all_1" name="" value=""/>
                            <label class="turbo_ckeckbox" for="check_all_1"></label>
                        </div>
                        <div class="turbo_list_heading turbo_list_brands_photo">Изображение</div>
                        <div class="turbo_list_heading turbo_list_bransimages_name">Название</div>
                        <div class="turbo_list_heading turbo_list_brands_group">Группа баннеров</div>
                        <div class="turbo_list_heading turbo_list_status">Активность</div>
                        <div class="turbo_list_heading turbo_list_close"></div>
                    </div>
                    
                    <div class="banners_wrap turbo_list_body features_wrap sortable">
                        {foreach $banners_images as $banners_image}
                        <div class="fn_row turbo_list_body_item fn_sort_item">
                            <div class="turbo_list_row">
                                <input type="hidden" name="positions[{$banners_image->id}]" value="{$banners_image->position}">
                                
                                <div class="turbo_list_boding turbo_list_drag move_zone">
                                    {include file='svg_icon.tpl' svgId='drag_vertical'}
                                </div>
                                
                                <div class="turbo_list_boding turbo_list_check">
                                    <input class="hidden_check" type="checkbox" id="id_{$banners_image->id}" name="check[]" value="{$banners_image->id}"/>
                                    <label class="turbo_ckeckbox" for="id_{$banners_image->id}"></label>
                                </div>
                                
                                <div class="turbo_list_boding turbo_list_brands_photo">
                                    {if $banners_image->image}
                                        <a href="{url module=BannersImageAdmin id=$banners_image->id return=$smarty.server.REQUEST_URI}">
                                            <img src="{$banners_image->image|resize_banners:100:100}"/>
                                        </a>
                                    {else}
                                        <img height="100" width="100" src="design/images/no_image.png"/>
                                    {/if}
                                </div>
                                
                                <div class="turbo_list_boding turbo_list_bransimages_name">
                                    <a class="link" href="{url module=BannersImageAdmin id=$banners_image->id return=$smarty.server.REQUEST_URI}">
                                        {$banners_image->name|escape}
                                    </a>
                                    <div class="turbo_list_name_brand">
                                        {$img_url=$config->root_url|cat:'/'|cat:$config->banners_images_dir|cat:$banners_image->image}
                                        {assign var="info" value=$img_url|getimagesize}
                                        {$info.0} X {$info.1} px
                                    </div>
                                </div>
                                
                                <div class="turbo_list_boding turbo_list_brands_group">
                                    {if $banners}
                                    <select class="selectpicker" name=image_banners[{$banners_image->id}]">
                                        {foreach $banners as $b}
                                            <option value="{$b->id}"{if $b->id == $banners_image->banner_id} selected{/if}>{$b->name}</option>
                                        {/foreach}
                                    </select>
                                    {/if}
                                </div>
                                
                                <div class="turbo_list_boding turbo_list_status">
                                    {*visible*}
                                    <label class="switch switch-default">
                                        <input class="switch-input fn_ajax_action {if $banners_image->visible}fn_active_class{/if}" data-module="banners_image" data-action="visible" data-id="{$banners_image->id}" name="visible" value="1" type="checkbox"  {if $banners_image->visible}checked=""{/if}/>
                                        <span class="switch-label"></span>
                                        <span class="switch-handle"></span>
                                    </label>
                                </div>
                                <div class="turbo_list_boding turbo_list_close">
                                    {*delete*}
                                    <button data-hint="Удалить баннер" type="button" class="btn_close fn_remove hint-bottom-right-t-info-s-small-mobile  hint-anim" data-toggle="modal" data-target="#fn_action_modal" onclick="success_action($(this));">
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
                                <select name="action" class="selectpicker">
                                    {if $banners|count>1}
                                        {foreach $banners as $b}
                                            <option value="move_to_banner[{$b->id}]">Переместить в группу {$b->name|escape}</option>
                                        {/foreach}
                                    {/if}
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
    </div>
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm 12 txt_center">
            {include file='pagination.tpl'}
        </div>
    </div>
    {else}
    <div class="heading_box mt-1">
        <div class="text_grey">Нет баннеров</div>
    </div>
    {/if}
</div>