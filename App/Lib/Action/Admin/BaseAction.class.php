<?php
class BaseAction extends Action{

	public function _initialize(){
            
            if(!isset($_SESSION['admin'])) {
                
                $this->error('请登录后进行操作',U('Admin/Login/login'));
              
            }
		
	}
	
	//保存配置信息
	public function updateconfig($config){
		$check_file=array(
			'./App/Conf/config.php',
		);		
		foreach ($check_file as $file){
			//检测文件是否可写
			if (!is_writeable($file)) {
				$this->error('配置文件'.$file.'不可写。如果您使用的是Unix/Linux主机，请修改该文件的权限为777。如果您使用的是Windows主机，请将此文件设为everyone可写！');
				exit();
			}
		}
		$config_old = require './App/Conf/config.php';

		if(is_array($config) && is_array($config_old)){
			$config_new = array_merge($config_old,$config);
		}
		if(is_array($config_new)){
			arr2file('./App/Conf/config.php',$config_new);
		}
		@unlink('./App/Runtime/~runtime.php');

		$this->success('恭喜您，配置信息更新成功！');
	}
	
	//保存到home/config.php
	public function updateconf($config){
		$check_file=array(
			'./App/Conf/home.php',
			'./App/Conf/Home/config.php',
		);
		foreach ($check_file as $file){
			//检测文件是否可写
			if (!is_writeable($file)) {
				$this->error('配置文件'.$file.'不可写。如果您使用的是Unix/Linux主机，请修改该文件的权限为777。如果您使用的是Windows主机，请将此文件设为everyone可写！');
				exit();
			}
		}
		$config_old = require './App/Conf/Home/config.php';
		if(is_array($config) && is_array($config_old)){
			$config_new = array_merge($config_old,$config);
		}
		if(is_array($config_new)){
			arr2file('./App/Conf/Home/config.php',$config_new);
			arr2file('./App/Conf/home.php',$config_new);
		}
		@unlink('./App/Runtime/~runtime.php');
		
		//动态模式则删除首页静态文件
		if (!$config_new['url_html']) {
			$arr=array('.html','.htm','.shtml','.shtm');
			foreach ($arr as $val){
				@unlink('./index'.$val);
			}
		}
		$this->success('恭喜您，配置信息更新成功！');
	}
	
	//关键词过滤
	public function filter($source){
		$pattern=array();
		$replacement=array();
		$file = C('filter');
		$filter = explode(',', $file);
		foreach ($filter as $val){
			$val=trim($val);
			if ($val){
				$pattern[] = '/'.$val.'/';
				$replacement[] = '***';
			}
		}
		return preg_replace($pattern,$replacement,$source);
	}
	
	//分割标题获得标签方法
	public function get_tags($title){
	
		Vendor('pscws4.pscws4', '' ,'.class.php');
		$pscws = new PSCWS4();
		$pscws->set_dict('./Public/statics/js/scws/dict.utf8.xdb');
		$pscws->set_rule('./Public/statics/js/scws/rules.utf8.ini');
		$pscws->set_ignore(true);
		$pscws->send_text($title);
		$words = $pscws->get_tops(10);
		$tags = array();
		foreach ($words as $val) {
			$tags[] = $val['word'];
		}
		$pscws->close();
		return $tags;
	}
	
    //上传方法
    public function upload($savePath,$thumb=array()) {
    
    	import("ORG.Net.UploadFile");
    	$upload = new UploadFile();
    	$upload->maxSize  = 2097152;// 设置附件上传大小
    	$upload->savePath = $savePath;// 设置附件上传目录
    	$upload->saveRule = uniqid;
    	$upload->allowExts  = array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型

    	if ($thumb) {
	    	$upload->thumb = true;
	    	$upload->thumbMaxWidth = $thumb['width'];    	
	    	$upload->thumbMaxHeight = $thumb['height'];
	    	$upload->thumbPrefix = 's_';
	    	$upload->thumbRemoveOrigin = true;
    	}

    	if(!$upload->upload()) {
    		// 上传错误提示错误信息
    		$this->error($upload->getErrorMsg());
    	}else{
    		// 上传成功 获取上传文件信息
    		$info =  $upload->getUploadFileInfo();
    	}
    	return $info;
    }
	
	//下载远程图片
	public function down_item($img,$name){
		$dir=date("Ymd");
		mkdir('./Uploads/LocalItems/'.$dir);
		$type = end(explode( '.', $img ));
		import("ORG.Net.Http");
		$http=new Http();			
		$http->curlDownload($img.'_100x1000.jpg','Uploads/LocalItems/'.$dir.'/'.$name.'_100x1000.'.$type);
		$http->curlDownload($img.'_210x1000.jpg','Uploads/LocalItems/'.$dir.'/'.$name.'_210x1000.'.$type);
		$http->curlDownload($img.'_350x1000.jpg','Uploads/LocalItems/'.$dir.'/'.$name.'_350x1000.'.$type);
		$http->curlDownload($img.'_500x1000.jpg','Uploads/LocalItems/'.$dir.'/'.$name.'_500x1000.'.$type);
		return C('web_path').'Uploads/LocalItems/'.$dir.'/'.$name;
	}
	
	//下载店铺远程图片
	public function down_shop($img,$name){
		import("ORG.Net.Http");
		$http=new Http();
		$http->curlDownload($img,'Uploads/Shop/'.$name);
		return C('web_path').'Uploads/Shop/'.$name;
	}
	
	//商品图片
	public function upload_item($img,$name){
		$dir=date("Ymd");
		mkdir('./Uploads/LocalItems/'.$dir);
		$type = end(explode( '.', $img ));
		import("ORG.Util.Image");
		$image=new Image();
		$image->thumb($img,'Uploads/LocalItems/'.$dir.'/'.$name.'_100x1000.'.$type,'',52,10000);
		$image->thumb($img,'Uploads/LocalItems/'.$dir.'/'.$name.'_210x1000.'.$type,'',210,10000);
		$image->thumb($img,'Uploads/LocalItems/'.$dir.'/'.$name.'_350x1000.'.$type,'',350,10000);
		$image->thumb($img,'Uploads/LocalItems/'.$dir.'/'.$name.'_500x1000.'.$type,'',500,10000);
	}
}