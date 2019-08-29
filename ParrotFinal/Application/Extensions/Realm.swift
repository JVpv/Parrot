//
//  Realm.swift
//  Unifor Mobile
//
//  Created by Thiago Diniz on 14/09/17.
//  Copyright © 2017 NATI. All rights reserved.
//

import Foundation

import RealmSwift
import ObjectMapper

extension Realm {
    
    static func clearDatabase() {
        
        do {
            
            try uiRealm.write {
                
                uiRealm.deleteAll()
            }
            
        } catch  {
            
            print("Não foi possível excluir o banco de dados.")
        }
    }
    
    static func showPath() {
        
        if SessionControl.isDebug() {
            
            if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last?.path {
                
                print("\nDOCUMENTS >> \(url)")
            }
        }
    }
    
    private static var applicationDocumentsDirectory: URL = {
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return urls[urls.count-1]
        
    }()
    
    static func clearDocumentsFolder() {
        
        let fileManager = FileManager.default
        
        let tempFolderPath = applicationDocumentsDirectory.path
        
        do {
            
            let filePaths = try fileManager.contentsOfDirectory(atPath: tempFolderPath)
            
            for filePath in filePaths {
                
                let url = "\(tempFolderPath)/\(filePath)"
                
                try fileManager.removeItem(atPath: url)
            }
            
        } catch {
            
            print("Could not clear temp folder: \(error)")
        }
    }
    
    func deleteRecursive<T: Object>(_ list: List<T>) {
        list.forEach({ deleteRecursive($0) })
    }
    
    func deleteRecursive<T: Object>(_ results: Results<T>) {
        results.forEach({ deleteRecursive($0) })
    }
    
    func deleteRecursive<T: Object>(_ entity: T) {
        
        var objects = Set<Object>()
        objects.insert(entity)
        
        while !objects.isEmpty {
            
            let object = objects.removeFirst()
            if object.isInvalidated {
                continue
            }
            
            object.objectSchema.properties.forEach { (property) in
                guard let value = object.value(forKey: property.name) else {
                    return
                }
                
                if let rlmObject = value as? Object {
                    objects.insert(rlmObject)
                } else if let listObjects = value as? RealmSwift.ListBase {
                    for i in 0..<listObjects.count {
                        if let rlmObject = listObjects._rlmArray.object(at: UInt(i)) as? Object {
                            objects.insert(rlmObject)
                        }
                    }
                }
            }
            
            self.delete(object)
        }
    }
}


protocol DetachableObject: AnyObject {
    
    func detached() -> Self
    
}

extension Object: DetachableObject {
    
    func detached() -> Self {
        
        let detached = type(of: self).init()
        
        for property in objectSchema.properties {
            
            guard let value = value(forKey: property.name) else {
                
                continue
            }
            
            if let detachable = value as? DetachableObject {
                
                detached.setValue(detachable.detached(), forKey: property.name)
                
            } else {
                
                detached.setValue(value, forKey: property.name)
            }
        }
        return detached
    }
}
