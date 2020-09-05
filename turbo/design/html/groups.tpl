{* Title *}
{$meta_title='Группы пользователей' scope=parent}

<div class="row">
    <div class="col-lg-8 col-md-8">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                Группы пользователей ({$groups|count})
            </div>
            <div class="box_btn_heading">
                <a class="btn btn_small btn-info" href="index.php?module=GroupAdmin">
                    {include file='svg_icon.tpl' svgId='plus'}
                    <span>Добавить группу</span>
                </a>
            </div>
        </div>
    </div>
</div>

<div class="boxed fn_toggle_wrap">
    {if $groups}
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12">
                <form class="fn_form_list" method="post">
                    <input type="hidden" name="session_id" value="{$smarty.session.id}">

                    <div class="groups_wrap turbo_list">
                        <div class="turbo_list_head">
                            <div class="turbo_list_heading turbo_list_check">
                                <input class="hidden_check fn_check_all" type="checkbox" id="check_all_1" name="" value=""/>
                                <label class="turbo_ckeckbox" for="check_all_1"></label>
                            </div>
                            <div class="turbo_list_heading turbo_list_usergroups_name">Имя группы</div>
                            <div class="turbo_list_heading turbo_list_usergroups_sale">Процент скидки</div>
                            <div class="turbo_list_heading turbo_list_close"></div>
                        </div>
                        <div class="turbo_list_body">
                            {foreach $groups as $group}
                                <div class="fn_row turbo_list_body_item body_narrow">
                                    <div class="turbo_list_row narrow">
                                        <div class="turbo_list_boding turbo_list_check">
                                            <input class="hidden_check" type="checkbox" id="id_{$group->id}" name="check[]" value="{$group->id}"/>
                                            <label class="turbo_ckeckbox" for="id_{$group->id}"></label>
                                        </div>
                                        <div class="turbo_list_boding turbo_list_usergroups_name">
                                            <a href="{url module=GroupAdmin id=$group->id}">
                                                {$group->name|escape}
                                            </a>
                                        </div>
                                        <div class="turbo_list_boding turbo_list_usergroups_sale">
                                            <span class="tag tag-danger">Скидка {$group->discount} %</span>
                                        </div>
                                       <div class="turbo_list_boding turbo_list_close">
                                            {*delete*}
                                            <button data-hint="Удалить группу" type="button" class="btn_close fn_remove hint-bottom-right-t-info-s-small-mobile  hint-anim" data-toggle="modal" data-target="#fn_action_modal" onclick="success_action($(this));">
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
            </div>
        </div>
    {else}
        <div class="heading_box mt-1">
            <div class="text_grey">Нет групп пользователей</div>
        </div>
    {/if}
</div>