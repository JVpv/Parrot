//
//  AnexoService.swift
//  Unifor Mobile
//
//  Created by Breno Aquino on 06/03/18.
//  Copyright © 2018 NATI. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import RealmSwift
import SwiftyJSON

protocol AnexoServiceDelegate: class {
    
    func postAnexoSuccess(idAnexo: Int, anexo: Anexo)
    func postAnexoFailure(idAnexo: Int, error: String)
    
    func progressUpload(idAnexo: Int, progress: String)
}

class AnexoService {
    
    weak var delegate: AnexoServiceDelegate?
    
    required init(delegate: AnexoServiceDelegate) {
        
        self.delegate = delegate
    }
    
    func postAnexo(anexoControle: AnexoControle) {
        
        Alamofire.upload(multipartFormData: { (multipartFormData: MultipartFormData) in
            
            multipartFormData.append(anexoControle.data, withName: anexoControle.anexoObjeto.fileName, fileName: anexoControle.anexoObjeto.fileName, mimeType: anexoControle.anexoObjeto.contentType)
            
        }, to: baseURL + "discussao/anexo", method: .post, headers: SessionControl.headers) { (encodingResult: SessionManager.MultipartFormDataEncodingResult) in
            
            switch encodingResult {
                
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress: Progress) in
                    
                    self.delegate?.progressUpload(idAnexo: anexoControle.id, progress: "\(progress.fractionCompleted)")
                })
                
                upload.validate().responseArray (keyPath: "data") { (response: DataResponse<[Anexo]>) in
                    
                    switch response.result {
                        
                    case .success:
                        
                        if let anexo = response.result.value!.first {
                            
                            self.delegate?.postAnexoSuccess(idAnexo: anexoControle.id, anexo: anexo)
                            
                        } else {
                            
                            self.delegate?.postAnexoFailure(idAnexo: anexoControle.id, error: "Falha em postar o anexo")
                        }
                        
                    case .failure(let error):
                        
                        print(error.localizedDescription)
                    }
                }
                
            case .failure(let encodingError):
                
                print(encodingError.localizedDescription)
            }
        }
    }
}
