//
//  MenuViewController.swift
//  Webskitters
//
//  Created by Amalendu Kar on 05/06/21.
//

import UIKit

class MenuViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var menuTableView: TableView!
    
    // MARK: - Properties
    
    var viewModel: MenuViewModel!
    
    // MARK: - Lifecycle
    
    // Custom initializers go here
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewModel == nil { viewModel = MenuViewModel() }
        viewModel.delegate = self
        
        setupTableView()
    }
    
    // MARK: - Layout
    
    private func setupTableView() {
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.tableFooterView = UIView()
        menuTableView.showsVerticalScrollIndicator = false
        menuTableView.showsHorizontalScrollIndicator = false
        
        menuTableView.register(UINib(nibName: "MenuNestedTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuNestedTableViewCell")
        menuTableView.register(UINib(nibName: "RoleTableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "RoleTableHeaderView")
        
        menuTableView.rowHeight = UITableView.automaticDimension
        menuTableView.estimatedRowHeight = 100
        
        menuTableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        menuTableView.sectionHeaderHeight = 100
        
        menuTableView.refreshControl = UIRefreshControl()
        menuTableView.refreshControl?.addTarget(self, action: #selector(pullTorefresh(_ :)), for: .valueChanged)
        
        getPlanings()
    }
    
    // MARK: - User Interaction
    
    @objc func pullTorefresh(_ sender: UIRefreshControl) {
        getPlanings()
    }
    
    // MARK: - Additional Helpers
    
    private func getPlanings() {
        menuTableView.refreshControl?.beginRefreshing()
        viewModel.getPlanings()
    }
}


// MARK: - UITableViewDelegate

extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UITableViewDataSource

extension MenuViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.roleViewModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let selectedSection = viewModel.selectedSection, selectedSection == section {
            return viewModel.roleViewModels[selectedSection].objectives.count > 0 ? 1 : 0
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuNestedTableViewCell", for: indexPath) as? MenuNestedTableViewCell else {
            fatalError()
        }
        cell.viewModel = viewModel.roleViewModels[indexPath.section]
        cell.delegate = self
        cell.tableView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RoleTableHeaderView") as? RoleTableHeaderView else {
            fatalError()
        }
        view.tag = section
        view.delegate = self
        var isSelected: Bool = false
        if let selectedSection = viewModel.selectedSection {
            isSelected = section == selectedSection
        }
        view.configure(with: viewModel.roleViewModels[section].role, isSelected: isSelected)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

// MARK: - RoleTableHeaderViewDelgate

extension MenuViewController: RoleTableHeaderViewDelgate {
    
    func didTapOnHeaderView(on view: RoleTableHeaderView) {
        let reloadable: [Int] = viewModel.getReladbleSections(newSelected: view.tag)
        menuTableView.reloadSections(IndexSet(reloadable), with: .automatic)
    }
}

// MARK: - MenuNestedTableViewCellDelegate

extension MenuViewController: MenuNestedTableViewCellDelegate {
    
    func didChangeHeight(for cell: MenuNestedTableViewCell) {
        menuTableView.beginUpdates()
        menuTableView.endUpdates()
    }
}

// MARK: - MenuViewModelDelegate

extension MenuViewController: MenuViewModelDelegate {
    
    func didGetResponseForPlannig(is error: Error?) {
        menuTableView.refreshControl?.endRefreshing()
        if let error = error {
            showAlert(with: "Error", message: error.localizedDescription)
        }
        menuTableView.reloadData()
    }
}
