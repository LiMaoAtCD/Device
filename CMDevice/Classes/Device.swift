//
//  Device.swift
//  Device
//
//  Created by Lucas Ortis on 30/10/2015.
//  Copyright © 2015 Ekhoo. All rights reserved.
//

import UIKit

open class Device {
    static fileprivate func getVersionCode() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)

        let versionCode: String = String(validatingUTF8: NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: String.Encoding.ascii.rawValue)!.utf8String!)!

        return versionCode
    }

    static fileprivate func getVersion(code: String) -> Version {
        switch code {
            /*** iPhone ***/
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return .iPhone4
            case "iPhone4,1", "iPhone4,2", "iPhone4,3":     return .iPhone4S
            case "iPhone5,1", "iPhone5,2":                 return .iPhone5
            case "iPhone5,3", "iPhone5,4":                 return .iPhone5C
            case "iPhone6,1", "iPhone6,2":                 return .iPhone5S
            case "iPhone7,2":                            return .iPhone6
            case "iPhone7,1":                            return .iPhone6Plus
            case "iPhone8,1":                            return .iPhone6S
            case "iPhone8,2":                            return .iPhone6SPlus
            case "iPhone8,3", "iPhone8,4":                 return .iPhoneSE
            case "iPhone9,1", "iPhone9,3":                 return .iPhone7
            case "iPhone9,2", "iPhone9,4":                 return .iPhone7Plus
            case "iPhone10,1", "iPhone10,4":               return .iPhone8
            case "iPhone10,2", "iPhone10,5":               return .iPhone8Plus
            case "iPhone10,3", "iPhone10,6":               return .iPhoneX
            case "iPhone11,2":                           return .iPhoneXS
            case "iPhone11,4", "iPhone11,6":               return .iPhoneXS_Max
            case "iPhone11,8":                           return .iPhoneXR
            case "iPhone12,1":                return .iPhone11
            case "iPhone12,3":                return .iPhone11Pro
            case "iPhone12,5":                return .iPhone11Pro_Max
            case "iPhone13,1":                return .iPhone12Mini
            case "iPhone13,2":                return .iPhone12
            case "iPhone13,3":                return .iPhone12Pro
            case "iPhone13,4":                return .iPhone12Pro_Max
            case "iPhone14,5":                return .iPhone13
            case "iPhone14,4":                return .iPhone13Mini
            case "iPhone14,2":                return .iPhone13Pro
            case "iPhone14,3":                return .iPhone13ProMax
            case "iPhone14,6":                return .iPhoneSE3
            case "iPhone14,7":                return .iPhone14
            case "iPhone14,8":                return .iPhone14Plus
            case "iPhone15,2":                return .iPhone14Pro
            case "iPhone15,3":                return .iPhone14Pro_Max


            /*** iPad ***/
            case "iPad1,1", "iPad1,2":                       return .iPad1
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return .iPad2
            case "iPad3,1", "iPad3,2", "iPad3,3":            return .iPad3
            case "iPad3,4", "iPad3,5", "iPad3,6":            return .iPad4
            case "iPad6,11", "iPad6,12":                     return .iPad5
            case "iPad7,5", "iPad7,6":                       return .iPad6
            case "iPad7,11", "iPad7,12":                     return .iPad7
            case "iPad11,6", "iPad11,7":                     return .iPad8
            case "iPad12,1", "iPad12,2":                     return .iPad9
            case "iPad4,1", "iPad4,2", "iPad4,3":            return .iPadAir
            case "iPad5,3", "iPad5,4":                       return .iPadAir2
            case "iPad11,3", "iPad11,4":                     return .iPadAir3
            case "iPad13,1", "iPad13,2":                     return .iPadAir4
            case "iPad2,5", "iPad2,6", "iPad2,7":            return .iPadMini
            case "iPad4,4", "iPad4,5", "iPad4,6":            return .iPadMini2
            case "iPad4,7", "iPad4,8", "iPad4,9":            return .iPadMini3
            case "iPad5,1", "iPad5,2":                       return .iPadMini4
            case "iPad11,1", "iPad11,2":                     return .iPadMini5
            case "iPad14,1", "iPad14,2":                     return .iPadMini6

            /*** iPadPro ***/
            case "iPad6,3", "iPad6,4":                       return .iPadPro9_7Inch
            case "iPad6,7", "iPad6,8":                       return .iPadPro12_9Inch
            case "iPad7,1", "iPad7,2":                       return .iPadPro12_9Inch2
            case "iPad7,3", "iPad7,4":                       return .iPadPro10_5Inch
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4": return .iPadPro11_0Inch
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8": return .iPadPro12_9Inch3
            case "iPad8,9", "iPad8,10":                      return .iPadPro11_Inch2
            case "iPad8,11", "iPad8,12":                     return .iPadPro12_Inch4
            case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7": return .iPadPro11_Inch3
            case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11": return .ipadPro12_Inch5
            case "AudioAccessory1,1":                        return .homePod

            /*** iPod ***/
            case "iPod1,1":                                  return .iPodTouch1Gen
            case "iPod2,1":                                  return .iPodTouch2Gen
            case "iPod3,1":                                  return .iPodTouch3Gen
            case "iPod4,1":                                  return .iPodTouch4Gen
            case "iPod5,1":                                  return .iPodTouch5Gen
            case "iPod7,1":                                  return .iPodTouch6Gen
            case "iPod9,1":                                  return .iPodTouch7Gen

            /*** Simulator ***/
            case "i386", "x86_64", "arm64":                  return .simulator

            default:                                         return .unknown
        }
    }

    static fileprivate func getType(code: String) -> Type {
        let versionCode = getVersionCode()

        if versionCode.contains("iPhone") {
            return .iPhone
        } else if versionCode.contains("iPad") {
            return .iPad
        } else if versionCode.contains("iPod") {
            return .iPod
        } else if versionCode == "i386" || versionCode == "x86_64" || versionCode == "arm64" {
            return .simulator
        } else {
            return .unknown
        }
    }

    static public func version() -> Version {
        return getVersion(code: getVersionCode())
    }

    static public func size() -> Size {
        let w: Double = Double(UIScreen.main.bounds.width)
        let h: Double = Double(UIScreen.main.bounds.height)
        let screenHeight: Double = max(w, h)

        switch screenHeight {
            case 480:
                return .screen3_5Inch
            case 568:
                return .screen4Inch
            case 667:
                return UIScreen.main.scale == 3.0 ? .screen5_5Inch : .screen4_7Inch
            case 736:
                return .screen5_5Inch
            case 812:
                return .screen5_8Inch
            case 780:
                return .screen5_4Inch
            case 844:
                return .screen6_1Inch
            case 852:
                return .screen6_1Inch
            case 926:
                return .screen6_7Inch
            case 932:
                return .screen6_7Inch
            case 896:
                switch version() {
                    case .iPhoneXS_Max:
                        return .screen6_5Inch
                    default:
                        return .screen6_1Inch
                }
            case 1024:
                switch version() {
                    case .iPadMini,.iPadMini2,.iPadMini3,.iPadMini4:
                        return .screen7_9Inch
                    case .iPadPro10_5Inch:
                        return .screen10_5Inch
                    default:
                        return .screen9_7Inch
                }
            case 1112:
                switch version() {
                    case .iPad7:
                        return .screen10_2Inch
                    default:
                        return .screen10_5Inch
                }
            case 1194:
                return .screen11Inch
            case 1366:
                return .screen12_9Inch
            default:
                return .unknownSize
        }
    }

    static public func type() -> Type {
        return getType(code: getVersionCode())
    }

    @available(*, deprecated, message: "use == operator instead")
    static public func isEqualToScreenSize(_ size: Size) -> Bool {
        return size == self.size() ? true : false;
    }

    @available(*, deprecated, message: "use > operator instead")
    static public func isLargerThanScreenSize(_ size: Size) -> Bool {
        return size.rawValue < self.size().rawValue ? true : false;
    }

    @available(*, deprecated, message: "use < operator instead")
    static public func isSmallerThanScreenSize(_ size: Size) -> Bool {
        return size.rawValue > self.size().rawValue ? true : false;
    }

    // MARK: - 设备类型相关
    static public func deviceString() -> String {
        return getVersionCode()
    }

    static public func isRetina() -> Bool {
        return UIScreen.main.scale > 1.0
    }

    static public func isPad() -> Bool {
        return type() == .iPad
    }

    static public func isPhone() -> Bool {
        return type() == .iPhone
    }

    static public func isPod() -> Bool {
        return type() == .iPod
    }

    static public func isSimulator() -> Bool {
        return type() == .simulator
    }

    /// 是否是iPhoneX系列
    /// - Returns: 判断结果
    static public func isIPhoneXSeries() -> Bool {
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
                return window.safeAreaInsets.bottom > 0
            }
            if let window = UIApplication.shared.windows.first {
                return window.safeAreaInsets.bottom > 0
            }
        }
        return false
    }

    // MARK: - 设备常量相关（安全距离、是否是x系列、屏幕尺寸、状态栏高度等）
    /// 获取屏幕尺寸
    /// - Returns: 返回屏幕尺寸
    static public func screenSize() -> (kScreenWidth: CGFloat, kScreenHeight: CGFloat) {
        let kbounds = UIScreen.main.bounds.size
        let width = min(kbounds.width, kbounds.height)
        let height = max(kbounds.width, kbounds.height)
        return (width, height)
    }


    /// 获取状态栏高度
    /// 假如因为状态栏隐藏导致取到的值为0则默认返回顶部安全距离
    /// - Returns: 状态栏高度
    static public func kStatusBarHeight() -> CGFloat {
        var height: CGFloat = 0
        if #available(iOS 13.0, *) {
            let barFrames = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0?.statusBarManager?.statusBarFrame }).filter({ $0 != CGRect.zero })
            if !barFrames.isEmpty, let one = barFrames.first {
                height = one.height
            }
        } else {
            height = UIApplication.shared.statusBarFrame.size.height
        }
        return height.isZero ? default_values().statusBarHeight : height
    }


    /// 获取顶部安全距离
    /// - Returns: 顶部安全距离
    static public func safeDistance_top() -> CGFloat {
        return safeAreaInsets().top
    }


    /// 获取底部安全距离
    /// - Returns: 底部安全距离
    static public func safeDistance_bottom() -> CGFloat {
        return safeAreaInsets().bottom
    }


    /// 安全区域，只针对iPhone系列，不支持ipad和touch
    /// - Returns: 返回安全区域
    static public func safeAreaInsets() -> UIEdgeInsets {
        /**
         下面是代码获取，由于代码获取和应用生命周期相关，可能会出现取值为0的情况，所以添加了默认值的兜底处理
         */
        let defaultInset = default_values().safeInsets
        var safeInsets: UIEdgeInsets = UIEdgeInsets.zero
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            if let windowScene = scene as? UIWindowScene, let window = windowScene.windows.first {
                safeInsets = window.safeAreaInsets
            }
        } else if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.windows.first {
                safeInsets = window.safeAreaInsets
            }
        }
        // 如果取到的安全区间为0则根据机型返回默认区域
        guard safeInsets != .zero else { return defaultInset }
        return safeInsets
    }

    static private func default_values() -> (safeInsets: UIEdgeInsets, statusBarHeight: CGFloat) {
        let version = getVersion(code: getVersionCode())
        switch version {
            case .iPhone4, .iPhone4S ,
                    .iPhone5, .iPhone5C, .iPhone5S,
                    .iPhone6, .iPhone6Plus, .iPhone6S, .iPhone6SPlus,
                    .iPhone7, .iPhone7Plus,
                    .iPhone8, .iPhone8Plus:
                return (UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0), 20)
            case .iPhoneX, .iPhoneXS, .iPhoneXR, .iPhoneXS_Max, .iPhone11Pro, .iPhone11Pro_Max:
                return (UIEdgeInsets.init(top: 44, left: 0, bottom: 34, right: 0), 44)
            case .iPhone11:
                return (UIEdgeInsets.init(top: 48, left: 0, bottom: 34, right: 0), 48)

            case .iPhone12Mini, .iPhone13Mini:
                return (UIEdgeInsets.init(top: 50, left: 0, bottom: 34, right: 0), 50)
            case .iPhone12, .iPhone12Pro, .iPhone12Pro_Max, .iPhone13, .iPhone13Pro, .iPhone13ProMax, .iPhone14, .iPhone14Plus :
                return (UIEdgeInsets.init(top: 47, left: 0, bottom: 34, right: 0), 47)
            case .iPhone14Pro, .iPhone14Pro_Max:
                return (UIEdgeInsets.init(top: 59, left: 0, bottom: 34, right: 0), 54)
            case .iPhoneSE, .iPhoneSE3:
                return (UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0), 20)
            // ipad以及touch暂不支持，默认返回X系列安全区
            default:
                return (UIEdgeInsets.init(top: 47, left: 0, bottom: 34, right: 0), 47)
        }
    }
}
