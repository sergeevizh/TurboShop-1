{* Title *}
{if $category}
    {$meta_title=$category->name scope=parent}
{else}
    {$meta_title='Товары' scope=parent}
{/if}

<div class="row">
    <div class="col-lg-7 col-md-12">
        <div class="wrap_heading">
            {if $products_count}
            <div class="box_heading heading_page">
                {if $category->name || $brand->name}
                    {$category->name} {$brand->name} ({$products_count} {$products_count|plural:'товар':'товаров':'товара'})
                {elseif $keyword}
                    {$products_count|plural:'Найден':'Найдено':'Найдено'} {$products_count} {$products_count|plural:'товар':'товаров':'товара'}
                {else}
                    {$products_count} {$products_count|plural:'товар':'товаров':'товара'}
                {/if}		
            </div>
            {else}
            <div class="box_heading heading_page">Нет товаров</div>
            {/if}
			<div class="box_btn_heading">
                <a class="btn btn_small btn-info" href="{url module=ProductAdmin return=$smarty.server.REQUEST_URI}">
                    {include file='svg_icon.tpl' svgId='plus'}
                    <span>Добавить товар</span>
                </a>
            </div>
        </div>
    </div>
    <div class="col-md-12 col-lg-5 col-xs-12 float-xs-right">
        <div class="boxed_search">
            <form class="search" method="get">
                <input type="hidden" name="module" value="ProductsAdmin">
                <div class="input-group">
                    <input name="keyword" class="form-control" placeholder="поиск товара..." type="text" value="{$keyword|escape}" >
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
        <div class="col-lg-12 col-md-12 ">
            <div class="boxed_sorting">
                <div class="row">
                    <div class="col-md-3 col-lg-3 col-sm-12">
                        <div>
                            <select id="id_filter" name="products_filter" class="selectpicker form-control" title="Фильтр по товарам" data-live-search="true" onchange="location = this.value;">
                                <option value="{url brand_id=null category_id=null keyword=null page=null limit=null filter=null}" {if !$filter}selected{/if}>Все товары</option>
                                <option value="{url keyword=null brand_id=null category_id=null page=null limit=null filter='featured'}" {if $filter == 'featured'}selected{/if}>Хиты продаж</option>
                                <option value="{url keyword=null brand_id=null category_id=null page=null limit=null filter='discounted'}" {if $filter == 'discounted'}selected{/if}>Со скидкой</option>
                                <option value="{url keyword=null brand_id=null category_id=null page=null limit=null filter='visible'}" {if $filter == 'visible'}selected{/if}>Активные</option>
                                <option value="{url keyword=null brand_id=null category_id=null page=null limit=null filter='hidden'}" {if $filter == 'hidden'}selected{/if}>Неактивные</option>
                                <option value="{url keyword=null brand_id=null category_id=null page=null limit=null filter='outofstock'}" {if $filter == 'outofstock'}selected{/if}>Отсутствующие</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3 col-lg-3 col-sm-12">
                        <select id="id_categories" name="categories_filter" title="Фильтр по категориям" class="selectpicker form-control" data-live-search="true" data-size="10" onchange="location = this.value;">
                            <option value="{url keyword=null brand_id=null page=null limit=null category_id=null}" {if !$category}selected{/if}>Все категории</option>
                            {function name=category_select level=0}
                                {foreach $categories as $c}
                                    <option value='{url keyword=null brand_id=null page=null limit=null category_id=$c->id}' {if $category->id == $c->id}selected{/if}>
                                        {section sp $level}- {/section}{$c->name|escape}
                                    </option>
                                {category_select categories=$c->subcategories level=$level+1}
                                {/foreach}
                            {/function}
                            {category_select categories=$categories}
                        </select>
                    </div>
                    <div class="col-md-3 col-lg-3 col-sm-12">
                        <select id="id_brands" name="brands_filter" title="Фильтр по брендам" class="selectpicker form-control" data-live-search="true" data-size="10" onchange="location = this.value;">
                            <option value="{url keyword=null brand_id=null page=null limit=null category_id=null}" {if !$brand}selected{/if}>Все бренды</option>
                            {foreach $brands as $b}
                            <option value="{url keyword=null page=null limit=null brand_id=$b->id}" brand_id="{$b->id}"  {if $brand->id == $b->id}selected{/if}>{$b->name}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </div>
    {if $products}
    <div class="row">
        {* Основная форма *}
        <div class="col-lg-12 col-md-12 col-sm-12">
            <form method="post" class="fn_form_list">
                <input type="hidden" name="session_id" value="{$smarty.session.id}">
                <div class="turbo_list products_list fn_sort_list">
                    <div class="turbo_list_head">
                        <div class="turbo_list_boding turbo_list_drag"></div>
                        <div class="turbo_list_heading turbo_list_check">
                            <input class="hidden_check fn_check_all" type="checkbox" id="check_all_1" name="" value=""/>
                            <label class="turbo_ckeckbox" for="check_all_1"></label>
                        </div>
                        <div class="turbo_list_heading turbo_list_photo">Фото</div>
                        <div class="turbo_list_heading turbo_list_name">Название </div>
                        <div class="turbo_list_heading turbo_list_price">Цена</div>
                        <div class="turbo_list_heading turbo_list_count">К-во</div>
                        <div class="turbo_list_heading turbo_list_status">Активность</div>
                        <div class="turbo_list_heading turbo_list_setting turbo_list_products_setting">Действия</div>
                        <div class="turbo_list_heading turbo_list_close"></div>
                    </div>
                    <div id="" class="turbo_list_body sortable">
                        {foreach $products as $product}
                        <div class="fn_row turbo_list_body_item fn_sort_item">
                            <div class="turbo_list_row">
                                <input type="hidden" name="positions[{$product->id}]" value="{$product->position}">
                                <div class="turbo_list_boding turbo_list_drag move_zone">
                                    {include file='svg_icon.tpl' svgId='drag_vertical'}
                                </div>
                                <div class="turbo_list_boding turbo_list_check">
                                    <input class="hidden_check" type="checkbox" id="id_{$product->id}" name="check[]" value="{$product->id}"/>
                                    <label class="turbo_ckeckbox" for="id_{$product->id}"></label>
                                </div>
                                <div class="turbo_list_boding turbo_list_photo">
                                    {$image = $product->images|@first}
                                    {if $image}
                                    <a href="{url module=ProductAdmin id=$product->id return=$smarty.server.REQUEST_URI}">
                                    <img src="{$image->filename|escape|resize:55:55}"/></a>
                                    {else}
                                    <a href="{url module=ProductAdmin id=$product->id return=$smarty.server.REQUEST_URI}">
                                        <i class="fa fa-picture-o fa-3-3x mt-h4" aria-hidden="true"></i>
                                    </a>   
                                    {/if}
                                </div>
                                <div class="turbo_list_boding turbo_list_name">
                                    <a class="link" href="{url module=ProductAdmin id=$product->id return=$smarty.server.REQUEST_URI}">
                                        {$product->name|escape}
                                        {if $product->variants[0]->name}
                                        <span class="text_grey">({$product->variants[0]->name|escape})</span>
                                        {/if}
                                    </a>
                                    <div class="hidden-lg-up mt-q">
                                        <span class="text_primary text_600">{$product->variants[0]->price} {if isset($currencies[$product->variants[0]->currency_id])}
                                            {$currencies[$product->variants[0]->currency_id]->code|escape}
                                        {/if}</span>
                                        <span class="text_500">{if $product->variants[0]->infinity}∞{else}{$product->variants[0]->stock}{/if} {$settings->units|escape}</span>
                                    </div>
                                    {if $brands_name[$product->brand_id]->name}
                                    <div class="turbo_list_name_brand">Бренд {$brands_name[$product->brand_id]->name|escape}</div>
                                    {/if}
                                    {if $product->variants|count > 1}
                                    <div class="fn_variants_toggle variants_toggle">
                                        <span>Варианты</span>
                                        <i class="fn_icon_arrow fa fa-angle-down fa-lg m-t-2"></i>
                                    </div>
                                    {/if}
                                </div>
                                <div class="turbo_list_boding turbo_list_price">
                                    <div class="input-group">
                                        <input class="form-control {if $product->variants[0]->compare_price > 0}text_warning{/if}" type="text" name="price[{$product->variants[0]->id}]" value="{$product->variants[0]->price}">
                                        <span class="input-group-addon">
                                            {$currency->sign}
                                        </span>
                                    </div>
                                </div>
                                <div class="turbo_list_boding turbo_list_count">
                                    <div class="input-group">
                                        <input class="form-control " type="text" name="stock[{$product->variants[0]->id}]" value="{if $product->variants[0]->infinity}∞{else}{$product->variants[0]->stock}{/if}"/>
                                        <span class="input-group-addon  p-0">
                                            {$settings->units|escape}
                                        </span>
                                    </div>
                                </div>
                                {*visible*}
                                <div class="turbo_list_boding turbo_list_status">
                                    <label class="switch switch-default ">
                                        <input class="switch-input fn_ajax_action {if $product->visible}fn_active_class{/if}" data-module="product" data-action="visible" data-id="{$product->id}" name="visible" value="1" type="checkbox"  {if $product->visible}checked=""{/if}/>
                                        <span class="switch-label"></span>
                                        <span class="switch-handle"></span>
                                    </label>
                                </div>
                                <div class=" turbo_list_setting turbo_list_products_setting">
                                    {*Меню кнопок для планшета*}
                                    <div class="">
                                        {*open*}
                                        <a href="../products/{$product->url|escape}" target="_blank" data-hint="Посмотреть на сайте" class="setting_icon setting_icon_open hint-bottom-middle-t-info-s-small-mobile  hint-anim">
                                            {include file='svg_icon.tpl' svgId='icon_desktop'}
                                        </a>
                                        {*featured*}
                                        <button data-hint="Рекомендуем" type="button" class="setting_icon setting_icon_featured fn_ajax_action {if $product->featured}fn_active_class{/if} hint-bottom-middle-t-info-s-small-mobile  hint-anim" data-module="product" data-action="featured" data-id="{$product->id}" >
                                            {include file='svg_icon.tpl' svgId='icon_featured'}
                                        </button>
                                        {*copy*}
                                        <button data-hint="Дублировать товар" type="button" class="setting_icon setting_icon_copy fn_copy hint-bottom-middle-t-info-s-small-mobile  hint-anim">
                                            {include file='svg_icon.tpl' svgId='icon_copy'}
                                        </button>
                                    </div>
                                </div>
                                <div class="turbo_list_boding turbo_list_close">
                                    {*delete*}
                                    <button data-hint="Удалить товар" type="button" class="btn_close fn_remove hint-bottom-right-t-info-s-small-mobile  hint-anim" data-toggle="modal" data-target="#fn_action_modal" onclick="success_action($(this));">
                                        {include file='svg_icon.tpl' svgId='delete'}
                                    </button>
                                </div>
                            </div>
                            {if $product->variants|count > 1}
                            {*Если есть варианты товара*}
                            <div class="turbo_list_variants products_variants_block">
                                {foreach $product->variants as $variant}
                                {if $variant@iteration > 1}
                                <div class="turbo_list_row products">
                                    <div class="turbo_list_boding turbo_list_drag"></div>
                                    <div class="turbo_list_boding turbo_list_check"></div>
                                    <div class="turbo_list_boding turbo_list_photo"></div>
                                    <div class="turbo_list_boding turbo_list_variant_name">
                                        <span class="text_grey">{$variant->name|escape}</span>
                                    </div>
                                    <div class="turbo_list_boding turbo_list_price">
                                        <div class="input-group">
                                            <input class="form-control {if $product->variants[0]->compare_price > 0}text_warning{/if}" type="text" name="price[{$variant->id}]" value="{$variant->price}">
                                            <span class="input-group-addon">
                                                {$currency->sign}
                                            </span>
                                        </div>
                                    </div>
                                    <div class="turbo_list_boding turbo_list_count">
                                        <div class="input-group">
                                            <input class="form-control" type="text" name="stock[{$variant->id}]" value="{if $variant->infinity}∞{else}{$variant->stock}{/if}"/>
                                            <span class="input-group-addon p-0">
                                                {$settings->units|escape}
                                            </span>
                                        </div>
                                    </div>
                                    <div class="turbo_list_boding turbo_list_status"></div>
                                    <div class="turbo_list_boding turbo_list_close"></div>
                                </div>
                                {/if}
                                {/foreach}
                            </div>
                            {/if}
                        </div>
                        {/foreach}
                    </div>
                    <div class="turbo_list_footer fn_action_block">
                        <div class="turbo_list_foot_left">
                            <div class="turbo_list_boding turbo_list_drag"></div>
                            <div class="turbo_list_heading turbo_list_check">
                                <input class="hidden_check fn_check_all" type="checkbox" id="check_all_2" name="" value=""/>
                                <label class="turbo_ckeckbox" for="check_all_2"></label>
                            </div>
                            <div class="turbo_list_option">
                                <select name="action" class="selectpicker products_action">
                                    <option value="enable">Сделать видимыми</option>
                                    <option value="disable">Сделать невидимыми</option>
                                    <option value="set_featured">Сделать рекомендуемым</option>
                                    <option value="unset_featured">Отменить рекомендуемый</option>
                                    <option value="duplicate">Создать дубликат</option>
                                    {if $pages_count>1}
                                    <option value="move_to_page">Переместить на страницу</option>
                                    {/if}
                                    {if $categories|count>1}
                                    <option value="move_to_category">Переместить в категорию</option>
                                    {/if}
                                    {if $brands|count>0}
                                    <option value="move_to_brand">Указать бренд</option>
                                    {/if}
                                    <option value="delete">Удалить</option>
                                </select>
                            </div>
                            <div>
                                <div id="move_to_page" class="col-lg-12 col-md-12 col-sm-12 hidden fn_hide_block">
                                    <select name="target_page" class="selectpicker">
                                        {section target_page $pages_count}
                                        <option value="{$smarty.section.target_page.index+1}">{$smarty.section.target_page.index+1}</option>
                                        {/section}
                                    </select>
                                </div>
                                <div id="move_to_category" class="col-lg-12 col-md-12 col-sm-12 hidden fn_hide_block">
                                    <select name="target_category" class="selectpicker" data-live-search="true" data-size="10">
                                        {function name=category_select_btn level=0}
                                            {foreach $categories as $category}
                                                <option value="{$category->id}">{section sp $level}-{/section}{$category->name|escape}</option>
                                                {category_select_btn categories=$category->subcategories selected_id=$selected_id level=$level+1}
                                            {/foreach}
                                        {/function}
                                        {category_select_btn categories=$categories}
                                    </select>
                                </div>
                                <div id="move_to_brand" class="col-lg-12 col-md-12 col-sm-12 hidden fn_hide_block">
                                    <select name="target_brand" class="selectpicker" data-live-search="true" data-size="10">
                                        <option value="0">Не указан</option>
                                        {foreach $all_brands as $b}
                                        <option value="{$b->id}">{$b->name|escape}</option>
                                        {/foreach}
                                    </select>
                                </div>
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
        <div class="text_grey">Нет товаров</div>
    </div>
    {/if}
</div>
{literal}
<script>
    $(function() {
        $(document).on('click','.fn_variants_toggle',function(){
            $(this).find('.fn_icon_arrow').toggleClass('rotate_180');
            $(this).parents('.fn_row').find('.products_variants_block').slideToggle();
        });
        $(document).on('change','.fn_action_block select.products_action',function(){
            var elem = $(this).find('option:selected').val();
            $('.fn_hide_block').addClass('hidden');
            if($('#'+elem).size()>0){
                $('#'+elem).removeClass('hidden');
            }
        });
        $(document).on('click','.fn_show_icon_menu',function(){
            $(this).toggleClass('show');
        });
        // Дублировать товар
        $(document).on("click", ".fn_copy", function () {
            $('.fn_form_list input[type="checkbox"][name*="check"]').attr('checked', false);
            $(this).closest(".fn_form_list").find('select[name="action"] option[value=duplicate]').attr('selected', true);
            $(this).closest(".fn_row").find('input[type="checkbox"][name*="check"]').attr('checked', true);
            $(this).closest(".fn_row").find('input[type="checkbox"][name*="check"]').click();
            $(this).closest(".fn_form_list").submit();
        });
        // Бесконечность на складе
        $("input[name*=stock]").focus(function() {
            if($(this).val() == '∞')
            $(this).val('');
            return false;
        });
        $("input[name*=stock]").blur(function() {
            if($(this).val() == '')
            $(this).val('∞');
        });
    });
</script>
{/literal}