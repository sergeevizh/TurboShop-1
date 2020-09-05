// Аяксовая корзина
$(document).ready(function() {
	
    $('form.variants').submit (function(e) {e.preventDefault();
        button=$(this).find('input[type="submit"]');
        if($(this).find('select[name=variant]').length>0)
        variant=$(this).find('select').val();
        if($(this).find('input[name=variant]:checked').length>0)
        variant=$(this).find('input[name=variant]:checked').val();
        
        $.ajax({
            url:"ajax/cart.php",
            data:{variant:variant},
            dataType:'json',success:function(data){$('#cart_informer').html(data);
                if(button.attr('data-result-text'))button.val(button.attr('data-result-text'));
            }});
            var o1 = $(this).offset();
            var o2 = $('#cart_informer').offset();
            var dx = o1.left - o2.left;
            var dy = o1.top - o2.top;
            var distance = Math.sqrt(dx * dx + dy * dy);
            $(this).closest('.product').find('.image img').effect("transfer", { to: $("#cart_informer"), className: "transfer_class" }, distance);	
            $('.transfer_class').html($(this).closest('.product').find('.image').html());
            $('.transfer_class').find('img').css('height', '100%');
            return false;
    });
});

// Замена цены товара
$('select[name=variant]').on('change',  function() {
	var price = $(this).find('option:selected').data('price'),
	sku = $(this).find('option:selected').data('sku'),
	compare = $(this).find('option:selected').data('compare')
	$('.offers_price .price_value').html(price)
	$('.offers_price_old .price_value').html(compare)
	$('.article .value').html(sku)
});

// Избранное
$('a.wishlist').on('click', function(e) {
      href = $(this).attr('href');
          $('#wishlist_informer').load(href+' #wishlist_informer');
          $(this).removeClass('wishlist');
          $(this).attr('href', 'wishlist');
    	  $(this).html("<i class='fa fa-heart text-danger'></i>");          
    	var o1 = $(this).offset();
    	var o2 = $('#wishlist_informer').offset();
    	var dx = o1.left - o2.left;
    	var dy = o1.top - o2.top;
    	var distance = Math.sqrt(dx * dx + dy * dy);
    	$(this).closest('.product').find('.image img').effect("transfer", { to: $("#wishlist_informer"), className: "transfer_class" }, distance);
    	$('.transfer_class').html($(this).closest('.product').find('.image').html());
    	$('.transfer_class').find('img').css('height', '100%');
    	return false;

});

// Сравнение
$('a.compare').on('click', function(e) {
      href = $(this).attr('href');
          $('#compare_informer').load(href+' #compare_informer');
          $(this).removeClass('compare');
          $(this).attr('href', 'compare');
    			$(this).html("<i class='fa fa-chart-bar text-primary'></i>");          
    	var o1 = $(this).offset();
    	var o2 = $('#compare_informer').offset();
    	var dx = o1.left - o2.left;
    	var dy = o1.top - o2.top;
    	var distance = Math.sqrt(dx * dx + dy * dy);
    	$(this).closest('.product').find('.image img').effect("transfer", { to: $("#compare_informer"), className: "transfer_class" }, distance);
    	$('.transfer_class').html($(this).closest('.product').find('.image').html());
    	$('.transfer_class').find('img').css('height', '100%');
    	return false;

});

// Избранное
$('a.wishlist-list').on('click', function(e) {
      href = $(this).attr('href');
          $('#wishlist_informer').load(href+' #wishlist_informer');
          $(this).removeClass('wishlist-list');
          $(this).attr('href', 'wishlist');
    	  $(this).html("<i class='fa fa-heart text-danger'></i> В избранном");          
    	var o1 = $(this).offset();
    	var o2 = $('#wishlist_informer').offset();
    	var dx = o1.left - o2.left;
    	var dy = o1.top - o2.top;
    	var distance = Math.sqrt(dx * dx + dy * dy);
    	$(this).closest('.product').find('.image img').effect("transfer", { to: $("#wishlist_informer"), className: "transfer_class" }, distance);
    	$('.transfer_class').html($(this).closest('.product').find('.image').html());
    	$('.transfer_class').find('img').css('height', '100%');
    	return false;

});

// Сравнение
$('a.compare-list').on('click', function(e) {
      href = $(this).attr('href');
          $('#compare_informer').load(href+' #compare_informer');
          $(this).removeClass('compare-list');
          $(this).attr('href', 'compare');
    			$(this).html("<i class='fa fa-chart-bar text-primary'></i> В сравнении");          
    	var o1 = $(this).offset();
    	var o2 = $('#compare_informer').offset();
    	var dx = o1.left - o2.left;
    	var dy = o1.top - o2.top;
    	var distance = Math.sqrt(dx * dx + dy * dy);
    	$(this).closest('.product').find('.image img').effect("transfer", { to: $("#compare_informer"), className: "transfer_class" }, distance);
    	$('.transfer_class').html($(this).closest('.product').find('.image').html());
    	$('.transfer_class').find('img').css('height', '100%');
    	return false;

});