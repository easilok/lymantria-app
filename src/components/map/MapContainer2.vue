<template>
    <ol-map :loadTilesWhileAnimating="true" :loadTilesWhileInteracting="true" style="height: 100%; min-height: 400px">
        <ol-view ref="view" :center="center" :rotation="rotation" :zoom="zoom" :projection="projection" />

        <ol-tile-layer>
            <ol-source-osm />
        </ol-tile-layer>

        <ol-vector-layer :zIndex="2">
            <ol-source-vector>
                <ol-feature ref="positionFeature">
                    <ol-geom-point :coordinates="center"></ol-geom-point>
                    <ol-style>
                        <ol-style-icon :src="markerUrl" :scale="1"></ol-style-icon>
                    </ol-style>
                </ol-feature>
            </ol-source-vector>
        </ol-vector-layer>

        <ol-overlay :position="overlayPosition" positioning="bottom-center" :offset="[0, -30]">
            <template v-slot="_">
                <div class="overlay-content">
                    <slot name="marker">
                        {{ markerContent }}
                    </slot>
                </div>
            </template>
        </ol-overlay>
    </ol-map>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import markerUrl from '@/assets/map-marker-icon-32x32.png';

const props = defineProps<{
    markerContent: string;
    latitude: number;
    longitude: number;
}>();

const center = ref([props.longitude, props.latitude]);
const overlayPosition = ref([props.longitude, props.latitude]);
const projection = ref('EPSG:4326');
const zoom = ref(15);
const rotation = ref(0);
</script>

<style lang="scss">
/* .overlay-content { */
/*     /1* background: #efefef; *1/ */
/*     /1* box-shadow: 0 5px 10px rgb(2 2 2 / 20%); *1/ */
/*     /1* padding: 10px 20px; *1/ */
/*     /1* font-size: 16px; *1/ */
/*     text-decoration: none; */
/*     color: white; */
/*     font-size: 11pt; */
/*     font-weight: bold; */
/*     text-shadow: black 0.1em 0.1em 0.2em; */
/* } */

$border-color: rgb(62, 68, 70);

.overlay-content {
    background-color: rgb(24, 26, 27);
    box-shadow: rgba(0, 0, 0, 0.2) 0px 1px 4px;
    /* position: absolute; */
    padding: 15px;
    border-radius: 10px;
    border: 1px solid $border-color;
    /* bottom: 12px; */
    /* left: -50px; */
    min-width: 280px;
    color: rgb(200, 195, 188);
}
.overlay-content:after,
.overlay-content:before {
    top: 100%;
    border: solid transparent;
    content: ' ';
    height: 0;
    width: 0;
    position: absolute;
    pointer-events: none;
}
.overlay-content:after {
    border-top-color: $border-color;
    border-width: 10px;
    left: 50%;
    margin-left: -10px;
}
.overlay-content:before {
    border-top-color: #cccccc;
    border-top-color: $border-color;
    border-width: 11px;
    left: 50%;
    /* left: 48px; */
    margin-left: -11px;
}
.overlay-content-closer {
    text-decoration: none;
    position: absolute;
    top: 2px;
    right: 8px;
}
.overlay-content-closer:after {
    content: '✖';
}
</style>
