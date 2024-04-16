//
//  Hooks.swift
//  ClimaEs
//
//  Created by Sergei Kornilov on 28/03/2024.
//

import UIKit

// MARK: - UIView ext
public extension UIView {
    
    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
}

// MARK: - UIColor ext
extension UIColor {
    convenience init(rgb: UInt) {
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
    }
}


extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data, using encoding: String.Encoding = .isoLatin1) throws -> T {
        guard let string = String(data: data, encoding: encoding) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "No se han podido descodificar los datos"))
        }
        
        guard let dataInUTF8 = string.data(using: .utf8) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Error al convertir los datos a UTF-8"))
        }
        
        return try self.decode(T.self, from: dataInUTF8)
    }
}

extension UIViewController {
    func setupBackground() {
        addBackgroundImage(named: "background")
        addBlurEffect()
        addColorOverlay(color: UIColor.white.withAlphaComponent(0.5))
    }
    
    private func addBackgroundImage(named imageName: String) {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: imageName)
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }
    
    private func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at: 1)
    }
    
    private func addColorOverlay(color: UIColor) {
        let overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = color
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(overlayView, at: 2)
    }
}
