import type { User } from './user';

export interface Language {
    id: number;
    user_id: number;
    name: string;
    slug: string;
    user: User;
}
