//
//  StringExt.swift
//  VozLiving
//
//  Created by Hung Nguyen Thanh on 7/3/17.
//  Copyright © 2017 VozLiving. All rights reserved.
//

import Foundation

extension Character {
    func isEmoji() -> Bool {
        return Character(UnicodeScalar(UInt32(0x1d000))!) <= self && self <= Character(UnicodeScalar(UInt32(0x1f77f))!)
            || Character(UnicodeScalar(UInt32(0x2100))!) <= self && self <= Character(UnicodeScalar(UInt32(0x26ff))!)
    }
}

extension String {
    
    // MARK: - Localized
    var localized : String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "");
    }
    
    func stringByRemovingEmoji() -> String {
        //        return String(filter(self, {(c: Character) in !c.isEmoji()}))
        
        let nStr = String(self.characters.filter { (char: Character) -> Bool in
            !char.isEmoji()
        })
        
        return nStr
    }
    
    var urlEncode: String {
        
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
    }
    
    var urlDecode: String {
        
        return self.removingPercentEncoding!
        
    }
    
    
    static func localized(key : String) -> String {
        return key.localized
    }
    
    // MARK: - Validate String
    // MARK: - trimString
    func trimString() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    // MARK: - isEmptyString
    func isEmptyString() -> Bool{
        if self.trimString().isEmpty {
            return true
        }
        return false
    }
    
    
    // MARK: - String path component helper
    var lastPathComponent: String {
        
        get {
            return (self as NSString).lastPathComponent
        }
    }
    var pathExtension: String {
        
        get {
            
            return (self as NSString).pathExtension
        }
    }
    var stringByDeletingLastPathComponent: String {
        
        get {
            
            return (self as NSString).deletingLastPathComponent
        }
    }
    var stringByDeletingPathExtension: String {
        
        get {
            
            return (self as NSString).deletingPathExtension
        }
    }
    var pathComponents: [String] {
        
        get {
            
            return (self as NSString).pathComponents
        }
    }
    
    func stringByAppendingPathComponent(path: String) -> String {
        
        let nsSt = self as NSString
        
        return nsSt.appendingPathComponent(path)
    }
    
    func stringByAppendingPathExtension(ext: String) -> String? {
        
        let nsSt = self as NSString
        
        return nsSt.appendingPathExtension(ext)
    }
    
    var length: Int {
        get {
            return self.characters.count
        }
    }
    
    func filterOnlyNumber() -> String {
        
        let nStr = String(self.characters.filter { (char: Character) -> Bool in
            char >= "0" && char <= "9"
        })
        
        return nStr
    }
    
    func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
}
