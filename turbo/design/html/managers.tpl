{* Title *}
{$meta_title='Менеджеры' scope=parent}

<div class="row">
    <div class="col-lg-7 col-md-7">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                {$managers_count} {$managers_count|plural:'менеджер':'менеджеров':'менеджера'}
            </div>
            <div class="box_btn_heading">
                <a class="btn btn_small btn-info" href="{url module=ManagerAdmin}">
                    {include file='svg_icon.tpl' svgId='plus'}
                    <span>Добавить менеджера</span>
                </a>
            </div>
        </div>
    </div>
</div>

<div class="boxed fn_toggle_wrap">
    {if $managers}
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12">
                <form method="post" class="fn_form_list">
                    <input type="hidden" name="session_id" value="{$smarty.session.id}">

                    <div class="managers_wrap turbo_list">
                        <div class="turbo_list_head">
                            <div class="turbo_list_heading turbo_list_check">
                                <input class="hidden_check fn_check_all" type="checkbox" id="check_all_1" name="" value=""/>
                                <label class="turbo_ckeckbox" for="check_all_1"></label>
                            </div>
                            <div class="turbo_list_heading turbo_list_manager_name">Название</div>
                            <div class="turbo_list_heading turbo_list_close"></div>
                        </div>

                        <div class="turbo_list_body">
                            {foreach $managers as $manager_admin}
                                <div class="fn_row turbo_list_body_item body_narrow">
                                    <div class="turbo_list_row narrow">
                                        <div class="turbo_list_boding turbo_list_check">
                                            <input class="hidden_check" type="checkbox" id="id_{$manager_admin->id}" name="check[]" value="{$manager_admin->id}"/>
                                            <label class="turbo_ckeckbox" for="id_{$manager_admin->id}"></label>
                                        </div>

                                        <div class="turbo_list_boding turbo_list_manager_name">
                                            <a class="link" href="index.php?module=ManagerAdmin&login={$manager_admin->login|urlencode}">
                                                {$manager_admin->login|escape}
                                            </a>
                                            {if $manager_admin->comment}
                                                <span class="text_grey">{$manager_admin->comment|escape}</span>
                                            {/if}
                                        </div>

                                        {if $manager_admin->id != $manager->id}
                                            <div class="turbo_list_boding turbo_list_close">
                                                {*delete*}
                                                <button data-hint="Удалить менеджера" type="button" class="btn_close fn_remove hint-bottom-right-t-info-s-small-mobile  hint-anim" data-toggle="modal" data-target="#fn_action_modal" onclick="success_action($(this));">
                                                    {include file='svg_icon.tpl' svgId='delete'}
                                                </button>
                                            </div>
                                        {/if}
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
            <div class="text_grey">Нет менеджеров</div>
        </div>
    {/if}
</div>