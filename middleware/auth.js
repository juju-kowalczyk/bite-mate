// middleware/auth.js
export default function ({ redirect }) {
    const token = localStorage.getItem('token');
    if (!token) {
        return redirect('/login');
    }
}
