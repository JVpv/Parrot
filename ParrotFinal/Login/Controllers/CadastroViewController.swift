//
//  CadastroViewController.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 29/07/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import UIKit
import Photos

class CadastroViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var name_tf: UITextField!
    @IBOutlet weak var username_tf: UITextField!
    @IBOutlet weak var email_tf: UITextField!
    @IBOutlet weak var password_tf: UITextField!
    @IBOutlet weak var confirm_tf: UITextField!
    @IBOutlet weak var enviarFoto: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    
    let imagePicker = UIImagePickerController()
    
    var data: Data?
    var fileName: String?
    var mimeType: String?
    
    var service: AutenticacaoService!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.service = AutenticacaoService.init(delegate: self)
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
    }
    
    
    @IBAction func Cadastro(_ sender: Any) {
        
        if let email = self.email_tf.text, let username = self.username_tf.text, let nome = self.name_tf.text, let senha = self.password_tf.text, let confirm = self.confirm_tf.text, !email.isEmpty && !senha.isEmpty && !username.isEmpty, !nome.isEmpty, !confirm.isEmpty {
            //self.service.postCadastro(nome: nome, username: username, email: email, password: senha)
            if let imagem = imageView.image {
                data = imagem.jpegData(compressionQuality: 0.9)}
            let nonOptionalData: Data! = data
            self.mimeType = self.getMimeType(for: nonOptionalData)
            let parameters = ["nome": nome,
                              "username": username,
                              "email": email,
                              "password": senha,
                ] as [String : Any]
            service.postCadastro(data: self.data, fileName: self.fileName ?? "foto.jpeg", mimeType: self.mimeType ?? "image/jpeg", parameters: parameters)
        }
    }
    @IBAction func enviarFoto(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        if let pickedImageURL = info[UIImagePickerController.InfoKey.referenceURL] as? URL {
            let result = PHAsset.fetchAssets(withALAssetURLs: [pickedImageURL], options: nil)
            let asset = result.firstObject
            self.fileName = asset?.value(forKey: "filename") as? String
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func getMimeType(for data: Data) -> String {
        
        var b: UInt8 = 0
        data.copyBytes(to: &b, count: 1)
        
        switch b {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x4D, 0x49:
            return "image/tiff"
        case 0x25:
            return "application/pdf"
        case 0xD0:
            return "application/vnd"
        case 0x46:
            return "text/plain"
        default:
            return "application/octet-stream"
        }
    }
}

extension CadastroViewController: AutenticacaoServiceDelegate {
    
    func success() {
        
        self.navigationController?.popViewController(animated: true)
        ScreenManager.setupInitialViewController()
    }
    func failure(error: String) {
        print(error)
    }
}
