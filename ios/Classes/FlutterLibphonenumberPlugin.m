#import "FlutterLibphonenumberPlugin.h"
#import <flutter_libphonenumber/flutter_libphonenumber-Swift.h>

@implementation FlutterLibphonenumberPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterLibphonenumberPlugin registerWithRegistrar:registrar];
}
@end
