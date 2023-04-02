<template>
    <h3 class="mb-2 font-bold text-lg">Monitoring Details</h3>
    <div v-if="state.monitoring">
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
    </div>
    <h3 class="my-2 font-bold text-lg">Monitoring Butterflies</h3>
    <div class="relative flex butterfly-exhibit" v-if="state.monitoring && state.monitoring.appearances">
        <ButterflyCard
            :key="appearance.id"
            v-for="(appearance, index) in state.monitoring.appearances"
            :butterfly="appearance.butterfly"
            :index="index"
            :expanded="state.monitoring.appearances.length == 1"
        />
    </div>
</template>

<script setup lang="ts">
import { onMounted, reactive } from 'vue';
import makeRequest from '../utils/makeRequest';
import type { Monitoring } from '../types/monitoring';
import type { ApiResponse } from '../types/common';
import ButterflyCard from '../components/card/ButterflyCard.vue';

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

<style scoped>
.butterfly-exhibit {
    overflow: scroll;
    height: 600px;
}

.butterfly-exhibit .card {
    position: absolute;
}
</style>
