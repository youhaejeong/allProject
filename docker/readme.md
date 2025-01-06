# 도커를 이용한 배포방법

#### [도커로 배포시 DB연결 주의사항](https://github.com/youhaejeong/allProject/blob/main/docker/database.md)

#### maven install 시 maven test 가 fail 될시 test skip 구문을 pom.xml 에 추가하고 진행한다
```
<properties>
    <maven.test.skip>true</maven.test.skip>
</properties>
```

## 로컬 PC에 도커 설치 

1. 윈도우용 도커 설치   
 https://docs.docker.com/desktop/install/windows-install/    
 https://jimmy-ai.tistory.com/292 참고
2. mac용 도커 설치   
 https://docs.docker.com/desktop/install/mac-install/

3. 설치 후 터미널창에서 도커설치 확인
    ```
     docker --version
     Docker version 24.0.6, build ed223bc
    ```


## 프로젝트 세팅
### 도커파일 생성
1. Package Explorer > 프로젝트이름 우클릭 > New > file > 파일명 Dockerfile입력
2. Dockerfile 내용 입력
    ### *스프링부트 내장톰캣, java 17 기준
    ```dockerfile

    # 자바버전 설정
    FROM openjdk:17-ea-11-jdk-slim

    # poi API(엑셀 API)를 사용하는 경우, docker용 Slim JDK 사용 시 에러가 발생하는 경우 있음
    # 해결방법 1. 하단의 구문 추가
    # slim에서 제외된 폰트를 다운받아 오류를 해결한다.
    # RUN apt-get update; apt-get install -y fontconfig libfreetype6
    # 해결방법 2. openjdk를 slim이 아닌 기본 버전을 사용한다.
    # FROM openjdk:17


    # 컨테이너 내부에서 작업 디렉토리 설정
    WORKDIR /app

    # WAR 파일을 컨테이너로 복사
    COPY target/*.war /app/(프로젝트 이름).war

    # 실행 파일 설정
    CMD ["java", "-jar", "/app/(프로젝트 이름).war"]

    
    #타임존 설정
    ENV TZ=Asia/Seoul
    ```

    **서블릿 버전이 바껴서 스프링부트 2버전은 톰캣 9이하, 부트 3부터는 톰캣 10이상부터 호환됨**   

    ### *스프링부트3, java 17, 외장 톰캣 10.1 기준    
    ### 스프링부트2 버전일 경우, 톰캣 9버전을 사용
    9버전을 사용할땐   
    [톰캣 다운로드 페이지](https://tomcat.apache.org/download-90.cgi)에서 core에 tar.gz 우클릭해서 링크복사   
    dockerfile에 톰캣 다운로드 링크부분 교체  

    ```dockerfile

    # 자바버전 설정
    FROM openjdk:17-ea-jdk-slim

    # Set environment variables
    ENV CATALINA_HOME /usr/local/tomcat
    ENV PATH $CATALINA_HOME/bin:$PATH

    # Create a directory for Tomcat
    RUN mkdir -p "$CATALINA_HOME"

    # 컨테이너 내부에서 작업 디렉토리 설정
    WORKDIR $CATALINA_HOME/webapps

    # Update package list and install curl
    RUN apt-get update && apt-get install -y curl
    RUN apt-get install -y tzdata

    # 타임존 설정
    ENV TZ=Asia/Seoul

    # Tomcat 10 다운로드
    RUN curl -o /tmp/tomcat.tar.gz -L https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.24/bin/apache-tomcat-10.1.24.tar.gz

    # Tomcat 압축 풀기
    RUN tar xf /tmp/tomcat.tar.gz -C $CATALINA_HOME --strip-components=1

    # WAR 파일을 컨테이너로 복사 
    RUN rm -rf $CATALINA_HOME/webapps/*
    COPY target/*.war $CATALINA_HOME/webapps/ROOT.war

    # Tomcat port 설정
    EXPOSE 8080

    # Tomcat 실행
    CMD ["catalina.sh", "run"]
    ```



    ### *전자정부 java 8, tomcat 8.5, 포트번호 8080 기준   
    > server.xml 설정을 변경 할 경우    
    > 로컬 설정파일을 컨테이너에 복사    
    > Package Explorer > 프로젝트이름 > target 우클릭 > New > file > 파일명 server.xml 입력
    > 로컬 톰캣의 server.xml 붙여 넣기
    ```dockerfile

    # 자바버전 설정
    FROM tomcat:8.5-jdk8-openjdk-slim

    # Set environment variables
    ENV CATALINA_HOME /usr/local/tomcat
    ENV PATH $CATALINA_HOME/bin:$PATH

    # 컨테이너 내부에서 작업 디렉토리 설정
    WORKDIR $CATALINA_HOME/webapps

    # 호스트 머신의 WAR 파일을 컨테이너로 복사
    RUN rm -rf $CATALINA_HOME/webapps/*
    COPY target/*.war $CATALINA_HOME/webapps/ROOT.war

    # server.xml 설정을 변경 할 경우 
    # 로컬 설정파일을 컨테이너에 복사
    # COPY target/server.xml $CATALINA_HOME/conf/server.xml

    # 타임존 설정
    RUN apt-get update
    RUN apt-get install -y tzdata
    ENV TZ=Asia/Seoul

    # 포트 설정
    # server.xml에서 포트를 변경한 경우 여기서도 수정
    EXPOSE 8080

    # 실행 파일 설정
    CMD ["catalina.sh", "run"]
    
    ```

3. 프로젝트 빌드   
  프로젝트 우클릭 > run as > maven install

4. docker 엔진 실행

    ~~5. 프로젝트 폴더 경로에서 터미널 실행~~   
        ~~```
        docker build --platform linux/amd64 -t (이미지이름) .
        ```~~   
    ~~6. 도커이미지 생성 확인~~    
        ~~```
        docker image ls
        ```~~   
    ~~7. 도커이미지를 tar파일로 변환~~   
        ~~```
        docker save -o (프로젝트 이름).tar (이미지이름)
        ```~~   
    ~~8. tar파일 개발서버로 전송~~   
    ~~이건 다들 할줄 알잖아요?~~   
    ~~프로젝트 별로 폴더구분해서 그쪽으로 넣으면 될 듯~~   

    **개발자면 이런거 자동화 합시다**   

5. 레포지토리의 docker.sh 파일을 프로젝트 루트 디렉토리로 복사

6. 로컬환경 설정
    - 도커 데스트탑 실행
    - 설정 > docker engine으로 이동
    - json파일에 다음 내용 추가
registry 서버를 외부에서 접속하려면 https를 통한 인증절차를 거치는데
ssl 설정과 인증서 등록과정을 거쳐야하는데 매우 복잡하기 때문에
인증절차 없이 접속 가능하도록 아래와 같이 설정한다.

```json
{
  기존 내용...
  "insecure-registries" : [ "210.90.113.81:5000" ]
}
```

7. ./docker.sh 실행   
    도커 이미지를 개발서버에 구축한 registry에 올리는 과정.    
    git에 push하는 과정이라고 생각하면 된다.
> registry에 대한 자세한 내용은    
> [여기 참고](https://gitlab.brighten.co.kr/lgh/deloy_with_docker/-/blob/main/registry.md)


## 서버세팅
1. 도커설치 확인
    ```
     docker --version
     Docker version 24.0.6, build ed223bc
    ```
    
2. 도커가 없을 경우 설치
    ```
    #Install
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    
    #Docker 서비스 실행
    sudo systemctl start docker
    
    #부팅시 자동 실행 설정
    sudo chkconfig docker on
    ```

## 서버 배포 과정

### 1.registry에서 내려받기(*추천 개편함)
1. registry.sh 파일을 서버 프로젝트 경로에 복사   
    1-1. registry 내용을 프로젝트에 맞게 수정
> 외부 톰캣을 사용하는 경우에는 파일 업로드 경로가 /upload가 아니기 때문에   
> 해당 프로젝트에 맞는 경로로 수정해줘야한다.   
> ex) -v /home/$PROJECT_NAME/upload:/usr/local/tomcat/upload   
> 아마 이 경로일듯?  

2. ./registry.sh 실행   
    2-1. 실행이 안될경우 
    ```
    sudo chmod +x registry.sh
    sudo ./registry.sh
    ```
3. 입력하라는 대로 하면 실행됨!!   

### 2.명령어 하나하나 수동으로 입력하는 방식(tar파일 방식)
1. 기존에 실행중인 컨테이너 종료
    ```
    docker rm -f (컨테이너 이름)
    ```

2. 이전에 실행하던 도커이미지 삭제
    ```
    docker rmi (이미지이름)
    ```

3. tar파일 이미지로 변환
    ```
    docker load -i (프로젝트이름).tar
    ```

4. 도커 컨테이너 실행
    ```
    nohup docker run --add-host=host.docker.internal:host-gateway -p 8085:8080 --restart=always -e TZ=Asia/Seoul -v /home/(프로젝트경로)/upload:/upload --name (컨테이너 이름) (이미지 이름) &

    nohup docker run -p 외부접속포트:내부프로젝트포트 [컨테이너 자동실행 옵션] -e 타임존설정 -v 서버 파일 저장 경로:컨테이너 내부 파일 경로 --name (컨테이너 이름) (이미지 이름) &
    ```   
    **Dockerfile에서 타임존 설정을 했다면 '-e TZ=Asia/Seoul' 는 생략할 수 있다.**   
  
    도커 컨테이너는 외부와 분리된 환경에서 동작하고 종료시 내부 파일이 다 삭제된다.   
    따라서 컨테이너 내부 파일 저장경로(프로젝트의 upload경로)와   
    서버의 해당 프로젝트 파일 경로를 마운트시켜서  
    파일이 동기화 되도록한다.  
    위 방법으로 실행하면 /upload에 저장된 파일들이 서버의 /home/프로젝트경로/upload 경로에도 저장된다.   

    --add-host=host.docker.internal:host-gateway 옵션은 도커 컨테이너에 외부 호스트 서버의 IP를 전달하는 옵션이다.  


### 3.쉘 스크립트로 자동화(tar파일 방식)
1. 위 내용 자동화   
컨테이너 이름 = 이미지 이름 = 프로젝트 이름 = 프로젝트 경로    
일때    
start.sh에서 프로젝트이름과 포트번호를 입력하면 3 ~ 6 과정을 자동으로 실행


## [도커명령어 모음](https://gitlab.brighten.co.kr/lgh/deloy_with_docker/-/blob/main/command.md)


## 업데이트 예정
- 젠킨스를 이용한 빌드 ~ 배포 과정 자동화.
- 깃랩 파이프라인을 이용해 깃 푸시 ~ 배포 자동화.
- 깃랩 파이프라인과 브랜치 전략을 이용해  
기능 개발용 브랜치와 개발서버 배포용, 운영서버 배포용 브랜치 구분.   
개발서버 배포용 브랜치에 merge 시 배포까지 자동화.
