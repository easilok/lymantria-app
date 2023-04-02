<script setup lang="ts">
import type { Butterfly } from '@/types/butterfly';
import { computed } from 'vue';

const props = defineProps<{
    butterfly: Butterfly;
    index: number;
    expanded: boolean;
}>();

const butterflyImageUrl = computed(() => {
    return `url(${props.butterfly.image})`;
});

const butterflyCardPosition = computed(() => {
    if (props.expanded) {
        return {};
    }
    return {
        'z-index': props.index + 10,
        left: `${10 + 30 * props.index}px`
    };
});
</script>

<template>
    <article class="card" :style="butterflyCardPosition">
        <h3 v-if="!expanded" class="card-text__side">{{ butterfly.scientific }}</h3>
        <div class="card-image background" :style="{ 'background-image': butterflyImageUrl }"></div>
        <div class="card-text">
            <h3>{{ butterfly.scientific }}</h3>
            <h5>
                <em>({{ butterfly.described }})</em>
            </h5>
            <p v-if="butterfly.details && butterfly.details.length > 0">
                {{ butterfly.details[0].description.slice(0, 200) }}
                {{ butterfly.details[0].description.length > 200 ? '...' : '' }}
            </p>
        </div>
        <div class="card-stats">
            <div class="stat daytime">
                <div class="value" title="Noturna">&#127769;</div>
            </div>
            <div class="stat">
                <div class="value">{{ butterfly.appearances }}</div>
                <div class="type">aparições</div>
            </div>
            <div class="stat">
                <div class="value">{{ butterfly.size }}</div>
                <!--<div class="type">envergadura</div>-->
            </div>
        </div>
    </article>
</template>

<style scoped>
.card:hover {
    /*   animation: pick 3s ease-in-out;*/
    box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.6);
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
}

.card-image {
    height: 210px;
    overflow: hidden;
}
.card-text {
    height: 210px;
}
.card-stats {
    height: 80px;
}

.card-image.background {
    background-position: center;
    border-top-left-radius: 15px;
    border-top-right-radius: 15px;
    background-size: cover;
}

.card-image img {
    max-width: 100%;
    /*height: auto;*/
    border-top-left-radius: 15px;
    border-top-right-radius: 15px;
    object-fit: cover;
    /*object-position: 80% 50%;*/
}

.card-text {
    padding: 15px 25px;
}

.card-text p {
    color: grey;
    font-size: 15px;
    font-weight: 300;
}

.card-text h3 {
    margin: 0px;
    font-size: 18px;
}

.card-text h5 {
    margin-top: 0px;
    color: grey;
}

.card-stats {
    display: flex;
    width: 100%;
    justify-content: space-around;
    align-items: center;
    border-bottom-left-radius: 15px;
    border-bottom-right-radius: 15px;
    background: rgb(22 163 74);
}

.card-stats .stat {
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;

    color: white;
    padding: 10px;
}

.card-stats .stat.daytime {
    font-size: 24px;
}

.card:hover {
    z-index: 100 !important;
}

.card-text__side {
    position: absolute;
    background-color: rgba(255, 255, 255, 0.3);
    border-top-left-radius: 15px;
    padding: 2px;
    height: 210px;
    width: 50px;
    /* left: -20px; */
    left: 0px;
    writing-mode: sideways-lr;
    text-orientation: mixed;
    color: #4d4d4d;
    z-index: 100;
}

.card:hover .card-text__side {
    display: none;
}
</style>
