<?php
/**
 * Turbo CMS
 *
 * @author 		Turbo CMS
 * @link 		https://turbo-cms.com
 *
 * Этот класс использует шаблон products.tpl
 *
 */
 
require_once('View.php');

class ProductsView extends View
{
 	/**
	 *
	 * Отображение списка товаров
	 *
	 */	
	function fetch()
	{
		// GET-Параметры
		$category_url = $this->request->get('category', 'string');
		$brand_url    = $this->request->get('brand', 'string');
		$mode    = $this->request->get('mode', 'string');
		
		$filter = array();
		$filter['visible'] = 1;	

		if ($mode == 'hits')
		{
			$filter['featured'] = 1;
		}

		if ($mode == 'new')
		{
			$filter['new'] = 1;
		}
		if ($mode == 'sale')
		{
			$filter['discounted'] = 1;
		}  
        
       	$current_min_price = $this->request->post('min_price');
		$current_max_price = $this->request->post('max_price');
		
		$rate_from = $this->request->post('rate_from');
		$rate_to = $this->request->post('rate_to');

		if( !isset($rate_from) )
			$rate_from = 1;
			
		if( !isset($rate_to) )
			$rate_to = 1;
		
		$filter['min_price'] = $current_min_price / $rate_from * $rate_to;
		$filter['max_price'] = $current_max_price / $rate_from * $rate_to;
        
        // Если задан бренд, выберем его из базы
		if (!empty($brand_url))
		{
			$brand = $this->brands->get_brand((string)$brand_url);
			if (empty($brand))
				return false;
			$this->design->assign('brand', $brand);
			$filter['brand_id'] = $brand->id;
		}
        elseif($this->request->get('b')){
            $filter['brand_id'] = (array)$this->request->get('b');
        }
		
		// Выберем текущую категорию
		if (!empty($category_url))
		{
			$category = $this->categories->get_category((string)$category_url);
			if (empty($category) || (!$category->visible && empty($_SESSION['admin'])))
				return false;
			$this->design->assign('category', $category);
			$filter['category_id'] = $category->children;
		}

		// Если задано ключевое слово
		$keyword = $this->request->get('keyword');
		if (!empty($keyword))
		{
			$this->design->assign('keyword', $keyword);
			$filter['keyword'] = $keyword;
		}

		// Сортировка товаров, сохраняем в сесси, чтобы текущая сортировка оставалась для всего сайта
		if($sort = $this->request->get('sort', 'string'))
			$_SESSION['sort'] = $sort;		
		if (!empty($_SESSION['sort']))
			$filter['sort'] = $_SESSION['sort'];			
		else
			$filter['sort'] = 'position';			
		$this->design->assign('sort', $filter['sort']);
        
        $price_products = array();
		$price_products_ids = array();
		foreach($this->products->get_products($filter) as $p)
			$price_products[$p->id] = $p;
		if(!empty($price_products))
			$price_products_ids = array_keys($price_products);
		
		// Свойства товаров
		if(!empty($category))
		{
			$features = array();
            $filter['features'] = array();
			foreach($this->features->get_features(array('category_id'=>$category->id, 'in_filter'=>1)) as $feature)
			{ 
				$features[$feature->id] = $feature;
				if(($val = $this->request->get($feature->id))!='')
                    $filter['features'][$feature->id] = $val;	
			}
			
			$options_filter['visible'] = 1;
			
			$features_ids = array_keys($features);
			if(!empty($features_ids))
				$options_filter['feature_id'] = $features_ids;
			$options_filter['category_id'] = $category->children;
			if(isset($filter['features']))
				$options_filter['features'] = $filter['features'];
			if(!empty($brand))
				$options_filter['brand_id'] = $brand->id;
            if(!empty($price_products_ids))
				$options_filter['product_id'] = $price_products_ids;
			
			$options = $this->features->get_options($options_filter);

			foreach($options as $option)
			{
				if(isset($features[$option->feature_id]))
					$features[$option->feature_id]->options[] = $option;
			}
			
			foreach($features as $i=>&$feature)
			{ 
				if(empty($feature->options))
					unset($features[$i]);
			}

			$this->design->assign('features', $features);
            $this->design->assign('filter_features', $filter['features']);
 		}

		// Постраничная навигация
		$items_per_page = $this->settings->products_num;		
		// Текущая страница в постраничном выводе
		$current_page = $this->request->get('page', 'integer');
		// Если не задана, то равна 1
		$current_page = max(1, $current_page);
		$this->design->assign('current_page_num', $current_page);
		// Вычисляем количество страниц
		$products_count = $this->products->count_products($filter);
		
		// Показать все страницы сразу
		if($this->request->get('page') == 'all')
			$items_per_page = $products_count;	
		
		$pages_num = ceil($products_count/$items_per_page);
		$this->design->assign('total_pages_num', $pages_num);
		$this->design->assign('total_products_num', $products_count);

		$filter['page'] = $current_page;
		$filter['limit'] = $items_per_page;
		
		///////////////////////////////////////////////
		// Постраничная навигация END
		///////////////////////////////////////////////
		
		$discount = 0;
		if(isset($_SESSION['user_id']) && $user = $this->users->get_user(intval($_SESSION['user_id'])))
			$discount = $user->discount;
			
		// Товары 
		$products = array();
		foreach($this->products->get_products($filter) as $p)
			$products[$p->id] = $p;
			
		// Если искали товар и найден ровно один - перенаправляем на него
		if(!empty($keyword) && $products_count == 1)
			header('Location: '.$this->config->root_url.'/products/'.$p->url);
		
		if(!empty($products))
		{
			$products_ids = array_keys($products);
			foreach($products as &$product)
			{
				$product->variants = array();
				$product->images = array();
				$product->properties = array();
			}
	
			$variants = $this->variants->get_variants(array('product_id'=>$products_ids, 'in_stock'=>true));
			
			foreach($variants as &$variant)
			{
				$products[$variant->product_id]->variants[] = $variant;
			}
	
			$images = $this->products->get_images(array('product_id'=>$products_ids));
			foreach($images as $image)
				$products[$image->product_id]->images[] = $image;

			foreach($products as &$product)
			{
				if(isset($product->variants[0]))
					$product->variant = $product->variants[0];
				if(isset($product->images[0]))
					$product->image = $product->images[0];
			}
				
            $this->design->assign('products', $products);
 		}
		
		unset($filter['min_price']);
		unset($filter['max_price']);
		unset($filter['limit']);
		foreach($this->products->get_products($filter) as $p)
			$products_prices[$p->id] = $p;

		if(!empty($products_prices))
		{
			$prices_products_ids = array_keys($products_prices);
			$prices_variants = $this->variants->get_variants(array('product_id'=>$prices_products_ids));
			foreach($prices_variants as &$prices_variant)
				$prices[] = $prices_variant->price;
		}

		$min_price = 0;
		$max_price = 0;
		if (!empty($prices)) {
			$min_price = min($prices);
			$max_price = max($prices);
		}
		
		if(!isset($current_min_price) && empty($current_min_price))
			$current_min_price = $min_price;
		if(!isset($current_max_price) && empty($current_max_price))
			$current_max_price = $max_price;
			
		$this->design->assign('minprice', $min_price);
		$this->design->assign('maxprice', $max_price);
		$this->design->assign('current_minprice', $current_min_price * $rate_to / $rate_from);
		$this->design->assign('current_maxprice', $current_max_price * $rate_to / $rate_from);
        
        // Выбираем бренды, они нужны нам в шаблоне	
		if(!empty($category))
		{
			$brands = $this->brands->get_brands($filter);
            $category->brands = $brands;		
		}
		
		// Устанавливаем мета-теги в зависимости от запроса
		if($this->page)
		{
			$this->design->assign('meta_title', $this->page->meta_title);
			$this->design->assign('meta_keywords', $this->page->meta_keywords);
			$this->design->assign('meta_description', $this->page->meta_description);
		}
		elseif(isset($category))
		{
			$this->design->assign('meta_title', $category->meta_title);
			$this->design->assign('meta_keywords', $category->meta_keywords);
			$this->design->assign('meta_description', $category->meta_description);
		}
		elseif(isset($brand))
		{
			$this->design->assign('meta_title', $brand->meta_title);
			$this->design->assign('meta_keywords', $brand->meta_keywords);
			$this->design->assign('meta_description', $brand->meta_description);
		}
		elseif(isset($keyword))
		{
			$this->design->assign('meta_title', $keyword);
		}
			
		$this->body = $this->design->fetch('products.tpl');
		return $this->body;
	}
}