ABSDIR=$(dirname $ABSPATH)

source ${ABSDIR}/profile.sh

IDLE_PORT=$(find_idel_port)

echo "> $IDEL_PORT 에서 구동 중인 애플리케이션의 PID를 확인하는 중입니다."
IDLE_PID=$(lsof -ti tcp:${IDLE_PORT})

if [ -z ${IDLE_PORT} ]; then
  echo "> 현재 구동 중인 애플리케이션이 없으므로 종료하지 않습니다."
else
  echo "> 현재 구동 중인 애플리메이션($IDLE_PID)을 종료합니다."
  kill -15 ${IDLE_PID}
  sleep 5
fi
