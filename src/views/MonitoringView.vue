<template>
    <h2 class="my-2 font-bold text-xl inline">Welcome!</h2>
    <h5 class="inline text-gray-500 italic">
        Here is the last Butterfly deck
        <v-icon v-if="monitoringDate" name="bi-info-circle" scale="0.8" :title="'from: ' + monitoringDate" />
    </h5>
    <div class="relative flex butterfly-exhibit" v-if="state.monitoring && state.monitoring.appearances">
        <ButterflyCard
            :key="appearance.id"
            v-for="(appearance, index) in state.monitoring.appearances"
            :butterfly="appearance.butterfly"
            :index="index"
            :expanded="index + 1 >= state.monitoring.appearances.length"
        />
    </div>
    <hr />
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
</template>

<script setup lang="ts">
import { computed, onMounted, reactive } from 'vue';
import dayjs from 'dayjs';
import makeRequest from '../utils/makeRequest';
import type { Monitoring } from '../types/monitoring';
import type { ApiResponse } from '../types/common';
import ButterflyCard from '../components/card/ButterflyCard.vue';
import MonitoringMap from '../components/monitoring/MonitoringMap.vue';
import MonitoringEnvironment from '../components/monitoring/MonitoringEnvironment.vue';
import MonitoringStats from '../components/monitoring/MonitoringStats.vue';

interface MonitoringViewState {
    monitoring: null | Monitoring;
}

const state: MonitoringViewState = reactive({
    monitoring: null
});

const monitoringDate = computed(() => {
    if (!state.monitoring) {
        return '';
    }
    const parsedDate = dayjs(state.monitoring.registered_at);
    return parsedDate.isValid() ? parsedDate.format('DD-MM-YYYY (HH:mm)') : '';
});

onMounted(async () => {
    const response = await makeRequest<undefined, ApiResponse<Monitoring>>('monitoring/1', 'get');
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
    height: 600px;
    width: 100%;
    .butterfly-exhibit__container {
        height: 100%;
        width: 100%;
        overflow-y: auto;
    }
    .card {
        position: absolute;
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
