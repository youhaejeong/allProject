# 리눅스 서버 가상호스트 구축
version 1.1.0 인은지

## 0. 목차
1. [도메인 사용여부 확인](#1-도메인-확인)
2. [apache 설정](#1-도메인-확인) <br>
    2.1. [httpd.conf 기본 구성 요소](#21-httpdconf-기본-구성-요소)   
    2.2. [httpd.conf 설정](#22-httpdconf-설정)
3. [SSL 인증서](#3-ssl-인증서-발급)     
    3.1. [Let's encrypt 인증서](#31-lets-encrypt-인증서)


## 1. 도메인 확인
사용할 도메인이 존재하는지 확인 (주로 카페24에서 도메인을 등록해 사용한다)
```
ping [도메인 or IP] :  컴퓨터 네트워크 상태를 점검, 진단하는 명령어
ex. ping google.com 
```

## 2. Apache 설정

```
/etc/httpd/conf/httpd.conf
```
아파치(apache)의 메인 설정 파일이다.    
아파치 설치 시 자동으로 /etc/httpd/conf 경로에 httpd.conf 파일이 생성된다.

### 2.1 httpd.conf 기본 구성 요소
apache 설정은 [2.2항목](#22-httpdconf-설정) 참고

#### ServerRoot

<p align="center">
  <img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FectrGd%2Fbtrh5YjNlOD%2Fz5LM5ZnzcP2skd5DZpfJf1%2Fimg.png">
</p>

<!-- ![serverRoot](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FectrGd%2Fbtrh5YjNlOD%2Fz5LM5ZnzcP2skd5DZpfJf1%2Fimg.png "serverRoot") -->

* 아파치 Root 홈 디렉터리 경로이다.
* 절대 경로로 설정해야 한다.
* 설치 시 기본적으로 /etc/httpd 경로로 지정되어진다.

#### Listen
<p align="center">
  <img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FdWSQ8p%2Fbtrh3qODTwR%2F512IgJ4Pjc1SnFMeupxrV0%2Fimg.png">
</p>

* Apache 웹 서버 포트를 지정한다.
* 다른 IP 주소와 포트에 대해서 연결 할 수 있도록 해준다.
* 미 지정시 아파치가 실행되지 않는다.
* 여러 포트 지정 시 Listen 지시자를 여려번 선언한다.

#### Include
<p align="center">
  <img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbXtnR0%2Fbtrh4NJAetP%2FwhNJyuXF4r9sqjQC9wKlc1%2Fimg.png">
</p>

* httpd.conf 파일이 아닌 다른 설정 파일을 포함하여 적용한다.

#### ServerAdmin
<p align="center">
  <img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FccDgGE%2Fbtrh7xfbk6k%2F5ng7hY0JoHT0tfPbCv9iAk%2Fimg.png">
</p>

* 서버 오류 발생 시 클라이언트로 전송할 오류 메세지에 보여질 관리자 이메일 주소이다.
* 에러 발생시 에러화면에 해당 이메일 주소가 표시된다.

#### ServerName
<p align="center">
  <img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F4f2wA%2FbtrhZm7iblv%2FJ2bh2ad8GfLJkkUegtIuQk%2Fimg.png">
</p>

* 서버의 도메인을 입력한다.
* 클라이언트에게 보여줄 호스트 이름 및 포트를 지정한다.
* DNS 주소가 등록되지 않으면 IP 주소로 설정한다.

#### DocumentRoot
<p align="center">
  <img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FKaRAe%2Fbtrh0DOwgPI%2FLcAaF7tyVvrCK8afaZhWpk%2Fimg.png">
</p>

* 아파치 서버의 웹문서가 있는 경로 및 웹페이지의 루트를 지정한다.
* 마지막 경로엔 '/'를 지정하지 않는다.
* DocumentRoot 라인 이후엔 < directory > 지시자가 작성된다.

#### < Directory >

<p align="center">
  <img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FJJbM1%2FbtrhWJIKfHx%2F0C5gO3utyZ2s1eQ1TBWNy1%2Fimg.png">
</p>

```
<Directory {디렉토리 명}>
    [Options]
    [AllowOverride]
    [Require]
    ...
</Directory>
```

* 각 디렉터리의 고유한 설정을 하기 위한 블록이다.
* options : 특정 디렉터리 하위의 모든 디렉터리와 파일에 대한 접근 권한을 제어한다.

    | option | 설명 |
    |---------|------|
    |None| 모든 접근을 허용하지 않는다.|
    |All| 모든 옵션설정을 허용한다.|
    |Indexes|디렉터리 접근 시 DerectoryIndex 지시자에 설정한 파일이 없을 경우, <br> 디렉터리 목록을 화면에 표시한다.|
    |Includes|mod_include를 사용하는 SSI(Server Side Includes)를 허용한다.|
    |IncludesNoExec|SSI를 허용하지만, #exec cmd와 #exec cgi는 사용할 수 없다.|
    |FollowSymLink|심볼릭 링크 사용 가능하다.|
    |ExecCGI|mod_cgi를 사용하는 CGI 스크립트 실행 가능하다.|
    |MultiViews|클라이언트가 요청한 media type과 content-encoding을 가지고 다중확장자를 지원하기 위해 MultiViews 기능을 사용한다.|
    <br>

* AllowOverride : 디렉터리에 .htaccess 파일이 있을 경우 기존 설정을 덮어쓸지 여부를 설정한다.

    | option | 설명 |
    |---------|------|
    |None|htaccess 파일을 override하지 않는다.|
    |All|htaccess 파일을 우선 적용하도록 override를 허용한다.|
    |AutoConfig|클라이언트 인증 지시자의 사용을 허용한다.|
<br>

* Require : 해당 디렉터리의 접근 허용 여부를 설정한다.

    |option|설명|
    |------|----|
    |all denied| 모든 접근을 거부한다.|
    |all granted|모든 접근을 허용한다.|
    |ip [ip주소] | 특정 ip주소의 접근을 허용한다.|
    |not ip [ip주소] | 특정 ip주소의 접근을 거부한다.|

* .htaccess 파일

    ```
    # vi /usr/local/apache/htdocs/admin/.htaccess

    AuthType Basic                                  (인증 기본방식)
    AuthName "Admin Login"                          (표시할 인증 메시지)
    AuthUserFile /usr/local/apache/conf/password    (사용자 인증 파일명)
    Require valid_user                              (사용인증할 방식 user나 group과 인증할 대상)
    ```

    - 디렉터리에 인증할 설정 옵션을 제공하는 파일
    - 허가, 인증, URL 재작성, 스팸봇 차단 등드의 기능

* Order, Deny, Allow

    <p align="center">
    <img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FNuaRu%2Fbtrh2ii5tzQ%2FWhzTJU3rGYxmMUHKFA7Av0%2Fimg.png">
    </p>

    - Order : Deny와 Allow의 순서를 정한다. 먼저 적은 순서가 먼저 적용된다.
    - Deny : 접근 제한 대상을 설정한다.
        - Deny from all : 모든 클라이언트의 접근을 거부한다.
        - Deny from [ip주소] : 특정 주소의 접근을 거부한다.
    - Allow : 접근 허가 대상을 설정한다.
        - Allow from all : 모든 클라이언트의 접근을 허용한다.
        - Allow from [ip주소] : 특정 주소의 접근을 허용한다.

    ```
    예시
    <Directory "/usr/local/apache/htdocs/admin">
        Order Deny, Allow
        Deny from All
        Allow from 203.247.40.0
    </Directory>
    -> 접근을 통제하는 디렉터리는 /usr/local/apache/htdocs/admin이고,
        203.247.40.0 네트워크 대역의 주소를 갖는 클라이언트의 접근 만을 허가한다.
    ```
    <p align="center">
    <img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FDANGL%2Fbtrh4MKIFYt%2FtKQAjwZFfcoakq2M1Ljiw0%2Fimg.png">
    </p>

    <!-- ```
    <Directory />
        AllowOverrie none;
        Require all denied
    </Directory>
    ``` -->
    - 디렉터리 경로에 " /"로 설정하면 모든 디렉터리에 적용되는 옵션을 설정한다. 

 #### DirectoryIndex

 <p align="center">
    <img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbjbfiR%2FbtrhX2VDvya%2FQK31CChrRzLdQPQ8KFeTrK%2Fimg.png">
</p>
    
<!-- ```
#
# DirectoryIndex :sets the file that Apache will serve Inf a directory
# is requested.
#
<IfModule dir_module>
    DirectoryIndex index.html
</IfModule>
``` -->
* 클라이언트가 디렉터리 요청할 때 DirectoryIndex에 설정된 파일명을 요청한다.

```
사용예시

# DirectoryIndex index.html, index.htm, index.php

> 웹 디렉터리 접근 시에 인식되는 인덱스 파일 순서를 index.html, index.htm, index.php 순으로 지정한다.
```

#### UserDir
```
UserDir [디렉터리]
```
* 일반 사용자의 웹 디렉터리를 지정한다.

#### Files

<p align="center">
    <img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fd59OBo%2FbtrhX0Q0nLM%2FrEfru7DXpahG0Hj8r20SG1%2Fimg.png">
</p>

<!-- ```
#
# The following lines prevent .htaccess and .htpasswd files from being
# viewed by Web clients.
#
<Files ".ht*">
    Require all denied
</Files>
``` -->
* 해당 파일로 설정된 파일에 대한 옵션을 설정한다.
* 주로 접근권한을 설정한다.

#### ErrorLog
<p align="center">
    <img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fbw0CIP%2Fbtrh7xl0EUD%2FANvVx4qiZ8Hs2aB3AHxCB0%2Fimg.png">
</p>
<!-- ```
#
# ErrorLog : The location of the error log file.
# If you do not specify an ErrorLog directive within a <VirtualHost>
# container, error messages relating to that virtual host will be
# logged here. If you *do* define an error logfile for a <VirtualHost>
# container, that host's errors will be logged there and not here.
#
ErrorLog "logs/error_log"
``` -->

* 아파치의 error log가 생성되는 경로를 지정한다.

#### LogLevel
<p align="center">
    <img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FcjZnMx%2FbtrhX1WKvf1%2Fl7nDvu5vansZneSfJgMrK1%2Fimg.png">
</p>

<!-- ```
#
# LogLevel : Contol the number of messages logged to the error_log.
# Possible values include: debug, info, notice, warn, error, crit,
# alert, emerg.
#
LogLevel warn 
``` -->
* log를 남길 기준의 Level을 설정한다.
* 레벨은 debug, info, notice, warn, error, crit, alert, emerg가 있고, 기본적으로 warn으로 설정되어진다.

#### ErrorDocument

<p align="center">
    <img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbrbqwT%2FbtrhUUQI55V%2FNB7Go7Qkr6QEELEMPA5m10%2Fimg.png">
</p>

<!-- ```
# ErrorDocument 500 "The server made a boo boo"
# ErrorDocument 404 /missing.html
# ErrorDocument 404 "/cgi-bin/missing_handler.pl"
# ErrorDocument 402 http://www.example.com/subscription_info.html
``` -->
* 아파치에서 Error 발생 시 서버가 클라이언트에게 반환할 메시지 및 페이지를 설정한다.

    |Error code|설명|
    |----------|----|
    |400| Bad Request, 클라이언트의 잘못된 요청으로 처리할 수 없음|
    |401| Unauthorized, 클라이언트의 인증 실패|
    |402| Payment required, 예약됨|
    |403| Forbidden, 접근 허가가 거부됨|
    |404| Not found, 존재하지 않는 문서|

#### < VirtualHost >

```
<VirtualHost [IP 주소:포트]>
    ServerAdmin ..
    DocumentRoot ..
    ServeerAlias ..
</VirtualHost>
```

|||
|---|---|
|VirtualHost *:80 |가상 호스트 구역을 설정하여 사용한다. 가상 호스트의 첫 번째 구역은 클라이언트가 요청한 ServerName(도메인)을 찾지 못하였을 경우에 보여지게 될 부분을 설정하게 된다.|
|ServerAdmin|해당 가상호스트의 관리자 이메일 주소|
|DocumentRoot|해당 가상 호스트의 홈페이지 디렉토리 위치|
|ServerName|해당 가상호스트의 도메인명|
|ServerAlias|가상 호스트 설정에 별칭으로 등록한다.|
|ErrorLog|해당 가상 호스트의 웹 에러로그 파일 위치|
|CustomLog|해당 가상호스트의 웹 로그파일 위치|
|ProxyPreserveHost on|HTTP 요청 헤더의 Host: 부분을 유지하는 옵션|
|ProxyPass|서버가 적절한 문서를 가져오도록 설정|
|ReversPassReverse|외부에서 접속했을 때 내부 서버나 다른 곳으로 연결해 주는 방법|
|DirectoryIndex|클라이언트의 요청이 있을 때, 파일명을 지정하지 않고 디렉토리만 지정될 경우가 있다. 파일명이 생략된 경우에 어떤 파일을 반환할까를 DirectoryIndex로 지정한다.|
|Alias|별칭을 만드는 지시자이고 Alias 별칭명 실제명과 같은 방식으로 만들게 된다. 별칭명 뒤에 /를 포함하면 아파치 서버는 URL에도 /이 있어야 처리할 수 있다.|
|JkMount|확장자 jsp, json, xml, do를 가진 경로는 woker tomcat으로 연결하는 구문|

* 아파치 웹 서버에서 주 도메인 이외에 추가로 도메인 설정

<br>

****
### 2.2 httpd.conf 설정

#### 2.2.1 VirtualHost 추가

아파치 웹 서버에서 주 도메인 이외에 추가로 도메인 설정 하기 위해선 http.conf파일에 아래와 같이 VirtualHost를 추가해 주면 된다.

해당 문단에서는 https는 지원하지 않는 것을 전제로 한다.

```
<VirtualHost *:80>
    DocumentRoot <war파일 경로> ex) /home/test/html
    ServerName domain.com
#    ServerAlias <원하는 주소> ex)blog.domain.com or www.domain.com...
#    ServerAdmin <email주소>

    ProxyRequests Off
    ProxyPreserveHost On
#    AllowEncodedSlashes NoDecode

    <Proxy *>
    Order deny,allow
    Allow from all
    </proxy>

    ProxyPass / http://localhost:8080/ 
    ProxyPassReverse / http://localhost:8080/

#    ErrorLog <로그 경로>/docker-error.log
#    CustomLog <로그 경로>/docker-access.log combined

</VirtualHost>
```
**주석처리된 부분은 생략 가능하다.

* 도메인 세팅   
    ServerName은 서비스 할 도메인이며 ServerAlias는 서버의 별칭이다.    
    (ServerAlias는 생략가능)

* 로그 세팅 (생략가능)      
    ErrorLog는 에러로그의 경로이며, CustomLog는 접속 로그의 경로이다.

* 프록시 세팅
    | | |
    |---|---|
    |proxyRequests Off|on일 경우 Forward Proxy로 동작, off일 경우 Reverse Proxy로 동작하는 옵션이다.|
    |proxyPreserveHost On|HTTP 요청 헤더의 Host: 부분을 유지하는 옵션이다.|
    |AllowEncodedSlaxhes NoDecode <br> (생략가능)|웹 서버 뒤에서 인코딩된 /를 디코딩 하지 않도록 설정하는 옵션이다.
    |< proxy*> Order deny,allow Allow from all </ proxy>|프록시에 대한 보안 설정이다.<br>deny조건을 먼저 확인한 후 allow조건을 확인하며, 모든 호스트에서 접속이 가능하다.|
    |proxypass / <경로>|위 세팅을 기준으로 설명했을 때, 외부에서 들어온 www.domin.com/blog/posts/1 요청을 localhost:8080/posts/1로 변환시켜주는 기능이다.|
    |proxypassReverse / <경로>|위의것과 기능은 동일하지만, 내부에서 리다이렉트가 일어났을 시 생성되는 URL의 도메인이 localhost:8080/이 되버리기 때문에 이를 다시 www.domain.com/으로 변환해주는 기능이다.|

<!-- ```
[root@ ~] # vi /etc/httpd/conf/vhost.conf

<VirtualHost *:80>
#   ServerAdmin webmaster@dummy-host.example.com
    DocumentRoot /home/test
    ServerName domain.com
    ServerAlias www.domain.com
#   ErrorLog "/var/log/httpd/dummy-host.example.com-error_log"
#   CustomLog "dummy-host.example.com-access_log" common
</VirtualHost>
```  -->

#### 2.2.2 Apache 재시작
```
# systemctl restart httpd   :  아파치 재시작
``` 
<br>

## 3. SSL 인증서

SSL 인증서란?   
SSL 인증서는 웹사이트의 ID를 인증하고 암호화된 연결을 가능하게 하는 디지털 인증서이다. SSL은 웹 서버와 웹 브라우저 사이에 암호화된 링크를 생성하게 해주는 보안 프로토콜인 Secure Sockets Layer를 나타낸다.


### 3.1 Let's encrypt 인증서

#### 3.1.1 인증서 설치
1. snap 설치
    1. epel 패키지 저장소를 설치한다
        ```
        # yum install epel-release
        ```
    2. epel 패키지 저장소가 유효한지 확인한다.
        ```
        # yum replist enabled
        ```
    3. snapd를 설치하고 버전을 확인한다.
        ```
        # yum install snapd : snapd 설치
        # snap --version : snap 버전 확인
        ```
    4. snap 메인 통신 소켓을 관리하는 systemd를 활성화 한다.
        ```
        # systemctl enable --now snapd.socket
        ```
    5. snapd 버전이 최신 버전인지 확인한다.
        ```
        # snap install core
        # snap refresh core
        ```
    6. snap 심볼릭 링크를 생성한다.
        ```
        $ sudo ln -s /var/lib/snapd/snap /snap
        ```

2. certbot 설치
    1. certbot를 설치한다.
        ```
        $ sudo snap install --classic certbot
        ```
    2. certbot 명령을 시스템에서 실행할 수 있도록 준비한다.
        ```
        $ sudo ln -s /snap/bin/certbort /usr/bin/certbot
        ```
    3. certbot 버전을 확인한다.
        ```
        $ certbot --version
        ```

3. certbot 실행(인증서 생성)

* standalone 옵션을 이용한 인증서 발급   
    1. 실행중인 웹서버를 중단시킨다.
        ```
        $ cd /usr/local/[tomcat]/bin : tomcat 경로로 이동
        $ sh shutdown.sh : tomcat 서버 종료
        ```
    2. certbot 실행 (SSL 인증)
        ```
        $ sudo certbot certonly --standalone --dry-run : certbot 실행 시뮬레이션
        $ sudo certbot certonly --standalone : certbot 실행
        ```
    * 여러 번 실행하게 된다면 too many certificates... 오류가 발생한다.   
    이 경우 한참뒤에 실행 할 수 있기 때문에 시뮬레이션을 먼저 실행하는것을 권장한다.
        ```
        Saving debug log to /var/log/letsencrypt/letsencrypt.log
        Enter email address (used for urgent renewal and security notices)
        (Enter 'c' to cancel):
        : 인증서 갱신 및 보안공지를 위한 email 입력
        ```
        ```
        - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        Please read the Terms of Service at
        https://letsencrypt.org/documents/LE-SA-v1.2-November-15-2017.pdf. You must
        agree in order to register with the ACME server. Do you agree?
        - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        (Y)es/(N)o: Y 
        : ACME 약관 동의 여부 N선택 시 진행불가
        ```
        ```
        - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        Would you be willing, once your first certificate is successfully issued, to
        share your email address with the Electronic Frontier Foundation, a founding
        partner of the Let's Encrypt project and the non-profit organization that
        develops Certbot? We'd like to send you email about our work encrypting the web,
        EFF news, campaigns, and ways to support digital freedom.
        - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        (Y)es/(N)o: N
        : Let's Encrypt 프로젝트 정보를 이메일로 받을지 여부.
        ```
        ```
        Please enter in your domain name(s) (comma and/or space separated)
        (Enter 'c' to cancel): 
        : 인증서를 발급할 도메인 입력. 여러개를 입력할 수 있다.
        ```
    3. 인증서 발급 완료
        ```
        IMPORTANT NOTES:
        - Congratulations! Your certificate and chain have been saved at:
        [발급된 인증서 경로]
        Your key file has been saved at:
        [발급된 인증서 경로]
        Your certificate will expire on 2021-05-16. To obtain a new or
        tweaked version of this certificate in the future, simply run
        certbot again. To non-interactively renew *all* of your
        certificates, run "certbot renew"
        ```
    * 발급이 완료된다면 발급된 인증서 경로가 출력된다.
    4. 인증서 발급 확인
        ```
        $ cd /etc/letsencrypt/archive : 도메인으로 된 파일 있는지 확인
        ```
* webroot를 이용한 인증서 발급   

* webserver를 이용한 인증서 발급  

*  DNS를 이용한 인증서 발급
  
#### 자동갱신
```
certbot certificates
발급받은 인증서 확인
```
```
 which certbot
 cerbot 실행경로 확인
```

* /path/to/renew_cert.sh 생성
    ```
    #!/bin/bash

    # 아파치 웹 서버 중지
    systemctl stop httpd

    # Certbot을 사용하여 인증서 갱신
    Certbot실행경로~~ renew --quiet

    # 아파치 웹 서버 다시 시작
    systemctl start httpd
    ```
* 실행권한 부여
  ```
  chmod +x /path/to/renew_cert.sh
  ```
* crontab -e로 크론탭 수정(매월 새벽 1시에 갱신)
    ```
    0 0 1 * * /path/to/renew_cert.sh
    ```

#### 3.1.2 인증서 Apache 설정

httpd.conf 파일에서 VirtualHost *: 80이 설정되어 있는 것을 전제로 한다.     
(VirtualHost *: 80 설정은 [이곳](#221-virtualhost-추가)을 참고)    

설정된 VirtualHost *: 80 아래에 해당 VirtualHost를 추가한다.

```
<VirtualHost *:443>
  DocumentRoot <war파일 경로> ex) /home/test/html
  ServerName domain.com
#  ServerAlias <원하는 주소> ex)blog.domain.com or www.domain.com...
#  ServerAdmin <email주소>

  ProxyRequests Off
  ProxyPreserveHost On
#  AllowEncodedSlashes NoDecode

  <Proxy *>
    Order deny,allow
    Allow from all
  </proxy>

  SSLEngine on
  SSLProxyEngine on
  SSLProxyVerify none
  SSLProxyCheckPeerCN off
  SSLProxyCheckPeerName off
  SSLProxyCheckPeerExpire off
  SSLCertificateFile "<인증서 경로>/cert.pem"
  SSLCertificateKeyFile "<인증서 경로>/privkey.pem"
  SSLCertificateChainFile "<인증서 경로>/chain.pem"

  ProxyPass / http://127.0.0.1:8080/
  ProxyPassReverse / http://127.0.0.1:8080/

  RequestHeader set X-Forwarded-Proto "https"
  RequestHeader set X-Forwarded-Port "443"

#  ErrorLog <로그 경로>/docker-error.log
#  CustomLog <로그 경로>/docker-access.log combined

</VirtualHost>
```
mod_ssl 이 설치가 안되어있다면
``` 
sudo yum install mod_ssl
```
**주석처리된 부분은 생략 가능하다.

* SSL을 위한 Proxy Settings
    | | |
    |---|---|
    |RequestHeader set X-Forwarded-Proto "https"<br>RequestHeader set X-Forwarded-Port "443"|프록시를 타고 들어온 요청이 Https요청이고, 443번 포트를 통해 왔음을 알리는 헤더를 추가하는 기능이다.|
    |SSLProxyEngine on<br>SSLProxyVerify none<br>SSLProxyCheckPeerName off<br>SSLProxyCheckPeerExpire off|프록시 서버에서 SSL검증을 하였기 때문에 중계된 서버에서 검사를 할 필요가 없음을 알리는 세팅이다.|

* SSL 세팅
    | | |
    |---|---|
    |SSLEngine<br>SSLCertificateFile "<인증서 경로>/cert.pem"<br>SSLCertificateKeyFile "<인증서 경로>/privkey.pem"<br>SSLCertificateChainFile "<인증서 경로>/chain.pem" | SSLEngine을 사용하여 Apache가 SSL을 지원하도록 하는 옵션들이다.<br> 이때, <VirtualHost *:443>로 443포트로 매핑해주는 것이 좋다.|


#### 3.1.3 인증서 Tomcat 설정

##### 인증서 적용
```
$ cd /usr/local/[톰캣]/conf : server.xml이 있는 경로로 이동
$ vi server.xml : vi 편집기로 server.xml 파일 편집
```

기존 8080 포트 밑에 443 포트 설정을 추가한다.
* 기존 8080포트 
  ```
  <Connector port="8080" protocol="HTTP/1.1"  
            connectionTimeout="20000"
            redirectPort="8443" />
  ```
* 443 포트 추가
  ```
  <Connector port="443" 
  protocol="org.apache.coyote.http11.Http11NioProtocol"  
  maxThreads="150" SSLEnabled="true"
  defaultSSLHostConfigName="[도메인]" >

  <SSLHostConfig>      
    <Certificate certificateKeyFile="[발급받은 인증서 경로]/privkey.pem"  
                 certificateFile="[발급받은 인증서 경로]/cert.pem"
                 certificateChainFile="[발급받은 인증서 경로]/fullchain.pem"
                 type="RSA" />
  </SSLHostConfig>      
  </Connector>
  ```
* 여러 호스트 명을 같은 포트로 나누어 사용할 경우 Host 태그를 추가한다.
<br>

  ```
  <Host name="[도메인]"  appBase="[홈디렉토리]"
        unpackWARs="true" autoDeploy="true">

    <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
            prefix="localhost_access_log" suffix=".txt"
            pattern="%h %l %u %t &quot;%r&quot; %s %b" />

  </Host>
  ```
  appBase에 설정한 경로로 디렉토리 생성
  서브로 ROOT 디렉토리를 생성
<br>

##### 인증서 갱신
```
# certbot renew --dry-run : 인증서 갱신 시뮬레이션
# certbot renew : 인증서 갱신
```
* Let's encrypt에서 발급되는 인증서의 유효기간은 3개월이기 때문에 **3개월마다 인증서를 갱신해야한다.**  
* 인증서가 갱신된 이후에는 톰캣을 재시작 한다.
 
##### 인증서 자동 갱신
```
$ crontab -l : 크론탭 내용 보기
$ crontab -e : 크론탭 편집
```

```
$ crontab -e
  0 3 * * * /usr/local/[tomcat]/bin/shutdown.sh
  : 매일 3시에 톰캣을 종료한다.

  1 3 * * * /usr/bin/certbot renew --renew-hook="/usr/local/[tomcat]/bin/startup.sh"
  : 매일 3시 1분에 인증서를 갱신한 후 톰캣을 시작한다.
```

* 주기 설정
  ```
  *         *           *         *         *
  분(0~59)  시간(0~23)  일(1~31)  월(1~12)  요일(0~7)
  ```

##### tomcat 재시작
설정을 적용했으면 관리자 권한으로 Tomcat을 재시작한다.
  ```
  $ cd /usr/local/[tomcat]/bin : tomcat 경로로 이동
  $ sh shutdown.sh : tomcat 서버 종료
  $ sh startup.sh : tomcat 서버 시작
  ```

### 3.2 OOO 인증서
`그 외의 사용한 인증서가 있다면 추가`
<br>
******
### 로키
참고사이트<br>
https://blog.naver.com/ncloud24/223338091706
<br>
인증서 설치<br>
https://idchowto.com/rocky-linux-8%EC%97%90-letsencrypt-%EC%9D%B8%EC%A6%9D%EC%84%9C-%EC%83%9D%EC%84%B1-%EB%B0%8F-nginx-%EC%A0%81%EC%9A%A9/
<br>
인증서 관련 참고 명령어<br>
https://docs.rockylinux.org/ko/guides/security/generating_ssl_keys_lets_encrypt/


아파치가 설치가 안되어 있다면 
```
dnf install certbot python3-certbot-apache
```

    외부에서 접속하는 http가 on 되어있는지 확인 

```
    getsebool -a | grep httpd_can_network_connect
```
안되있다면 
```
    setsebool -P httpd_can_network_connect on
    systemctl restart httpd
    httpd_can_network_connect --> on
    
```
필요한 conf.d 파일을 먼저 생성한 후에 시작
```
certbot --apache
```
명령어 실행시 어떤 도메인으로 ssl 을 발급받을건지 선택함 
ssl 443 관련된 conf.d 가 자동으로 생성됨 

******
참고문서

* 2.1. https://meongj-devlog.tistory.com/94
* 2.2. https://velog.io/@always0ne/Proxy-Pass%EB%A5%BC-%EC%82%AC%EC%9A%A9%ED%95%98%EC%97%AC-Apache-Web-Server%EC%97%90-WAS-%EC%97%B0%EB%8F%99%ED%95%98%EA%B8%B0
* 3.1 https://www.vompressor.com/tls1/
