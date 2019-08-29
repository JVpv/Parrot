//
//  PickerFileManager.swift
//  Unifor Mobile
//
//  Created by Breno Aquino on 05/03/18.
//  Copyright © 2018 NATI. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation
import Photos
import AVKit

protocol PickerFileManagerDelegate: class {
    
    func picked(anexo: AnexoControle)
    func uploadSuccess(anexo: Anexo, id: Int)
    func uploadFailure(id: Int, error: String)
}

class PickerFileManager: NSObject {
    
    var viewController: UIViewController!
    
    var service: AnexoService!
    
    var idControler: Int = 0
    
    weak var delegate: PickerFileManagerDelegate?
    
    init(viewController: UIViewController) {
        super.init()
        
        self.viewController = viewController
        
        
        self.service = AnexoService(delegate: self)
    }
    
    // MARK: - General Functions
    func setInitialId(id: Int) {
        
        self.idControler = id
    }
    
    func picketAll(_ url: URL) {
        
        var error: String?
        
        let fileName:String = AnexosUtils.nameOfPath(url: url)
        let fileExtension = AnexosUtils.lastPathExtension(fileName: fileName)
        let mimeType: String = AnexosUtils.mimeTypeFromFileExtension(fileExtension: fileExtension)!
        let fileType: FileTypeAnexo = AnexosUtils.firstPathType(fileName: mimeType)
        
        var novo = AnexoControle()
        novo.id = self.idControler
        novo.anexoObjeto.fileName = fileName
        novo.anexoObjeto.contentType = mimeType
        novo.data = try! Data(contentsOf: url)
        
        guard let size = AnexosUtils.getSize(file: novo.data) else {
            return
        }
        
        
                    
                    if let dataImage = try? Data(contentsOf: url) {
                        
                        let image = UIImage(data: dataImage)!
                        
                        novo.data = UIImageJPEGRepresentation(image, 0.25)!
                        novo.anexoImage = UIImage(data: novo.data)!
                    }
        
        
        if let error = error {
            
            self.alertError(error)
            
        } else {
            
            self.idControler += 1
            self.service.postAnexo(anexoControle: novo)
            self.delegate?.picked(anexo: novo)
        }
    }
    
    // MARK: - Call Functions
    func photo() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            myPickerController.mediaTypes = [kUTTypeImage as String]
            self.viewController.present(myPickerController, animated: true)
        }
    }
    
    func camera() {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .camera
            myPickerController.mediaTypes = [kUTTypeImage as String]
            self.viewController.present(myPickerController, animated: true)
        }
    }
    
    func movie() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            myPickerController.mediaTypes = [kUTTypeMovie as String]
            self.viewController.present(myPickerController, animated: true)
        }
    }
    
    func doc() {
        
        let importMenu = UIDocumentMenuViewController(documentTypes: [kUTTypePDF as String], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .fullScreen
        
        self.viewController.present(importMenu, animated: true)
    }
    
    func otherFile() {
        
        let importMenu = UIDocumentMenuViewController(documentTypes: [kUTTypeContent as String], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .fullScreen
        
        self.viewController.present(importMenu, animated: true)
    }
}

// MARK: - MidiaPicker
extension PickerFileManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func getFileName(info: [String : Any]) -> String {
        
        if let imageURL = info[UIImagePickerControllerReferenceURL] as? URL {
            
            let result = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
            
            let asset = result.firstObject
            
            let fileName = asset?.value(forKey: "filename")
            
            if let fileString = fileName as? String {
                
                let fileUrl = URL(string: fileString)
                
                if let name = fileUrl?.lastPathComponent {
                    
                    return name
                }
            }
        }
        
        return "asset.JPG"
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var error: String?
        
        let fileName = self.getFileName(info: info)
        let mimeTypeExtension = AnexosUtils.lastPathExtension(fileName: fileName)
        let mimeType: String = AnexosUtils.mimeTypeFromFileExtension(fileExtension: mimeTypeExtension)!
        
        var novo = AnexoControle()
        novo.id = self.idControler
        novo.anexoObjeto.fileName = fileName
        novo.anexoObjeto.contentType = mimeType
        
        // MARK: Photo
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            novo.data = UIImageJPEGRepresentation(image, 0.25)!
            novo.anexoImage = image
            
            guard let size = AnexosUtils.getSize(file: novo.data) else {
                return
            }
        }

        
        if let error = error {
            
            self.alertError(error)
        }
        
        self.viewController.dismiss(animated: true)
    }
}

// MARK: - DocumentPicker
extension PickerFileManager: UIDocumentMenuDelegate, UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        self.picketAll(url)
    }
    
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        self.viewController.present(documentPicker, animated: true, completion: nil)
    }
}

// MARK: - Alerts
extension PickerFileManager {
    
    private func configure(alert: UIAlertController) {
            
            alert.addAction(UIAlertAction(title: "Fotos", style: .default, handler: { (_) in
                self.photo()
            }))
            
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
                self.camera()
            }))
    }
    
    func showOptions() {
        
            let alert = UIAlertController(title: "Anexar", message: nil, preferredStyle: .actionSheet)
            
            self.configure(alert: alert)
            
            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
            
            self.viewController.present(alert, animated: true)
    }
    
    func showOptions(barButton: UIBarButtonItem) {
            
            let alert = UIAlertController(title: "Anexar", message: nil, preferredStyle: .actionSheet)
            
            self.configure(alert: alert)
            
            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
                
                if let popoverController = alert.popoverPresentationController {
                    
                    popoverController.barButtonItem = barButton
                    popoverController.permittedArrowDirections = UIPopoverArrowDirection.up
                }
            
            self.viewController.present(alert, animated: true)
        
    }
    
    func alertError(_ message: String) {
        
        let alertAction = UIAlertController(title: "Aviso", message: message, preferredStyle: .alert)
        
        alertAction.addAction(UIAlertAction(title: "Fechar", style: .cancel , handler: nil))
        
        self.viewController.present(alertAction, animated: true, completion: nil)
    }
}

// MARK: - AnexoDelegate
extension PickerFileManager: AnexoServiceDelegate {
    func postAnexoFailure(idAnexo: Int, error: String) {
        self.delegate?.uploadFailure(id: idAnexo, error: "Falha na postagem de um anexo")
    }
    
    
    func postAnexoSuccess(idAnexo: Int, anexo: Anexo) {
        
        self.delegate?.uploadSuccess(anexo: anexo, id: idAnexo)
    }
    
    func progressUpload(idAnexo: Int, progress: String) {
        
        print(progress)
    }
}
