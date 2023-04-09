<template>
    <h2 class="my-2 font-bold text-xl inline">Welcome!</h2>
    <h5 class="inline ml-2 text-gray-500 italic">
        Here is the last Butterfly deck
        <v-icon
            v-if="state.monitoring"
            name="bi-info-circle"
            scale="0.8"
            :title="'from: ' + state.monitoring.registered_at"
        />
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
    <div class="monitoring-details__container" v-if="state.monitoring">
        <MonitoringMap>
            <div>
                <label class="font-bold">Name: </label>
                <span>{{ state.monitoring.name }}</span>
            </div>
            <div>
                <label class="font-bold">Local: </label>
                <span>{{ state.monitoring.local }}</span>
            </div>
            <div>
                <label class="font-bold">Host: </label>
                <span>{{ state.monitoring.user.name }}</span>
            </div>
        </MonitoringMap>
        <MonitoringEnvironment
            :hostedBy="state.monitoring.user.name"
            :temperature="state.monitoring.temperature"
            :humidity="state.monitoring.humidity"
            :wind="state.monitoring.wind"
            :sky="state.monitoring.sky"
        />
        <MonitoringStats
            :registeredAt="state.monitoring.registered_at"
            :timestampEnd="state.monitoring.timestamp_end"
            :appearances="state.monitoring.appearances"
        />
    </div>
</template>

<script setup lang="ts">
import { onMounted, reactive } from 'vue';
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
    padding: 15px;
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
    @apply flex flex-wrap;
    width: 100%;
    > * {
        width: calc(100% / 3);
    }
}
</style>
