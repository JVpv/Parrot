//
//  PickerUtils.swift
//  Unifor Mobile
//
//  Created by Breno Aquino on 05/03/18.
//  Copyright © 2018 NATI. All rights reserved.
//

import Foundation
import MobileCoreServices
import UIKit

let IMAGE_MAX_SIZE = 5.0
let AUDIO_MAX_SIZE = 10.0
let VIDEO_MAX_SIZE = 20.0

struct AnexoControle {
    
    var id: Int = -1
    var anexoImage = UIImage()
    var urlImage: String = ""
    var data = Data()
    var anexoObjeto = Anexo()
    var isUploading: Bool = false
}

enum FileTypeAnexo: String {
    
    case image = "image"
    case video = "video"
    case audio = "audio"
    case outros = ""
    
    var legend: String {
        
        switch self {
        case .image:
            return "A imagem"
        case .audio:
            return "O audio"
        case .video:
            return "O vídeo"
        default:
            return ""
        }
    }
}
    var maxSize: Double {
        
        return IMAGE_MAX_SIZE
    }

class AnexosUtils {
    
    static func getSize(file: Data) -> Double? {
        
        let byteCount =  file.count
        
        let megabytes = Double(byteCount)/1024.0/1024.0
        
        return Double(String(format: "%.2f", megabytes))!
    }
    
    static func nameOfPath(url: URL) -> String {
        
        let fileName:String = url.lastPathComponent
        
        return fileName
    }
    
    static func firstPathType(fileName: String) -> FileTypeAnexo {
        
        let arrayFileName = fileName.components(separatedBy: "/")
        let fileType = arrayFileName[0]
        
        if let type = FileTypeAnexo(rawValue: fileType) {
            return type
        }
        
        return FileTypeAnexo.outros
    }
    
    static func lastPathExtension(fileName: String) -> String {
        
        let arrayFileName = fileName.components(separatedBy: ".")
        let mimeTypeExtension = arrayFileName[(arrayFileName.count - 1)]
        
        return mimeTypeExtension
    }
    
    static func mimeTypeFromFileExtension(fileExtension: String) -> String? {
        
        guard let uti: CFString = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension as NSString, nil)?.takeRetainedValue() else {
            return nil
        }
        
        guard let mimeType: CFString = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() else {
            return "application/octet-stream"
        }
        
        return mimeType as String
    }
}
