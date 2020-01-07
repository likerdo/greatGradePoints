REPOSITORY=/home/ec2-user/app/step2
PROJECT_NAME=greatGradePoints

cd $REPOSITORY/$PROJECT_NAME/

echo "> Build 파일 복사"
cp $REPOSITORY/zip/*.jar $REPOSITORY/

echo "> 현재 구동중인 애플리케이션을  확인하는중입니다"
CURRENT_PID=$(pgrep -fl greatGradePoints | awk '{print $1}')

if [ -z "$CURRENT_PID" ] ; then
        echo "> 현재 구동중인 애플리케이션이 없습니다"
else
        echo "> 현재 구동중인 애플리케이션(pid: $CURRENT_PID)을 종료(-15)하고 5초 대기합니다"
        kill -15 $CURRENT_PID
        sleep 5
fi

echo "> 새 애플리케이션을 배포합니다"
JAR_NAME=$(ls -tr $REPOSITORY/ | grep *.jar | tail -n 1 )

echo "> $JAR_NAME 에 실행권한을 추가합니다"

chmod +x $JAR_NAME

echo "> $JAR_NAME 을 실행합니다"

nohup java -jar \
-Dspring.config.location=classpath:/application.properties,classpath:/application-real.properties,/home/ec2-user/app/application-oauth.properties,/home/ec2-user/app/application-real-db.properties \
-Dspring.profiles.active=real \
$JAR_NAME > $REPOSITORY/nohup.out 2>&1 &