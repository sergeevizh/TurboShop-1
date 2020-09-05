{$meta_title = "Изображения" scope=parent}

<div class="row">
    <div class="col-lg-10 col-md-10">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                Изображения темы {$theme|escape}
            </div>
        </div>
    </div>
    <div class="col-md-2 col-lg-2 col-sm-12 float-xs-right"></div>
</div>

{if $message_error}
<div class="row">
    <div class="col-lg-12 col-md-12 col-sm-12">
        <div class="boxed boxed_warning">
            <div class="">
                {if $message_error == 'permissions'}Установите права на запись для папки {$images_dir}
                {elseif $message_error == 'name_exists'}Файл с таким именем уже существует
                {elseif $message_error == 'theme_locked'}Текущая тема защищена от изменений. Создайте копию темы.
                {else}{$message_error}{/if}
            </div>
        </div>
    </div>
</div>
{/if}

<div class="boxed fn_toggle_wrap">
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <form method="post" enctype="multipart/form-data">
                <input type="hidden" name="session_id" value="{$smarty.session.id}">
                <input type="hidden" name="delete_image" value="">
                <!-- Список файлов для выбора -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="heading_box">
                            Изображения
                            <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                                <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
                            </div>
                        </div>
                        <div class="toggle_body_wrap fn_card on">
                            <div class="row">
                                {foreach $images as $image}
                                <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
                                    <div class="banner_card">
                                        <div class="banner_card_header">
                                            <input type="text" class="hidden" name="old_name[]" value="{$image->name|escape}">
                                            <div class="form-group col-lg-9 col-md-8 px-0 fn_rename_value hidden mb-0">
                                                <input type="text" class="form-control" name="new_name[]" value="{$image->name|escape}">
                                            </div>
                                            <span class="font-weight-bold">{$image->name|escape|truncate:20:'...'}</span>
                                            <i class="fa fa-pencil fn_rename_theme rename_theme p-h" data-old_name="{$image->name|escape}"></i>
                                            
                                            <button type="button" data-name="{$image->name}" class="fn_delete_image btn_close float-xs-right">
                                                {include file='svg_icon.tpl' svgId='delete'}
                                            </button>
                                        </div>
                                        <div class="banner_card_block">
                                            <div class="wrap_bottom_tag_images">
                                                <a class="theme_image_item" href='../{$images_dir}{$image->name|escape}'>
                                                    <img src='../{$images_dir}{$image->name|escape}'>
                                                </a>
                                                <div class="tag tag-info">
                                                    {if $image->size>1024*1024}
                                                    {($image->size/1024/1024)|round:2} МБ
                                                    {elseif $image->size>1024}
                                                    {($image->size/1024)|round:2} КБ
                                                    {else}
                                                    {$image->size} Байт
                                                    {/if},
                                                    {$image->width}&times;{$image->height} px
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                {/foreach}
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-lg-7 col-md-7">
                        <div class="">
                            <button type="button" class="fn_add_image btn btn_small btn-info mb-1 btn_images_add">
                                {include file='svg_icon.tpl' svgId='plus'}
                                Добавить изображение
                            </button>
                        </div>
                    </div>
                    <div class="col-lg-5 col-md-5 pull-right">
                        <button type="submit" name="save" class="btn btn_small btn_green float-md-right">
                            {include file='svg_icon.tpl' svgId='checked'}
                            <span>Применить</span>
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

{* On document load *}
<script>
    var general_confirm_delete = 'Подтвердите удаление';
</script>
{literal}
<script>
    $(function() {
        
        $('.fn_rename_theme').on('click',function(){
            $(this).parent().find('.fn_rename_value').toggleClass('hidden');
            $(this).prev().toggleClass('hidden');
            $(this).parent().find('.fn_rename_value > input').val($(this).data('old_name'))
        });
        // Удалить
        $('.fn_delete_image').on('click',function(){
            $('input[name=delete_image]').val($(this).data('name'));
            $('form').submit();
        });
        
        // Загрузить
        $('.fn_add_image').on('click',function(){
            $(this).closest('div').append($('<input class="import_file" type="file" name="upload_images[]">'));
        });
        
        $("form").submit(function() {
            if($('input[name="delete_image"]').val()!='' && !confirm(general_confirm_delete))
			return false;	
        });
        
    });
</script>
{/literal}