#import "FlutterPhoneinfochangePlugPlugin.h"

@implementation FlutterPhoneinfochangePlugPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_phoneinfochange_plug"
            binaryMessenger:[registrar messenger]];
  FlutterPhoneinfochangePlugPlugin* instance = [[FlutterPhoneinfochangePlugPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }else if ([@"calculate" isEqualToString:call.method]) {
    NSInteger a = [arguments[@"a"] intValue];
    NSInteger b = [arguments[@"b"] intValue];
    result([NSString stringWithFormat:@"%d", a + b]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}
// -(int)getVolume{
//   AVAudioSession *audioSession = [AVAudioSession sharedInstance];
// CGFloat volume = audioSession.outputVolume;
// int voice=lroundf(volume);
//     return voice;
}
// - (int)setVolume:(float)value {   
//      self.volumeSlider = [self volumeSlider];      // 需要设置 showsVolumeSlider 为 YES  
//        self.volumeView.showsVolumeSlider = YES; 
//         [self.volumeSlidersetValue:value animated:NO];  
//       [self.volumeSlider sendActionsForControlEvents:UIControlEventTouchUpInside];  
//       [self.volumeView sizeToFit];  
//      return getVolume();
//     }


@end
