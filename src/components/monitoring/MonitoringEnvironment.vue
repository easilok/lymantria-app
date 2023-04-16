<script setup lang="ts">
import { computed } from 'vue';

const props = defineProps<{
    hostedBy: string;
    temperature: number;
    humidity: number;
    wind: string;
    sky: string;
}>();

const formatedTemperature = computed(() => {
    if (props.temperature !== null) {
        return `${props.temperature} ºC`;
    }
    return 'N/A';
});

const formatedHumidity = computed(() => {
    if (props.humidity !== null) {
        return `${props.humidity} ºC`;
    }
    return 'N/A';
});

const iconScale = computed(() => {
    return 1.5;
});
</script>

<template>
    <div class="monitoring-env">
        <div class="monitoring-env__stat">
            <v-icon class="monitorin-env__icon" :scale="iconScale" name="co-user" title="Registered by" />&nbsp;
            <span class="">{{ hostedBy }}</span>
        </div>
        <div class="monitoring-env__stat">
            <v-icon class="monitorin-env__icon" :scale="iconScale" name="wi-thermometer" title="Temperature" />&nbsp;
            <span class="">{{ formatedTemperature }}</span>
        </div>
        <div class="monitoring-env__stat">
            <v-icon class="monitorin-env__icon" :scale="iconScale" name="bi-droplet" title="Humidity" />&nbsp;
            <span class="">{{ formatedHumidity }}</span>
        </div>
        <div class="monitoring-env__stat">
            <v-icon class="monitorin-env__icon" :scale="iconScale" name="bi-wind" title="Wind" />&nbsp;
            <span class="">{{ wind || 'N/A' }}</span>
        </div>
        <div class="monitoring-env__stat">
            <v-icon class="monitorin-env__icon" :scale="iconScale" name="bi-cloud-sun" title="Sky" />&nbsp;
            <span class="">{{ sky || 'N/A' }}</span>
        </div>
    </div>
</template>

<style scoped lang="scss">
.monitoring-env {
    > * {
        margin-bottom: 0.7rem;
    }
}

.monitoring-env__stat {
    display: flex;
    align-items: center;
}

.monitorin-env__icon {
    width: 2rem;
}
</style>
