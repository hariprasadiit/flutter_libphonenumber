# Flutter libphonenumber

Flutter plugin wrapper to Google&#x27;s libphonenumber

Uses flutter platform channel to communicate with native implementation of libphonenumber.

This library uses below native libraries
 - Android: https://github.com/MichaelRocks/libphonenumber-android
 - iOS: https://github.com/marmelroy/PhoneNumberKit
 
#### NOTE
 Only number parsing is implemented as of now

## Usage

```dart
try{
  final parsed = await FlutterLibPhoneNumber.parse(_phoneController.text);
} on PlatformException catch(e){
  debugPrint(e.code +' --- '+e.message);
}
```

`parse()` takes 2 parameters.

`numberString` - Number string to be parsed

`defaultRegion` - default is `IN`. Used when country code prefix is not provided with phone number string