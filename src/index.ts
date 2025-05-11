// src/index.ts
// Express 서버 초기화
import express from 'express';
import bodyParser from 'body-parser';

const app = express();
const port = 3000;

app.use(bodyParser.json());

app.get('/', (req, res) => {
  res.send('Hello, TypeScript API Server!');
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
