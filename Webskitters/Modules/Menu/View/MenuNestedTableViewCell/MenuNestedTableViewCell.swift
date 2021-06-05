//
//  MenuNestedTableViewCell.swift
//  Webskitters
//
//  Created by Amalendu Kar on 05/06/21.
//

import UIKit

protocol MenuNestedTableViewCellDelegate: AnyObject {
    func didChangeHeight(for cell: MenuNestedTableViewCell)
}

class MenuNestedTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: TableView!
    
    // MARK: - Properties
    
    var viewModel: MenuNestedTableViewCellViewModel! {
        didSet {
            guard viewModel != nil else {
                return
            }
            setupTableView()
        }
    }
    
    weak var delegate: MenuNestedTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Additional Helper Functions
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        tableView.isScrollEnabled = false
        
        tableView.register(UINib(nibName: "MenuResultsTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuResultsTableViewCell")
        tableView.register(UINib(nibName: "MenuObjectiveTableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "MenuObjectiveTableHeaderView")
    }
}

// MARK: - UITableViewDelegate

extension MenuNestedTableViewCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UITableViewDataSource

extension MenuNestedTableViewCell: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.role.objectives.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let selectedObjectiveIndex = viewModel.selectedObjectiveIndex, selectedObjectiveIndex == section {
            return viewModel.role.objectives[selectedObjectiveIndex].results.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuResultsTableViewCell", for: indexPath) as? MenuResultsTableViewCell else {
            fatalError()
        }
        cell.textLabel?.text = viewModel.role.objectives[indexPath.section].results[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MenuObjectiveTableHeaderView") as? MenuObjectiveTableHeaderView else {
            fatalError()
        }
        view.tag = section
        view.delegate = self
        var isSelected: Bool = false
        if let selectedObjectiveIndex = viewModel.selectedObjectiveIndex {
            isSelected = section == selectedObjectiveIndex
        }
        view.configure(with: viewModel.role.objectives[section], isSelected: isSelected)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

// MARK: - MenuObjectiveTableHeaderViewDelegate

extension MenuNestedTableViewCell: MenuObjectiveTableHeaderViewDelegate {
    
    func didTapOnHeaderView(on view: MenuObjectiveTableHeaderView) {
        var reloadable: [Int] = []
        if let selectedObjectiveIndex = viewModel.selectedObjectiveIndex {
            if selectedObjectiveIndex == view.tag {
                viewModel.selectedObjectiveIndex = nil
            }else {
                viewModel.selectedObjectiveIndex = view.tag
                reloadable.append(view.tag)
            }
            reloadable.append(selectedObjectiveIndex)
        }else {
            viewModel.selectedObjectiveIndex = view.tag
            reloadable.append(view.tag)
        }
        tableView.reloadSections(IndexSet(reloadable), with: .automatic)
        contentView.layoutIfNeeded()
        tableView.layoutIfNeeded()
        delegate?.didChangeHeight(for: self)
    }
}
