import type { Language } from './language';
import type { User } from './user';

export type ButterflyRarity = 'common' | 'rare' | 'ultrarare';

export type ButterflyDaytime = 'day' | 'night';

export interface Butterfly {
    id: number;
    scientific: string;
    user_id: number;
    described: string;
    rarity: ButterflyRarity;
    daytime: ButterflyDaytime;
    group?: string;
    appearances: number;
    size?: number;
    image?: string;
    details: ButterflyDescription[];
    user: User;
}

export interface ButterflyDescription {
    id: number;
    language_id: number;
    butterfly_id: number;
    user_id: number;
    description: string;
    common_name: string;
    observation: string;
    user: User;
    language: Language;
}
