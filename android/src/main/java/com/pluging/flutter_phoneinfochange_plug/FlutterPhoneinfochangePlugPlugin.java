package com.pluging.flutter_phoneinfochange_plug;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Context;
import android.media.AudioManager;
import android.provider.Settings;
import android.view.Window;
import android.view.WindowManager;

import java.util.List;

import android.content.ContentResolver;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterPhoneinfochangePlugPlugin
 */
public class FlutterPhoneinfochangePlugPlugin implements MethodCallHandler {

    private final MethodChannel channel;
    private Activity activity;
    private int streamType;

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_phoneinfochange_plug");
        channel.setMethodCallHandler(new FlutterPhoneinfochangePlugPlugin(registrar.activity(), channel));
    }

    private FlutterPhoneinfochangePlugPlugin(Activity activity, MethodChannel channel) {
        this.activity = activity;
        this.channel = channel;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("calculate")) {
            int a = call.argument("a");
            int b = call.argument("b");
            int r = a + b;
            result.success("" + r);
        } else if (call.method.equals("getVolume")) {
            int a = call.argument("volume");
            result.success(getVCol());
        } else if (call.method.equals("setVolume")) {
            int a = call.argument("volume");
            result.success(setVcol(a));
        } else if (call.method.equals("getBrightness")) {
            result.success(getSystemBrightness());
        } else if (call.method.equals("setBrightness")) {
            int brightness = call.argument("brightness");
            result.success(changeAppBrightness(brightness));
        } else {
            result.notImplemented();
        }
    }

    // 获取媒体音量
    int getVCol() {
        AudioManager AudioManager = (AudioManager) this.activity.getApplicationContext()
                .getSystemService(Context.AUDIO_SERVICE);
        int musicVolume = AudioManager.getStreamVolume(AudioManager.STREAM_MUSIC);
        return musicVolume;
    }

    // 设置媒体音量
    int setVcol(int volume) {
        int result = 0;
        if (volume >= 15) {
            result = 15;
        } else {
            result = volume;
        }
        AudioManager AudioManager = (AudioManager) this.activity.getApplicationContext()
                .getSystemService(Context.AUDIO_SERVICE);

        AudioManager.setStreamVolume(AudioManager.STREAM_MUSIC, result, AudioManager.FLAG_SHOW_UI);

        return result;
    }

    /**
     * 获取手机亮度
     */
    int getSystemBrightness() {
        int screenBrightness = 255;
        try {
            screenBrightness = Settings.System.getInt(this.activity.getContentResolver(), Settings.System.SCREEN_BRIGHTNESS);
            //同步系统亮度
            changeAppBrightness(screenBrightness);
        } catch (Exception e) {

        }
        return screenBrightness;


    }

    /**
     * 设置手机亮度
     */

    /**
     69      * 改变App当前Window亮度
     70      *
     71      * @param brightness
     72      */
    /**
     * 改变App当前Window亮度
     *
     * @param brightness
     */
    int changeAppBrightness(int brightness) {
        if (brightness >= 255) {
            brightness = 255;
        }
        Window window = this.activity.getWindow();
        WindowManager.LayoutParams lp = window.getAttributes();
        if (brightness == -1) {
            lp.screenBrightness = WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_NONE;
        } else {
            lp.screenBrightness = (brightness <= 0 ? 1 : brightness) / 255f;
        }
        window.setAttributes(lp);

        return brightness;
    }
}
