const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8080/api/';
const API_VERSION = import.meta.env.VITE_API_VERSION || '';

export interface FetchResponse<R> {
    status: number;
    json: R | { message: string; error?: Error };
}

const makeRequest = async <D, R>(path: string, method: string, data?: D): Promise<FetchResponse<R>> => {
    let queryParams = '';
    if (method === 'get' && data) {
        queryParams = `?${data}`;
    }
    const response = await fetch(`${API_URL}${API_VERSION}${path}${queryParams}`, {
        method: method,
        headers: {
            Accept: 'application/json', // eslint-disable-line quote-props
            'Content-Type': 'application/json' // eslint-disable-line quote-props
        },
        mode: 'cors',
        body: method !== 'get' ? JSON.stringify(data) : undefined
    });

    if (response.status === 403) {
        return {
            status: response.status,
            json: { message: 'You have no permissions for this request.' }
        };
    }
    try {
        const json = await response.json();
        return {
            status: response.status,
            json: json
        };
    } catch {
        return {
            status: response.status,
            json: { message: 'Invalid Request' }
        };
    }
};

export default makeRequest;
