import { createApp } from 'vue';
import { createPinia } from 'pinia';

import App from './App.vue';
import router from './router';

import './assets/main.css';

import { OhVueIcon, addIcons } from 'oh-vue-icons';
import { LaSun, PrMoon, LaEye, CoResizeWidth, FcBinoculars, FaBinoculars, BiInfoCircle } from 'oh-vue-icons/icons';

addIcons(LaSun, PrMoon, LaEye, CoResizeWidth, FcBinoculars, FaBinoculars, BiInfoCircle);

const app = createApp(App);

app.use(createPinia());
app.use(router);

app.component('v-icon', OhVueIcon);

app.mount('#app');
