//
//  WeatherView.swift
//  ClimaEs
//
//  Created by Sergei Kornilov on 28/03/2024.
//

import UIKit

class ItemCellView: UIView {
    let itemIconView: UIImageView = {
        let itemIconView = UIImageView(image: UIImage(systemName: "play.circle.fill"))
        itemIconView.toAutoLayout()
        itemIconView.clipsToBounds = true
        itemIconView.backgroundColor = .white
        itemIconView.layer.cornerRadius = 10
        return itemIconView
    }()
    
    let itemLabel: UILabel = {
        let itemLabel = UILabel()
        itemLabel.toAutoLayout()
        itemLabel.font = UIFont(name: "Lato-Regular", size: 14)
        itemLabel.text = "Label"
        return itemLabel
    }()
    
    let itemValue: UILabel = {
        let itemValue = UILabel()
        itemValue.toAutoLayout()
        itemValue.font = UIFont(name: "Lato-Regular", size: 14)
        itemValue.text = "Value"
        return itemValue
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(itemIconView, itemLabel, itemValue)
        setupItemView()
        self.backgroundColor = UIColor(rgb: 0xD0BCFF)
        self.layer.cornerRadius = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupItemView() {
        itemIconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        itemLabel.snp.makeConstraints { make in
            make.leading.equalTo(itemIconView.snp.trailing).offset(20)
            make.top.equalToSuperview().offset(5)
            make.trailing.lessThanOrEqualToSuperview().offset(-20)
        }
        
        itemValue.snp.makeConstraints { make in
            make.leading.equalTo(itemIconView.snp.trailing).offset(20)
            make.top.equalTo(itemLabel.snp.bottom).offset(5)
            make.trailing.lessThanOrEqualToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}


class WeatherView: UIView {
    
    let windCell = ItemCellView()
    let rainCell = ItemCellView()
    let pressureCell = ItemCellView()
    let uvCell = ItemCellView()
    
    
    //MARK: Init
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupForecastInfo()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupForecastInfo() {
        windCell.itemIconView.image = UIImage(systemName: "humidity")
        rainCell.itemIconView.image = UIImage(systemName: "cloud.rain")
        pressureCell.itemIconView.image = UIImage(systemName: "thermometer")
        uvCell.itemIconView.image = UIImage(systemName: "sun.max")
        
        let forecastInfoFirstLine = UIStackView(arrangedSubviews: [windCell, rainCell])
        forecastInfoFirstLine.distribution = .fillEqually
        forecastInfoFirstLine.spacing = 10
        
        let forecastInfoSecondLine = UIStackView(arrangedSubviews: [pressureCell, uvCell])
        forecastInfoSecondLine.distribution = .fillEqually
        forecastInfoSecondLine.spacing = 10
        
        let forecastInfoStack = UIStackView(arrangedSubviews: [forecastInfoFirstLine, forecastInfoSecondLine])
        forecastInfoStack.axis = .vertical
        forecastInfoStack.spacing = 10
        forecastInfoStack.toAutoLayout()
        
        addSubview(forecastInfoStack)
        
        forecastInfoStack.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(safeAreaLayoutGuide.snp.right).offset(-20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
    }
    
}
