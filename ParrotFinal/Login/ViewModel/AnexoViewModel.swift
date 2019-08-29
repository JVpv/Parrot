 
 import Foundation
 import UIKit
 
 struct AnexoView {
    
    var id = ""
    var contentType = ""
    var url = ""
    var fileName = ""
    var idThumbnail = ""
    var urlThumbnail = ""
    var tipo: TipoAnexo = .imagem
 }
 
 enum TipoAnexo {
    
    case opengraph
    case documento
    case video
    case imagem
    case audio
    
    static func getType(_ contentType: String) -> TipoAnexo {
        
        if contentType.contains("opengraph") {
            return .opengraph
        } else if contentType.contains("image") {
            return .imagem
        } else if contentType.contains("audio") {
            return .audio
        } else if contentType.contains("video") {
            return .video
        } else {
            return .documento
        }
    }
 }
 
 class AnexoViewModel {
    
    static private func getAnexoAsView(anexo: Anexo, idPublicacao: Int) -> AnexoView {
        
        var anexoView = AnexoView()
        anexoView.tipo = TipoAnexo.getType(anexo.contentType)
        anexoView.id = anexo.id
        anexoView.fileName = anexo.fileName
        anexoView.url = anexo.url
        anexoView.idThumbnail = anexo.idThumbnail
        anexoView.urlThumbnail = anexo.urlThumbnail
        
        if anexoView.tipo == .opengraph {
            anexoView.url = self.getOpenpraghURL(idPublicacao: idPublicacao)
            anexoView.urlThumbnail = self.getOpenpraghImage(idPublicacao: idPublicacao)
        }
        
        return anexoView
    }
    
    static func returnAnexoInFormatRequest(anexo: Anexo) -> AnexoRequest {
        
        let anexorequest: AnexoRequest = self.popularAnexosRequest(anexo: anexo)
        
        return anexorequest
    }
    
    static func popularAnexosRequest(anexo: Anexo) -> AnexoRequest {
        
        let anexoRequest = AnexoRequest()
        
        anexoRequest.id = anexo.id
        anexoRequest.contentType = anexo.contentType
        anexoRequest.fileName = anexo.fileName
        
        if !anexo.idThumbnail.isEmpty {
            
            anexoRequest.idThumbnail = anexo.idThumbnail
        }
        
        return anexoRequest
    }
    
    static func getAnexosAsView(idPublicacao: Int) -> [AnexoView] {
        
        var anexos: [AnexoView] = []
        
        if let postagem = uiRealm.objects(Postagem.self).filter("id = \(idPublicacao)").first {
        
            for result in postagem.anexo {
                if self.validarAnexo(contentType: result.contentType) {
                    anexos.append(self.getAnexoAsView(anexo: result.detached(), idPublicacao: idPublicacao))
                }
            }
        }
        return anexos
    }
    
    static func getAnexos(idPublicacao: Int) -> [Anexo] {
        
        var anexos: [Anexo] = []
        
        if let publicacao = PostagemViewModel.getPublicacao(idPublicacao)?.detached() {
            
            for anexo in publicacao.anexo {
                
                if !anexo.contentType.contains("opengraph") {
                    
                    anexos.append(anexo)
                }
            }
        }
        
        return anexos
    }
    
    static func getOpengraph(idPublicacao: Int) -> [Anexo] {
    
        var anexos: [Anexo] = []
        
        if let publicacao = PostagemViewModel.getPublicacao(idPublicacao)?.detached() {
            
            for anexo in publicacao.anexo {
                
                if !anexo.contentType.contains("opengraph") {
                    
                    anexos.append(anexo)
                }
            }
        }
        
        return anexos
    }
    
    static func validarAnexo(contentType: String) -> Bool {
        
        if TipoAnexo.getType(contentType) != .opengraph {
            return true
        } else if contentType == "opengraph/imagem" {
            return true
        } else {
            return false
        }
    }
    
    private static func getOpenpraghURL(idPublicacao: Int) -> String {
        
        if let publicacao = PostagemViewModel.getPublicacao(idPublicacao) {
            if let anexoLink = publicacao.anexo.filter({$0.contentType == "opengraph/link"}).first {
                return anexoLink.id
            }
        }
        return ""
    }
    
    private static func getOpenpraghImage(idPublicacao: Int) -> String {
        
        if let publicacao = PostagemViewModel.getPublicacao(idPublicacao) {
            if let anexoLink = publicacao.anexo.filter({$0.contentType == "opengraph/imagem"}).first {
                return anexoLink.id
            }
        }
        return ""
    }
}
