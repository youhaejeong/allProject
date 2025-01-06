## registry란?
github와 비슷하게 docker에는 이미지를 올릴 수 있는 docker hub라는게 있다.   

일반적으로 로컬에서 docker hub에 이미지를 push를 하고   
서버환경에서 pull을 받아 실행한다.   

하지만 docker hub에 올라간 이미지는 누구나 pull 받을 수 있기 때문에   
docker hub 대신 docker hub처럼 쓸수있는   
private registry를 구축해서 사용한다.   

[참고사이트](https://velog.io/@lijahong/0%EB%B6%80%ED%84%B0-%EC%8B%9C%EC%9E%91%ED%95%98%EB%8A%94-Docker-%EA%B3%B5%EB%B6%80-Private-Registry-%EA%B5%AC%ED%98%84)

## 설치 방법

### registry서버 구축
1. 서버에 도커설치가 되어있다는 가정하에
```
docker pull registry
docker pull hyper/docker-registry-web
```
이미지 2개를 다운받는다.

2. registry를 실행한다
```
docker run -d -p 5000:5000 --restart=always --name registry -v /home/registry:/var/lib/registry/docker/registry -e REGISTRY_STORAGE_DELETE_ENABLED=true registry
```

3. registry ui 웹서버를 실행한다.
```
docker run -it -d -p 8999:8080 --name registry_web --link registry -e REGISTRY_URL=http://192.168.1.225:5000/v2 -e REGISTRY_NAME=192.168.1.225:5000 hyper/docker-registry-web
```
```
docker run -it -d -p [registry_web 포트설정]:8080 --name [registry_web 컨테이너 이름지정] --link [2에서 실행한 registry 컨테이너 이름] -e REGISTRY_URL=http://[registry서버 ip]:5000/v2 -e REGISTRY_NAME=[registry서버 ip]:5000 hyper/docker-registry-web
```

### 로컬환경 설정
1. 도커 데스트탑 실행
2. 설정 > docker engine으로 이동
3. json파일에 다음 내용 추가
registry 서버를 외부에서 접속하려면 https를 통한 인증절차를 거치는데
ssl 설정과 인증서 등록과정을 거쳐야하는데 매우 복잡하기 때문에
인증절차 없이 접속 가능하도록 아래와 같이 설정한다.

```json
{
  기존 내용...
  "insecure-registries" : [ "[registry 서버 ip ex)192.168.1.225]:5000" ]
}
```

### 대신 registry에서 사용되는 포트(5000)는 내부망에서만 접속가능하도록 사용한다

## 도커 이미지 push
로컬에서 작업한 도커 이미지를 서버로 push한다
0. 이미지 생성   
1. 이미지 형식 변경   
일반적으로 이미지의 이름은 아래와 같은 형식을 취해야 한다
> public -> gildong/myweb:1.0 처럼 앞에 USER ID 를 입력해야 한다   
> private -> reg.test.com:5000/myweb:1.0 or 192.168.1.101:5000/myweb:1.0 처럼 앞에 주소를 입력해야 한다   
> local -> myweb:1.0 처럼 이미지 이름과 태그만 입력하면 된다   
```
docker tag [이미지이름] 192.168.1.225:5000/[이미지이름]
```

2. 이미지 push
```
docker push [서버 ip ex)192.168.1.225]:5000/[이미지이름]
```
3. registry확인
```
curl -XGET [서버ip ex)192.168.1.228]:5000/v2/_catalog
```
```
{"repositories":["이미지이름"]}
```
과 같이 확인 가능하다
   
브라우저에서 [서버ip]:8999로 접속해서도 registry에 등록된 이미지를 확인할 수 있다.


## 도커 이미지 pull
1. 이미지 pull
```
docker pull localhost:5000/[이미지이름]
```
```
docker pull [서버ip]:5000/[이미지이름]
```
로 pull을 받는다

> 만약 registry서버와 도커 이미지를 실행할 서버 환경이 다르다면   
> 도커 이미지를 실행할 서버에서 insecure-registries 설정을 해줘야한다. [설정방법](https://kimmj.github.io/docker/insecure-registry/)  
> 지금은 같은 환경이므로 필요없다.      

2. 내려받은 이미지를 실행   
### pull받은 이미지 실행시 주의

~~nohup docker run -p $PORT:$PORT --restart=always -e TZ=Asia/Seoul -v /home/$PROJECT_NAME/upload:/upload --name $PROJECT_NAME $PROJECT_NAME &~~

start.sh 파일에 젤 마지막 $PROJECT_NAME을 localhost:5000/$PROJECT_NAME로 변경해줘야 한다
```
nohup docker run -p $PORT:$PORT --restart=always -e TZ=Asia/Seoul -v /home/$PROJECT_NAME/upload:/upload --name $PROJECT_NAME localhost:5000/$PROJECT_NAME &
```
