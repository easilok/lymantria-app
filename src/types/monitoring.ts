import type { Butterfly } from './butterfly';
import type { User } from './user';

export interface Monitoring {
    id: number;
    registered_at: string;
    local: string;
    name: string;
    longitude: number;
    latitude: number;
    obs: string;
    hosted_by: number;
    timestamp_end?: string;
    temperature_start: number;
    humidity_start: number;
    wind_start: string;
    precipitation_start: number;
    sky_start: string;
    temperature_end?: number;
    humidity_end?: number;
    wind_end?: string;
    precipitation_end?: number;
    sky_end?: string;
    user: User;
    appearances: ButterflyAppearance[];
}

export interface ButterflyAppearance {
    id: number;
    monitoring_id: number;
    butterfly_id: number;
    quantity: number;
    image: string;
    observation: string;
    registered_by: number;
    register: User;
    butterfly: Butterfly;
}
