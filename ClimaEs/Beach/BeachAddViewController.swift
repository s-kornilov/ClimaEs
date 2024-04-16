//
//  BeachAddViewController.swift
//  ClimaEs
//
//  Created by Sergei Kornilov on 30/03/2024.
//

import UIKit

class BeachAddViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    lazy var filteredBeaches = [Beach]()
    var isSearchActive = false
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .magenta
        filteredBeaches = beaches
        
        setupSearchBar()
        setupTableView()
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        view.addSubview(searchBar)
        searchBar.toAutoLayout()

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "beachCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "placeholderCell")
    }
    
    // MARK: - UISearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearchActive = !searchText.isEmpty
        filteredBeaches = searchText.isEmpty ? [] : beaches.filter { $0.beachName.localizedCaseInsensitiveContains(searchText) }
        tableView.reloadData()
    }
    
    // MARK: - UITable
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? filteredBeaches.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSearchActive {
            let cell = tableView.dequeueReusableCell(withIdentifier: "beachCell", for: indexPath)
            let beach = filteredBeaches[indexPath.row]
            cell.textLabel?.text = "\(beach.beachName), \(beach.cityName)"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "placeholderCell", for: indexPath)
            // Настройте ячейку с изображением здесь
            cell.imageView?.image = UIImage(named: "lupa")

            cell.textLabel?.text = "" // Очистите текст, если он не нужен
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearchActive && !filteredBeaches.isEmpty {
            // Получаем выбранный пляж из отфильтрованного списка
            let beach = filteredBeaches[indexPath.row]
            // Добавляем этот пляж в избранное
            BeachesStore.shared.addFavoriteBeach(beach)
            print("#BeachAddVC: Total de playas conservadas: \(BeachesStore.shared.favoriteBeaches.count)")
            NotificationCenter.default.post(name: NSNotification.Name("BeachAdded"), object: beach)

        }
        self.dismiss(animated: true, completion: nil)
    }
}
