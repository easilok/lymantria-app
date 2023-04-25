<template>
    <section class="app-content">
        <div>
            <h2 class="my-2 font-bold text-xl inline">Welcome!</h2>
            <h5 class="text-gray-500 italic">Here is the last Butterfly deck (from {{ monitoringDate }}).</h5>
        </div>
        <div class="flex-grow my-6">
            <div
                class="relative flex butterfly-exhibit flex-col sm:flex-row"
                :class="{ vertical: mobileList }"
                v-if="state.monitoring && state.monitoring.appearances"
            >
                <ButterflyCard
                    :key="appearance.id"
                    v-for="(appearance, index) in state.monitoring.appearances"
                    :butterfly="appearance.butterfly"
                    :index="index"
                    :expanded="index + 1 >= state.monitoring.appearances.length"
                    :overlap="!mobileList"
                    :vertical="mobileList"
                />
            </div>
        </div>
    </section>
    <section class="border-t app-content">
        <h3 class="my-2 font-bold text-lg">Details</h3>
        <div class="flex flex-wrap flex-row sm:flex-row-reverse monitoring-details__container" v-if="state.monitoring">
            <div class="monitoring-details__info sm:border-l-2 w-full sm:w-1/3 md:w-1/2">
                <MonitoringEnvironment
                    class="sm:px-4 w-full sm:w-1/2"
                    :hostedBy="state.monitoring.user.name"
                    :temperature="state.monitoring.temperature"
                    :humidity="state.monitoring.humidity"
                    :wind="state.monitoring.wind"
                    :sky="state.monitoring.sky"
                />
                <hr class="my-4 sm:mb-0 w-11/12 self-center" />
                <MonitoringStats
                    class="sm:px-4 w-full sm:w-1/2"
                    :registeredAt="state.monitoring.registered_at"
                    :timestampEnd="state.monitoring.timestamp_end || ''"
                    :appearances="state.monitoring.appearances"
                />
            </div>
            <hr class="block sm:hidden my-4 w-11/12 self-center" />
            <MonitoringMap
                class="w-full sm:w-2/3 md:w-1/2"
                :local="state.monitoring.local"
                :name="state.monitoring.name"
                :host="state.monitoring.user.name"
                :latitude="state.monitoring.latitude"
                :longitude="state.monitoring.longitude"
            />
        </div>
    </section>
</template>

<script setup lang="ts">
import { computed, onMounted, onUnmounted, reactive } from 'vue';
import dayjs from 'dayjs';
import { useRoute } from 'vue-router';
import makeRequest from '../utils/makeRequest';
import type { Monitoring } from '../types/monitoring';
import type { ApiResponse } from '../types/common';
import ButterflyCard from '../components/card/ButterflyCard.vue';
import MonitoringMap from '../components/monitoring/MonitoringMap.vue';
import MonitoringEnvironment from '../components/monitoring/MonitoringEnvironment.vue';
import MonitoringStats from '../components/monitoring/MonitoringStats.vue';

interface MonitoringViewState {
    monitoring: null | Monitoring;
    windowWidth: number;
}

const state: MonitoringViewState = reactive({
    monitoring: null,
    windowWidth: window.innerWidth
});

const monitoringDate = computed(() => {
    if (!state.monitoring) {
        return '';
    }
    const parsedDate = dayjs(state.monitoring.registered_at);
    return parsedDate.isValid() ? parsedDate.format('DD/MM/YYYY') : '';
});

const mobileList = computed(() => {
    return state.windowWidth < 768;
});

const onWidthChange = () => (state.windowWidth = window.innerWidth);
onMounted(() => window.addEventListener('resize', onWidthChange));
onUnmounted(() => window.removeEventListener('resize', onWidthChange));

const route = useRoute();

onMounted(async () => {
    let monitoringRequest = 'monitoring/latest';
    if (route.params.idMonitoring) {
        monitoringRequest = `monitoring/${route.params.idMonitoring}`;
    }
    const response = await makeRequest<undefined, ApiResponse<Monitoring>>(monitoringRequest, 'get');
    if (response.status === 200) {
        const data = response.json as ApiResponse<Monitoring>;
        console.log(data.records);
        state.monitoring = data.records;
    }
});
</script>

<style scoped lang="scss">
.butterfly-exhibit {
    overflow: auto;
    height: 550px;
    width: 100%;
    padding: 20px 10px;
    .butterfly-exhibit__container {
        height: 100%;
        width: 100%;
        overflow-y: auto;
    }
    .card.overlap {
        position: absolute;
    }
    &.vertical {
        overflow: visible;
        height: auto;
    }
}

.monitoring-details__container {
    width: 100%;
}

.monitoring-details__info {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}
</style>
