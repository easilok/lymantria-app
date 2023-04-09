<script setup lang="ts">
defineProps<{
    appearances: number;
    title?: string;
    icon?: string;
}>();
</script>

<template>
    <div class="stat">
        <slot>
            <v-icon class="type" :name="icon || 'fc-binoculars'" scale="1" :title="title || 'Appearances'" />
            <div class="value">{{ appearances }}</div>
        </slot>
    </div>
</template>
