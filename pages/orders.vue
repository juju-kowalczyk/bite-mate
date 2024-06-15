<template>
  <div>
    <form @submit.prevent="addOrder">
      <input v-model="description" type="text" placeholder="Order Description" required />
      <button type="submit">Add Order</button>
    </form>
    <ul>
      <li v-for="order in orders" :key="order.id">
        {{ order.description }}
        <img :src="order.qrCodeUrl" alt="QR Code" />
      </li>
    </ul>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';

definePageMeta({
  middleware: 'auth',
});

const orders = ref([]);
const description = ref('');

const fetchOrders = async () => {
  const res = await fetch('/api/orders', {
    headers: {
      Authorization: `Bearer ${localStorage.getItem('token')}`,
    },
  });
  const data = await res.json();
  if (data.orders) {
    orders.value = data.orders;
  } else {
    alert(data.error || 'An error occurred');
  }
};

const addOrder = async () => {
  const res = await fetch('/api/orders', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${localStorage.getItem('token')}`,
    },
    body: JSON.stringify({ description: description.value }),
  });
  const data = await res.json();
  if (data.success) {
    fetchOrders();
    description.value = '';
  } else {
    alert(data.error || 'An error occurred');
  }
};

onMounted(() => {
  fetchOrders();
});
</script>
