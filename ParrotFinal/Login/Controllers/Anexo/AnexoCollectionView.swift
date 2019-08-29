//
//  AnexoCollectionView.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 26/08/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import UIKit
import Reusable

class AnexoCollectionView: UIView, NibOwnerLoadable {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var anexos: [AnexoView] = [] {
        didSet {
                self.pageControl.numberOfPages = anexos.count
                self.collectionView.reloadData()
                self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    func setupCollection() {
        
        collectionView.register(cellType: AnexoCollectionViewCell.self)
        collectionView.backgroundColor = UIColor.clear
        self.backgroundColor = .clear
    }
    
    func clear() {
        
        self.anexos = []
        self.collectionView.reloadData()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNibContent()
        self.setupCollection()
    }
    
    init(frame: CGRect, usuario: UsuarioView) {
        super.init(frame: frame)
        self.loadNibContent()
        self.setupCollection()
    }
}

extension AnexoCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.anexos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 10, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let anexo = self.anexos[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: AnexoCollectionViewCell.self)
        
        cell.bind(anexo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let anexo = self.anexos[indexPath.item]
        
        if let window = UIApplication.shared.keyWindow, let controller = window.rootViewController {
            
           // VisualizacaoAnexo.mostrarAnexo(anexo: anexo, sender: controller)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageWidth = scrollView.frame.size.width
        
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        
        self.pageControl.currentPage = page
    }
}
