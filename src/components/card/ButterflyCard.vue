<script setup lang="ts">
import type { Butterfly } from '@/types/butterfly';
import DayTime from '@/components/card/stats/DayTime.vue';
import StatAppearances from '@/components/card/stats/StatAppearances.vue';
import StatSize from '@/components/card/stats/StatSize.vue';
import { computed } from 'vue';

const props = defineProps<{
    butterfly: Butterfly;
    index: number;
    expanded: boolean;
    overlap: boolean;
    vertical: boolean;
}>();

const butterflyImageUrl = computed(() => {
    return `url(${props.butterfly.image})`;
});

const butterflyCardPosition = computed(() => {
    if (!props.overlap || props.vertical) {
        return {};
    }

    return {
        'z-index': props.index + 10,
        left: `${10 + 30 * props.index}px`
    };
});

const butterflyRarityClass = computed(() => `rarity-${props.butterfly.rarity}`);
</script>

<template>
    <article class="card" :class="{ overlap: overlap, vertical: vertical }" :style="butterflyCardPosition">
        <h3 v-if="!expanded && overlap && !vertical" class="card-text__side">{{ butterfly.scientific }}</h3>
        <div class="card-image background" :style="{ 'background-image': butterflyImageUrl }"></div>
        <div class="card-text">
            <h3 class="card-text__scientific">{{ butterfly.scientific }}</h3>
            <h6 class="card-text__described">
                <em>({{ butterfly.described }})</em>
            </h6>
            <h4 class="card-text__common" v-if="butterfly.details && butterfly.details.length > 0">
                <em>Common Name: {{ butterfly.details[0].common_name }}</em>
            </h4>
            <p v-if="butterfly.details && butterfly.details.length > 0" :title="butterfly.details[0].description">
                {{ butterfly.details[0].description.slice(0, 210) }}
                {{ butterfly.details[0].description.length > 210 ? '...' : '' }}
            </p>
        </div>
        <div :class="['card-stats', butterflyRarityClass]">
            <DayTime :isDiurnal="butterfly.daytime == 'day'" />
            <StatAppearances :appearances="butterfly.appearances" />
            <StatSize :size="butterfly.size || ''" />
        </div>
    </article>
</template>

<style scoped lang="scss">
.card:hover {
    /*   animation: pick 3s ease-in-out;*/
    box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.6);

    z-index: 100 !important;

    .card-text__side {
        display: none;
    }
}

.card {
    display: flex;
    /*transform: rotate3d(-1, -1, 0, 15deg);*/
    flex-direction: column;
    cursor: pointer;

    border-radius: 18px;
    width: 300px;
    min-width: 300px;
    height: 500px;
    background: white;
    box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.9);
    font-family: roboto;
    text-align: center;
    &.vertical {
        margin: auto;
        margin-bottom: 1rem;
        overflow: visible;
    }
}

.card-image {
    height: 190px;
    overflow: hidden;
    &.background {
        background-position: center;
        border-top-left-radius: 15px;
        border-top-right-radius: 15px;
        background-size: cover;
    }
    img {
        max-width: 100%;
        /*height: auto;*/
        border-top-left-radius: 15px;
        border-top-right-radius: 15px;
        object-fit: cover;
        /*object-position: 80% 50%;*/
    }
}

.card-text {
    height: 250px;
    padding: 15px 25px;

    .card-text__common {
        @apply text-gray-500 mb-1;
    }

    .card-text__scientific {
        @apply text-stone-800;
    }

    .card-text__described {
        @apply text-sm text-gray-400;
    }

    p {
        color: grey;
        font-size: 15px;
        font-weight: 300;
    }

    h3 {
        margin: 0px;
        font-size: 18px;
    }

    h5 {
        margin-top: 0px;
        color: grey;
    }
}

.card-stats {
    height: 60px;
    display: flex;
    width: 100%;
    align-items: center;
    border-bottom-left-radius: 15px;
    border-bottom-right-radius: 15px;
    background: rgb(22 163 74);
    .stat {
        width: calc(100% / 3);
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;

        color: white;
        padding: 10px;

        &.daytime {
            font-size: 24px;
        }
    }
    &.rarity-rare {
        @apply bg-cyan-700;
    }
    &.rarity-ultrarare {
        @apply bg-amber-400;
    }
}

.card-text__side {
    position: absolute;
    background-color: rgba(255, 255, 255, 0.3);
    border-top-left-radius: 15px;
    padding: 2px;
    height: 200px;
    width: 30px;
    /* left: -20px; */
    left: 0px;
    writing-mode: sideways-lr;
    text-orientation: mixed;
    color: #4d4d4d;
    z-index: 100;
}
</style>
