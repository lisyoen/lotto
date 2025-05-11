import express, { Request, Response } from 'express';
import Database from 'better-sqlite3';

const app = express();
const port = 8100;

app.use(express.json());

app.get('/', (req: Request, res: Response) => {
  res.send('Hello, TypeScript API Server!');
});

// 데이터베이스 연결을 전역으로 설정
const db = new Database('db/lotto.db');

// 사용자 로그인 API
app.post('/api/login', (req: Request, res: Response) => {
  const { username, password } = req.body;
  if (!username || !password) {
    return res.status(400).send({ error: 'Username and password are required' });
  }
  res.send({ message: 'Login successful', username });
});

// 사용자 로또번호 전송 API
app.post('/api/lotto/send', (req: Request, res: Response) => {
  const { lottoNumbers, round } = req.body;
  if (!lottoNumbers || !Array.isArray(lottoNumbers) || lottoNumbers.length !== 6) {
    return res.status(400).send({ error: '6개의 로또 번호가 필요합니다.' });
  }

  const [number1, number2, number3, number4, number5, number6] = lottoNumbers;

  const stmt = db.prepare(`INSERT INTO lotto_numbers (user_id, round, number1, number2, number3, number4, number5, number6) VALUES (?, ?, ?, ?, ?, ?, ?, ?)`);
  stmt.run(1, round, number1, number2, number3, number4, number5, number6); // user_id는 임시로 1로 설정

  res.send({ message: 'Lotto numbers saved', numbers: lottoNumbers });
});

// 사용자 로또번호 표시 API
app.get('/api/lotto/view', (req: Request, res: Response) => {
  const rows = db.prepare(`SELECT round, number1, number2, number3, number4, number5, number6 FROM lotto_numbers WHERE user_id = ?`).all(1); // user_id는 임시로 1로 설정

  res.send({ message: 'Lotto numbers retrieved', numbers: rows });
});

// 사용자 로또번호 페이지 단위 조회 API
app.get('/api/lotto/view/paged', (req: Request, res: Response) => {
  const { page = 1, limit = 10 } = req.query;

  const offset = (Number(page) - 1) * Number(limit);
  const rows = db.prepare(
    `SELECT round, number1, number2, number3, number4, number5, number6 
     FROM lotto_numbers 
     WHERE user_id = ? 
     LIMIT ? OFFSET ?`
  ).all(1, Number(limit), offset); // user_id는 임시로 1로 설정

  res.send({
    message: 'Paged lotto numbers retrieved',
    page: Number(page),
    limit: Number(limit),
    numbers: rows
  });
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
