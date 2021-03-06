<?php

class LoginAction extends Action {
    public function index(){
		$this->display();
	}
	
	public function login() {
		
		if(IS_POST) {
			$username = I('username', 'trim');
			$password = I('password', 'trim');

			/*
			$data = array(
				'username' => $username,
				'password' => md5($password),
				'role_id' => 1,
				'last_ip' => get_client_ip(),
				'last_time' => time(), 
				'status' => 1,
				'email' => 'lurma@qq.com',
				
			);
			
			M('admin')->add($data);

			*/

			$db = M('admin');

			$admin = $db->where(array('username' => $username, 'status' => 1))->find();
		
			if(!$admin) {
				$this->error('用户不存在', U('Login/login'));
			} 
			
			if($admin['password'] != md5($password)) {
				$this->error('密码错误', U('Login/login'));
			}
			
			$session = array(
				'id' => $admin['id'],
				'role_id' => $admin['role_id'],
				'role_name' => $db->where(array('id' => $admin['role_id']))->getField('name'),
				'username' => $admin['username'],
				'token' => md5($username.md5($password)),
				'last_time' => date('Y-m-d H:i:s', $admin['last_time']),
				'last_ip' => get_client_ip(),
			);

			// 保存cookie，时效为10天
			cookie('admin', $session, array('expire' => 3600*24*10));
			
			// 保存session
			session('admin', $session);
			
			$data = array(
				'id' => $admin['id'],
				'last_time' => time(),
				'last_ip' => get_client_ip()
			);
			
			$db->save($data);

			$this->success('登陆成功', U('Index/index'));
		
		} else {
			$this->display();
		}
	
	}

	public function logout() {
		cookie('admin', null);
		session('admin', null);
		$this->success('注销成功', U('Login/login')); 
	}
}