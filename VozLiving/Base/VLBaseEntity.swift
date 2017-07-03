//
//  VLBaseEntity.swift
//  VozLiving
//
//  Created by Hung Nguyen Thanh on 7/3/17.
//  Copyright © 2017 VozLiving. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import ObjectMapper

class VLBaseEntity: Object , Mappable, NSCopying {
    
    var map : Map?
    
    var id: String!
    
    lazy var unknownProperties = [String: AnyObject]()
    
    required init() {
        super.init()
    }
    
    // MARK: - Mappable
    required init?(map: Map) {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    func mapping(map: Map) {
        self.map = map
        
        self.id <- map["id"]
    }
    
    class func getDummyMap() -> Map {
        return Map(mappingType: MappingType.fromJSON, JSON: [String : AnyObject]())
    }
    
    
    // MARK: - Support Method
    func nestedObject<T: Mappable>(objectName : String) -> T? {
        var obj : T?
        if map != nil {
            obj <- map![objectName]
        }
        return obj
    }
    
    func nestedObject<T>(objectName : String) -> T? {
        var obj : T?
        if map != nil {
            obj <- map![objectName]
        }
        return obj
    }
    
    func nestedObjectArray<T: Mappable>(arrayName : String) -> [T]? {
        var obj : [T]?
        if map != nil {
            obj <- map![arrayName]
        }
        return obj
    }
    
    func nestedObjectArray<T>(arrayName : String) -> [T]? {
        var obj : [T]?
        if map != nil {
            obj <- map![arrayName]
        }
        return obj
    }
    
    
    
    subscript(key : String) -> AnyObject! {
        get {
            return unknownProperties[key]
        }
        
        set {
            if newValue != nil {
                unknownProperties[key] = newValue
            }
        }
    }
    
    func debugQuickLookObject() -> AnyObject? {
        return self.toJSONString(prettyPrint: true) as AnyObject?
    }
    
    override var description: String {
        
        return super.description + ": \(String(describing: self.debugQuickLookObject()))"
    }
    
    func checkNil(value: AnyObject!) -> AnyObject {
        if value == nil {
            return NSNull()
        }
        
        return value
    }
    
    
    // MARK - Copy
    public func copy(with zone: NSZone? = nil) -> Any {
        
        return VLBaseEntity()
        
    }
    
    
    func saveToDisk(path: String) {
        
        if let jsonString = self.toJSONString() {
            
            do {
                
                try jsonString.write(toFile: path + NSDate().description + ".json", atomically: true, encoding: String.Encoding.utf8)
                
            } catch {
                
            }
            
        }
        
    }
}
