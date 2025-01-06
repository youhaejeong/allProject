# 사용자로부터 프로젝트 이름 입력 받기
echo "프로젝트 이름을 입력하세요:"
read PROJECT_NAME

# 이전 이미지 삭제
IMAGE_NAME="210.90.113.81:5000/$PROJECT_NAME"
if [ "$(docker images -q $IMAGE_NAME)" ]; then
    docker rmi $IMAGE_NAME
    echo "이전 이미지 $IMAGE_NAME 삭제 완료"
else
    echo "이전 이미지 $IMAGE_NAME 없음"
fi

if [ "$(docker images -q $PROJECT_NAME)" ]; then
    docker rmi $PROJECT_NAME
    echo "이전 이미지 $PROJECT_NAME 삭제 완료"
else
    echo "이전 이미지 $PROJECT_NAME 없음"
fi


docker build --platform linux/amd64 -t 210.90.113.81:5000/$PROJECT_NAME .

docker push 210.90.113.81:5000/$PROJECT_NAME
