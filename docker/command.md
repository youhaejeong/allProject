
## 도커 명령어 모음
1. 실행중인 컨테이너 확인 
    ```
    docker ps 
    ```
2. 정지된 컨테이너 확인
    ```
    docker ps -a
    ```
3. 현재 이미지 확인
    ```
    docker images
    ```
4. 이미지 삭제
    ```
    docker rmi (이미지 아이디)
    ```
5. 컨테이너 내부 접속
    ```
    docker exec -it (컨테이너 아이디 or 컨테이너 이름) /bin/bash
    ```
6. 컨테이너 종료
    ```
    docker stop (컨테이너 아이디 or 컨테이너 이름)
    ```
7. 컨테이너 삭제
    ```
    docker rm -f (컨테이너 아이디 or 컨테이너 이름)
    ```
