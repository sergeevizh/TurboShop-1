<?php
	
require_once('api/Turbo.php');

// Этот класс выбирает модуль в зависимости от параметра Section и выводит его на экран
class IndexAdmin extends Turbo
{
	// Соответсвие модулей и названий соответствующих прав
	private $modules_permissions = array(
		'ProductsAdmin'             => 'products',
		'ProductAdmin'              => 'products',
		'CategoriesAdmin'           => 'categories',
		'CategoryAdmin'             => 'categories',
		'BrandsAdmin'               => 'brands',
		'BrandAdmin'                => 'brands',
		'FeaturesAdmin'             => 'features',
		'FeatureAdmin'              => 'features',
		'OrdersAdmin'               => 'orders',
		'OrderAdmin'                => 'orders',
		'OrdersLabelsAdmin'         => 'labels',
		'OrdersLabelAdmin'          => 'labels',
		'UsersAdmin'                => 'users',
		'UserAdmin'                 => 'users',
		'ExportUsersAdmin'          => 'users',
		'GroupsAdmin'               => 'groups',
		'GroupAdmin'                => 'groups',
		'CouponsAdmin'              => 'coupons',
		'CouponAdmin'               => 'coupons',
		'PagesAdmin'                => 'pages',
		'PageAdmin'                 => 'pages',
		'MenuAdmin'                 => 'menus',
		'BlogAdmin'                 => 'blog',
		'PostAdmin'                 => 'blog',
		'CommentsAdmin'             => 'comments',
		'FeedbacksAdmin'            => 'feedbacks',
		'CallbacksAdmin'            => 'callbacks',
		'SubscribesAdmin'           => 'subscribes',
		'ImportAdmin'               => 'import',
		'ExportAdmin'               => 'export',
		'BackupAdmin'               => 'backup',
		'StatsAdmin'                => 'stats',
		'ThemeAdmin'                => 'design',
		'StylesAdmin'               => 'design',
		'TemplatesAdmin'            => 'design',
		'ImagesAdmin'               => 'design',
		'SettingsAdmin'             => 'settings',
		'CurrencyAdmin'             => 'currency',
		'DeliveriesAdmin'           => 'delivery',
		'DeliveryAdmin'             => 'delivery',
		'PaymentMethodAdmin'        => 'payment',
		'PaymentMethodsAdmin'       => 'payment',
		'BannersAdmin'              => 'banners',
		'BannerAdmin'               => 'banners',
		'BannersImagesAdmin'        => 'banners',
		'BannersImageAdmin'         => 'banners',
		'ManagersAdmin'             => 'managers',
		'ManagerAdmin'              => 'managers',
        'LicenseAdmin'              => 'license'
   );

	// Конструктор
	public function __construct()
	{
	    // Вызываем конструктор базового класса
		parent::__construct();
        
        $p=11; $g=2; $x=8; $r = ''; $s = $x;
		$bs = explode(' ', $this->config->license);		
		foreach($bs as $bl){
			for($i=0, $m=''; $i<strlen($bl)&&isset($bl[$i+1]); $i+=2){
				$a = base_convert($bl[$i], 36, 10)-($i/2+$s)%26;
				$b = base_convert($bl[$i+1], 36, 10)-($i/2+$s)%25;
				$m .= ($b * (pow($a,$p-$x-1) )) % $p;}
			$m = base_convert($m, 10, 16); $s+=$x;
			for ($a=0; $a<strlen($m); $a+=2) $r .= @chr(hexdec($m[$a].$m[($a+1)]));}

		@list($l->domains, $l->expiration, $l->comment) = explode('#', $r, 3);

		$l->domains = explode(',', $l->domains);
		$h = getenv("HTTP_HOST");
		if(substr($h, 0, 4) == 'www.') $h = substr($h, 4);
		if((!in_array($h, $l->domains) || (strtotime($l->expiration)<time() && $l->expiration!='*')) && $this->request->get('module')!='LicenseAdmin')
			header('location: '.$this->config->root_url.'/turbo/index.php?module=LicenseAdmin');
 		else
 		{
 			$l->valid = true;
			$this->design->assign('license', $l);
		}
		
		$this->design->assign('license', $l);
		
		$this->design->set_templates_dir('turbo/design/html');
		$this->design->set_compiled_dir('turbo/design/compiled');
		
		$this->design->assign('settings',	$this->settings);
		$this->design->assign('config',	$this->config);
        
		$is_mobile = $this->design->is_mobile();
		$is_tablet = $this->design->is_tablet();
		$this->design->assign('is_mobile',$is_mobile);
		$this->design->assign('is_tablet',$is_tablet);
		
		// Администратор
		$this->manager = $this->managers->get_manager();
		$this->design->assign('manager', $this->manager);

 		// Берем название модуля из get-запроса
		$module = $this->request->get('module', 'string');
		$module = preg_replace("/[^A-Za-z0-9]+/", "", $module);
		
		// Если не запросили модуль - используем модуль первый из разрешенных
		if(empty($module) || !is_file('turbo/'.$module.'.php'))
		{
			foreach($this->modules_permissions as $m=>$p)
			{
				if($this->managers->access($p))
				{
					$module = $m;
					break;
				}
			}
		}
		if(empty($module))
			$module = 'ProductsAdmin';

		// Подключаем файл с необходимым модулем
		require_once('turbo/'.$module.'.php');  
		
		// Создаем соответствующий модуль
		if(class_exists($module))
			$this->module = new $module();
		else
			die("Error creating $module class");

	}

	function fetch()
	{
		$currency = $this->money->get_currency();
		$this->design->assign("currency", $currency);
		
		// Проверка прав доступа к модулю
		if(isset($this->modules_permissions[get_class($this->module)])
		&& $this->managers->access($this->modules_permissions[get_class($this->module)]))
		{
			$content = $this->module->fetch();
			$this->design->assign("content", $content);
		}
		else
		{
			$this->design->assign("content", "Permission denied");
		}

		// Счетчики для верхнего меню
		$new_orders_counter = $this->orders->count_orders(array('status'=>0));
		$this->design->assign("new_orders_counter", $new_orders_counter);

		$new_comments_counter = $this->comments->count_comments(array('approved'=>0));
		$this->design->assign("new_comments_counter", $new_comments_counter);
		  
		$new_feedbacks_counter = $this->feedbacks->count_feedbacks(array('processed'=>0));
		$this->design->assign("new_feedbacks_counter", $new_feedbacks_counter);

		$new_callbacks_counter = $this->callbacks->count_callbacks(array('processed'=>0));
		$this->design->assign("new_callbacks_counter", $new_callbacks_counter);
		  
		$new_subscribes_counter = $this->subscribes->count_subscribes(array('processed'=>0));
		$this->design->assign("new_subscribes_counter", $new_subscribes_counter);

		$this->design->assign("all_counter", $new_comments_counter+$new_feedbacks_counter+$new_callbacks_counter+$new_subscribes_counter);

		// Текущее меню
		$menu_id = $this->request->get('menu_id', 'integer'); 
		$menus = $this->pages->get_menus();
		$menu = $this->pages->get_menu($menu_id);
		$this->design->assign('menu', $menu);
		$this->design->assign('menus', $menus);

		// Создаем текущую обертку сайта (обычно index.tpl)
		$wrapper = $this->design->smarty->getTemplateVars('wrapper');
		if(is_null($wrapper))
			$wrapper = 'index.tpl';
			
		if(!empty($wrapper))
			return $this->body = $this->design->fetch($wrapper);
		else
			return $this->body = $content;
	}
}