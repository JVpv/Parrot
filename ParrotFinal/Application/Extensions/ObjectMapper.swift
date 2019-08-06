//
//  ObjectMapperToString.swift
//  Unifor Mobile
//
//  Created by Thiago Diniz on 14/09/17.
//  Copyright © 2017 NATI. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

open class ObjectMapperToString : TransformType {
    
    public typealias Object = String
    public typealias JSON = Int
    
    open func transformFromJSON(_ value: Any?) -> String? {
        
        if let value = value {
            
            return String(describing: value)
        }
        
        return ""
    }
    
    open func transformToJSON(_ value: Object?) -> Int? {
        
        if let value = value {
            
            return Int(value)
        }
        
        return 0
    }
}

class DateTransform: TransformType {
    
    typealias Object = Date
    typealias JSON = String
    var formatter: DateFormatter
    
    init(formatter: String) {
        
        self.formatter = DateFormatter(withFormat: formatter, locale: "pt_BR")
        self.formatter.timeZone = TimeZone(identifier: localTimeZoneId)
    }
    
    func transformFromJSON(_ value: Any?) -> Date? {
        
        if let dateString = value as? String {
            
            return self.formatter.date(from: dateString)
            
        }
        
        return nil
    }
    
    func transformToJSON(_ value: Date?) -> String? {
        
        if let value = value {
            
            return self.formatter.string(from: value)
        }
        
        return nil
    }
}

class DateTransformSince1970: TransformType {
    
    typealias Object = Date
    typealias JSON = Double
    
    func transformFromJSON(_ value: Any?) -> Date? {
        
        if let dateDouble = value as? Double {
            
            return Date(timeIntervalSince1970: TimeInterval(dateDouble/1000))
        }
        
        return nil
    }
    
    func transformToJSON(_ value: Date?) -> Double? {
        
        if let value = value {
            
            return Double(value.timeIntervalSince1970*1000)
        }
        
        return nil
    }
}

class ListTransform<T: RealmSwift.Object>: TransformType where T: Mappable {
    
    public init() { }
    
    public typealias Object = List<T>
    public typealias JSON = Array<Any>
    
    public func transformFromJSON(_ value: Any?) -> List<T>? {
        if let objects = Mapper<T>().mapArray(JSONObject: value) {
            let list = List<T>()
            list.append(objectsIn: objects)
            return list
        }
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        return value?.flatMap { $0.toJSON() }
    }
    
}

class ListTransformString: TransformType {
    
    typealias Object = List<String>
    typealias JSON = Array<String>
    
    func transformFromJSON(_ value: Any?) -> List<String>? {
        
        if let arrayString = value as? Array<String> {
            
            let listString = List<String>()
            
            listString.append(objectsIn: arrayString)
            
            return listString
        }
        
        return nil
    }
    
    func transformToJSON(_ value: List<String>?) -> Array<String>? {
        
        if let value = value {
            
            var arrayString = Array<String>()
            
            for singleString in value {
                
                arrayString.append(singleString)
            }
            
            return arrayString
        }
        
        return nil
    }
}
