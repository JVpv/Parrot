//
//  AnexoPickedView.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 21/08/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import UIKit
import Reusable

protocol AnexoPickedViewDelegate {
    func AnexoPicked(anexo: AnexoRequest?)
}

class AnexoPickedView: UIView, NibOwnerLoadable {
    
    var delegate: AnexoPickedViewDelegate!

    @IBOutlet weak var collectionView: UICollectionView!
    
    var pickerFileManager: PickerFileManager!
    
    var files: [AnexoControle] = []
    
    var id: Int? {
        didSet {
            self.popularCollection()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.loadNibContent()
        
        self.configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadNibContent()
        
        self.configure()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configure()
    }
    
    init (frame: CGRect, viewController: UIViewController) {
        super.init(frame: frame)
        
        self.loadNibContent()
        
        self.configure()
        
        self.createPicker(viewController: viewController)
    }
    
    func configure() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(cellType: AnexoPickerCollectionCell.self)
    }
    
    func popularCollection() {
        
        if let id = self.id {
            
            let anexos = AnexoViewModel.getAnexos(idPublicacao: id)
            
            for anexo in anexos {
                
                var file = AnexoControle()
                file.id = self.files.count
                file.anexoObjeto = anexo
                file.urlImage = anexo.url
                file.isUploading = false
                
                self.files.append(file)
            }
        }
        
        self.pickerFileManager.setInitialId(id: self.files.count)
        
        self.collectionView.reloadData()
    }

    func createPicker(viewController: UIViewController) {
     
        self.pickerFileManager = PickerFileManager(viewController: viewController)
        
        self.delegate = self as! AnexoPickedViewDelegate
    }
}

extension AnexoPickedView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.files.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let anexoControle = self.files[indexPath.row]
        
        let cell = self.collectionView.dequeueReusableCell(for: indexPath) as AnexoPickerCollectionCell
        
        cell.bind(anexo: anexoControle, delegate: self)
        
        return cell
    }
}

extension AnexoPickedView: AnexoPickerCollectionCellDelegate {
    
    func deleteAnexo(id: Int) {
        
        if let index = self.files.index(where: {$0.id == id}) {
            
            self.files.remove(at: index)
        }
        
        self.collectionView.reloadData()
    }
}

extension AnexoPickedView: PickerFileManagerDelegate {
    
    func picked(anexo: AnexoControle) {
        
        var anexoControle = anexo
        anexoControle.isUploading = true
        
        self.files.append(anexoControle)
        
        self.collectionView.reloadData()
    }
    
    func uploadSuccess(anexo: Anexo, id: Int) {
        
        if let index = self.files.index(where: {$0.id == id}) {
            
            self.files[index].anexoObjeto = anexo
            
            self.files[index].isUploading = false
        }
        
        //self.delegate.AnexoPicked(anexo: )
        
        self.collectionView.reloadData()
    }
    
    func uploadFailure(id: Int, error: String) {
        
        if let index = self.files.index(where: {$0.id == id}) {
            
            self.files.remove(at: index)
        }
        
        self.collectionView.reloadData()
    }
}
