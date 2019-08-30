//
//  PrincipalViewController.swift
//  Treinamento-iOS
//
//  Created by administrador on 26/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit
import Kingfisher
import Photos

class PrincipalViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    

    @IBOutlet weak var background_view: UIView!
    @IBOutlet weak var status_tv: UITextView!
    @IBOutlet weak var postagens_tbv: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fotoPerfil: UIImageView!
    
    var postagensView: [PostagemView] = []
    var autoresView: [AutorView] = []
    var strings: [[String]] = []
    var pagina: Int = 1
    
    var data: Data?
    var fileName: String?
    var mimeType: String?
    
    let imagePicker = UIImagePickerController()
    
    var service: PostagemService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        status_tv.textColor = UIColor.lightGray
        
        self.service = PostagemService.init(delegate: self)
        
        background_view.layer.cornerRadius = 10
        
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.service.listagemPostagens(pagina: self.pagina)
        
        if let foto = SessionControl.user?.foto {
            self.fotoPerfil.kf.setImage(with: baseURL + foto as? Resource)}
    }
    
    
    @IBAction func postar_Status(_ sender: Any) {
        if let status = status_tv.text{
            
            if let imagem = imageView.image {
                
                data = imagem.jpegData(compressionQuality: 0.9)
                let nonOptionalData: Data! = data
                self.mimeType = self.getMimeType(for: nonOptionalData)
            }
                let parameters = [
                                    "mensagem": status,
                                 ] as [String : Any]
            service.postStatus(data: self.data, fileName: self.fileName ?? "foto.jpeg", mimeType: self.mimeType ?? "image/jpeg", parameters: parameters)
        }
        self.postagens_tbv.reloadData()
    }
    
    @IBAction func adicionar_foto(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            
            if let pickedImageURL = info[UIImagePickerController.InfoKey.referenceURL] as? URL {
                let result = PHAsset.fetchAssets(withALAssetURLs: [pickedImageURL], options: nil)
                let asset = result.firstObject
                self.fileName = asset?.value(forKey: "filename") as? String
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupTableView() {
        self.postagens_tbv.delegate = self
        self.postagens_tbv.dataSource = self
        self.postagens_tbv.register(cellType: PostagemCell.self)
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.postagensView.count {
            self.pagina += 1
            self.service.listagemPostagens(pagina: self.pagina)
            self.postagens_tbv.reloadData()
        }
    }
}

extension PrincipalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.postagensView.count
    }
    
    func tableView(_ postagens_tbv: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postagens_tbv.dequeueReusableCell(for: indexPath) as PostagemCell
        cell.bind(postagem: self.postagensView[indexPath.row])
        cell.delegate = self
        return cell
    }
 }

extension PrincipalViewController: PostagemServiceDelegate {
    func failure(error: String) {
        
        print(error)
    }
    
    func success() {
        
        self.postagensView = PostagemViewModel.getAll()
        self.postagens_tbv.reloadData()
    }
}

extension PrincipalViewController: PostagemCellDelegate {
    func darLike(id: Int, curtido: Bool) {
        
        self.service.curtir(id: id, curtido: curtido)
        
    }
    
    func showOptions(id: Int) {
        
        let optionMenu = UIAlertController(title: nil, message: "Escolhe", preferredStyle: .actionSheet)
        
        let deletar = UIAlertAction(title: "Apagar", style: .default) { (action) in
            self.service.deletarStatus(id: id)
        }
        
        let editar = UIAlertAction(title: "Editar", style: .default) { (action) in
            let controller = StoryboardScene.Postagem.editarPostagemViewController.instantiate()
            controller.id = id
            self.present(controller, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(deletar)
        optionMenu.addAction(editar)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
}
