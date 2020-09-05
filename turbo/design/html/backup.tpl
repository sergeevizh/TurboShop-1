{* Title *}
{$meta_title='Бекап' scope=parent}

<div class="row">
    <div class="col-lg-7 col-md-7">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                Бекап
            </div>
            <div class="box_btn_heading">
                <a class="btn btn_small btn-info" href="">
                    {include file='svg_icon.tpl' svgId='plus'}
                    <span>Создать бекап</span>
                </a>
                <form id="hidden" method="post">
                    <input type="hidden" name="session_id" value="{$smarty.session.id}">
                    <input type="hidden" name="action" value="">
                    <input type="hidden" name="name" value="">
                </form>
            </div>
        </div>
    </div>
</div>

<div class="boxed fn_toggle_wrap">
    {if $backups}
    <form method="post" class="fn_form_list">
        <input type="hidden" name="session_id" value="{$smarty.session.id}">
        <div class="turbo_list products_list fn_sort_list">
            <div class="turbo_list_head">
                <div class="turbo_list_heading turbo_list_check">
                    <input class="hidden_check fn_check_all" type="checkbox" id="check_all_1" name="" value="" />
                    <label class="turbo_ckeckbox" for="check_all_1"></label>
                </div>
                <div class="turbo_list_heading turbo_list_backup_name">Бекап</div>
                <div class="turbo_list_heading turbo_list_setting">Действия</div>
                <div class="turbo_list_heading turbo_list_close"></div>
            </div>
            <div class="turbo_list_body sortable">
                {foreach $backups as $backup}
                <div class="fn_row turbo_list_body_item fn_sort_item">
                    <div class="turbo_list_row ">
                        <div class="turbo_list_boding turbo_list_check">
                            <input class="hidden_check" type="checkbox" id="id_{$backup->name}" name="check[]" value="{$backup->name}" />
                            <label class="turbo_ckeckbox" for="id_{$backup->name}"></label>
                        </div>
                        
                        <div class="turbo_list_boding turbo_list_backup_name">
                            <a href="files/backup/{$backup->name}">
                                {$backup->name}
                            </a>
                            ({if $backup->size>1024*1024}{($backup->size/1024/1024)|round:2} МБ{else}{($backup->size/1024)|round:2} КБ{/if})
                        </div>
                        
                        <div class="turbo_list_boding turbo_list_close">
                            <a href="#"  data-hint="Востановить бекап" class="btn_close fn_remove hint-bottom-right-t-info-s-small-mobile  hint-anim restore">
                                <i class="icon-reload icons font-xl"></i>
                            </a>
                        </div>
                        
                        <div class="turbo_list_boding turbo_list_close">
                            {*delete*}
                            <button data-hint="Удалить бекап" type="button" class="btn_close fn_remove hint-bottom-right-t-info-s-small-mobile  hint-anim" data-toggle="modal" data-target="#fn_action_modal" onclick="success_action($(this));">
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
    {else}
    <div class="heading_box mt-1">
        <div class="text_grey">Нет бэкапов</div>
    </div>
    {/if}
</div>
{literal}
<script>
    $(function() {
        
        // Восстановить 
        $("a.restore").click(function() {
            file = $(this).closest(".fn_row").find('[name*="check"]').val();
            $('form#hidden input[name="action"]').val('restore');
            $('form#hidden input[name="name"]').val(file);
            $('form#hidden').submit();
            return false;
        });
        
        // Создать бекап 
        $("a.btn-info").click(function() {
            $('form#hidden input[name="action"]').val('create');
            $('form#hidden').submit();
            return false;
        });
        
        $("form#hidden").submit(function() {
            if($('input[name="action"]').val()=='restore' && !confirm('Текущие данные будут потеряны. Подтвердите восстановление'))
			return false;	
        });
        
        $("form#fn_form_list").submit(function() {
            if($('select[name="action"]').val()=='delete' && !confirm('Подтвердите удаление'))
			return false;	
        });
        
        
    });
    
</script>
{/literal}
