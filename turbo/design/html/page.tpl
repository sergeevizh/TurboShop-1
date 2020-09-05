{if $page->id}
    {$meta_title = $page->name scope=parent}
{else}
    {$meta_title = 'Новая страница' scope=parent}
{/if}

<div class="row">
    <div class="col-lg-12 col-md-12">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                {if !$page->id}
                    Добавление страницы
                {else}
                    {$page->name|escape}
                {/if}
            </div>
            {if $page->id}
            <div class="box_btn_heading">
                <a class="btn btn_small btn-info add" target="_blank" href="../{$page->url}">
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
                    Страница добавлена
                {elseif $message_success == 'updated'}
                    Страница обновлена
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
                    Страница с таким URL уже существует
                {elseif $message_error=='empty_name'}
                    Введите название
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

<form method="post" enctype="multipart/form-data">
    <input type=hidden name="session_id" value="{$smarty.session.id}">
    <div class="row">
        <div class="col-xs-12 ">
            <div class="boxed match_matchHeight_true">
                <div class="row d_flex">
                    <div class="col-lg-10 col-md-9 col-sm-12">
                        <div class="heading_label">
                            Название
                        </div>
                        <div class="form-group">
                            <input class="form-control" name="name" type="text" value="{$page->name|escape}"/>
                            <input name="id" type="hidden" value="{$page->id|escape}"/>
                        </div>
                        <div class="heading_label">
                            Название пункта в меню
                        </div>
                        <div class="form-group">
                            <input class="form-control" name="header" type="text" value="{$page->header|escape}"/>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-lg-6 col-md-10">
                                <div class="mt-h mb-h">
                                    <div class="input-group">
                                        <span class="input-group-addon">URL</span>
                                        <input name="url" class="fn_meta_field form-control fn_url {if $page->id}fn_disabled{/if}" {if $page->id}readonly=""{/if} type="text" value="{$page->url|escape}" />
                                        <input type="checkbox" id="block_translit" class="hidden" value="1" {if $page->id}checked=""{/if}>
                                        <span class="input-group-addon fn_disable_url">
                                            {if $page->id}
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
                                        <input class="switch-input" name="visible" value='1' type="checkbox" id="visible_checkbox" {if $page->visible}checked=""{/if}/>
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
        <div class="col-lg-4 col-md-12 pr-0">
            <div class="boxed fn_toggle_wrap min_height_210px">
                <div class="heading_box">
                    Параметры меню
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
                    </div>
                </div>
                <div class="toggle_body_wrap on fn_card">
                    <div class="heading_label">Меню:</div>
                    <select name="menu_id" class="selectpicker mb-1">
                        {foreach $menus as $m}
                        <option value='{$m->id}' {if $page->menu_id == $m->id}selected{/if}>{$m->name|escape}</option>
                        {/foreach}
                    </select>
                    <div class="heading_label">Корневая страница:</div>
                    <select name="parent_id" class="selectpicker">
                        <option value='0'>Страница не выбрана</option>
                        {function name=page_select level=0}
                            {foreach from=$pages item=p}
                                {if $page->id != $p->id}
                                    <option value='{$p->id}' {if $page->parent_id == $p->id}selected{/if}>{section name=sp loop=$level}--{/section}{$p->name}</option>
                                    {page_select pages=$p->subpages level=$level+1}
                                {/if}
                            {/foreach}
                        {/function}
                        {page_select pages=$pages}
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-8 col-md-12">
            <div class="boxed fn_toggle_wrap min_height_210px">
                <div class="heading_box">
                    Мета-данные
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
                    </div>
                </div>
                <div class="toggle_body_wrap on fn_card row">
                    <div class="col-lg-6 col-md-6">
                        <div class="heading_label" >Meta-title</div>
                        <input name="meta_title" class="form-control fn_meta_field mb-h" type="text" value="{$page->meta_title|escape}" />
                        <div class="heading_label" >Meta-keywords</div>
                        <input name="meta_keywords" class="form-control fn_meta_field mb-h" type="text" value="{$page->meta_keywords|escape}" />
                    </div>
                    
                    <div class="col-lg-6 col-md-6 pl-0">
                        <div class="heading_label" >Meta-description</div>
                        <textarea name="meta_description" class="form-control turbo_textarea fn_meta_field">{$page->meta_description|escape}</textarea>
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
                            <textarea name="body" id="fn_editor" class="editor_small">{$page->body|escape}</textarea>
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