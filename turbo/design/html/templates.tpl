{if $template_file}
    {$meta_title = "Шаблон $template_file" scope=parent}
{/if}

<div class="row">
    <div class="col-lg-10 col-md-10">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                Тема {$theme}, шаблон {$template_file}
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
                {if $message_error == 'permissions'}Установите права на запись для файла {$template_file}
                {elseif $message_error == 'theme_locked'}Текущая тема защищена от изменений. Создайте копию темы.
                {else}{$message_error}{/if}
            </div>
        </div>
    </div>
</div>
{/if}

<div class="row">
    <div class="col-lg-12 col-md-12 col-sm-12">
        <div class="boxed boxed_attention">
            <div class="">
                В данном разделе вы можете редактировать файлы, отвечающие за отображение сайта.
                Перед началом редактирования создайте копию вашего шаблона.
            </div>
        </div>
    </div>
</div>

<!-- Список файлов для выбора -->
<div class="row">
    <div class="col-lg-12 col-md-12">
        <div class="boxed match fn_toggle_wrap tabs">
            <div class="design_tabs">
                <div class="design_navigation">
                    <a class="design_navigation_link {if $current_dir == "html"}focus{/if}" href='{url module=TemplatesAdmin  file=null email=null}'>Шаблон</a>
                </div>
                    <div class="design_container">
                        {foreach $templates as $t}
                        <a class="design_tab {if $template_file == $t}focus{/if}" href='{url module=TemplatesAdmin file=$t}'>{$t|escape}</a>
                        {/foreach}
                    </div>
                </div>
            </div>
        </div>
    </div>
    
{if $template_file}
<div class="row">
    <div class="col-lg-12 col-md-12">
        <div class="boxed fn_toggle_wrap min_height_230px">
            <div class="heading_box">Шаблон {$template_file}</div>
            <form>
                <textarea id="template_content" name="template_content" style="width:700px;height:500px;">{$template_content|escape}</textarea>
            </form>
            <div class="row">
                <div class="col-lg-12 col-md-12">
                    <button type="submit" name="save" class="fn_save btn btn_small btn_green float-md-right">
                        {include file='svg_icon.tpl' svgId='checked'}
                        <span>Применить</span>
                    </button>
                </div>
            </div>
            
        </div>
    </div>
</div>
{/if}

{* Подключаем редактор кода *}
<link rel="stylesheet" href="design/js/codemirror/lib/codemirror.css">
<link rel="stylesheet" href="design/js/codemirror/theme/style.css">
<script src="design/js/codemirror/lib/codemirror.js"></script>
<script src="design/js/codemirror/mode/smarty/smarty.js"></script>
<script src="design/js/codemirror/mode/smartymixed/smartymixed.js"></script>
<script src="design/js/codemirror/mode/xml/xml.js"></script>
<script src="design/js/codemirror/mode/htmlmixed/htmlmixed.js"></script>
<script src="design/js/codemirror/mode/css/css.js"></script>
<script src="design/js/codemirror/mode/javascript/javascript.js"></script>
<script src="design/js/codemirror/addon/selection/active-line.js"></script>

{literal}
<style type="text/css">
.CodeMirror{
    font-family:'Courier New';
    margin-bottom:10px;
    background-color: #ffffff;
    height: auto;
    min-height: 300px;
    width:100%;
}
.CodeMirror-scroll{
    overflow-y: hidden;
    overflow-x: auto;
}
.cm-s-style .cm-smarty.cm-tag{color: #ff008a;}
.cm-s-style .cm-smarty.cm-operator{color: #ff008a;}
.cm-s-style .cm-smarty.cm-string {color: #007000;}
.cm-s-style .cm-smarty.cm-variable {color: #ff008a;}
.cm-s-style .cm-smarty.cm-variable-2 {color: #cc006e;}
.cm-s-style .cm-smarty.cm-variable-3 {color: #ff008a;}
.cm-s-style .cm-smarty.cm-property {color: #ff008a;}
.cm-s-style .cm-comment {color: #505050;}
.cm-s-style .cm-smarty.cm-attribute {color: #ff20Fa;}
.cm-s-style .cm-smarty.cm-qualifier {color: #ff008a;}
.cm-s-style .cm-smarty.cm-number {color: #ff008a;}
.cm-s-style .cm-smarty.cm-keyword {color: #ff008a;}
.cm-s-style .cm-smarty.cm-string {color: #708;}
.cm-s-style .cm-tag-smarty{color: #ff008a;}
</style>

<script>
    $(function() {
        // Сохранение кода аяксом
        function save() {
            $('.CodeMirror').css('background-color','#e0ffe0');
            content = editor.getValue();
            $.ajax({
                type: 'POST',
                url: 'ajax/save_template.php',
                data: {'content': content, 'theme':'{/literal}{$theme}{literal}', 'template': '{/literal}{$template_file}{literal}', 'session_id': '{/literal}{$smarty.session.id}{literal}'},
                success: function(data){
                    $('.CodeMirror').animate({'background-color': '#eef2f4'},500);
                },
                dataType: 'json'
            });
        }
        // Нажали кнопку Сохранить
        $('.fn_save').on('click',function(){
            save();
        });
        // Обработка ctrl+s
        var isCtrl = false;
        var isCmd = false;
        $(document).keyup(function (e) {
            if(e.which == 17) isCtrl=false;
            if(e.which == 91) isCmd=false;
            }).keydown(function (e) {
            if(e.which == 17) isCtrl=true;
            if(e.which == 91) isCmd=true;
            if(e.which == 83 && (isCtrl || isCmd)) {
                save();
                e.preventDefault();
            }
        });
    });
</script>
{/literal}

{literal}
<script>
    var editor = CodeMirror.fromTextArea(document.getElementById("template_content"), {
        mode: "smartymixed",
        lineNumbers: true,
        styleActiveLine: true,
        matchBrackets: false,
        enterMode: 'keep',
        indentWithTabs: false,
        indentUnit: 2,
        tabMode: 'classic',
        theme : 'style'
        
    });
</script>
{/literal}