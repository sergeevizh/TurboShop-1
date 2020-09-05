{* Title *}
{$meta_title='Комментарии' scope=parent}

<div class="row">
    <div class="col-lg-7 col-md-7">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                {if $keyword && $comments_count}
                    {$comments_count|plural:'Нашелся':'Нашлось':'Нашлись'} {$comments_count} {$comments_count|plural:'комментарий':'комментариев':'комментария'} 
                {elseif !$type}
                    {$comments_count} {$comments_count|plural:'комментарий':'комментариев':'комментария'} 
                {elseif $type=='product'}
                    {$comments_count} {$comments_count|plural:'комментарий':'комментариев':'комментария'} к продуктам
                {elseif $type=='project'}
                    {$comments_count} {$comments_count|plural:'комментарий':'комментариев':'комментария'} к проектам
                {elseif $type=='article'}
                    {$comments_count} {$comments_count|plural:'комментарий':'комментариев':'комментария'} к статьям   
                {elseif $type=='blog'}
                    {$comments_count} {$comments_count|plural:'комментарий':'комментариев':'комментария'} к записям в блоге
                {/if}
            </div>
        </div>
    </div>
</div>

<div class="boxed fn_toggle_wrap">
    <div class="row">
        <div class="col-lg-12 col-md-12">
            <div class="boxed_sorting">
                <div class="row">
                    <div class="col-lg-3 col-md-3 col-sm-12">
                        <select class="selectpicker form-control" onchange="location = this.value;">
                            <option value="{url type=null}" {if !$type}selected{/if}>Все комментарии</option>
                            <option value="{url keyword=null type=product}" {if $type == 'product'}selected{/if}>К товарам</option>
                            <option value="{url keyword=null type=project}" {if $type == 'project'}selected{/if}>К проектам</option>
                            <option value="{url keyword=null type=blog}" {if $type == 'blog'}selected{/if}>К блогу</option>
                            <option value="{url keyword=null type=article}" {if $type == 'article'}selected{/if}>К статьям</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </div>
    {if $comments}
    <div class="row">
        {* Основная форма *}
        <div class="col-lg-12 col-md-12 col-sm-12">
            <form class="fn_form_list" method="post">
                <input type="hidden" name="session_id" value="{$smarty.session.id}">
                <div class="post_wrap turbo_list">
                    <div class="turbo_list_head">
                        <div class="turbo_list_heading turbo_list_check">
                            <input class="hidden_check fn_check_all" type="checkbox" id="check_all_1" name="" value=""/>
                            <label class="turbo_ckeckbox" for="check_all_1"></label>
                        </div>
                        <div class="turbo_list_heading turbo_list_comments_name">Комментарии</div>
                        <div class="turbo_list_heading turbo_list_comments_btn"></div>
                        <div class="turbo_list_heading turbo_list_close"></div>
                    </div>
                    <div class="turbo_list_body">
                        {function name=comments_tree level=0}
                        {foreach $comments as $comment}
                        <div class="fn_row turbo_list_body_item {if !$comment->approved}unapproved{/if} {if $level > 0}admin_note2{/if}">
                            <div class="turbo_list_row">
                                
                                <div class="turbo_list_boding turbo_list_check">
                                    <input class="hidden_check" type="checkbox" id="id_{$comment->id}" name="check[]" value="{$comment->id}"/>
                                    <label class="turbo_ckeckbox" for="id_{$comment->id}"></label>
                                </div>
                                
                                <div class="turbo_list_boding turbo_list_comments_name {if $level > 0}admin_note{/if}">
                                    <div class="turbo_list_text_inline mb-q mr-1">
                                        <span class="text_dark text_bold">Имя: </span> {$comment->name|escape}
                                    </div>
                                    {if $comment->email}
                                    <div class="turbo_list_text_inline mb-q">
                                        <span class="text_dark text_bold">Email: </span>  {$comment->email|escape}
                                    </div>
                                    {/if}
                                    <div class="mb-q">
                                        <span class="text_dark text_bold">Сообщение:</span>
                                        {$comment->text|escape|nl2br}
                                    </div>
                                    <div class="">
                                        Комментарий был оставлен  <span class="tag tag-default">{$comment->date|date} | {$comment->date|time}</span>
                                        {if $comment->type == 'product'}
                                        к товару <a target="_blank" href="{$config->root_url}/products/{$comment->product->url}#comment_{$comment->id}">{$comment->product->name}</a>
                                        {elseif $comment->type == 'project'}
                                        к проекту <a target="_blank" href="{$config->root_url}/project/{$comment->project->url}#comment_{$comment->id}">{$comment->project->name}</a>
                                        {elseif $comment->type == "blog"}
                                        к блогу <a href="{$config->root_url}/blog/{$comment->post->url|escape}#comment_{$comment->id}" target="_blank">{$comment->post->name|escape}</a>
                                        {elseif $comment->type == 'article'}
                                        к статье <a target="_blank" href="{$config->root_url}/article/{$comment->article->url}#comment_{$comment->id}">{$comment->article->name}</a>
                                        {/if}
                                    </div>
                                    <div class="hidden-md-up mt-q">
                                        {if !$comment->approved}
                                        <button type="button" class="btn btn_small btn-outline-warning fn_ajax_action {if $comment->approved}fn_active_class{/if}" data-module="comment" data-action="approved" data-id="{$comment->id}" onclick="$(this).hide();">
                                            Одобрить
                                        </button>
                                        {/if}
                                    </div>
                                </div>
                                
                                <div class="turbo_list_boding turbo_list_comments_btn">
                                    {if !$comment->approved}
                                    <button type="button" class="btn btn_small btn-outline-warning fn_ajax_action {if $comment->approved}fn_active_class{/if}" data-module="comment" data-action="approved" data-id="{$comment->id}" onclick="$(this).hide();">
                                        Одобрить
                                    </button>
                                    {/if}
                                </div>
                                
                                <div class="turbo_list_boding turbo_list_close">
                                    {*delete*}
                                    <button data-hint="Удалить комментарий" type="button" class="btn_close fn_remove hint-bottom-right-t-info-s-small-mobile  hint-anim" data-toggle="modal" data-target="#fn_action_modal" onclick="success_action($(this));">
                                        {include file='svg_icon.tpl' svgId='delete'}
                                    </button>
                                </div>
                                
                            </div>
                            {if isset($children[$comment->id])}
                            {comments_tree comments=$children[$comment->id] level=$level+1}
                            {/if}
                        </div>
                        
                        {/foreach}
                        {/function}
                        {comments_tree comments=$comments}
                    </div>
                    
                    <div class="turbo_list_footer fn_action_block">
                        <div class="turbo_list_foot_left">
                            <div class="turbo_list_heading turbo_list_check">
                                <input class="hidden_check fn_check_all" type="checkbox" id="check_all_2" name="" value=""/>
                                <label class="turbo_ckeckbox" for="check_all_2"></label>
                            </div>
                            <div class="turbo_list_option">
                                <select name="action" class="selectpicker">
                                    <option value="approve">Одобрить</option>
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
        <div class="text_grey">Нет комментариев</div>
    </div>
    {/if}
</div>