//
//  SearchBarViewController.swift
//  EventHubApp
//
//  Created by Andrew Linkov on 25.11.2024.
//

import UIKit

protocol SearchBarViewPresenter: AnyObject {
}

final class SearchBarViewController: UIViewController {
    
    //MARK: - Properties
    private let presenter: SearchBarViewPresenter
    private var events = [SearchModel]()
    
    //MARK: - UI Components
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(SearchBarCell.self, forCellReuseIdentifier: SearchBarCell.reuseID)
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.rowHeight = 105
        return table
    }()
    
    //MARK: - Init
    init(presenter: SearchBarViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Setup Methods
    private func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - SearchBarViewController + UITableViewDataSource
extension SearchBarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchBarCell.reuseID, for: indexPath) as? SearchBarCell else {
            fatalError("Unable to dequeue SearchBarCell")
        }
        cell.set(info: events[indexPath.row])
        return cell
    }
}

//MARK: - SearchBarViewController + UITableViewDelegate
extension SearchBarViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Логика обработки выбора ячейки
    }
}

//MARK: - SearchBarViewController + UISearchBarDelegate
extension SearchBarViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Логика фильтрации или поиска при изменении текста
    }
}

extension SearchBarViewController: SearchViewDelegate {
    
}





