# 📋 나만의 게시판 (Flask & PostgreSQL Bulletin Board)

Flask, Jinja2, PostgreSQL을 활용하여 개발한 게시판 웹 애플리케이션입니다.  
계층형 아키텍처(Blueprint 라우터, Service/Rules 검증, Repository DB 접근 계층)로 관심사를 분리하고 모던 UI 디자인 시스템을 적용하였습니다.

---

## 🚀 주요 기능

1. **게시글 목록 (`GET /`)**
   - 등록된 게시글 번호 오름차순 조회
   - 번호 뱃지 및 제목 링크
   - 새 글 작성 바로가기 및 빈 목록 안내
2. **게시글 상세 조회 (`GET /board/<int:post_id>`)**
   - 번호, 제목, 본문 확인
   - [목록으로], [수정하기], [삭제하기] 액션 제공
   - 존재하지 않는 글 접근 시 `404` 오류 페이지 안내
3. **게시글 작성 (`GET, POST /board/new`)**
   - 서버 측 제목/본문 공백 검증 (오류 시 `400` 및 작성 내용 유지)
   - PostgreSQL 시퀀스 기반 자동 채번 (`INSERT ... RETURNING id`)
   - PRG(Post-Redirect-Get) 패턴 적용 (`303 See Other`)으로 중복 저장 방지
4. **게시글 수정 (`GET, POST /board/<int:post_id>/edit`)**
   - 기존 게시글 데이터 폼 로딩
   - 공백 검증 및 오류 시 `400` 반환 (기존 DB 데이터 유지)
   - 수정 완료 후 `303` 응답으로 상세 화면 이동, 취소 시 해당 상세 화면 복귀
5. **게시글 삭제 (`GET, POST /board/<int:post_id>/delete`)**
   - 삭제 확인 화면(접속만으로 삭제되지 않음)
   - 확인 시 DB 삭제 후 `303` 응답으로 목록 화면 이동
   - 취소 시 해당 상세 화면 복귀 및 데이터 보존
6. **비동기 로그인 판정 (`GET /login`, `POST /auth/login`)**
   - JavaScript `fetch()` 기반 JSON 비동기 통신
   - 로그인 성공/실패/통신장애 동적 알림 배너 렌더링
7. **모니터링 연동 및 요청 로깅**
   - 모든 HTTP 요청 기록 콘솔 출력 및 감시 서비스(포트 5200)로 자동 전달

---

## 📁 프로젝트 구조

```text
my-board/
├─ app.py                     # 앱 생성, 블루프린트 등록, 로깅 훅, 서버 실행
├─ db.py                      # PostgreSQL 연결 풀 및 connect_db()
├─ post_rules.py              # 게시글 공통 유효성 검사 함수 (validate_post)
├─ request_logging.py         # HTTP 요청 기록 및 감시 서버 전송
├─ requirements.txt           # 필수 패키지 목록
├─ repositories/              # DB 데이터 액세스 계층
│  ├─ __init__.py
│  └─ posts.py                # CRUD SQL 쿼리 실행
├─ routes/                    # HTTP 라우팅 및 뷰 계층
│  ├─ __init__.py
│  └─ posts.py                # 게시판 Blueprint 및 엔드포인트 핸들러
├─ templates/                 # Jinja2 HTML 템플릿
│  ├─ index.html              # 게시글 목록
│  ├─ detail.html             # 게시글 상세
│  ├─ new.html                # 게시글 작성
│  ├─ edit.html               # 게시글 수정
│  ├─ delete.html             # 게시글 삭제 확인
│  ├─ login.html              # 비동기 로그인 판정 화면
│  └─ error.html              # 오류 안내 (404 등)
├─ static/
│  └─ style.css               # 모던 카드 디자인 시스템 스타일시트
└─ sql/
   └─ schema.sql              # DB 테이블 및 시퀀스 생성 SQL
```

---

## 🛠 실행 방법

### 1. 가상환경 생성 및 패키지 설치
```bash
python -m venv venv
venv\Scripts\activate       # Windows
python -m pip install -r requirements.txt
```

### 2. 환경변수 설정 (`.env`)
`.env.example`을 복사하여 `.env`를 생성하고 DB 접속 정보를 입력합니다:
```env
DB_HOST=127.0.0.1
DB_PORT=5432
DB_NAME=general_db
DB_USER=postgres
DB_PASSWORD=your_password
```

### 3. 서버 실행
```bash
python app.py
```
브라우저에서 **http://127.0.0.1:5100** 접속
