# 사용자로부터 프로젝트 이름 입력 받기
echo "프로젝트 이름을 입력하세요:"
read PROJECT_NAME

# 입력 받은 프로젝트 이름으로 tar 파일 경로 설정
IMAGE_FILE="$PROJECT_NAME.tar"

# 종료할 컨테이너 이름
CONTAINER_NAME="$PROJECT_NAME"

# 실행중인 컨테이너 종료
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    docker stop $CONTAINER_NAME
    docker rm -f $CONTAINER_NAME
    echo "컨테이너 $CONTAINER_NAME 종료 및 삭제 완료"
else
    echo "실행중인 컨테이너 $CONTAINER_NAME 없음"
fi

# 이전 이미지 삭제
IMAGE_NAME="$PROJECT_NAME"
if [ "$(docker images -q $IMAGE_NAME)" ]; then
    docker rmi $IMAGE_NAME
    echo "이전 이미지 $IMAGE_NAME 삭제 완료"
else
    echo "이전 이미지 $IMAGE_NAME 없음"
fi

# 이미지 로드
docker load -i "$IMAGE_FILE"

# 포트 번호 입력 받기
echo "외부 포트를 입력:"
read EXTERNAL_PORT
echo "내부 포트를 입력:"
read INTERNAL_PORT

nohup docker run --add-host=host.docker.internal:host-gateway -p $EXTERNAL_PORT:$INTERNAL_PORT --restart=always -e TZ=Asia/Seoul -v /home/$PROJECT_NAME/upload:/upload  --name $PROJECT_NAME $PROJECT_NAME &
