리눅스 비밀번호 변경

비밀번호 변경
```sh
passwd
```
centos 버전확인
```sh
shcat /etc/redhat-release
```

## 마리아db 설정
mariadb  Ver 15.1 Distrib 10.11.9-MariaDB, for Linux (x86_64) using readline 5.1 <br>
로 설치하기 위해서는 아래의 작업이 필요함
<br>
수동으로 레파지토리 추가

```sh
 vi /etc/yum.repos.d/MariaDb.repo
```
MariaDb.repo 의 내용
```sh
[mariadb]
name = MariaDB
# rpm.mariadb.org is a dynamic mirror if your preferred mirror goes offline. See https://mariadb.org/mirrorbits/ for details.
# baseurl = https://rpm.mariadb.org/10.11/centos/$releasever/$basearch
baseurl = https://tw1.mirror.blendbyte.net/mariadb/yum/10.11/centos/8/$basearch
module_hotfixes = 1
# gpgkey = https://rpm.mariadb.org/RPM-GPG-KEY-MariaDB
gpgkey = https://tw1.mirror.blendbyte.net/mariadb/yum/RPM-GPG-KEY-MariaDB
gpgcheck = 1
```
위의 설정이 끝났다면 dnf install을 진행
```sh
dnf -y install MariaDB-server MariaDB-client
```
마리아db가 잘 깔렸는지 확인한다
```sh
 mysql --version
 ```

 마리아db 가  설치가 되었다면 활성화 여부 확인
 ```sh
 systemctl status mariadb.server
 ```
 서버가 꺼졋을때 자동으로 재시작될 수 있게 enalbe 설정
 ```sh
 systemctl enable mariadb.service
 ```
 마리아db 시작
 ```sh
 systemctl start mariadb.service
 ```
 active 여부 확인
 ```sh
  systemctl status mariadb.service
  ```
#### 외부에서 db 에 접근할수 있게 방화벽 설정
아래의 작업을 하지 않는다면 외부 접근이 안됨
방화벽 시작
```sh
systemctl start firewalld
# 이떄 안된다면 
systemctl unmask firewalld
systemctl start firewalld
systemctl enable firewalld
systemctl status firewalld
```
데이터베이스(기본 port 3306)가 접근할수있게 설정
```sh
firewall-cmd --permanent --add-port=3306/tcp
firewall-cmd --reload
```
#### 마리아db
마리아 db 기본 설정
```sh
mariadb-secure-installation
```
```sh
$ sudo mysql_secure_installation

NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

In order to log into MariaDB to secure it, we'll need the current
password for the root user.  If you've just installed MariaDB, and
you haven't set the root password yet, the password will be blank,
so you should just press enter here.

Enter current password for root (enter for none): 
OK, successfully used password, moving on...

Setting the root password ensures that nobody can log into the MariaDB
root user without the proper authorisation.

Set root password? [Y/n] y # ROOT 패스워드 설정
New password: 
Re-enter new password: 
Password updated successfully!
Reloading privilege tables..
 ... Success!


By default, a MariaDB installation has an anonymous user, allowing anyone
to log into MariaDB without having to have a user account created for
them.  This is intended only for testing, and to make the installation
go a bit smoother.  You should remove them before moving into a
production environment.

Remove anonymous users? [Y/n] y # anonymous 사용자 삭제
 ... Success!

Normally, root should only be allowed to connect from 'localhost'.  This
ensures that someone cannot guess at the root password from the network.

Disallow root login remotely? [Y/n] y #ROOT 사용자 외부접속 삭제
 ... Success!

By default, MariaDB comes with a database named 'test' that anyone can
access.  This is also intended only for testing, and should be removed
before moving into a production environment.

Remove test database and access to it? [Y/n] y # TEST DB 삭제
 - Dropping test database...
 ... Success!
 - Removing privileges on test database...
 ... Success!

Reloading the privilege tables will ensure that all changes made so far
will take effect immediately.

Reload privilege tables now? [Y/n] y #privilege 테이블 reload
 ... Success!

Cleaning up...

All done!  If you've completed all of the above steps, your MariaDB
installation should now be secure.

Thanks for using MariaDB!

```

root 로 접근후 비밀번호가 제대로 설정되지 않았다면 
```sh
ALTER USER 'root'@'localhost' identified by '비밀번호';
```

브라이튼에서 접근가능한 계정 생성
```sh
create user 'brighten'@210.90.113.85 identified  by '비밀번호';
```
생성한 계정의 비밀번호를 바꾸고싶다면 
```sh
 ALTER USER 'brighten'@'210.90.118.85' identified by '비밀번호';
 ```
 권한 주기 모든 테이블에 접근가능하다
```sh
grant all privileges on *.* to '아이디'@'접속ip';
```
권한이 제대로 부여됬는지 확인

```sh
 show grants for brighten@210.90.113.85;
```
변경된 권한 적용
```sh
 FLUSH PRIVILEGES;
```

 ## 도커설정

도커가 설치되어 있는지 확인
 ```sh
  docker --version
 ```
 도커 설치 구문
 ```sh
  yum install -y yum-utils
  yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
 ```
도커 설치 확인
```sh
docker --version
```
저장소 관련 된 내용은 기환님의 git 을 보고 따라가면된다
이때 5000 포트가 사용중이라고 뜨면 
```sh
lsof -i :5000
```
명령어로 사용중인 pid 를 확인하고 그 pid 를 kill 시키면된다

```sh
systemctl start docker
systemctl enable docker.service #서버재실행시 재시작
```
내부아이피 확인
```sh
 ip addr |grep "inet"
```
## 엔진엑스 설치
```sh
dnf update
```

```sh
dnf install nginx
```
```sh
nginx -v
```
```sh
systemctl enable nginx
systemctl start nginx
```
nginx 방화벽 열기
```sh
 firewall-cmd --permanent --zone=public --add-service=http
 firewall-cmd --permanent --zone=public --add-service=https
 firewall-cmd --reload
```
```sh
firewall-cmd --list-all # 방화벽 관련 모든 내용 확인
firewall-cmd --list-ports # 방화벽 풀릭 포트만 확인
```
사용중인 포트 확인(listen 상태)
```sh
lsof -i : port번호
```
