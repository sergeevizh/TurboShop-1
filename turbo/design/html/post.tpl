{if $post->id}
    {$meta_title = $post->name scope=parent}
{else}
    {$meta_title = 'Новая запись в блоге' scope=parent}
{/if}

<div class="row">
    <div class="col-lg-12 col-md-12">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                {if !$post->id}
                    Добавление записи
                {else}
                    {$post->name|escape}
                {/if}
            </div>
            {if $post->id}
            <div class="box_btn_heading">
                <a class="btn btn_small btn-info add" target="_blank" href="../blog/{$post->url}">
                    {include file='svg_icon.tpl' svgId='icon_desktop'}
                    <span>Открыть на сайте</span>
                </a>
            </div>
            {/if}
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
                    Запись добавлена
                {elseif $message_success == 'updated'}
                    Запись обновлена
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
                {if $message_error == 'url_exists'}
                    Запись с таким URL уже существует
                {elseif $message_error=='empty_name'}
                    Введите название
                {elseif $message_error == 'empty_url'}
                    Введите URL
                {elseif $message_error == 'url_wrong'}
                    URL не должен начинаться или заканчиваться символом "-"
                {else}
                    {$message_error|escape}
                {/if}
            </div>
        </div>
    </div>
</div>
{/if}

<form method=post enctype="multipart/form-data" class="fn_fast_button">
    <input type="hidden" name="session_id" value="{$smarty.session.id}" />
    
    <div class="row">
        <div class="col-xs-12 ">
            <div class="boxed match_matchHeight_true">
                <div class="row d_flex">
                    <div class="col-lg-10 col-md-9 col-sm-12">
                        <div class="heading_label">
                            Название
                        </div>
                        <div class="form-group">
                            <input class="form-control" name="name" type="text" value="{$post->name|escape}"/>
                            <input name="id" type="hidden" value="{$post->id|escape}"/>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-lg-6 col-md-10">
                                <div class="">
                                    <div class="input-group">
                                        <span class="input-group-addon">URL</span>
                                        <input name="url" class="fn_meta_field form-control fn_url {if $post->id}fn_disabled{/if}" {if $post->id}readonly=""{/if} type="text" value="{$post->url|escape}" />
                                        <input type="checkbox" id="block_translit" class="hidden" value="1" {if $post->id}checked=""{/if}>
                                        <span class="input-group-addon fn_disable_url">
                                            {if $post->id}
                                            <i class="fa fa-lock"></i>
                                            {else}
                                            <i class="fa fa-lock fa-unlock"></i>
                                            {/if}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-3 col-sm-12">
                        <div class="activity_of_switch">
                            <div class="activity_of_switch_item"> {* row block *}
                                <div class="turbo_switch clearfix">
                                    <label class="switch_label">Активность</label>
                                    <label class="switch switch-default">
                                        <input class="switch-input" name="visible" value='1' type="checkbox" id="visible_checkbox" {if $post->visible}checked=""{/if}/>
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
        <div class="col-lg-3 col-md-12 pr-0">
            <div class="boxed fn_toggle_wrap min_height_210px">
                <div class="heading_box">
                    Изображение
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
                    </div>
                </div>
                <div class="toggle_body_wrap on fn_card">
                    <ul class="brand_images_list">
                        <li class="brand_image_item">
                            {if $post->image}
                            <input type="hidden" class="fn_accept_delete" name="delete_image" value="">
                            <div class="fn_parent_image2">
                                <div class="category_image image_wrapper fn_image_wrapper2 text-xs-center">
                                    <a href="javascript:;" class="fn_delete_item remove_image"></a>
                                    <img src="{$post->image|resize_posts:300:120}" alt="" />
                                </div>
                            </div>
                            {else}
                            <div class="fn_parent_image2"></div>
                            {/if}
                            <div class="fn_upload_image2 dropzone_block_image {if $post->image} hidden{/if}">
                                <i class="fa fa-plus font-5xl" aria-hidden="true"></i>
                                <input class="dropzone_image2" name="image" type="file" />
                            </div>
                            <div class="category_image image_wrapper fn_image_wrapper2 fn_new_image2 text-xs-center">
                                <a href="javascript:;" class="fn_delete_item remove_image"></a>
                                <img src="" alt="" />
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-12 pr-0">
            <div class="boxed fn_toggle_wrap min_height_210px">
                <div class="heading_box">
                    Параметры записи
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12 toggle_body_wrap on fn_card">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="">
                                    <div class="heading_label">Дата</div>
                                    <div class="">
                                        <input name="date" class="form-control" type="text" value="{$post->date|date}" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6 col-md-12">
            <div class="boxed match fn_toggle_wrap min_height_210px">
                <div class="heading_box">
                    Мета-данные
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
                    </div>
                </div>
                <div class="toggle_body_wrap on fn_card row">
                    <div class="col-lg-6 col-md-6">
                        <div class="heading_label" >Meta-title</div>
                        <input name="meta_title" class="form-control fn_meta_field mb-h" type="text" value="{$post->meta_title|escape}" />
                        <div class="heading_label" >Meta-keywords</div>
                        <input name="meta_keywords" class="form-control fn_meta_field mb-h" type="text" value="{$post->meta_keywords|escape}" />
                    </div>
                    
                    <div class="col-lg-6 col-md-6 pl-0">
                        <div class="heading_label" >Meta-description</div>
                        <textarea name="meta_description" class="form-control turbo_textarea fn_meta_field">{$post->meta_description|escape}</textarea>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12 col-md-12">
            <div class="boxed match fn_toggle_wrap tabs">
                <div class="heading_tabs">
                    <div class="tab_navigation">
                        <a href="#tab1" class="heading_box tab_navigation_link">Краткое описание</a>
                        <a href="#tab2" class="heading_box tab_navigation_link">Полное описание</a>
                    </div>
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
                    </div>
                </div>
                <div class="toggle_body_wrap on fn_card">
                    <div class="tab_container">
                        <div id="tab1" class="tab">
                            <textarea name="annotation" id="annotation" class="editor_small">{$post->annotation|escape}</textarea>
                        </div>
                        <div id="tab2" class="tab">
                            <textarea id="fn_editor" name="body" class="editor_large fn_editor_class">{$post->text|escape}</textarea>
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
<!-- Основная форма (The End) -->

{* Подключаем Tiny MCE *}
{include file='tinymce_init.tpl'}
{* On document load *}
{literal}
<script src="design/js/jquery/datepicker/jquery.ui.datepicker-ru.js"></script>
<script src="design/js/autocomplete/jquery.autocomplete-min.js"></script>
<script>
    $(window).on("load", function() {
        
        $('input[name="date"]').datepicker({
            regional:'ru'
        });
        
    });
</script>
{/literal}
