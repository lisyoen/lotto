#!/bin/bash

# 테스트할 서버 목록
servers=(
  "localhost:8100"
  "lisyoen2.iptime.org:8100"
)

for server in "${servers[@]}"; do
  echo "\n[$server API 테스트 결과]"
  results=()

  # 기본 엔드포인트 테스트
  if [ "$(curl -s -o /dev/null -w "%{http_code}" http://$server/)" = "200" ]; then
    results+=("GET /: 성공")
  else
    results+=("GET /: 실패")
  fi

  # 사용자 로그인 테스트
  if [ "$(curl -s -o /dev/null -w "%{http_code}" -X POST http://$server/api/login \
  -H "Content-Type: application/json" \
  -d '{"username": "testuser", "password": "testpass"}')" = "200" ]; then
    results+=("POST /api/login: 성공")
  else
    results+=("POST /api/login: 실패")
  fi

  # 로또 번호 저장 테스트
  if [ "$(curl -s -o /dev/null -w "%{http_code}" -X POST http://$server/api/lotto/send \
  -H "Content-Type: application/json" \
  -d '{"lottoNumbers": [1, 2, 3, 4, 5, 6], "round": 1}')" = "200" ]; then
    results+=("POST /api/lotto/send: 성공")
  else
    results+=("POST /api/lotto/send: 실패")
  fi

  # 로또 번호 조회 테스트
  if [ "$(curl -s -o /dev/null -w "%{http_code}" http://$server/api/lotto/view)" = "200" ]; then
    results+=("GET /api/lotto/view: 성공")
  else
    results+=("GET /api/lotto/view: 실패")
  fi

  # 로또 번호 페이지 단위 조회 테스트
  if [ "$(curl -s -o /dev/null -w "%{http_code}" "http://$server/api/lotto/view/paged?page=1&limit=5")" = "200" ]; then
    results+=("GET /api/lotto/view/paged: 성공")
  else
    results+=("GET /api/lotto/view/paged: 실패")
  fi

  for result in "${results[@]}"; do
    echo "- $result"
  done

  # 테스트 데이터 삭제 (테스트용 계정의 로또번호 삭제)
  curl -s -X DELETE http://$server/api/lotto/test/cleanup > /dev/null 2>&1

done
