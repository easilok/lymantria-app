<script setup lang="ts">
import { computed } from 'vue';
import type { ButterflyAppearance } from '@/types/ButterflyAppearance';

const props = defineProps<{
    registeredAt: string;
    timestampEnd: string;
    appearances: ButterflyAppearance[];
}>();

const monitoringDate = computed(() => {
    // TODO - Format only date
    return props.registeredAt;
});

const monitoringDuration = computed(() => {
    // TODO - Format interval with parsed dates
    const end = props.timestampEnd || '';
    return `${props.registeredAt} - ${end}`;
});

const monitoringButterflies = computed(() => {
    return props.appearances.reduce((acc, appearance) => {
        return acc + appearance.quantity;
    }, 0);
});

const monitoringSpecies = computed(() => {
    const species: { [key: string]: number } = {};

    props.appearances.forEach((appearance) => {
        if (species[appearance.butterfly]) {
            species[appearance.butterfly] += 1;
        } else {
            species[appearance.butterfly] = 1;
        }
    });

    return Object.keys(species).length;
});
</script>

<template>
    <div class="">
        <div class="">
            <span class="font-bold">Date: </span>
            <span class="">{{ monitoringDate }}</span>
        </div>
        <div class="">
            <span class="font-bold">Duration: </span>
            <span class="">{{ monitoringDuration }}</span>
        </div>
        <div class="">
            <span class="font-bold">Apperances: </span>
            <span class="">{{ monitoringButterflies }}</span>
        </div>
        <div class="">
            <span class="font-bold">Species: </span>
            <span class="">{{ monitoringSpecies }}</span>
        </div>
    </div>
</template>

<style scoped lang="scss"></style>
