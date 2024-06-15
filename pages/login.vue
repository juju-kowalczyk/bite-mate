<template>
  <div>
    <form @submit.prevent="handleSubmit">
      <input v-model="username" type="text" placeholder="Username" required />
      <input v-model="password" type="password" placeholder="Password" required />
      <button type="submit">{{ action === 'login' ? 'Login' : 'Register' }}</button>
      <button type="button" @click="toggleAction">{{ action === 'login' ? 'Switch to Register' : 'Switch to Login' }}</button>
    </form>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';

const username = ref('');
const password = ref('');
const action = ref('login');
const router = useRouter();

const handleSubmit = async () => {
  const res = await fetch('/api/auth', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ username: username.value, password: password.value, action: action.value }),
  });
  const data = await res.json();
  if (data.token) {
    localStorage.setItem('token', data.token);
    router.push('/orders');
  } else {
    alert(data.error || 'An error occurred');
  }
};

const toggleAction = () => {
  action.value = action.value === 'login' ? 'register' : 'login';
};
</script>
