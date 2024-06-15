// api/orders.js
import jwt from 'jsonwebtoken';
import pool from '../db';
import QRCode from 'qrcode';

const secret = 'your_jwt_secret';

export default defineEventHandler(async (event) => {
    const { method, headers, body } = await readBody(event);
    const authHeader = headers.authorization;
    const token = authHeader && authHeader.split(' ')[1];
    if (!token) return { error: 'Unauthorized' };

    try {
        const user = jwt.verify(token, secret);
        if (method === 'POST') {
            const { description } = body;
            const [result] = await pool.query('INSERT INTO orders (user_id, description) VALUES (?, ?)', [user.id, description]);
            const orderId = result.insertId;
            const qrCodeUrl = await QRCode.toDataURL(`https://yourapp.com/orders/${orderId}`);
            return { success: result.affectedRows === 1, qrCodeUrl };
        }

        if (method === 'GET') {
            const [orders] = await pool.query('SELECT * FROM orders WHERE user_id = ?', [user.id]);
            return { orders };
        }
    } catch (err) {
        return { error: 'Invalid token' };
    }
});
