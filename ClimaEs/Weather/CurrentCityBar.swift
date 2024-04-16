//
//  CurrentCityBar.swift
//  ClimaEs
//
//  Created by Sergei Kornilov on 29/03/2024.
//

import UIKit
import SnapKit

class CurrentCityBar: UIView {
    
    let currentCityIconView: UIImageView = {
        let currentCityIconView = UIImageView(image: UIImage(systemName: "location.fill"))
        currentCityIconView.toAutoLayout()
        currentCityIconView.clipsToBounds = true
        return currentCityIconView
    }()
    
    let currentCityLabel: UILabel = {
        let currentCityLabel = UILabel()
        currentCityLabel.toAutoLayout()
        currentCityLabel.font = UIFont(name: "Lato-Regular", size: 14)
        currentCityLabel.text = "Benalmadena"
        return currentCityLabel
    }()
    
    
    //MARK: Init
    init() {
        super.init(frame: .zero)
        addSubviews(currentCityIconView, currentCityLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        currentCityIconView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(5)
            make.width.height.equalTo(20)
            make.bottom.equalToSuperview()
        }
        
        currentCityLabel.snp.makeConstraints { make in
            make.leading.equalTo(currentCityIconView.snp.trailing).offset(5)
            make.top.bottom.equalToSuperview().offset(5)
            make.trailing.lessThanOrEqualToSuperview().offset(-5)
        }
    }
    
}
