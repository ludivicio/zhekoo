<?php

class IndexAction extends BaseAction {
    
    public function index(){

        $userinfo = array('username' => $_SESSION['admin']['username'],
                'rolename' => $_SESSION['admin']['rolename']);
        $this->assign('userinfo', $userinfo);

        //echo GROUP_NAME . '<br/>';
        //echo __GROUP__;

        $this->display();
    }


	//左侧导航栏
    public function left(){
		
		if(isset($_GET['id'])) {
			$id = $_GET['id'];
		}else {
			$id = 'config';
		}
		
		$this->assign('id', $id);
    	$this->display();
    }


	//系统环境信息
    public function main(){
    	$server_info = array(
    		'CMS版本'=>C('cms_versions'),
    		'操作系统'=>PHP_OS,
    		'运行环境'=>$_SERVER["SERVER_SOFTWARE"],
    		'PHP运行方式'=>php_sapi_name(),
    		'最大上传限制'=>ini_get('upload_max_filesize'),
    		'最大执行时间'=>ini_get('max_execution_time').'秒',
    		'服务器时间'=>date("Y年n月j日 H:i:s"),
    		//'北京时间'=>gmdate("Y年n月j日 H:i:s",time()+8*3600),
    		'服务器域名/IP'=>$_SERVER['SERVER_NAME'].' ['.gethostbyname($_SERVER['SERVER_NAME']).']',
    		'剩余空间'=>round((@disk_free_space(".")/(1024*1024)),2).'M',
    	);
    	$this->assign('server_info',$server_info);
    	$this->display();
    } 
}