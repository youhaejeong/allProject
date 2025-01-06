
- version 1.0.0 오재준 2023-08-09   
- version 1.0.1 오재준 2023-08-25 : 이미지 수정   
- version 1.0.2 오재준 2023-08-28 : branch 설명 추가
- version 1.0.3 유해정 2023-09-01 : bash로 깃랩에 프로젝트 올리기 추가 
- version 1.0.4 유해정 2024-02-07 : bash 강제 pull 추가
- version 1.1.0 오재준 2024-06-19 : 프로젝트 - git연결 설명 변경

- 질문사항 최하단에 작성해주시면 가능한한 반영예정

<br/>

# * Git이란 ?
```
- 형상관리를 도와주는 프로그램
- 프로젝트 소스를 관리, 기존 소스와 수정된 소스의 비교, 소스 히스토리, 소스공유 등을 소스코드 관리할 수 있는 기능을 수행
```
<br/>

# * Git Branch
```
- 브랜치란 여러 개발자들이 동시에 다양한 작업을 할 수 있게 만들어 주는 기능
 
- 브랜치를 나눠 작업하면 다른 사람의 영향을 받지 않고 독립적으로 특정 작업을 수행가능하며 각 작업단위가 기록되기 때문에 문제가 발생하였을 때 수정하기 용이해진다.
```
<br/>

# * 브랜치 전략
<img src="https://user-images.githubusercontent.com/75202381/263172988-1e3fbf44-3df1-4016-a5f4-812159a6bf43.png" width="600" height="" style="display:block; margin:0 auto;"/>
<br/>

> - Master
>   > 릴리즈 시 사용하는 최종 단계 메인 브랜치
>   >
>   > Tag를 통해 버전 관리를 한다.
>
> - Develop
>   > 다음 릴리즈 버전 개발을 진행하는 브랜치
>   >
>   > 추가 기능 구현이 필요해지면, 해당 브랜치에서 다시 브랜치(Feature)를 내어 개발을 진행하고, 완료된 기능은 다시 Develop 브랜치로 Merge한다.
> 
> - Feature
>   >Develop 브랜치에서 기능 구현을 할 때 만드는 브랜치
>   >
>   >한 기능 단위마다 Feature 브랜치를 생성하는게 원칙이다.
> - Release
>   >Develop에서 파생된 브랜치
>   >
>   >Master 브랜치로 현재 코드가 Merge 될 수 있는지 테스트하고, 이 과정에서 발생한 버그를 고치는 공간이다. 확인 결과 이상이 없다면, 해당 브랜치는 Master와 Merge한다.
> 
> - Hotfix
>   >Mater브랜치의 버그를 수정하는 브랜치
>   >
>   >검수를 해도 릴리즈된 Master 브랜치에서 버그가 발견되는 경우가 존재한다. 이때 Hotfix 브랜치를 내어 버그 수정을 진행한다. 디버그가 완료되면 Master, Develop 브랜치에 Merge해주고 브랜치를 닫는다.

```
- 중심이 되는 브랜치는 master, develop 브랜치
- 규모가 크기 때문에 사용된 브랜치는 닫아서 삭제하여 관리해준다.
- 대규모 프로젝트에서 자주 쓰임
```

<br/>
<div style="text-align:center;">
    <img src="https://user-images.githubusercontent.com/75202381/263173209-5f820376-b9a3-48c8-99ab-1bec9f46795b.png" width="" height="" style="display:flow; margin:0 auto; text-align:center;"/>
    <img src="https://user-images.githubusercontent.com/75202381/263173222-9a2686c5-0d0a-4051-9d97-8fce23bd807f.png" width="" height="" style="display:flow; margin:0 auto; text-align:center;"/>
</div>
<br/><br/>

```
- 다른 전략으로 GitHub Flow, GitLab Flow 방식이 있다.
- GitHub Flow는 master 브랜치를 중심으로 기능추가/버그수정을 할 때 master 브랜치에서 직접 따온 후 merge하는 방식으로 간단하게 처리하는 방식이다. 별도의 안전장치가 없으므로 merge할 때 주의가 필요하다.
- GitLab Flow는 GitHub Flow에서 배포하기전 테스트 등을 위해 pre-production 브랜치를 두어 안정성을 높인 방식이다.
```

<br/>

# * GitLab Project 시작하기
```
- (Gitlab 계정 생성 및 연결은 생략)
```

<img src="https://user-images.githubusercontent.com/75202381/263173878-9ceaf251-77b3-4288-854c-b93c62d3cfd5.png" width="" height="" style="display:block; margin:0 auto;"/>
<br/>

<img src="https://user-images.githubusercontent.com/75202381/263173938-3985aa09-0c5d-4500-8dbf-88576cb81d82.png" width="" height="" style="display:block; margin:0 auto;"/>
<br/>


```
- 좌측상단 Menu > Projects > Create new project 클릭   

- Create blank project(새 프로젝트) 생성

- 프로젝트 이름 적고 프로젝트 생성하기
```

<br/>
<img src="https://user-images.githubusercontent.com/75202381/263173962-26e133da-6105-444d-886d-8fa50838337a.png" width="" height="" style="display:block; margin:0 auto;"/><br/>

```
- 생성된 Git 프로젝트
```
<br/>

# * Eclipse / STS
## 1. Git 연결하기
<div class="to23061" style="display:none;">
    <div style="text-align:center;">
        <img src="https://user-images.githubusercontent.com/75202381/263174017-376bc0cf-837f-4e01-8a66-4f7102311e2d.png" width="" height="" style="display:block;"/><br/>
        <div style="text-align:left;">
            <img src="https://user-images.githubusercontent.com/75202381/263174060-2f85d5f7-c019-479a-a54d-ff165f99aee8.png" width="" height="" style="display:flow;"/>
            <img src="https://user-images.githubusercontent.com/75202381/263174077-58ccc6f4-f41a-4531-8ff3-ae9ab59c413b.png" width="" height="" style="display:flow;"/>
        </div>
        <br/>
        <img src="https://user-images.githubusercontent.com/75202381/263174101-ea2a2953-f748-4964-bab8-39c4f11844a6.png" width="" height="" style="display:block;"/><br/>
        <img src="https://user-images.githubusercontent.com/75202381/263174124-78e05ad6-b027-4e83-8653-2ad54e87a762.png" width="" height="" style="display:block;"/><br/>
    </div>
    <br/>
   

    ```
    - Git clone 주소 복사

    - 연결할 프로젝트 - Git 연결하기

    - 프로젝트 우클릭 > Team > Share Project >> Git 선택 후 Next >> 

    - Git Repository가 없다면 Use or create~를 체크할 시 해당 작업 폴더에 생성할 수 있다.

    - 연결되었다면 위와 같이 Team 메뉴가 변경된다.
    ```
    <br/>

    <div style="text-align:center;">
        <img src="https://user-images.githubusercontent.com/75202381/263174161-36dbff1f-27bb-4bc1-adbd-68a7dde7a492.png" width="" height="" style="display:block; margin:0 auto;"/><br/>
        <img src="https://user-images.githubusercontent.com/75202381/263174168-62704de2-32e9-4ad1-996f-cc4be1cac28e.png" width="" height="" style="display:float;"/>
        <img src="https://user-images.githubusercontent.com/75202381/263174174-0b48b097-d361-4430-873b-e23390bee209.png" width="" height="" style="display:float;"/>
        <img src="https://user-images.githubusercontent.com/75202381/263174183-3b08ab96-0f18-4d37-bbfc-a7e0393b2cf7.png" width="" height="" style="display:float;"/>
    </div>
    <br/>

    ```
    - Commit > unstaged changes에서 Commit하고자 하는 파일을 staged changes로 옮기고 commit message를 작성하고 commit and push

    (branch 설정을 하지않고 commit 진행시 master브랜치가 생성되는데 main과 헷갈릴 수 있음)
    (Commit and push를 하지않고 commit만 하였을 경우 team 메뉴에서 push 할 수 있다.)
    ```
    <br/>
</div>

<div style="text-align:center;">
    <img src="https://user-images.githubusercontent.com/75202381/263174017-376bc0cf-837f-4e01-8a66-4f7102311e2d.png" width="" height="" style="display:block;"/><br/>
    <img src="https://github.com/nice1247/manageImg/assets/75202381/48919cfb-4c9a-4c34-93f0-ae417630dc3d" width="" height="" style="display:block;"/><br/>
    <img src="https://github.com/nice1247/manageImg/assets/75202381/d29e074d-7a00-456b-93c4-ef29f6d4379f" width="" height="" style="display:block;"/><br/>
    <img src="https://github.com/nice1247/manageImg/assets/75202381/5f4aaa5f-195e-4dda-b550-01da97965329" width="" height="" style="display:block;"/><br/>
    <img src="https://github.com/nice1247/manageImg/assets/75202381/a968c9b7-cedc-4661-81ba-163eb4805fb9" width="" height="" style="display:block;"/><br/>
</div>

```
- Git Repositories탭에서 Clone a Git repository 선택
- repository 경로를 복사해두었다면 자동으로 입력되며 repository 정보를 불러온다
- Destinantion - Directory를 2가지 방법으로 설정할 수 있다.
    1. Git Repository와 java Project를 같은 폴더에서 관리
        (단, Git Repostiory와 java Project명을 동일하게 설정)
    2. Git Repository를 모아둘 폴더를 따로 관리

> Case 1.
    a. Git Repository를 받아올 때 Directory경로를 해당 프로젝트 workspace아래에 둔다.
    b. Git Repository가 생성되는 특성상 java Project보다 먼저 생성해주어야한다.
        (반대로 할 경우 java Project안에 repository가 생성되어 꼬인다.)
    c. Git Repository와 동일한 이름으로 java Project를 생성해주면 자동으로 git과 연결된다.
    - 작업폴더와 깃폴더를 공유하여 보기 편하고 같은 프로젝트이름으로 설정해주어 프로젝트를 혼동하는 경우가 줄어든다. 또한 폴더를 공유하기 때문에 Git Repository생성 후 다른 프로젝트를 붙여와서 사용할 수 있다. (단, .git폴더를 남겨두어야 한다.)

> Case 2.
    a. Git Repository를 받아올 때 Directory경로를 내가 관리할 폴더로 연결한다.
    b. java Project를 생성한다.
    c. java Project를 해당 Git Repository와 연결한다.
    - Git Repository생성과 java Project생성 순서에 구애받지 않으며 오류가 날 확률을 줄여준다.
    프로젝트명이 서로 달라도 연결이 가능하다. 연결시 Git Repository를 모아둔 폴더로 프로젝트가 이동한다는 것을 인지하고 있어야한다.

- Case 1이 프로젝트별 관리는 편리하나 첫 연결시 에러가 발생할 확률은 높다.
```



## 2. Git Repository 받아오기(공동 작업자)
<div style="text-align:center;">
    <img src="https://user-images.githubusercontent.com/75202381/263174213-1c01b6cf-4b3f-4f0d-98ff-88b038e6bc19.png" width="" height="" style="display:block; margin:0 auto;"/><br/>
    <img src="https://user-images.githubusercontent.com/75202381/263174221-3e1d7f78-215d-44c4-9f33-63d7ad7721b7.png" width="" height="" style="display:float;"/>
    <img src="https://user-images.githubusercontent.com/75202381/263174224-4b3c9808-77f5-4394-a050-2c7a553e26f6.png" width="" height="" style="display:float;"/><br/>
    <img src="https://user-images.githubusercontent.com/75202381/263174230-c4099656-e7f9-4a17-8c9d-95151da24d07.png" width="" height="" style="display:float;"/>
    <img src="https://user-images.githubusercontent.com/75202381/263174239-b1f2b5ed-dd2e-424e-97fb-e73269360f3f.png" width="" height="" style="display:float;"/><br/><br/>
    <img src="https://user-images.githubusercontent.com/75202381/263174245-b0212261-fb0a-46a4-8a55-006c019cf014.png" width="" height="" style="display:float;"/>
</div>
<br/>

```
- Git에서 해당 Repository clone 주소 복사해오기 > URI에 옮겨쓰기 > 받아올 Branch 선택 > Git repository 저장 해 둘 곳 선택(Git 관리하는 폴더 또는 프로젝트 내에 저장 해두는 것이 관리하기 편함)

- Import Project
```

<br/>

# * Git Branch 사용하기
```
- 기본 프로세스 
: 브랜치 생성 > 메인이 되는 브랜치로부터 Pull > 작업... > 메인브랜치로 Commit & Push > Merge(브랜치 삭제)이지만   소규모 프로젝트의 경우 브랜치를 살려두고 작업해도 무방(브랜치 삭제는 대규모 프로젝트에서 혼란방지를 위해 시행)
```
<br/>

## 1. Branch 생성
<img src="https://user-images.githubusercontent.com/75202381/263612188-d42706d8-ea82-46cd-a2f5-48b337779f77.png" width="" height="" style="display:block; margin:0 auto;"/><br/>

```
- 프로젝트 우클릭 > Team > Switch To > New Branch...
```
<br/>
<img src="https://user-images.githubusercontent.com/75202381/263612209-a615e55f-47bd-4798-8be4-63ac37f9dc8f.png" width="" height="" style="display:block; margin:0 auto;"/><br/>
<img src="https://user-images.githubusercontent.com/75202381/263612226-633a7b7a-42f9-4ce7-9395-57c824d0428c.png" width="" height="" style="display:block; margin:0 auto;"/><br/>
<br/>

```
- Source : 소스가 될 브랜치, Branch name : 생성할 브랜치명, Check out new branch : 생성하자마자 checkout
```

<br/>
<img src="https://user-images.githubusercontent.com/75202381/263612241-51125f33-ed34-49be-9790-a3894ada902d.png" width="" height="" style="display:block; margin:0 auto;"/><br/>

```
- 성공하였다면 다음과 같이 프로젝트명 옆에 브랜치명이 표시된다.
```

## 2. Branch Pull
<br/>
<img src="https://user-images.githubusercontent.com/75202381/263612245-65054ded-0b6f-4aa4-87d6-090416f36fbb.png" width="" height="" style="display:block; margin:0 auto;"/><br/>
<img src="https://user-images.githubusercontent.com/75202381/263612256-b7e61a67-3eff-4371-b325-79e994688261.png" width="" height="" style="display:block; margin:0 auto;"/><br/>

```
- Pull 선택시 해당 브랜치로 부터 pull, Pull... 선택시 pull받을 브랜치 선택가능
```
<br/>


# * GitBash
## 1. Git Bash를 통해 프로젝트 받아오기
- 기본세팅
```
$ git config --list 						                 // git 설정 리스트
$ git config --global user.name [사용할 이름]
$ git config --global user.email [사용할 이메일]
$ git config --global push.default current 				     // 현재위치(브랜치)에서 push받을 수 있도록 설정
$ git config --global init.defaultBranch main(main 브랜치)    // 기본 main 브랜치명 설정
```
### gitBash 로 깃랩에 소스파일 올리기 
스프링 부트에서 spirng starter project를 이용해 생성하게 될시 main은 master 가 되어있음 

<img src="https://user-images.githubusercontent.com/75202381/263174923-48c8f94b-4457-489b-a5bd-ff4244e3d1cf.png" width="" height="" alt="git config" style="display:block; margin:0 auto;"/>
<p style="text-align:center;"><em>git config</em></p>

```
업로드할 파일 선택
이클립스에서 프로젝트 우클릭후 properties 를 보면 경로 확인 가능 
업로드할 프로젝트 폴더 우클릭 ->git bash here
초기설정
git config --global user.name "유저이름"
git config --global user.email "유저 이메일"

git init  #.git생성
git add . #선택한 프로젝트 폴더 내의 모든 파일 관리 
git status #상태확인
```

<img src="https://www.wflower.or.kr/upload/imagess/git_status.png" width="" height="" alt="git config" style="display:block; margin:0 auto;"/>
<p style="text-align:center;"><em>git status</em></p>

```


git commit -m "주석" #커밋

git remote add origin 깃랩 주소(shift +ins버튼으로 복사 붙여넣기)

git push origin main #푸쉬


깃랩 로그인


깃랩 확인

깃랩에 제대로 업로드 된것 확인되면 로컬과 생성한 프로젝트 모두 삭제 후 clone으로 다시 내려 받는게 젤 깔끔합니다

```
####   git push 가 제대로 되고 잇지 않다면 
```
 git pull origin main --allow-unrelated-histories
#강제로 pull 진행 후 push 재시도
```




```
$ cd [프로젝트 받을 폴더위치]
$ git clone [Git Clone 주소]
$ cd [작업폴더]				                        // 내려받은 작업폴더로 이동
$ git branch [브랜치명]			                    // 작업할 브랜치 생성
$ git checkout [브랜치명]			                // 생성한 브랜치로 이동
                                      (작업….)
$ git add -all ( $ git add . )		                // 작업한 모든 파일 staging area에 추가
	or
$ git add [작업할 파일명]

$ git commit -m [코멘트]			                      // 변경사항 내역 등 커밋 내역 작성
$ git push origin main			                      // 원격 저장소 main으로 push
($ remote -v를 통해 원격저장소 확인 가능)
- 이 때 push 기본설정을 해놓았다면 $ git push만 입력하여 전송가능

(작업전 pull 받아주기)
```




## 2. Git Bash를 통해 Git과 연결하기
```
- 작업폴더 생성 후 이동
$ git init                                                    // git repository 생성
$ git remote add origin [Git Clone 주소]                      // git 연결

- main 브랜치가 일치하지 않는다면(기본 브랜치명 설정 안했을 시)..
$ git branch -m [생성된 후 브랜치명] [원격저장소 메인 브랜치명] 

$ git pull origin main			                              // 원격저장소에서 프로젝트 받아오기

 이후 브랜치 생성해서 작업하고 올리는 것은 동일
```









<br/>

# * 이외
```
1. 이클립스에서 프로젝트 Overwrite
    프로젝트 우클릭 > Team > Synchronize Workspace
    Overwrite하려는 프로젝트 또는 파일 우클릭 > Overwrite

2. GitBash에서 프로젝트 Overwrite
    $ git fetch --all
    $ git reset --hard origin/master
    $ git pull origin master
```

```
$ git status                                       // 현재 브랜치 상태 확인
$ git branch                                       // 브랜치 목록 확인
$ git config --global unset user.name	           // 이름삭제
$ git config --global unset user.email		       // 이메일삭제
$ git push --set-upstream origin main	           // 기본브랜치설정
$ git log --graph --oneline			               // branch 그래프
$ rm -rf .git				                       // git repository 삭제
```






<br/>

# * 세팅
```
@ Pipeline(빌드, 자동테스트, 배포) 해제시키기 (Settings > CI/CD)
```

<img src="https://user-images.githubusercontent.com/75202381/263175029-9b8be905-e2f0-4d2f-90dd-05632ea77eab.png" width="" height="" style="display:block; margin:0 auto;"/><br/><br/>


```
@ 메인 브랜치 설정 (Settings > Repository)
```

<img src="https://user-images.githubusercontent.com/75202381/263175037-41d148fc-8e2e-4a20-b1e2-427a8983eb8d.png" width="" height="" style="display:block; margin:0 auto;"/><br/><br/>


```
@ Merge 할 때 브랜치 자동 삭제 해제시키기 (Settings > General)
```

<img src="https://user-images.githubusercontent.com/75202381/263175048-7ecca3a9-46db-4e98-999c-4e5e04f5e296.png" width="" height="" style="display:block; margin:0 auto;"/><br/><br/>



# 질문사항 ! (기입시 수정예정)
1. 1
2. 2
3. 3
4. 





#Fork	#Pipeline	#Rebase / Reset
