{* Title *}
{$meta_title='Покупатели' scope=parent}

{if $users_count>0}
    <div class="row">
        <progress id="progressbar" class="progress progress-xs progress-info mt-0" style="display: none" value="0" max="100"></progress>
    </div>
{/if}

<div class="row">
    <div class="col-lg-7 col-md-7">
        <div class="heading_page">
            {if $keyword && $users_count>0}
               {$users_count|plural:'Нашелся':'Нашлось':'Нашлись'} {$users_count} {$users_count|plural:'покупатель':'покупателей':'покупателя'}
            {elseif $users_count>0}
                {$users_count} {$users_count|plural:'покупатель':'покупателей':'покупателя'}
			{else}
				Нет покупателей
            {/if}
            {if $users_count>0}
                <div class="export_block export_users hint-bottom-middle-t-info-s-small-mobile  hint-anim" data-hint="Экспорт пользователей">
                    <span class="fn_start_export fa fa-file-excel-o"></span>
                </div>
            {/if}
        </div>
    </div>

    <div class="col-md-12 col-lg-5 col-xs-12 float-xs-right">
        <div class="boxed_search">
            <form class="search" method="get">
                <input type="hidden" name="module" value="UsersAdmin">
                <div class="input-group">

                    <input name="keyword" class="form-control" placeholder="поиск пользователя..." type="text" value="{$keyword|escape}" >

                    <span class="input-group-btn">
                        <button type="submit" class="btn btn_green"><i class="fa fa-search"></i> <span class="hidden-md-down"></span></button>
                    </span>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="boxed fn_toggle_wrap">
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="boxed_sorting action_options">
                <div class="row">
                    <div class="col-md-3 col-lg-3 col-sm-12">
                        <select class="selectpicker" onchange="location = this.value;">
                            <option value="{url group_id=null}">Все группы</option>
                            {foreach $groups as $g}
                                <option value="{url group_id=$g->id}" {if $group->id == $g->id}selected{/if}>{$g->name|escape}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </div>
   {if $users}
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12">
                <form class="fn_form_list" method="post">
                    <input type="hidden" name="session_id" value="{$smarty.session.id}">

                    <div class="users_wrap turbo_list products_list fn_sort_list">
                        <div class="turbo_list_head">
                            <div class="turbo_list_heading turbo_list_check">
                                <input class="hidden_check fn_check_all" type="checkbox" id="check_all_1" name="" value=""/>
                                <label class="turbo_ckeckbox" for="check_all_1"></label>
                            </div>
                            <div class="turbo_list_heading turbo_list_users_name">
                                <span>Имя</span>
                                <a href="{url sort=name}" {if $sort == 'name'}class="selected"{/if}>{include file='svg_icon.tpl' svgId='sorts'}</a>
                            </div>
                            <div class="turbo_list_heading turbo_list_users_email">
                                <span>Email</span>
                                <a href="{url sort=email}" {if $sort == 'email'}class="selected"{/if}>{include file='svg_icon.tpl' svgId='sorts'}</a>
                            </div>
                            <div class="turbo_list_heading turbo_list_users_date">
                                <span>Дата</span>
                                <a href="{url sort=date}" {if $sort == 'date'}class="selected"{/if}>{include file='svg_icon.tpl' svgId='sorts'}</a>
                            </div>
                            <div class="turbo_list_heading turbo_list_users_group">Группа</div>
                            
                             <div class="turbo_list_heading turbo_list_count">Заказов</div>
                            
                            <div class="turbo_list_heading turbo_list_status">Активность</div>
                            <div class="turbo_list_heading turbo_list_close"></div>
                        </div>
                        <div class="turbo_list_body sortable">
                            {foreach $users as $user}
                                <div class="fn_row turbo_list_body_item fn_sort_item body_narrow">
                                    <div class="turbo_list_row narrow">
                                        <div class="turbo_list_boding turbo_list_check">
                                            <input class="hidden_check" type="checkbox" id="id_{$user->id}" name="check[]" value="{$user->id}"/>
                                            <label class="turbo_ckeckbox" for="id_{$user->id}"></label>
                                        </div>

                                        <div class="turbo_list_boding turbo_list_users_name">
                                            <a href="{url module=UserAdmin id=$user->id}">
                                                {$user->name|escape}
                                            </a>
                                        </div>

                                        <div class="turbo_list_boding turbo_list_users_email">
                                            <a href="mailto:{$user->name|escape}<{$user->email|escape}>">
                                                {$user->email|escape}
                                            </a>
                                        </div>

                                        <div class="turbo_list_boding turbo_list_users_date">
                                            {$user->created|date} | {$user->created|time}
                                        </div>

                                        <div class="turbo_list_boding turbo_list_users_group">
                                           {if $groups[$user->group_id]}
                                                <span>{$groups[$user->group_id]->name|escape}</span>
											{else}
												<span>нет</span>
                                            {/if}    
                                        </div>

                                          <div class="turbo_list_boding turbo_list_count">
                                            {$user->orders|count}
                                        </div>

                                        <div class="turbo_list_boding turbo_list_status">
                                             {*visible*}
                                            <label class="switch switch-default">
                                                <input class="switch-input fn_ajax_action {if $user->enabled}fn_active_class{/if}" data-module="user" data-action="enabled" data-id="{$user->id}" name="enabled" value="1" type="checkbox"  {if $user->enabled}checked=""{/if}/>
                                                <span class="switch-label"></span>
                                                <span class="switch-handle"></span>
                                            </label>
                                        </div>
                                        
                                        <div class="turbo_list_boding turbo_list_close">
                                            <button data-hint="удалить пользователя" type="button" class="btn_close fn_remove hint-bottom-right-t-info-s-small-mobile  hint-anim" data-toggle="modal" data-target="#fn_action_modal" onclick="success_action($(this));">
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
                                    <select name="action" class="selectpicker fn_user_select">
                                        <option value="0">Выберите действие</option>
                                        <option value="enable">Включить</option>
                                        <option value="disable">Выключить</option>
                                        <option value="move_to">Переместить в группу</option>
                                        <option value="delete">Удалить</option>
                                    </select>
                                </div>
                                <div id="move_to" class="turbo_list_option hidden fn_hide_block">
                                    <select name="move_group" class="selectpicker">
                                    {if $groups}
                                        {foreach $groups as $group}
                                            <option value="{$group->id}">{$group->name|escape}</option>
                                        {/foreach}
                                    {/if}
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
            <div class="col-lg-12 col-md-12 col-sm 12 txt_center">
                {include file='pagination.tpl'}
            </div>
        </div>
    {else}
        <div class="heading_box mt-1">
            <div class="text_grey">Нет покупателей</div>
        </div>
    {/if}
</div>


<script src="{$config->root_url}/turbo/design/js/piecon/piecon.js"></script>
<script>
    var group_id='{$group_id|escape}';
    var keyword='{$keyword|escape}';
    var sort='{$sort|escape}';
</script>

{literal}
<script>
$(function() {

    $(document).on('change','select.fn_user_select',function(){
        var elem = $(this).find('option:selected').val();
        $('.fn_hide_block').addClass('hidden');
        if($('#'+elem).size()>0){
            $('#'+elem).removeClass('hidden');
        }
    });

    // On document load
    $(document).on('click','.fn_start_export',function(){
        Piecon.setOptions({fallback: 'force'});
        Piecon.setProgress(0);
        var progress_item = $("#progressbar"); //указываем селектор элемента с анимацией
        progress_item.show();
        do_export('',progress_item);
    });

    function do_export(page,progress) {
        page = typeof(page) != 'undefined' ? page : 1;
        $.ajax({
            url: "ajax/export_users.php",
            data: {page:page, group_id:group_id, keyword:keyword, sort:sort},
            dataType: 'json',
            success: function(data){
                if(data && !data.end) {
                    Piecon.setProgress(Math.round(100*data.page/data.totalpages));
                    progress.attr('value',100*data.page/data.totalpages);
                    do_export(data.page*1+1,progress);
                }
                else {
                    Piecon.setProgress(100);
                    progress.attr('value','100');
                    window.location.href = 'files/export_users/users.csv';
                    progress.fadeOut(500);
                }
            },
            error:function(xhr, status, errorThrown) {
                alert(errorThrown+'\n'+xhr.responseText);
            }
        });
    }
});
</script>
{/literal}
