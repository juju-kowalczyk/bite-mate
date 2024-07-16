import { createWebHistory, createRouter } from "vue-router";
import Login from "@/pages/login.vue";
import Orders from "@/pages/orders.vue";

const routes = [
    {
        path: "/",
        name: "Login",
        component: Login,
    },
    {
        path: "/orders/",
        name: "Orders",
        component: Orders,
    },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;