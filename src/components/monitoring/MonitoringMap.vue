<template>
    <div class="pr-2">
        <div class="border">
            <slot></slot>
        </div>
        <MapContainer v-if="latitude && longitude" :host="host" :latitude="latitude" :longitude="longitude" />
    </div>
</template>

<script setup lang="ts">
import MapContainer from '../map/MapContainer.vue';

defineProps<{
    name: string;
    host: string;
    latitude: number;
    longitude: number;
}>();
</script>
