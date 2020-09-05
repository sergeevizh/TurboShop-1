<?php

/**
 * Turbo CMS
 *
 * @copyright 	2013 Turbo CMS
 * @link 		https://turbo-cms.com
 * @author 		Turbo CMS
 *
 * К этому скрипту обращается Interkassa 2.0 в процессе оплаты
 *
 */

// Работаем в корневой директории
chdir ('../../');
require_once('api/Turbo.php');
$turbo = new Turbo();

////////////////////////////////////////////////
// Проверка статуса
////////////////////////////////////////////////
if($_POST['ik_inv_st'] !== 'success')
	err('bad status');

////////////////////////////////////////////////
// Выберем заказ из базы
////////////////////////////////////////////////
$order = $turbo->orders->get_order(intval($_POST['ik_pm_no']));
if(empty($order))
	err('Оплачиваемый заказ не найден');
 
////////////////////////////////////////////////
// Выбираем из базы соответствующий метод оплаты
////////////////////////////////////////////////
$method = $turbo->payment->get_payment_method(intval($order->payment_method_id));
if(empty($method))
	err("Неизвестный метод оплаты");
	
$settings = unserialize($method->settings);
$payment_currency = $turbo->money->get_currency(intval($method->currency_id));

////////////////////////////////////////////////
// Проверка id кассы
////////////////////////////////////////////////
if($settings['ik_co_id'] !== $_POST['ik_co_id'])
	err('Неверный идентификатор кассы');

// Проверяем контрольную подпись
$ik_key = $settings['ik_secret_key'];

$dataSet = $_POST;
unset($dataSet['ik_sign']);
ksort($dataSet, SORT_STRING); // сортируем по ключам в алфавитном порядке элементы массива 
array_push($dataSet, $ik_key); // добавляем в конец массива "секретный ключ" 
$signString = implode(':', $dataSet); // конкатенируем значения через символ ":" 
$sign = base64_encode(md5($signString, true)); // берем MD5 хэш в бинарном виде по сформированной строке и кодируем в BASE64 

if($sign !== $_POST['ik_sign'])
	err('bad sign');

// Нельзя оплатить уже оплаченный заказ  
if($order->paid)
	err('Этот заказ уже оплачен');

if($_POST['ik_am'] != round($turbo->money->convert($order->total_price, $method->currency_id, false), 2) || $_POST['ik_am']<=0)
	err("incorrect price");

// Установим статус оплачен
$turbo->orders->update_order(intval($order->id), array('paid'=>1));

// Отправим уведомление на email
$turbo->notify->email_order_user(intval($order->id));
$turbo->notify->email_order_admin(intval($order->id));

// Спишем товары  
$turbo->orders->close(intval($order->id));

function err($msg)
{
	header($_SERVER['SERVER_PROTOCOL'].' 400 Bad Request', true, 400);
	//mail("test@test", "interkassa: $msg", $msg);
	die($msg);
}
