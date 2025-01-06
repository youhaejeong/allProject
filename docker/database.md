## 도커 컨테이너에서 호스트 서버의 DB에 접속할 경우 주의사항

```yml
url: jdbc:mysql://localhost:3306/cafecare?serverTimezone=Asia/Seoul&characterEncoding=UTF-8
```
DB url이 localhost로 설정되어 있는 경우에   
도커 컨테이너에서는 localhost를 컨테이너 내부를 가리키기 때문에   
DB 연결이 안되는 문제가 발생할 수 있다.   

따라서 url에 내부 ip 주소를 사용하거나
```yml
url: jdbc:mysql://192.168.1.143:3306/cafecare?serverTimezone=Asia/Seoul&characterEncoding=UTF-8
```
   
   
또는 도커에서 제공하는 특수 도메인을 이용하여 호스트 서버의 localhost에 연결할 수 있다.
```yml
url: jdbc:mysql://host.docker.internal:3306/cafecare?serverTimezone=Asia/Seoul&characterEncoding=UTF-8
```
단, 이 경우에 linux 환경에서는 host.docker.internal의 주소를 설정해주어야 한다.    
컨테이너 실행시 --add-host=host.docker.internal:host-gateway 옵션을 지정해주면 된다.  
```bash
docker run --add-host=host.docker.internal:host-gateway ... myapp
```
