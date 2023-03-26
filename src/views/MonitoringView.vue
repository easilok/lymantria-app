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
    <ul v-if="state.monitoring">
        <li v-for="appearance in state.monitoring.appearances" :key="appearance.id">
            <div>
                <label class="font-bold">Name: </label>
                <span>{{butterflyIdentification(appearance)}}
                    <em class="text-gray-400 ml-2" v-if="appearance.butterfly.details">
                        {{appearance.butterfly.details[0].common_name}}
                    </em>
                </span>
            </div>
        </li>
    </ul>
</template>

<script setup lang="ts">
    import { onMounted, reactive } from 'vue'
    import makeRequest from '../utils/makeRequest'
    import type { Monitoring, ButterflyAppearance } from '../types/monitoring'
    import type { ApiResponse } from '../types/common'

    interface MonitoringViewState {
    monitoring: null | Monitoring
    }

    const state: MonitoringViewState = reactive({
        monitoring: null
    })

    const butterflyIdentification = (monitoringAppearance: ButterflyAppearance):string  => {
        if (!monitoringAppearance) {
            return '';
        }

        const identification = monitoringAppearance.butterfly.scientific || 'unknown name';
        return `${identification} - (${monitoringAppearance.butterfly.described})`
    }

    onMounted(async() => {
        const response = await makeRequest<undefined, ApiResponse< Monitoring>>('monitoring/1', 'get')
        if (response.status === 200) {
            const data = response.json as ApiResponse<Monitoring>
            console.log(data.records)
            state.monitoring = data.records
        }
    })
</script>
