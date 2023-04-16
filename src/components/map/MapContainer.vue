<template>
    <div ref="mapRoot" style="width: 100%; height: 100%"></div>
</template>

<script setup lang="ts">
import { Feature, View, Map } from 'ol/index';
import TileLayer from 'ol/layer/Tile';
import VectorLayer from 'ol/layer/Vector';
import VectorSource from 'ol/source/Vector';
import { useGeographic } from 'ol/proj';
import { Point } from 'ol/geom';
import { Icon, Style } from 'ol/style';
import OSM from 'ol/source/OSM';
import { ref, onMounted } from 'vue';
import markerUrl from '@/assets/map-marker-icon-32x32.png';

// importing the OpenLayers stylesheet is required for having
// good looking buttons!
import 'ol/ol.css';

const props = defineProps<{
    host: string;
    latitude: number;
    longitude: number;
}>();

const mapRoot = ref(null);

useGeographic();

onMounted(() => {
    const place = [props.longitude, props.latitude];
    const point = new Point(place);

    const stationMarker = new Feature({
        type: 'icon',
        geometry: point
    });
    // Create new the OpenLayers map
    new Map({
        // use the mapRoot ref to mount the map on the DOM
        target: mapRoot.value || undefined,
        layers: [
            // Background tiled layer
            new TileLayer({
                source: new OSM()
            }),
            new VectorLayer({
                source: new VectorSource({
                    features: [stationMarker]
                }),
                style: new Style({
                    image: new Icon({
                        anchor: [0.5, 1],
                        src: markerUrl
                    })
                })
            })
        ],

        view: new View({
            zoom: 15,
            center: place,
            constrainResolution: true
        })
    });
});
</script>
