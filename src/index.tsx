import { NativeModules } from 'react-native';

type McheckProxyType = {
  multiply(a: number, b: number): Promise<number>;
};

const { McheckProxy } = NativeModules;

export default McheckProxy as McheckProxyType;
