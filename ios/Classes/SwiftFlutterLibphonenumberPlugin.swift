import Flutter
import UIKit
import PhoneNumberKit

public class SwiftFlutterLibphonenumberPlugin: NSObject, FlutterPlugin {
  
    private let phoneNumberKit = PhoneNumberKit()
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.vizmo.flutterlibphonenumber", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterLibphonenumberPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let method = call.method
    if("parse" == method){
        let args = call.arguments as! [String: Any?]
        
        guard let phoneNumber = args["phoneNumber"] as? String else {
            result(FlutterError(code: "INVALID_NUMBER", message: "Phone number is invalid", details: nil))
            return
        }
        
        let ignoreType = args["ignoreType"] as? Bool ?? true
        
        do {
            var parsedNumber: PhoneNumber?
            if let defaultRegion = args["defaultRegion"] as? String, !defaultRegion.isEmpty {
                parsedNumber = try phoneNumberKit.parse(phoneNumber, withRegion: defaultRegion, ignoreType: ignoreType)
            } else {
                parsedNumber = try phoneNumberKit.parse(phoneNumber)
            }
            
            if let parsed = parsedNumber {
                let phoneDict: [String : Any?] = [
                    "countryCode": parsed.countryCode,
                    "nationalNumber": parsed.nationalNumber,
                    "numberExtension": parsed.numberExtension,
                ]
                result(phoneDict)
            } else {
                result(FlutterError(code: "PARSE_ERROR", message: "Could not parse the phone number ", details: nil))
            }
            
        }catch let error as PhoneNumberError{
            var code = "INVALID_COUNTRY_CODE"
            switch(error) {
            case .invalidCountryCode:
                code = "INVALID_COUNTRY_CODE"
            case .notANumber:
                code = "NOT_A_NUMBER"
            case .tooShort:
                code = "TOO_SHORT"
            case .tooLong:
                code = "TOO_LONG"
            default:
                code = "PARSE_ERROR"
            }
            result(FlutterError(code: code, message: error.errorDescription, details: nil))
        }catch {
            result(FlutterError(code: "PARSE_ERROR", message: "Unknown error while parsing", details: nil))
        }
        
    }else {
        result(FlutterMethodNotImplemented)
    }
  }
}
