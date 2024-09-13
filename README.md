## 목차
- [목차](#목차)
- [1. URLSearchParams](#1-urlsearchparams)
- [2. 함수의() 뜻](#2-함수의-뜻)
- [3. DTO와 VO , dao 차이](#3-dto와-vo--dao-차이)

## 1. URLSearchParams
> 틀린 내용 찾기
```javascript
fetch("/test",{
    method : "GET",
    headers:{
        'Content-Type' : 'appilcation/json'
    },
    body : JSON.stringify(list)
})
```
> method 가 get 일 경우에는 body가 존재하지 않는다 조건을 보낼려면 쿼리스트링이나 pathvariable 을 사용하여 data 에 담아 보내야 한다
> 
> 이때 쿼리스트링을 사용시 직접 작성하는 방법도 잇지만 <span style="color: red; font-weight: 1000;">URLSearchParams</span>을 사용하는 방법도 있다
```javascript
# 사용예시

fetch("/test",{
    method : "GET",
    headers:{
        'Content-Type' : 'appilcation/json'
    },
    data : new URLSearchParams({'name' :'유해정'})
})
 ```
 ```javascript
# 사용예시

fetch("/test?"+new URLSearchParams({'name' :'유해정'}),{
    method : "GET",
})
 ```
  ```javascript
# 사용예시

let searchParams = new URLSearchParams({'name' :'유해정'})
fetch("/test?"+searchParams,{
    method : "GET",
})
 ```
<span style="color: red; font-weight: 1000;">URLSearchParams</span> 는 쿼리스트링 그대로 문자열로 넘길수도 있다.
아무것도 담기지 않은 <span style="color: red; font-weight: 1000;">URLSearchParams</span> 를 생성하여 <span style="color: #1EA4FF; font-weight: 1000;">append</span> 를 사용해 파라미터를 추가할 수 있다 
```javascript

let searchParams = new URLSearchParams()
searchParams.append("name","유해정")
```

이때 <span style="color: #1EA4FF; font-weight: 1000;">set</span> 라는 메서드도 있는데 이는 <span style="color: #1EA4FF; font-weight: 1000;">append</span> 와 달리 기존 값을 지우고 새로운값을 추가하는 것 


## 2. 함수의() 뜻
```javascript
#예제

function login(){}
# 이때의 login 은 정의만 하는것이므로 () 붙이면 클릭이벤트를 정의하면서 해당 함수를 즉시 실행함
document.getElementById("login").addEventListener("click",login);

document.getElementsByName("password")[0].addEventListener("keydown",function(event){
    if(event.key =="Enter"){
        login();
    }
});
```

## 3. DTO와 VO , dao 차이
> DTO <span style="color:red; font-weight: 1000;">Data Transfer Object</span> <span style="font-weight: 1000;">데이터 전송 객체</span><br>
