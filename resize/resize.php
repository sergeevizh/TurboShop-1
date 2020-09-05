<?php

require_once('../api/Turbo.php');

$filename = $_GET['file'];
$token = $_GET['token'];
$is_category = $_GET['is_category'];
$is_post = $_GET['is_post'];
$is_brands = $_GET['is_brands'];
$is_banners = $_GET['is_banners'];

$turbo = new Turbo();

if(!$turbo->config->check_token($filename, $token))
	exit('bad token');		

$resized_filename =  $turbo->image->resize($filename, $is_category, $is_post, $is_brands, $is_banners);

if(is_readable($resized_filename))
{
	header('Content-type: image');
	print file_get_contents($resized_filename);
}

