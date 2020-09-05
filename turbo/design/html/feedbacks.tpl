{* Title *}
{$meta_title='Обратная связь' scope=parent}

<div class="row">
    <div class="col-lg-7 col-md-7">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                {if $feedbacks_count}
                    {$feedbacks_count} {$feedbacks_count|plural:'сообщение':'сообщений':'сообщения'} 
                {else}
                    Нет сообщений
                {/if}
            </div>
        </div>
    </div>
</div>

<div class="boxed fn_toggle_wrap">
    {if $feedbacks}
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <form method="post" class="fn_form_list">
                <input type="hidden" name="session_id" value="{$smarty.session.id}">
                
                <div class="post_wrap turbo_list">
                    <div class="turbo_list_head">
                        <div class="turbo_list_heading turbo_list_check">
                            <input class="hidden_check fn_check_all" type="checkbox" id="check_all_1" name="" value=""/>
                            <label class="turbo_ckeckbox" for="check_all_1"></label>
                        </div>
                        <div class="turbo_list_heading turbo_list_comments_name">Сообщения</div>
                        <div class="turbo_list_heading turbo_list_comments_btn"></div>
                        <div class="turbo_list_heading turbo_list_close"></div>
                    </div>
                    
                    <div class="turbo_list_body">
                        {function name=comments_tree level=0}
                        {foreach $feedbacks as $feedback}
                        <div class="fn_row turbo_list_body_item {if !$feedback->processed}unapproved{/if} {if $level > 0}admin_note2{/if}">
                            <div class="turbo_list_row">
                                <div class="turbo_list_boding turbo_list_check">
                                    <input class="hidden_check" type="checkbox" id="id_{$feedback->id}" name="check[]" value="{$feedback->id}"/>
                                    <label class="turbo_ckeckbox" for="id_{$feedback->id}"></label>
                                </div>
                                
                                <div class="turbo_list_boding turbo_list_comments_name {if $level > 0}admin_note{/if}">
                                    <div class="turbo_list_text_inline mb-q mr-1">
                                        <span class="text_dark text_bold">Имя: </span> <a href="mailto:{$feedback->name|escape}<{$feedback->email|escape}>?subject=Вопрос от пользователя {$feedback->name|escape}">{$feedback->name|escape}</a>
                                    </div>
                                    <div class="turbo_list_text_inline mb-q">
                                        <span class="text_dark text_bold">Email: </span> {$feedback->email|escape}
                                    </div>
                                    <div class="mb-q">
                                        <span class="text_dark text_bold">Сообщение:</span>
                                        {$feedback->message|escape|nl2br}
                                    </div>
                                    <div>
                                        Заявка была отправлена  <span class="tag tag-default">{$feedback->date|date} | {$feedback->date|time}</span>
                                    </div>
                                    {if !$feedback->processed}
                                    <div class="hidden-md-up mt-q">
                                        <button type="button" class="btn btn_small btn-outline-warning fn_ajax_action {if $feedback->processed}fn_active_class{/if}" data-module="feedback" data-action="processed" data-id="{$feedback->id}" onclick="$(this).hide();">
                                            Обработать
                                        </button>
                                    </div>
                                    {/if}
                                </div>
                                <div class="turbo_list_boding turbo_list_comments_btn">
                                    {if !$feedback->processed}
                                    <button type="button" class="btn btn_small btn-outline-warning fn_ajax_action {if $feedback->processed}fn_active_class{/if}" data-module="feedback" data-action="processed" data-id="{$feedback->id}" onclick="$(this).hide();">
                                        Обработать
                                    </button>
                                    {/if}
                                </div>
                                <div class="turbo_list_boding turbo_list_close">
                                    {*delete*}
                                    <button data-hint="Удалить сообщение" type="button" class="btn_close fn_remove hint-bottom-right-t-info-s-small-mobile  hint-anim" data-toggle="modal" data-target="#fn_action_modal" onclick="success_action($(this));">
                                        {include file='svg_icon.tpl' svgId='delete'}
                                    </button>
                                </div>
                            </div>
                            {if isset($admin_answer[$feedback->id])}
                            {comments_tree feedbacks=$admin_answer[$feedback->id] level=$level+1}
                            {/if}
                        </div>
                        {/foreach}
                        {/function}
                        {comments_tree feedbacks=$feedbacks}
                    </div>
                    
                    <div class="turbo_list_footer fn_action_block">
                        <div class="turbo_list_foot_left">
                            <div class="turbo_list_heading turbo_list_check">
                                <input class="hidden_check fn_check_all" type="checkbox" id="check_all_2" name="" value=""/>
                                <label class="turbo_ckeckbox" for="check_all_2"></label>
                            </div>
                            <div class="turbo_list_option">
                                <select name="action" class="selectpicker">
                                    <option value="processed">Обработать</option>
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
        <div class="text_grey">Нет сообщений</div>
    </div>
    {/if}
</div>