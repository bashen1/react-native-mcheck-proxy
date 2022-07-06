package com.reactnativemcheckproxy;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkCapabilities;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Promise;

public class McheckProxyModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public McheckProxyModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "McheckProxy";
    }

    /**
     * VPN检测
     * @param promise
     */
    @ReactMethod
    public void detectVPN(Promise promise){
        promise.resolve(this.isCheckVpn());
    }

    /**
     * 代理IP检测
     * @param promise
     */
    @ReactMethod
    public void detectProxy(Promise promise){
        promise.resolve(this.isCheckProxy());
    }

    /**
     * VPN检测（同步）
     */
    @ReactMethod (isBlockingSynchronousMethod = true)
    public boolean detectProxySync(){
       return this.isCheckProxy();
    }

    /**
     * 代理IP检测（同步）
     */
    @ReactMethod (isBlockingSynchronousMethod = true)
    public boolean detectVPNSync(){
        return this.isCheckVpn();
    }

    private boolean isCheckProxy() {
        return System.getProperty("http.proxyPort") != null;
    }

    private boolean isCheckVpn() {
        ConnectivityManager cm = (ConnectivityManager)reactContext.getSystemService(Context.CONNECTIVITY_SERVICE);
        Network[] networks = cm.getAllNetworks();

        boolean isRunningVPN = false;
        for (Network value : networks) {
            NetworkCapabilities caps = cm.getNetworkCapabilities(value);
            if (caps != null && (caps.hasTransport(NetworkCapabilities.TRANSPORT_VPN) || !caps.hasCapability(NetworkCapabilities.NET_CAPABILITY_NOT_VPN))) {
                isRunningVPN = true;
                break;
            }
        }
        return isRunningVPN;
    }
}
