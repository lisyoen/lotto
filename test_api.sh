#!/bin/bash

# 결과 저장 변수
results=()

# 기본 엔드포인트 테스트
if curl -s -o /dev/null -w "%{http_code}" http://localhost:8100/ | grep -q "200"; then
  results+=("GET /: 성공")
else
  results+=("GET /: 실패")
fi

# 사용자 로그인 테스트
if curl -s -o /dev/null -w "%{http_code}" -X POST http://localhost:8100/api/login \
-H "Content-Type: application/json" \
-d '{"username": "testuser", "password": "testpass"}' | grep -q "200"; then
  results+=("POST /api/login: 성공")
else
  results+=("POST /api/login: 실패")
fi

# 로또 번호 저장 테스트
if curl -s -o /dev/null -w "%{http_code}" -X POST http://localhost:8100/api/lotto/send \
-H "Content-Type: application/json" \
-d '{"lottoNumbers": [1, 2, 3, 4, 5, 6], "round": 1}' | grep -q "200"; then
  results+=("POST /api/lotto/send: 성공")
else
  results+=("POST /api/lotto/send: 실패")
fi

# 로또 번호 조회 테스트
if curl -s -o /dev/null -w "%{http_code}" http://localhost:8100/api/lotto/view | grep -q "200"; then
  results+=("GET /api/lotto/view: 성공")
else
  results+=("GET /api/lotto/view: 실패")
fi

# 로또 번호 페이지 단위 조회 테스트
if curl -s -o /dev/null -w "%{http_code}" "http://localhost:8100/api/lotto/view/paged?page=1&limit=5" | grep -q "200"; then
  results+=("GET /api/lotto/view/paged: 성공")
else
  results+=("GET /api/lotto/view/paged: 실패")
fi

# 결과 출력
echo "API 테스트 결과:"
for result in "${results[@]}"; do
  echo "- $result"
done
