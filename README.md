<!-- File Path: /home/lisyoen/git/lotto-server/README.md -->

# 로또 서버

로또번호 관리/추천 서비스

Express 로 제작

> 🧩 관련 프로젝트
- [로또 클라이언트](https://github.com/lisyoen/lotto-client)
- [로또 서버](https://github.com/lisyoen/lotto-server)

## API 설명

### QRCode 읽기
- **URL**: `/api/qrcode`
- **Method**: POST
- **Request Body**:
  ```json
  {
    "qrData": "string"
  }
  ```
- **Response**:
  ```json
  {
    "message": "QR data received",
    "data": "string"
  }
  ```

### 사용자 로그인
- **URL**: `/api/login`
- **Method**: POST
- **Request Body**:
  ```json
  {
    "username": "string",
    "password": "string"
  }
  ```
- **Response**:
  ```json
  {
    "message": "Login successful",
    "username": "string"
  }
  ```

### 사용자 로또번호 전송
- **URL**: `/api/lotto/send`
- **Method**: POST
- **Request Body**:
  ```json
  {
    "round": 1,
    "lottoNumbers": [1, 2, 3, 4, 5, 6]
  }
  ```
- **Response**:
  ```json
  {
    "message": "Lotto numbers saved",
    "round": 1,
    "numbers": [1, 2, 3, 4, 5, 6]
  }
  ```

### 사용자 로또번호 표시
- **URL**: `/api/lotto/view`
- **Method**: GET
- **Response**:
  ```json
  {
    "message": "Lotto numbers retrieved",
    "round": 1,
    "numbers": [1, 2, 3, 4, 5, 6]
  }
  ```

### 사용자 로또번호 페이지 단위 조회
- **URL**: `/api/lotto/view/paged`
- **Method**: GET
- **Query Parameters**:
  - `page` (optional, default: 1): 조회할 페이지 번호
  - `limit` (optional, default: 10): 한 페이지에 표시할 로또 번호 개수
- **Response**:
  ```json
  {
    "message": "Paged lotto numbers retrieved",
    "page": 1,
    "limit": 10,
    "numbers": [
      {
        "round": 1,
        "number1": 1,
        "number2": 2,
        "number3": 3,
        "number4": 4,
        "number5": 5,
        "number6": 6
      }
    ]
  }
  ```

## NPM 스크립트

### `npm run init:db`
- 데이터베이스를 초기화합니다. `db/init_db.sql` 파일을 실행하여 필요한 테이블을 생성합니다.

### `npm run restart`
- 서버를 재시작합니다. PM2를 사용하여 서버를 중지하고 다시 시작합니다.

### `npm run test:api`
- API 테스트 스크립트를 실행합니다. `test_api.sh` 파일을 실행하여 모든 API 엔드포인트를 테스트합니다.
