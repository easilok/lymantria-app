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
</script>

<template>
    <div class="">
        <div class="">
            <span class="font-bold">By: </span>
            <span class="">{{ hostedBy }}</span>
        </div>
        <div class="">
            <span class="font-bold">Temperature: </span>
            <span class="">{{ formatedTemperature }}</span>
        </div>
        <div class="">
            <span class="font-bold">Humidity: </span>
            <span class="">{{ formatedHumidity }}</span>
        </div>
        <div class="">
            <span class="font-bold">Wind: </span>
            <span class="">{{ wind || 'N/A' }}</span>
        </div>
        <div class="">
            <span class="font-bold">Sky: </span>
            <span class="">{{ sky || 'N/A' }}</span>
        </div>
    </div>
</template>

<style scoped lang="scss"></style>
