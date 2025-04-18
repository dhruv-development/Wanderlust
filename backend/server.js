import dotenv from 'dotenv';
dotenv.config();
import compression from 'compression';
import cookieParser from 'cookie-parser';
import cors from 'cors';
import express from 'express';
import connectDB from './config/db.js';
import { PORT } from './config/utils.js';
import authRouter from './routes/auth.js';
import postsRouter from './routes/posts.js';
// import { connectToRedis } from './services/redis.js';
const app = express();
const port = PORT || 5000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const allowedOrigins = process.env.CORS_ORIGIN?.split(',') || [
  'https://codematrix.space',
  'https://www.codematrix.space'
];

const corsOrigin = process.env.CORS_ORIGIN;
app.use(cors({
    origin: corsOrigin,
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    credentials: true,
    optionsSuccessStatus: 204,
}));
app.use(cookieParser());
app.use(compression());

// Connect to database
connectDB();

// Connect to redis
// connectToRedis();

// API route
app.use('/api/posts', postsRouter);
app.use('/api/auth', authRouter);

app.get('/', (req, res) => {
  res.send('Yay!! Backend of wanderlust app is now accessible');
});
// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'OK', message: 'Backend is healthy' });
});
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

export default app;
