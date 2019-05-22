//
//  String+JW.swift
//  ToMakeMoney
//
//  Created by LjwMac on 2018/1/15.
//  Copyright © 2018年 jw. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto
//import Cache             // MD5
//import CryptoSwift     // MD5

import CommonCrypto


extension JWNamespaceWrapper where T == String {
    
    // api 与参数拼接
    func api(addParams: [String: Any]) -> String {
        return jwWrappedValue.api(addParams: addParams)
    }
    
    // api 与子路径拼接
    func api(addPath: String) -> String {
        return jwWrappedValue.api(addPath: addPath)
    }
    
    // api 子路径解析成字典
    func apiParams() -> [String: String] {
        var toParams = [String: String]()
        
        let paramsInfoArray =  jwWrappedValue.split(separator: "&")
        for itemPInfoTemp in paramsInfoArray {
            
            let itemParamsInfo = itemPInfoTemp.split(separator: "=")
            if itemParamsInfo.count > 1 {
                let firstRange = String(itemParamsInfo[0]).jw.range
                let valString = String(itemPInfoTemp)
                let toValue = valString.substring(from: firstRange.location + firstRange.length + 1)
                toParams[String(itemParamsInfo[0])] = toValue
            } else if itemParamsInfo.count > 0 {
                toParams[String(itemParamsInfo[0])] = ""
            }
            
        }
        return toParams
    }
    
    // 子字符串
    func string(range: NSRange) -> String {
        return jwWrappedValue.substring(from: range.location, count: range.length)
    }
    // 子字符串
    func string(from: Int ,count: Int) -> String {
        return jwWrappedValue.substring(from: from, count: count)
    }
    // 子字符串
    func string(from: Int, to: Int) -> String {
        return jwWrappedValue.substring(from: from, to: to)
    }
    // 子字符串
    func string(from: Int) -> String {
        return jwWrappedValue.substring(from: from)
    }
    // 子字符串
    func string(to: Int) -> String {
        return jwWrappedValue.substring(to: to)
    }
    
    var range: NSRange { return jwWrappedValue.range }

    // 子字符串位置
    func nsRange(fromSubString subString: String) -> NSRange? {
        return jwWrappedValue.nsRange(fromSubString: subString)
    }
    
    // 修复urlencode问题
    func fixUrlEncode() -> String {
        var charSet = CharacterSet.urlQueryAllowed
        charSet.insert(charactersIn: "#")
        charSet.insert(charactersIn: "%")
        return jwWrappedValue.addingPercentEncoding(withAllowedCharacters: charSet) ?? jwWrappedValue
    }
    
    func urlEncodeQueryAllowed() -> String? {
        return jwWrappedValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    func urlEncodeQueryAllowedFix() -> String {
        return self.escape(jwWrappedValue)
    }
    
   fileprivate func escape(_ string: String) -> String {
    
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: generalDelimitersToEncode + subDelimitersToEncode)
        var escaped = ""
        if #available(iOS 8.3, *) {
            escaped = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
        } else {
            let batchSize = 50
            var index = string.startIndex
            while index != string.endIndex {
                let startIndex = index
                let endIndex = string.index(index, offsetBy: batchSize, limitedBy: string.endIndex) ?? startIndex
                let substring = string[startIndex..<endIndex]
                escaped += (substring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet as CharacterSet) ?? String(substring))
                index = endIndex
            }
        }
        return escaped
    
    }
    
    func directoryPath(createWhenNoFound: Bool = true) -> String {
        if !self.directoryExists(path: jwWrappedValue) && createWhenNoFound {
           try? FileManager.default.createDirectory(atPath: jwWrappedValue, withIntermediateDirectories: true, attributes: nil)
        }
        return jwWrappedValue
    }
    
    fileprivate func directoryExists(path: String) -> Bool {
        var pointer = ObjCBool.init(true);
        if FileManager.default.fileExists(atPath: path, isDirectory: &pointer) {
            if !pointer.boolValue {
                return true
            }
        }
        return false
    }
    
    
}

extension JWNamespaceWrapper where T == String {
    
    
    var md5: String {
        return jwWrappedValue.md5
    }
    
    // 根据日期格式生成日期
    func toFormattedDate(formatter: String) -> Date? {
        let df = DateFormatter()
        df.dateFormat = formatter
        let d = df.date(from: jwWrappedValue)
        return d
    }
 
    // Base64
    var fromBase64 : String? {
        guard let data = Data(base64Encoded: jwWrappedValue, options: Data.Base64DecodingOptions(rawValue: 0)) else {
            return nil
        }
        return String(data: data as Data, encoding: String.Encoding.utf8)
    }
    
    // Base64
    var toBase64 : String? {
        guard let data = jwWrappedValue.data(using: String.Encoding.utf8) else {
            return nil
        }
        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }
    
    func textSize(maxSize:CGSize, font: UIFont, paragraphStyle: NSMutableParagraphStyle? = nil) -> CGSize {
        
        var attr = [NSAttributedString.Key : Any]()
        attr[NSAttributedString.Key.font] = font
        
        var oriLineMode: NSLineBreakMode? = nil
        
        // 一定要修改成 byWordWrapping
        if let paragraphStyle = paragraphStyle {
            oriLineMode = paragraphStyle.lineBreakMode
            paragraphStyle.lineBreakMode = .byWordWrapping
            attr[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        
        let size = (jwWrappedValue as NSString).boundingRect(with: maxSize,
                                                             options: [.usesLineFragmentOrigin],
                                                             attributes: attr,
                                                             context: nil).size
        if paragraphStyle != nil, oriLineMode != nil {
            paragraphStyle?.lineBreakMode = oriLineMode!
        }
        return size
    }
    
    func textSize(maxSize: CGSize, attributes: [NSAttributedString.Key: Any]? = nil) -> CGSize {
        
        return (jwWrappedValue as NSString).boundingRect(with: maxSize,
                                                         options: [.usesLineFragmentOrigin],
                                                         attributes: attributes,
                                                         context: nil).size
        
    }
    
    var securePhone: String {
        guard jwWrappedValue.isMatch(byRegex: CommonMatchRegex.phone.rawValue) else {
            return ""
        }
        
        return "\(jwWrappedValue.prefix(3))****\(jwWrappedValue.suffix(4))"
        
    }
}

/// 取自Kingfisher
fileprivate extension String {
    
    var md5: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        #if swift(>=5.0)
        _ = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) in
            return CC_MD5(bytes.baseAddress, CC_LONG(data.count), &digest)
        }
        #else
        _ = data.withUnsafeBytes { bytes in
            return CC_MD5(bytes, CC_LONG(data.count), &digest)
        }
        #endif
        
        return digest.map { String(format: "%02x", $0) }.joined()
    }
    
}

/// 常用正则
enum CommonMatchRegex: String {
    
    // 简单手机号码校验
    case phone = "^1[0-9]{10}$"
    // 严格手机号码校验
    case phoneStrict = "^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$"
    // 数字
    case number = "[0-9]+$"
    // 邮编
    case zipCode = "^[1-9]\\d{5}$"
    // ip 地址
    case ipAddress = "((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)"
    // 网址
    case website = "[a-zA-z]+://[^\\s]*"
    // 数字和字母
    case alphanumeric = "^[0-9A-Za-z]+$"
    // 用户名
    case nickname = "^[a-zA-Z0-9\\u4e00-\\u9fa5_]{1,10}$"
    // 密码
    case password = "^[a-zA-Z0-9]{6,16}$"
    
    
    case passwordStrict = "^(?=.*[a-z])(?=.*[a-z]).{6,16}$"
    
    /**
     严格密码校验(6-16位字母或数字，首位不能为数字,不能纯字母,不能纯数字)
     (?![0-9]+$) 表示不为多个数字
     (?![a-zA-Z]+$) 表示不为多个字母
     
     */
    case passwordStrict1 = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,16}"
    
    // 身份证简单校验
    case idCard = "(^[0-9]{15}$)|([0-9]{17}([0-9]|[xX])$)"
    
    // 18位身份证
    case idCard18 = "^\\d{6}(18|19|20)?\\d{2}(0[1-9]|1[012])(0[1-9]|[12]\\d|3[01])\\d{3}(\\d|[xX])$"
    
    // 车牌
    case carNumber = "^[京津沪渝蒙新藏宁桂黑吉辽晋青冀鲁豫苏皖浙闽赣湘鄂粤琼甘陕川云贵]{1}[A-Za-z]{1}[A-Za-z0-9]{5,6}$"
    
    // 简单邮箱校验
    case email = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*.\\w+([-.]\\w+)*$"
    /**
     严格邮箱校验
     
     @之前必须有内容且只能是字母（大小写）、数字、下划线(_)、减号（-）、点（.)
     @和最后一个点（.）之间必须有内容且只能是字母（大小写）、数字、点（.）、减号（-），且两个点不能挨着
     最后一个点（.）之后必须有内容且内容只能是字母（大小写）、数字且长度为大于等于2个字节，小于等于6个字节
     */
    case emailStrict = "^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z0-9]{2,6}$"
}

/// 正则
extension JWNamespaceWrapper where T == String {
   
    // 正则匹配
    func isMatch(byRegex: String) -> Bool {
        return jwWrappedValue.isMatch(byRegex: byRegex)
    }
    
    // 是否是电话号码
    var isPhoneNumber: Bool {
        let regex: String = CommonMatchRegex.phone.rawValue
        return jwWrappedValue.isMatch(byRegex: regex)
    }
    
    // 是否包含Emoji
    var isContainsEmoji: Bool {
        for scalar in jwWrappedValue.unicodeScalars {
            switch scalar.value {
            case
            0x00A0...0x00AF,
            0x2030...0x204F,
            0x2120...0x213F,
            0x2190...0x21AF,
            0x2310...0x329F,
            0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false
    }
    
    // 是否是身份证号(目前只匹配大陆身份证号)
    var isIdCard: Bool {
        
        let value = jwWrappedValue.uppercased()
        
        // 判断是否15或者18位
        guard value.count == 15 || value.count == 18 else { return false }
        
        let areasStr: [String] = ["11","12", "13", "14", "15","21", "22","23", "31","32", "33","34", "35","36", "37","41", "42","43", "44","45", "46","50", "51","52", "53","54", "61","62", "63","64", "65","71", "81","82", "91"]
        
        // 判断是否存在地区列表中
        guard areasStr.contains(value.substring(to: 2)) else { return false }
        
        // 15位转化为18位
        let toValue = value.count == 15 ? value.idCardNum15To18() : value
        
        let birthdayStr = toValue.substring(from: 6, count: 8)
        
        let df = DateFormatter(); df.dateFormat = "yyyyMMdd"
        
        // 判断日期是否规范
        guard df.date(from: birthdayStr) != nil else { return false }
        
        // 校验数字
        let paperId = (toValue as NSString).utf8String!
        
        for i in 0...18 {
            if (0 <= paperId[i] && paperId[i] <= 9) && !(88 == paperId[i] || 120 == paperId[i]) && 17 == i {
                return false
            }
        }
        
        let R = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]
        let sChecker: [Int8] = [49, 48, 88, 57, 56, 55, 54, 53, 52, 51, 50]
        
        var lSumQT = 0
        
        //验证最末的校验码
        for i in 0...16 {
            lSumQT += (Int(paperId[i]) - 48) * R[i]
        }
        
        if sChecker[lSumQT%11] != paperId[17] {
            return false
        }
        
        return true
    }
    
    
    
}

fileprivate extension String {
    
    // 正则匹配
    func isMatch(byRegex: String) -> Bool {
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", byRegex)
        return predicate.evaluate(with: self)
    }
    
    var range: NSRange { return NSMakeRange(0, self.count) }
    
    func nsRange(fromSubString subString: String) -> NSRange? {
        let subRange = self.range(of: subString)
        if let subRange = subRange {
            return NSRange(subRange, in: self)
        }
        return nil
    }
    
    func substring(range: NSRange) -> String {
        return self.substring(from: range.location, count: range.length)
    }
    
    func substring(from: Int ,count: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(startIndex, offsetBy: count)
        return String(self[startIndex..<endIndex])
    }
    
    func substring(from: Int, to: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.endIndex, offsetBy: to - self.count)
        let subString = self[startIndex..<endIndex]
        return String(subString)
    }
    
    func substring(from index: Int) -> String {
        return self.substring(from: index, to: self.count)
    }
    
    func substring(to index: Int) -> String {
        return self.substring(from: 0, to: index)
    }
    
    
    func times(_ n: Int) -> String {
        
        let range = (0..<n)
        return range.reduce("") { (r, _) -> String in
            return r + self
        }
        
    }
    
    func ensureLeft(_ prefix: String) -> String {
        if self.hasPrefix(prefix) {
            return self
        } else {
            return "\(prefix)\(self)"
        }
    }
    
    func ensureRight(_ suffix: String) -> String {
        if self.hasSuffix(suffix) {
            return self
        } else {
            return "\(self)\(suffix)"
        }
    }
    
    func chompLeft(_ prefix: String) -> String {
        if let prefixRange = range(of: prefix) {
            if prefixRange.upperBound >= endIndex {
                return String(self[startIndex..<prefixRange.lowerBound])
            } else {
                return String(self[prefixRange.upperBound..<endIndex])
            }
        }
        return self
    }
    
    // api 与参数拼接
    func api(addParams: [String: Any]) -> String {
        
        /// 参数连接标识
        let addParamsTagStr = (self.contains("?") || addParams.count == 0) ? "" : "?"
        
        let combineTagStr = (addParams.count == 0 || self.hasSuffix("&") || self.hasSuffix("?")) ? "" : "&"
        
        let paramsStr = addParams.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        
        let toString = self + addParamsTagStr + combineTagStr + paramsStr
        
        return toString
        
    }
    
    // api 与子路径拼接
    func api(addPath: String) -> String {
        
        var toDomain = self
        for i in self.reversed() {
            if i == "/" {
                toDomain.removeLast()
            } else {
                break
            }
        }
        
        var toPath = addPath
        
        for i in addPath {
            if i == "/" {
                toPath.removeFirst()
            } else {
                break
            }
        }
        
        let toString = toDomain.ensureRight("/") + toPath
        return toString
    }
    
    
}

fileprivate extension String {
    
    func idCardNum15To18() -> String {
        
        if self.count != 15 { return self }
        
        var toValue = self
        
        let R = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]
        let sChecker: [Int8] = [49, 48, 88, 57, 56, 55, 54, 53, 52, 51, 50]
        
        toValue.insert(contentsOf: "19", at: toValue.index(toValue.startIndex, offsetBy: 6))
        
        let pid = (toValue as NSString).utf8String
        var p = 0
        for i in 0...16 {
            
            let pItem = pid![i]
            p += (Int(pItem) - 48) * R[i]
        }
        let o = p % sChecker.count
        let insertContent = NSString(format: "%c", sChecker[o])
        toValue.insert(contentsOf: insertContent as String, at: toValue.index(toValue.endIndex, offsetBy: 0))
        return toValue
    }
    
    
    func areaCodeAt(code: String) -> Bool {
        var dic: [String: String] = [:]
        dic["11"] = "北京"
        dic["12"] = "天津"
        dic["13"] = "河北"
        dic["14"] = "山西"
        dic["15"] = "内蒙古"
        dic["21"] = "辽宁"
        dic["22"] = "吉林"
        dic["23"] = "黑龙江"
        dic["31"] = "上海"
        dic["32"] = "江苏"
        dic["33"] = "浙江"
        dic["34"] = "安徽"
        dic["35"] = "福建"
        dic["36"] = "江西"
        dic["37"] = "山东"
        dic["41"] = "河南"
        dic["42"] = "湖北"
        dic["43"] = "湖南"
        dic["44"] = "广东"
        dic["45"] = "广西"
        dic["46"] = "海南"
        dic["50"] = "重庆"
        dic["51"] = "四川"
        dic["52"] = "贵州"
        dic["53"] = "云南"
        dic["54"] = "西藏"
        dic["61"] = "陕西"
        dic["62"] = "甘肃"
        dic["63"] = "青海"
        dic["64"] = "宁夏"
        dic["65"] = "新疆"
        dic["71"] = "台湾"
        dic["81"] = "香港"
        dic["82"] = "澳门"
        dic["91"] = "国外"
        if (dic[code] == nil) { return false }
        return true;
    }
    
}


