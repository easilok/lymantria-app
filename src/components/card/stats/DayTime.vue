<script setup lang="ts">
import { computed } from 'vue';

const props = defineProps<{
    isDiurnal: boolean;
    title?: string[];
    scale?: number;
    icons?: string[];
}>();

const dayTitle = computed(() => {
    return props.title && props.title.length > 0 ? props.title[0] : 'Diurnal';
});

const nightTitle = computed(() => {
    return props.title && props.title.length > 1 ? props.title[1] : 'Nocturnal';
});

const dayIcon = computed(() => {
    return props.icons && props.icons.length > 0 ? props.icons[0] : 'la-sun';
});

const nightIcon = computed(() => {
    return props.icons && props.icons.length > 1 ? props.icons[1] : 'pr-moon';
});
</script>

<template>
    <div class="stat daytime">
        <slot>
            <v-icon v-if="isDiurnal" :name="dayIcon" :scale="scale || 1.2" :title="dayTitle" />
            <v-icon v-else :name="nightIcon" :scale="scale || 1.2" :title="nightTitle" />
        </slot>
    </div>
</template>
