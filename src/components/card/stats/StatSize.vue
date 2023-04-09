<script setup lang="ts">
defineProps<{
    size: string;
    title?: string;
    icon?: string;
}>();
</script>

<template>
    <div class="stat">
        <slot>
            <v-icon class="type" :name="icon || 'co-resize-width'" scale="1" :title="title || 'Size'" />
            <div class="value">{{ size }}</div>
        </slot>
    </div>
</template>
