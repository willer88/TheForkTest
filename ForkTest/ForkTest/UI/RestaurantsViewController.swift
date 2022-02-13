//
//  RestaurantsViewController.swift
//  ForkTest
//
//  Created by Wilmar on 10/02/22.
//

import UIKit

enum SortTypes {
    case name
    case rating
    
    var title: String {
        switch self {
        case .name:
            return "Sort by Name"
        case .rating:
            return "Sort by Rating"
        }
    }
}

class RestaurantsViewController: UITableViewController {
    // MARK: Properties
    var viewModel: RestaurantsViewModel?
    var selectedSortType: SortTypes = .name
    var sortButton: UIBarButtonItem?
    
    // MARK: Lifecycle
    init(viewModel: RestaurantsViewModel) {
        self.viewModel = viewModel
        
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: RestaurantTableViewCell.cellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        
        sortButton = UIBarButtonItem(title: SortTypes.name.title, style: .plain, target: self, action: #selector(sortButtonTapped(barButtonItem:)))
        navigationItem.rightBarButtonItem = sortButton
        
        viewModel?.fetchRestaurants(completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.viewModel?.executeSorting(sortType: .name)
                    self.tableView.reloadData()
                case .failure(let error):
                    self.showErrorMessage(message: error.localizedDescription)
                }
            }
        })
    }
    // MARK: Events
    @objc func sortButtonTapped(barButtonItem: UIBarButtonItem) {
        selectedSortType = selectedSortType == .name ? .rating : .name
        sortButton?.title = selectedSortType.title
        viewModel?.executeSorting(sortType: selectedSortType)
        tableView.reloadData()
    }
}

// MARK: UITableViewDataSource
extension RestaurantsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.restaurants?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.cellIdentifier, for: indexPath) as? RestaurantTableViewCell else {
            preconditionFailure("RestaurantTableViewCell not found")
        }
        
        cell.delegate = self
        cell.configure(restaurantViewModel: viewModel?.restaurants?[indexPath.row])
        
        return cell
    }
}

// MARK: RestaurantTableViewCellDelegate
extension RestaurantsViewController: RestaurantTableViewCellDelegate {
    func didSelectFavorite(isSelected: Bool, restaurant: RestaurantViewModel) {
        guard let index = viewModel?.restaurants?.firstIndex(of: restaurant) else { return }
        viewModel?.restaurants?[index].isFavorite = isSelected
    }
}
