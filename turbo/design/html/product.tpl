{if $product->id}
	{$meta_title = $product->name scope=parent}
{else}
	{$meta_title = 'Новый товар' scope=parent}
{/if}

<div class="row">
	<div class="col-lg-12 col-md-12">
		<div class="wrap_heading">
			<div class="box_heading heading_page">
				{if !$product->id}
					Добавление товара
				{else}
					{$product->name|escape}
				{/if}
			</div>
			{if $product->id}
			<div class="box_btn_heading">
				<a class="btn btn_small btn-info add" target="_blank" href="../products/{$product->url}" >
					{include file='svg_icon.tpl' svgId='icon_desktop'}
					<span>Открыть на сайте</span>
				</a>
			</div>
			{/if}
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
					Товар добавлен
				{elseif $message_success=='updated'}
					Товар изменен
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
				{if $message_error=='url_exists'}
					Товар с таким адресом уже существует
				{elseif $message_error=='empty_name'}
					Введите название
				{elseif $message_error == 'empty_url'}
					Введите URL
				{elseif $message_error == 'url_wrong'}
					URL не должен начинаться или заканчиваться символом "-"
				{elseif $message_error == 'empty_categories'}
					У товара не задана категория
				{else}
					{$message_error|escape}
				{/if}
			</div>
		</div>
	</div>
</div>
{/if}

<form method="post" id="product" enctype="multipart/form-data" class="clearfix fn_fast_button" >
	<input type=hidden name="session_id" value="{$smarty.session.id}">
	<div class="row">
		<div class="col-xs-12">
			<div class="boxed">
				<div class="row d_flex">
					<div class="col-lg-10 col-md-9 col-sm-12">
						<div class="heading_label">
							Название
						</div>
						<div class="form-group">
							<input class="form-control" name="name" type="text" value="{$product->name|escape}"/>
							<input name="id" type="hidden" value="{$product->id|escape}"/>
						</div>
						<div class="row">
							<div class="col-xs-12 col-lg-6 col-md-10">
								<div class="">
									<div class="input-group">
										<span class="input-group-addon">URL</span>
										<input name="url" class="fn_meta_field form-control fn_url {if $product->id}fn_disabled{/if}" {if $product->id}readonly=""{/if} type="text" value="{$product->url|escape}" />
										<input type="checkbox" id="block_translit" class="hidden" value="1" {if $product->id}checked=""{/if}>
										<span class="input-group-addon fn_disable_url">
											{if $product->id}
												<i class="fa fa-lock"></i>
											{else}
												<i class="fa fa-lock fa-unlock"></i>
											{/if}
										</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-2 col-md-3 col-sm-12">
						<div class="activity_of_switch">
							<div class="activity_of_switch_item"> {* row block *}
								<div class="turbo_switch clearfix">
									<label class="switch_label">Активность</label>
									<label class="switch switch-default">
										<input class="switch-input" name="visible" value='1' type="checkbox" id="visible_checkbox" {if $product->visible}checked=""{/if}/>
										<span class="switch-label"></span>
										<span class="switch-handle"></span>
									</label>
								</div>
							</div>
							<div class="activity_of_switch_item"> {* row block *}
								<div class="turbo_switch clearfix">
									<label class="switch_label">Хит продаж</label>
									<label class="switch switch-default">
										<input class="switch-input" name="featured" value="1" type="checkbox" id="featured_checkbox" {if $product->featured}checked=""{/if}/>
										<span class="switch-label"></span>
										<span class="switch-handle"></span>
									</label>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-8 col-md-12 pr-0 ">
			<div class="boxed fn_toggle_wrap min_height_230px">
				<div class="heading_box">
					Изображения товара
					<div class="toggle_arrow_wrap fn_toggle_card text-primary">
						<a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
					</div>
				</div>
				<div class="toggle_body_wrap fn_card on ">
					<ul class="fn_droplist_wrap product_images_list clearfix sortable" data-image="product">
						<li class="fn_dropzone dropzone_block">
							<i class="fa fa-plus font-5xl" aria-hidden="true"></i>
							<input type="file" name="dropped_images[]" multiple class="dropinput">
						</li>
						{foreach $product_images as $image}
						<li class="product_image_item {if $image@first}first_image{/if} {if $image@iteration > 4}fn_toggle_hidden hidden{/if} fn_sort_item">
							<button type="button" class="fn_remove_image remove_image"></button>
							<i class="move_zone">
								{if $image}
								<img class="product_icon" src="{$image->filename|resize:110:110}" alt=""/>
								{else}
								<img class="product_icon" src="design/images/no_image.png" width="40">
								{/if}
								<input type="hidden" name="images[]" value="{$image->id}">
							</i>
						</li>
						{/foreach}
						<li class="fn_new_image_item product_image_item fn_sort_item">
							<button type="button" class="fn_remove_image remove_image"></button>
							<img src="" alt=""/>
							<input type="hidden" name="images_urls[]" value="">
						</li>
					</ul>
					{if $product_images|count > 4}
					<div class="show_more_images fn_show_images">Показать все фото</div>
					{/if}
				</div>
			</div>
		</div>
		<div class="col-lg-4 col-md-12 ">
			<div class="boxed fn_toggle_wrap min_height_230px">
				<div class="heading_label">
					Бренд
				</div>
				<div class="row">
					<div class="col-lg-12 toggle_body_wrap on fn_card ">
						<select name="brand_id" class="selectpicker mb-1{if !$brands}hidden{/if} fn_meta_brand" data-live-search="true">
							<option value="0" {if !$product->brand_id}selected=""{/if} data-brand_name="">Не указан</option>
							{foreach $brands as $brand}
								<option value="{$brand->id}" {if $product->brand_id == $brand->id}selected=""{/if} data-brand_name="{$brand->name|escape}">{$brand->name|escape}</option>
							{/foreach}
						</select>
						<div class="heading_label">Категория</div>
						<fieldset class="form-group">
							<div id="product_categories" {if !$categories}style='display:none;'{/if}>
								<div class="product_cats" id="product_cats">
									{foreach $product_categories as $product_category name=categories}
									<span class="list">
										{assign var ='first_category' value=reset($product_categories)}
										<div class="input-group">
											<select name="categories[]" class="form-control fn_meta_categories" data-live-search="true">
												<option value="0" selected="" data-category_name="">Укажите категорию</option>
												{function name=category_select level=0}
													{foreach $categories as $category}
														<option value='{$category->id}' {if $category->id == $selected_id}selected{/if} category_name='{$category->name|escape}'>{section name=sp loop=$level}-{/section} {$category->name|escape}</option>
														{category_select categories=$category->subcategories selected_id=$selected_id  level=$level+1}
													{/foreach}
												{/function}
												{category_select categories=$categories selected_id=$product_category->id}
											</select>
											<span {if not $smarty.foreach.categories.first}style="display:none;"{/if} class="add input-group-addon-categories">
												<i class="fa fa-plus"></i>
											</span>
											<span onclick="" {if $smarty.foreach.categories.first}style="display:none;"{/if} class="delete input-group-addon-categories">
												<i class="fa fa-minus"></i>
											</span>
										</div>
										<br>
									</span>
									{/foreach}	
								</div>
							</div>
						</fieldset>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-12 col-md-12 ">
			<div class="boxed fn_toggle_wrap match_matchHeight_true">
				<div class="heading_box">
					Варианты
					<div class="toggle_arrow_wrap fn_toggle_card text-primary">
						<a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
					</div>
				</div>
				<div class="variants_wrapper fn_card">
					<div class="turbo_list variants_list scrollbar-variant">
						<div class="turbo_list_body sortable variants_listadd">
							{foreach $product_variants as $variant}
							<div class="turbo_list_body_item variants_list_item ">
								<div class="turbo_list_row">
									<div class="turbo_list_boding variants_item_drag">
										<div class="heading_label"></div>
										<div class="move_zone">
											{include file='svg_icon.tpl' svgId='drag_vertical'}
										</div>
									</div>
									<div class="turbo_list_boding variants_item_sku">
										<div class="heading_label">Артикул</div>
										<input class="variant_input" name="variants[sku][]" type="text" value="{$variant->sku|escape}"/>
									</div>
									<div class="turbo_list_boding variants_item_name">
										<div class="heading_label">Название</div>
										<input name="variants[id][]" type="hidden" value="{$variant->id|escape}" />
										<input class="variant_input" name="variants[name][]" type="text" value="{$variant->name|escape}" />
									</div>
									<div class="turbo_list_boding variants_item_price">
										<div class="heading_label">Цена, {$currency->sign}</div>
										<input class="variant_input" name="variants[price][]" type="text" value="{$variant->price|escape}"/>
									</div>
									<div class="turbo_list_boding variants_item_discount">
										<div class="heading_label">Старая, {$currency->sign}</div>
										<input class="variant_input text_grey" name="variants[compare_price][]" type="text" value="{$variant->compare_price|escape}"/>
									</div>
									<div class="turbo_list_boding variants_item_amount">
										<div class="heading_label">Кол-во</div>
										<div class="input-group">
											<input class="form-control" name="variants[stock][]" type="text" value="{if $variant->infinity || $variant->stock == ''}∞{else}{$variant->stock|escape}{/if}"/>
											<span class="input-group-addon p-0">
												{$settings->units|escape}
											</span>
										</div>
									</div>
									{if !$variant@first}
									<div class="turbo_list_boding turbo_list_close remove_variant">
										<div class="heading_label"></div>
										<button data-hint="Удалить вариант" type="button" class="btn_close fn_remove_variant hint-bottom-right-t-info-s-small-mobile  hint-anim">
											{include file='svg_icon.tpl' svgId='delete'}
										</button>
									</div>
									{/if}
								</div>
							</div>
							{/foreach}
							<div class="turbo_list_body_item variants_list_item fn_new_row_variant">
								<div class="turbo_list_row ">
									<div class="turbo_list_boding variants_item_drag">
										<div class="heading_label"></div>
										<div class="move_zone">
											{include file='svg_icon.tpl' svgId='drag_vertical'}
										</div>
									</div>
									<div class="turbo_list_boding variants_item_sku">
										<div class="heading_label">Артикул</div>
										<input class="variant_input" name="variants[sku][]" type="text" value=""/>
									</div>
									<div class="turbo_list_boding variants_item_name">
										<div class="heading_label">Название</div>
										<input name="variants[id][]" type="hidden" value="" />
										<input class="variant_input" name="variants[name][]" type="text" value="" />
									</div>
									<div class="turbo_list_boding variants_item_price">
										<div class="heading_label">Цена, {$currency->sign}</div>
										<input class="variant_input" name="variants[price][]" type="text" value=""/>
									</div>
									<div class="turbo_list_boding variants_item_discount">
										<div class="heading_label">Старая, {$currency->sign}</div>
										<input class="variant_input" name="variants[compare_price][]" type="text" value=""/>
									</div>
									<div class="turbo_list_boding variants_item_amount">
										<div class="heading_label">Кол-во</div>
										<div class="input-group">
											<input class="form-control" name="variants[stock][]" type="text" value="∞"/>
											<span class="input-group-addon p-0">
												{$settings->units|escape}
											</span>
										</div>
									</div>
									<div class="turbo_list_boding turbo_list_close remove_variant">
										<div class="heading_label"></div>
										<button data-hint="Удалить вариант" type="button" class="btn_close fn_remove_variant hint-bottom-right-t-info-s-small-mobile  hint-anim">
											{include file='svg_icon.tpl' svgId='delete'}
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="box_btn_heading mt-1">
						<button type="button" class="btn btn_mini btn-info fn_add_variant">
							{include file='svg_icon.tpl' svgId='plus'}
							<span>Добавить вариант</span>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-6 col-md-12 pr-0 ">
			<div class="boxed fn_toggle_wrap min_height_210px">
				<div class="heading_box">
					Свойства товара
					<div class="toggle_arrow_wrap fn_toggle_card text-primary">
						<a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
					</div>
				</div>
				<div class="toggle_body_wrap on fn_card">
					<div class="features_wrap fn_features_wrap">
						{foreach $features as $feature}
						{assign var=feature_id value=$feature->id}
						<div class="feature_row clearfix">
							<span feature_id={$feature_id}>
								<div class="feature_name">
									<span title="{$feature->name}">{$feature->name}</span>
								</div>
								<div class="feature_value">
									<input class="feature_input fn_auto_option" type="text" name="options[{$feature_id}]" value="{$options.$feature_id->value|escape}" />
								</div>
							</span>
						</div>
						{/foreach}
						<div class="fn_new_feature">
							<div feature_id="" class="new_feature_row clearfix">
								<div class="wrap_inner_new_feature">
									<input type="text" class="new_feature new_feature_name" name="new_features_names[]" placeholder="Введите имя" />
									<input type="text" class="new_feature new_feature_value"  name="new_features_values[]" placeholder="Введите свойство"/>
								</div>
								<span class="fn_delete_feature btn_close delete_feature">
									{include file='svg_icon.tpl' svgId='delete'}
								</span>
							</div>
						</div>
					</div>
					<div class="box_btn_heading mt-1">
						<button type="button" class="btn btn_mini btn-info fn_add_feature">
							{include file='svg_icon.tpl' svgId='plus'}
							<span>Добавить свойство</span>
						</button>
					</div>
				</div>
			</div>
		</div>
		<div class="col-lg-6 col-md-12">
			<div class="boxed fn_toggle_wrap min_height_210px">
				<div class="heading_box">
					Рекомендуемые товары
					<div class="toggle_arrow_wrap fn_toggle_card text-primary">
						<a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
					</div>
				</div>
				<div class="toggle_body_wrap on fn_card fn_sort_list">
					<div class="turbo_list ok_related_list">
						<div class="turbo_list_body related_products sortable">
							{foreach $related_products as $related_product}
							<div class="fn_row turbo turbo_list_body_item fn_sort_item">
								<div class="turbo_list_row">
									<div class="turbo_list_boding turbo_list_drag move_zone">
										{include file='svg_icon.tpl' svgId='drag_vertical'}
									</div>
									<div class="turbo_list_boding turbo_list_related_photo">
										<input type="hidden" name="related_products[]" value="{$related_product->id}">
										<a href="{url module=ProductAdmin id=$related_product->id}">
											{if $related_product->images[0]}
												<img class="product_icon" src='{$related_product->images[0]->filename|resize:40:40}'>
											{else}
												<img class="product_icon" src="design/images/no_image.png" width="40">
											{/if}
										</a>
									</div>
									<div class="turbo_list_boding turbo_list_related_name">
										<a class="link" href="{url module=ProductAdmin id=$related_product->id}">{$related_product->name|escape}</a>
									</div>
									<div class="turbo_list_boding turbo_list_close">
										<button data-hint="Удалить товар" type="button" class="btn_close fn_remove_item hint-bottom-right-t-info-s-small-mobile  hint-anim">
											{include file='svg_icon.tpl' svgId='delete'}
										</button>
									</div>
								</div>
							</div>
							{/foreach}
							<div id="new_related_product" class="fn_row turbo turbo_list_body_item fn_sort_item" style='display:none;'>
								<div class="turbo_list_row">
									<div class="turbo_list_boding turbo_list_drag move_zone">
										{include file='svg_icon.tpl' svgId='drag_vertical'}
									</div>
									<div class="turbo_list_boding turbo_list_related_photo">
										<input type="hidden" name="related_products[]" value="">
										<img class="product_icon" src="">
									</div>
									<div class="turbo_list_boding turbo_list_related_name">
										<a class="link related_product_name" href=""></a>
									</div>
									<div class="turbo_list_boding turbo_list_close">
										<button data-hint="Удалить товар" type="button" class="btn_close fn_remove_item hint-bottom-right-t-info-s-small-mobile  hint-anim">
											{include file='svg_icon.tpl' svgId='delete'}
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="heading_label">Добавить рекомендуемый товар</div>
					<div class="autocomplete_arrow">
						<input type="text" name="related" id="related_products" class="form-control" placeholder='Выберите товар'>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-12 col-md-12">
			<div class="boxed match fn_toggle_wrap">
				<div class="heading_box">
					Мета-данные
					<div class="toggle_arrow_wrap fn_toggle_card text-primary">
						<a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
					</div>
				</div>
				<div class="toggle_body_wrap on fn_card row">
					<div class="col-lg-6 col-md-6">
						<div class="heading_label" >Meta-title</div>
						<input name="meta_title" class="form-control fn_meta_field mb-h" type="text" value="{$product->meta_title|escape}" />
						<div class="heading_label" >Meta-keywords</div>
						<input name="meta_keywords" class="form-control fn_meta_field mb-h" type="text" value="{$product->meta_keywords|escape}" />
					</div>
					<div class="col-lg-6 col-md-6 pl-0">
						<div class="heading_label" >Meta-description</div>
						<textarea name="meta_description" class="form-control turbo_textarea fn_meta_field">{$product->meta_description|escape}</textarea>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-12 col-md-12">
			<div class="boxed match fn_toggle_wrap tabs">
				<div class="heading_tabs">
					<div class="tab_navigation">
						<a href="#tab1" class="heading_box tab_navigation_link">Краткое описание</a>
						<a href="#tab2" class="heading_box tab_navigation_link">Полное описание</a>
					</div>
					<div class="toggle_arrow_wrap fn_toggle_card text-primary">
						<a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
					</div>
				</div>
				<div class="toggle_body_wrap on fn_card">
					<div class="tab_container">
						<div id="tab1" class="tab">
							<textarea name="annotation" id="annotation" class="editor_small">{$product->annotation|escape}</textarea>
						</div>
						<div id="tab2" class="tab">
							<textarea id="fn_editor" name="body" class="editor_large fn_editor_class">{$product->body|escape}</textarea>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12 col-md-12 mt-1">
						<button type="submit" name="" class="btn btn_small btn_green float-md-right">
							{include file='svg_icon.tpl' svgId='checked'}
							<span>Применить</span>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
{* Подключаем Tiny MCE *}
{include file='tinymce_init.tpl'}
{* On document load *}
{literal}
<script src="design/js/autocomplete/jquery.autocomplete-min.js"></script>
<script src="design/js/chosen/chosen.jquery.js"></script>
<link rel="stylesheet" type="text/css" href="design/js/chosen/chosen.min.css" media="screen" />
<script>
	$(window).on("load", function() {
		$(document).on("click", ".fn_show_images",function () {
			$(this).prev().find($(".fn_toggle_hidden")).toggleClass("hidden");
		});
		
		// Удаление товара
		$(document).on( "click", ".fn_remove_item", function() {
			$(this).closest(".fn_row").fadeOut(200, function() { $(this).remove(); });
			return false;
		});
		$(".chosen").chosen('chosen-select');
		$(document).on("input", ".fn_rating", function () {
			$(".fn_show_rating").html($(this).val());
			$(".fn_rating_value").val($(this).val());
		});
		
		// Добавление категории
		$('#product_categories .add').click(function() {
			$("#product_categories .product_cats span.list:last").clone(false).appendTo('#product_categories .product_cats').fadeIn('slow').find("select[name*=categories]:last").focus();
			$("#product_categories .product_cats span.list:last span.add").hide();
			$("#product_categories .product_cats span.list:last span.delete").show();
			return false;		
		});
		
		// Удаление категории
        $(document).on("click", "#product_categories .delete", function () {
			$(this).closest(".list").remove();
			return false;
		});
		var image_item_clone = $(".fn_new_image_item").clone(true);
		$(".fn_new_image_item").remove();
		var new_image_tem_clone = $(".fn_new_spec_image_item").clone(true);
		$(".fn_new_spec_image_item").remove();
		
		// Или перетаскиванием
		if(window.File && window.FileReader && window.FileList) {
			$(".fn_dropzone").on('dragover', function (e){
				e.preventDefault();
				$(this).css('background', '#bababa');
			});
			$(".fn_dropzone").on('dragleave', function(){
				$(this).css('background', '#f8f8f8');
			});
			function handleFileSelect(evt){
				dropInput = $(this).closest(".fn_droplist_wrap").find("input.dropinput:last").clone();
				var parent = $(this).closest(".fn_droplist_wrap");
				var files = evt.target.files; // FileList object
				// Loop through the FileList and render image files as thumbnails.
				for (var i = 0, f; f = files[i]; i++) {
					// Only process image files.
					if (!f.type.match('image.*')) {
						continue;
					}
					var reader = new FileReader();
					// Closure to capture the file information.
					reader.onload = (function(theFile) {
						return function(e) {
							// Render thumbnail.
							if(parent.data('image') == "product"){
								var clone_item = image_item_clone.clone(true);
								} else if(parent.data('image') == "special") {
								var clone_item = new_image_tem_clone.clone(true);
							}
							clone_item.find("img").attr("onerror",'');
							clone_item.find("img").attr("src", e.target.result);
							clone_item.find("input").val(theFile.name);
							clone_item.appendTo(parent);
							temp_input =  dropInput.clone();
							parent.find("input.dropinput").hide();
							parent.find(".fn_dropzone").append(temp_input);
						};
					})(f);
					// Read in the image file as a data URL.
					reader.readAsDataURL(f);
				}
				$(".fn_dropzone").removeAttr("style");
			}
			$(document).on('change','.dropinput',handleFileSelect);
		}
		$(document).on("click", ".fn_remove_image", function () {
			$(this).closest("li").remove();
		});
		$(document).on("click", ".fn_change_special", function () {
			if($(this).closest('li').hasClass("product_special")) {
				$(this).closest("ul").find("input[type=radio]").attr("checked", false);
				$(this).closest("li").removeClass("product_special");
				$(this).text($(this).data("origin"));
				} else {
				$(this).closest("ul").find("input[type=radio]").attr("checked", false);
				$(this).closest("li").removeClass("product_special");
				$(this).closest("li").find("input[type=radio]").attr("checked", true).click();
				$(this).closest("ul").find("li").removeClass("product_special");
				$(this).closest("li").addClass("product_special");
				$(this).text($(this).data("result"));
			}
		});
		$(document).on("click",".fn_remove_variant",function () {
			$(this).closest(".variants_list_item ").fadeOut(200);
			$(this).closest(".variants_list_item ").remove();
		});
		
		// Добавление варианта
		var variant = $(".fn_new_row_variant").clone(false);
		$(".fn_new_row_variant").remove();
		variant.find('.bootstrap-select').replaceWith(function() { return $('select', this); });
		$(document).on("click", ".fn_add_variant", function () {
			var variant_clone = variant.clone(true);
			variant_clone.find("select").selectpicker();
			variant_clone.removeClass("hidden").removeClass("fn_new_row_variant");
			$(".variants_listadd").append(variant_clone);
			return false;
		});
		function show_category_features(category_id)
		{
			$('div.fn_features_wrap').empty();
			$.ajax({
				url: "ajax/get_features.php",
				data: {category_id: category_id, product_id: $("input[name=id]").val()},
				dataType: 'json',
				success: function(data){
					for(i=0; i<data.length; i++)
					{
						feature = data[i];
						line = $("<div class='fn_new_feature_category feature_row clearfix'><div class='feature_name'><span title='' class='fn_feature_name'></span></div><div class='feature_value'><input class='feature_input fn_auto_option' type='text'/></div></div>");
						var new_line = line.clone(true);
						new_line.find(".feature_name span").text(feature.name);
						new_line.find("input").attr('name', "options["+feature.id+"]").val(feature.value);
						new_line.appendTo('div.fn_features_wrap').find("input")
						.autocomplete({
							serviceUrl:'ajax/options_autocomplete.php',
							minChars:0,
							params: {feature_id:feature.id},
							noCache: false
						});
					}
				}
			});
			return false;
		}
		
		// Изменение набора свойств при изменении категории
		$('select[name="categories[]"]:first').change(function() {
			show_category_features($("option:selected",this).val());
		});
		
		// Автодополнение свойств
		$('div.fn_features_wrap input[name*=options]').each(function(index) {
			feature_id = $(this).closest('span').attr('feature_id');
			$(this).autocomplete({
				serviceUrl:'ajax/options_autocomplete.php',
				minChars:0,
				params: {feature_id:feature_id},
				noCache: false
			});
		}); 
		
		// Добавление нового свойства товара
		var new_feature = $(".fn_new_feature").clone(true);
		$(".fn_new_feature").remove();
		new_feature.removeClass("fn_new_feature");
		$(document).on("click",".fn_add_feature",function () {
			$(new_feature).clone(true).appendTo(".features_wrap").fadeIn('slow');
			return false;
		});
		$(document).on("click",".fn_delete_feature",function () {
			$(this).parent().remove();
		});
		
		// Добавление связанного товара
		var new_related_product = $('#new_related_product').clone(true);
		$('#new_related_product').remove();
		new_related_product.removeAttr('id');
		$("input#related_products").autocomplete({
			serviceUrl:'ajax/search_products.php',
			minChars:0,
			noCache: false,
			onSelect:
			function(suggestion){
				$("input#related_products").val('').focus().blur();
				new_item = new_related_product.clone().appendTo('.related_products');
				new_item.find('a.related_product_name').html(suggestion.data.name);
				new_item.find('a.related_product_name').attr('href', 'index.php?module=ProductAdmin&id='+suggestion.data.id);
				new_item.find('input[name*="related_products"]').val(suggestion.data.id);
				if(suggestion.data.image)
				new_item.find('img.product_icon').attr("src", suggestion.data.image);
				else
				new_item.find('img.product_icon').remove();
				new_item.show();
			},
			formatResult:
			function(suggestions, currentValue){
				var reEscape = new RegExp('(\\' + ['/', '.', '*', '+', '?', '|', '(', ')', '[', ']', '{', '}', '\\'].join('|\\') + ')', 'g');
				var pattern = '(' + currentValue.replace(reEscape, '\\$1') + ')';
				return "<div>" + (suggestions.data.image?"<img align=absmiddle src='"+suggestions.data.image+"'> ":'') + "</div>" +  "<span>" + suggestions.value.replace(new RegExp(pattern, 'gi'), '<strong>$1<\/strong>') + "</span>";
			}
		});
		// infinity
		$("input[name*=variant][name*=stock]").focus(function() {
			if($(this).val() == '∞')
			$(this).val('');
			return false;
		});
		$("input[name*=variant][name*=stock]").blur(function() {
			if($(this).val() == '')
			$(this).val('∞');
		});
	});
</script>
{/literal}