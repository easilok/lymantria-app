<template>
    <div class="pr-2">
        <MapContainer2
            v-if="latitude && longitude"
            :markerContent="markerContent"
            :latitude="latitude"
            :longitude="longitude"
        >
            <template v-slot:marker>
                {{ name }} <em>by {{ host }}</em
                ><br />
                ({{ local }})
            </template>
        </MapContainer2>
    </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import MapContainer2 from '../map/MapContainer2.vue';

const props = defineProps<{
    name: string;
    host: string;
    local?: string;
    latitude: number;
    longitude: number;
}>();

const markerContent = computed(() => {
    return `${props.name} by ${props.host} (${props.local})`;
});
</script>
