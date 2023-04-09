import { createRouter, createWebHistory } from 'vue-router';
import DocsView from '../views/DocsView.vue';
import MonitoringView from '../views/MonitoringView.vue';

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes: [
        {
            path: '/',
            name: 'monitoring',
            component: MonitoringView
        },
        {
            path: '/docs',
            name: 'docs',
            component: DocsView
        }
    ]
});

export default router;
