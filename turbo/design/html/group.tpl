{if $group->id}
   {$meta_title = $group->name scope=parent}
{else}
   {$meta_title = 'Новая группа' scope=parent}
{/if}

<div class="row">
    <div class="col-lg-12 col-md-12">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                {if !$group->id}
                    Новая группа
                {else}
                    {$group->name|escape}
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
                    {if $message_success=='added'}
                        Группа добавлена
                    {elseif $message_success=='updated'}
                        Группа изменена
                    {else}
                        {$message_success|escape}
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

<form method="post" enctype="multipart/form-data">
    <input type="hidden" name="session_id" value="{$smarty.session.id}">

    <div class="row">
        <div class="col-lg-12">
            <div class="boxed match_matchHeight_true">
                <div class="row">
                    <div class="col-lg-6 col-md-12">
                        <div class="heading_label">
                            Название группы
                        </div>
                        <div class="form-group">
                            <input class="form-control" name="name" type="text" value="{$group->name|escape}"/>
                            <input name="id" type="hidden" value="{$group->id|escape}"/>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-12">
                        <div class="heading_label">
                            Скидка
                        </div>
                        <div class="form-group">
                             <input name="discount" class="form-control" type="text" value="{$group->discount|escape}" />
                        </div>
                    </div>
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
