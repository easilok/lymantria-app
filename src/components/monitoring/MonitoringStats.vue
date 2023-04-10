<script setup lang="ts">
import { computed } from 'vue';
import type { ButterflyAppearance } from '@/types/ButterflyAppearance';
import dayjs from 'dayjs';

const props = defineProps<{
    registeredAt: string;
    timestampEnd: string;
    appearances: ButterflyAppearance[];
}>();

const monitoringDate = computed(() => {
    const parsedDate = dayjs(props.registeredAt);
    return parsedDate.format('DD-MM-YYYY');
});

const monitoringDuration = computed(() => {
    const parsedDate = dayjs(props.registeredAt);
    const end = dayjs(props.timestampEnd) || '';
    return `${parsedDate.format('HH:mm')} - ${end.isValid() ? end.format('HH:mm') : '...'}`;
});

const monitoringButterflies = computed(() => {
    return props.appearances.reduce((acc, appearance) => {
        return acc + appearance.quantity;
    }, 0);
});

const monitoringSpecies = computed(() => {
    return props.appearances.length;
});

const monitoringFamilies = computed(() => {
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
    <div class="monitoring-stats">
        <div class="monitoring-stats__stat">
            <label class="font-bold">Date:</label>
            <span class="">{{ monitoringDate }}</span>
        </div>
        <div class="monitoring-stats__stat">
            <label class="font-bold">Duration:</label>
            <span class="">{{ monitoringDuration }}</span>
        </div>
        <div class="monitoring-stats__stat">
            <label class="font-bold">Butterflies:</label>
            <span class="">{{ monitoringButterflies }}</span>
        </div>
        <div class="monitoring-stats__stat">
            <label class="font-bold">Species:</label>
            <span class="">{{ monitoringSpecies }}</span>
        </div>
        <div class="monitoring-stats__stat">
            <label class="font-bold">Families:</label>
            <span class="">{{ monitoringFamilies }}</span>
        </div>
    </div>
</template>

<style scoped lang="scss">
.monitoring-stats {
    @apply px-4 border-l;
    > * {
        margin-bottom: 0.75rem;
    }
}

.monitoring-stats__stat {
    display: flex;
    align-items: center;
    label {
        @apply mr-2;
    }
}
</style>
