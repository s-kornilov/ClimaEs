//
//  BeachListTableViewCell.swift
//  ClimaEs
//
//  Created by Sergei Kornilov on 30/03/2024.
//

import UIKit

class BeachListTableViewCell: UITableViewCell {
    
    //MARK: Set UI elements
    lazy var itemBeachName: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Lato-Regular", size: 17)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var itemBeachCity: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Lato-Regular", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var itemFirstDayMaxTemperature: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Lato-Bold", size: 24)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var itemFirstDayThermalSensation: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Lato-Regular", size: 10)
        label.numberOfLines = 0
        return label
    }()
    lazy var itemFirstDayWaterTemperature: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Lato-Regular", size: 10)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var itemFirstDayUVIndex: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Lato-Regular", size: 10)
        label.numberOfLines = 0
        return label
    }()
    
    
    private let backgroundContainerView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    //MARK: Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    //MARK: Func
    private func setupViews() {
        contentView.addSubview(backgroundContainerView)
        backgroundContainerView.addSubviews(itemBeachName, itemBeachCity, itemFirstDayMaxTemperature, itemFirstDayThermalSensation, itemFirstDayWaterTemperature, itemFirstDayUVIndex )

        backgroundContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        itemBeachName.snp.makeConstraints { make in
            make.top.equalTo(backgroundContainerView.snp.top).offset(10)
            make.leading.equalTo(backgroundContainerView.snp.leading).offset(10)
        }
        
        itemBeachCity.snp.makeConstraints { make in
            make.top.equalTo(itemBeachName.snp.bottom).offset(5)
            make.leading.equalTo(backgroundContainerView.snp.leading).offset(10)
        }
        
        itemFirstDayMaxTemperature.snp.makeConstraints { make in
            make.top.equalTo(backgroundContainerView.snp.top).offset(5)
            make.trailing.equalTo(backgroundContainerView.snp.trailing).offset(-10)
        }
        
        itemFirstDayThermalSensation.snp.makeConstraints { make in
            make.top.equalTo(itemFirstDayMaxTemperature.snp.bottom).offset(5)
            make.trailing.equalTo(backgroundContainerView.snp.trailing).offset(-10)
        }
        
        itemFirstDayWaterTemperature.snp.makeConstraints { make in
            make.top.equalTo(itemFirstDayThermalSensation.snp.bottom).offset(5)
            make.trailing.equalTo(backgroundContainerView.snp.trailing).offset(-50)
        }
        
        itemFirstDayUVIndex.snp.makeConstraints { make in
            make.top.equalTo(itemFirstDayThermalSensation.snp.bottom).offset(5)
            make.leading.equalTo(itemFirstDayWaterTemperature.snp.trailing).offset(5)
            make.trailing.equalTo(backgroundContainerView.snp.trailing).offset(-10)
        }
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
    
    
    func configure(with beach: Beach, weather: WeatherPrediction?) {
        print("El tiempo: \(String(describing: weather?.prediccion.day.first?.maximumTemperature.valor1))")
        itemBeachName.text = beach.beachName
        itemBeachCity.text = beach.cityName

            
            if let weather = weather, let firstDayPrediction = weather.prediccion.day.first {
                let firstDayMaxTemperature = firstDayPrediction.maximumTemperature.valor1
                let firstDayThermalSensation = firstDayPrediction.thermalSensation.descripcion1
                let firstDayWaterTemperature = firstDayPrediction.waterTemperature.valor1
                let firstDayUVIndex = firstDayPrediction.maximumUV.valor1
                
                itemFirstDayMaxTemperature.text = "\(firstDayMaxTemperature)°C"
                itemFirstDayThermalSensation.text = "\(firstDayThermalSensation)"
                itemFirstDayWaterTemperature.text = "\(firstDayWaterTemperature)°C"
                itemFirstDayUVIndex.text = "UV = \(firstDayUVIndex)"
                
            } else {
                itemFirstDayMaxTemperature.text = "N/A"
            }
    }
    
}
