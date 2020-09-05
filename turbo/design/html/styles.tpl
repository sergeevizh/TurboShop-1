{if $style_file}
	{$meta_title = "Стиль $style_file" scope=parent}
{/if}

{* Подключаем редактор кода *}
<link rel="stylesheet" href="design/js/codemirror/lib/codemirror.css">
<link rel="stylesheet" href="design/js/codemirror/theme/style-css.css">
<script src="design/js/codemirror/lib/codemirror.js"></script>
<script src="design/js/codemirror/mode/css/css.js"></script>
<script src="design/js/codemirror/addon/selection/active-line.js"></script>
 
{literal}
<style type="text/css">
.CodeMirror{
	font-family:'Courier New';
	margin-bottom:10px;
	background-color: #ffffff;
	height: auto;
	min-height: 100px;
	width:100%;
}
.CodeMirror-scroll
{
	overflow-y: hidden;
	overflow-x: auto;
}
</style>

<script>
$(function() {	
	// Сохранение кода аяксом
	function save()
	{
		$('.CodeMirror').css('background-color','#e0ffe0');
		content = editor.getValue();
		
		$.ajax({
			type: 'POST',
			url: 'ajax/save_style.php',
			data: {'content': content, 'theme':'{/literal}{$theme}{literal}', 'style': '{/literal}{$style_file}{literal}', 'session_id': '{/literal}{$smarty.session.id}{literal}'},
			success: function(data){
			
				$('.CodeMirror').animate({'background-color': '#eef2f4'});
			},
			dataType: 'json'
		});
	}

	// Нажали кнопку Сохранить
	$('input[name="save"]').click(function() {
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

<div class="row">
    <div class="col-lg-10 col-md-10">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                Тема {$theme}, стиль {$style_file}
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
                     {if $message_error == 'permissions'}Установите права на запись для файла {$style_file}
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

<div class="row">
    <div class="col-lg-12 col-md-12">
        <div class="boxed match fn_toggle_wrap tabs">
            <div class="design_tabs">
                <div class="design_container">
                    {foreach $styles as $s}
                        <a class="design_tab {if $style_file == $s}focus{/if}" href='{url module=StylesAdmin file=$s}'>{$s|escape}</a>
                    {/foreach}
                </div>
            </div>
        </div>
	</div>
</div>

{if $style_file}
<div class="row">
	<div class="col-lg-12 col-md-12">
		<div class="boxed fn_toggle_wrap min_height_230px">
			<div class="heading_box">Стили {$style_file|escape}</div>

			 <form>
				<textarea id="content" name="content" style="width:100%;height:500px;">{$style_content|escape}</textarea>
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

{* Подключение редактора *}
{literal}
<script>
	var editor = CodeMirror.fromTextArea(document.getElementById("content"), {
			mode: "css",
			lineNumbers: true,
			styleActiveLine: true,
			matchBrackets: false,
			enterMode: 'keep',
			indentWithTabs: false,
			indentUnit: 1,
			tabMode: 'classic',
			theme : 'style-css'
		});
</script>
{/literal}

{/if}
