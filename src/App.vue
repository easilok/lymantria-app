<script setup lang="ts">
import { RouterView } from 'vue-router';
</script>

<template>
    <RouterView />
</template>

<style scoped>
header {
    line-height: 1.5;
}

nav {
    width: 100%;
    font-size: 1rem;
    text-align: center;
    border-bottom: 1px solid var(--color-border);
}

nav a.router-link-exact-active {
    color: var(--color-text);
}

nav a.router-link-exact-active:hover {
    background-color: transparent;
}

nav a {
    display: inline-block;
    padding: 0 1rem;
    border-left: 1px solid var(--color-border);
}

nav a:first-of-type {
    border: 0;
}

@media (min-width: 1024px) {
    header {
        display: flex;
        place-items: center;
    }

    nav {
        text-align: left;
        margin-left: -1rem;
        font-size: 1rem;

        padding: 0.5rem 0;
        margin-bottom: 1rem;
    }
}
</style>
