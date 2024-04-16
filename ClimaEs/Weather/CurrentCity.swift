//
//  CurrentCity.swift
//  ClimaEs
//
//  Created by Sergei Kornilov on 29/03/2024.
//

import UIKit
import SnapKit

class CurrentCity: UIView {
    
    
    
    func currentDate() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM yyyy"
        let dateString = formatter.string(from: now)
        return dateString
    }
    
    
    let itemIcon: UIImageView = {
        let itemIconView = UIImageView(image: UIImage(named: "clear"))
        itemIconView.toAutoLayout()
        itemIconView.clipsToBounds = true
        itemIconView.backgroundColor = .white
        itemIconView.layer.cornerRadius = 10
        return itemIconView
    }()
    
    let itemTemperature: UILabel = {
        let itemLabel = UILabel()
        itemLabel.toAutoLayout()
        itemLabel.font = UIFont(name: "Lato-Bold", size: 62)
        itemLabel.text = "23 °C"
        return itemLabel
    }()
    
    let itemPerceivedTemp: UILabel = {
        let itemValue = UILabel()
        itemValue.toAutoLayout()
        itemValue.font = UIFont(name: "Lato-Regular", size: 14)
        itemValue.text = "17 °C"
        return itemValue
    }()
    
    lazy var itemCurrentDate: UILabel = {
        let itemValue = UILabel()
        
        itemValue.toAutoLayout()
        itemValue.font = UIFont(name: "Lato-Regular", size: 14)
        itemValue.text = self.currentDate()
        return itemValue
    }()
    
    
    //MARK: Init
    init() {
        super.init(frame: .zero)
        addSubviews(itemIcon, itemTemperature, itemPerceivedTemp, itemCurrentDate)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraints() {
        itemTemperature.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
        }
        
        itemIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(100)
        }
        
        itemPerceivedTemp.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(itemIcon.snp.bottom).offset(20)
        }
        
        itemCurrentDate.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(itemPerceivedTemp.snp.bottom).offset(20)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
    }
    
}
