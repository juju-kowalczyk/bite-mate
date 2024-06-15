// api/auth.js
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import pool from '../db';

const secret = 'your_jwt_secret';

export default defineEventHandler(async (event) => {
    const { method, body } = await readBody(event);

    if (method === 'POST' && body.action === 'register') {
        const { username, password } = body;
        const hashedPassword = await bcrypt.hash(password, 10);
        const [result] = await pool.query('INSERT INTO users (username, password) VALUES (?, ?)', [username, hashedPassword]);
        return { success: result.affectedRows === 1 };
    }

    if (method === 'POST' && body.action === 'login') {
        const { username, password } = body;
        const [rows] = await pool.query('SELECT * FROM users WHERE username = ?', [username]);
        if (rows.length > 0) {
            const user = rows[0];
            const match = await bcrypt.compare(password, user.password);
            if (match) {
                const token = jwt.sign({ id: user.id }, secret, { expiresIn: '1h' });
                return { token };
            }
        }
        return { error: 'Invalid credentials' };
    }
});
