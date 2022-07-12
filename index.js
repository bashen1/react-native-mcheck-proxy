
import { NativeModules } from 'react-native';

const { McheckProxy } = NativeModules;

export async function detectVPN() {
    return await McheckProxy.detectVPN();
}

export async function detectProxy() {
    return await McheckProxy.detectProxy();
}

export function detectVPNSync() {
    return McheckProxy.detectVPNSync();
}

export function detectProxySync() {
    return McheckProxy.detectProxySync();
}
