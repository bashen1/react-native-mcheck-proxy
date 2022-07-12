# react-native-mcheck-proxy

检测是否挂了代理服务器

## Installation

```sh
npm install react-native-mcheck-proxy
```

## Usage

```js
import * as McheckProxy from "react-native-mcheck-proxy";

// ...

//vpn检测（同步）
const detectVPN = CheckProxy.detectVPNSync();
//代理ip检测（同步）
const detectProxy = CheckProxy.detectProxySync();
//vpn检测
const detectVPN = await CheckProxy.detectVPNSync();
//代理ip检测
const detectProxy =  await CheckProxy.detectProxySync();
```
