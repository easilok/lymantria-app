import { createApp } from 'vue';
import { createPinia } from 'pinia';

import { OhVueIcon, addIcons } from 'oh-vue-icons';
import OpenLayersMap from 'vue3-openlayers';
import 'vue3-openlayers/dist/vue3-openlayers.css';

import App from './App.vue';
import router from './router';

import './assets/main.css';

import {
    LaSun,
    PrMoon,
    LaEye,
    CoResizeWidth,
    FcBinoculars,
    FaBinoculars,
    BiInfoCircle,
    BiWind,
    WiThermometer,
    BiDroplet,
    CoUser,
    BiCloudSun
} from 'oh-vue-icons/icons';

addIcons(
    LaSun,
    PrMoon,
    LaEye,
    CoResizeWidth,
    FcBinoculars,
    FaBinoculars,
    BiInfoCircle,
    BiWind,
    WiThermometer,
    BiDroplet,
    CoUser,
    BiCloudSun
);

const app = createApp(App);

app.use(createPinia());
app.use(router);
app.use(OpenLayersMap);

app.component('v-icon', OhVueIcon);

app.mount('#app');
