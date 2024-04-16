//
//  BeachListViewController.swift
//  ClimaEs
//
//  Created by Sergei Kornilov on 30/03/2024.
//

import UIKit
import SnapKit

class BeachListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BeachListTableViewCell.self, forCellReuseIdentifier: "beachListCell")
        return tableView
    }()
    var expandedIndexPath: IndexPath?
    
    var weatherDataForBeaches: [String: WeatherPrediction] = [:]
    
    
    //MARK: Load view
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleBeachAdded), name: NSNotification.Name("BeachAdded"), object: nil)
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewBeach))
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(mapBeach))
        navigationItem.rightBarButtonItems = [addButton, editButton]
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        
        setupConstraint()
        loadWeatherForFavoriteBeaches()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupBackground()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupConstraint() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
        }
    }
    
    @objc private func handleBeachAdded(notification: Notification) {
        if let newBeach = notification.object as? Beach {
            loadWeatherForNewFavoriteBeach(newBeach)
        }
    }
    
    private func loadWeatherForFavoriteBeaches() {
        let favoriteBeaches = BeachesStore.shared.favoriteBeaches
        for beach in favoriteBeaches {
            loadWeatherForNewFavoriteBeach(beach)
        }
    }
    
    private func loadWeatherForNewFavoriteBeach(_ beach: Beach) {
        NetworkManager.shared.getWeatherData(forCityId: beach.beachId) { [weak self] result in
            switch result {
            case .success(let weatherDataURL):
                NetworkManager.shared.fetchWeatherData(from: weatherDataURL) { fetchResult in
                    DispatchQueue.main.async {
                        switch fetchResult {
                        case .success(let weatherPrediction):
                            // Actualizar los datos meteorológicos de esta playa
                            self?.weatherDataForBeaches[beach.beachId] = weatherPrediction.first
                            self?.tableView.reloadData()
                            //if let index = BeachesStore.shared.favoriteBeaches.firstIndex(where: {$0.beachId == beach.beachId}) {
                            //let indexPath = IndexPath(row: index, section: 0)
                            //// Actualizar la celda asociada a esta playa
                            //self?.tableView.reloadRows(at: [indexPath], with: .automatic)
                            //}
                        case .failure(let error):
                            print("Error al cargar los datos meteorológicos: \(error)")
                        }
                    }
                }
            case .failure(let error):
                print("Error al recuperar la URL de los datos meteorológicos: \(error), ir a XML")
                NetworkManager.shared.loadWeatherDataFromXML(forBeachId: beach.beachId) { [weak self] result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let weatherPrediction):
                            self?.weatherDataForBeaches[beach.beachId] = weatherPrediction
                            self?.tableView.reloadData()
                            //if let index = BeachesStore.shared.favoriteBeaches.firstIndex(where: {$0.beachId == beach.beachId}) {
                            //let indexPath = IndexPath(row: index, section: 0)
                            //self?.tableView.reloadRows(at: [indexPath], with: .automatic)
                            //self?.tableView.reloadData()
                            //}
                        case .failure(let error):
                            print("Error al cargar datos meteorológicos desde XML: \(error)")
                        }
                    }
                }
            }
        }
    }
    
    
    //MARK: Func
    @objc func addNewBeach() {
        let addNewBeachVC = BeachAddViewController()
        let navigationController = UINavigationController(rootViewController: addNewBeachVC)
        present(navigationController, animated: true)
    }
    
    @objc func mapBeach() {
        let mapBeachVC = MapViewController()
        navigationController?.pushViewController(mapBeachVC, animated: true)
    }
    
}

// MARK: - UITableViewDataSource
extension BeachListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BeachesStore.shared.favoriteBeaches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "beachListCell", for: indexPath) as? BeachListTableViewCell else {
            fatalError("No se puede poner en cola BeachListTableViewCell")
        }
        let beach = BeachesStore.shared.favoriteBeaches[indexPath.row]
        let weather = weatherDataForBeaches[beach.beachId]
        cell.configure(with: beach, weather: weather)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension BeachListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == expandedIndexPath {
            return 200
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Manejo de la expansión/colapso celular
        expandedIndexPath = (expandedIndexPath == indexPath) ? nil : indexPath
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { [weak self] (_, _, completionHandler) in
            self?.weatherDataForBeaches.removeValue(forKey: BeachesStore.shared.favoriteBeaches[indexPath.row].beachId)
            BeachesStore.shared.favoriteBeaches.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            completionHandler(true)
        }
        
        if let customImage = UIImage(named: "trash-bin") {
            deleteAction.image = customImage
        }
        
        deleteAction.backgroundColor = .white
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
}

