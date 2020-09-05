{* Title *}
{$meta_title='Бренды' scope=parent}

<div class="row">
    <div class="col-lg-7 col-md-7">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                Бренды
            </div>
            <div class="box_btn_heading">
                <a class="btn btn_small btn-info" href="{url module=BrandAdmin return=$smarty.server.REQUEST_URI}">
                    {include file='svg_icon.tpl' svgId='plus'}
                    <span>Добавить бренд</span>
                </a>
            </div>
        </div>
    </div>
</div>

<div class="boxed fn_toggle_wrap">
    {if $brands}
        <form method="post" class="fn_form_list">
            <input type="hidden" name="session_id" value="{$smarty.session.id}" />

            <div class="turbo_list products_list fn_sort_list">
                <div class="turbo_list_head">
                    <div class="turbo_list_heading turbo_list_check">
                        <input class="hidden_check fn_check_all" type="checkbox" id="check_all_1" name="" value="" />
                        <label class="turbo_ckeckbox" for="check_all_1"></label>
                    </div>
                    <div class="turbo_list_heading turbo_list_photo">Фото</div>
                    <div class="turbo_list_heading turbo_list_brands_name">Название</div>
                    <div class="turbo_list_heading turbo_list_status">Активность</div>
                    <div class="turbo_list_heading turbo_list_setting">Действия</div>
                    <div class="turbo_list_heading turbo_list_close"></div>
                </div>
                <div class="turbo_list_body sortable">
                    {foreach $brands as $brand}
                        <div class="fn_row turbo_list_body_item fn_sort_item body_narrow">
                            <div class="turbo_list_row narrow">
                            	
								<div class="turbo_list_boding turbo_list_check">
									<input class="hidden_check" type="checkbox" id="id_{$brand->id}" name="check[]" value="{$brand->id}" />
									<label class="turbo_ckeckbox" for="id_{$brand->id}"></label>
								</div>

								<div class="turbo_list_boding turbo_list_photo small_photo boding_small">
									{if $brand->image}
										<a href="{url module=BrandAdmin id=$brand->id return=$smarty.server.REQUEST_URI}">
											<img src="{$brand->image|resize_brands:35:35}" alt="" />
										</a>
									{else}
										 <a href="{url module=BrandAdmin id=$brand->id return=$smarty.server.REQUEST_URI}">
											<i class="fa fa-picture-o fa-2-2x mt-w" aria-hidden="true"></i>
										  </a>  
									{/if}
								</div>

								<div class="turbo_list_boding turbo_list_brands_name">
									<a href="{url module=BrandAdmin id=$brand->id return=$smarty.server.REQUEST_URI}">
										{$brand->name|escape}
									</a>
								</div>

                                <div class="turbo_list_boding turbo_list_status">
                                    {*visible*}
                                     <label class="switch switch-default ">
                                        <input class="switch-input fn_ajax_action {if $brand->visible}fn_active_class{/if}" data-module="brands" data-action="visible" data-id="{$brand->id}" name="visible" value="1" type="checkbox"  {if $brand->visible}checked=""{/if}/>
                                        <span class="switch-label"></span>
                                        <span class="switch-handle"></span>
                                    </label>
                                </div>

                                <div class="turbo_list_setting">
                                    <a href="../brands/{$brand->url|escape}" target="_blank" data-hint="Посмотреть на сайте" class="setting_icon setting_icon_open hint-bottom-middle-t-info-s-small-mobile  hint-anim">
                                        {include file='svg_icon.tpl' svgId='icon_desktop'}
                                    </a>
                                </div>

                                <div class="turbo_list_boding turbo_list_close">
                                    {*delete*}
                                    <button data-hint="Удалить бренд" type="button" class="btn_close fn_remove hint-bottom-right-t-info-s-small-mobile  hint-anim" data-toggle="modal" data-target="#fn_action_modal" onclick="success_action($(this));">
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
            <div class="text_grey">Нет брендов</div>
        </div>
    {/if}
</div>