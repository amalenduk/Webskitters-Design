//
//  MenuViewModel.swift
//  Webskitters
//
//  Created by Amalendu Kar on 05/06/21.
//

import Foundation

protocol MenuViewModelDelegate: AnyObject {
    func didGetResponseForPlannig(is error: Error?)
}

final class MenuViewModel: ViewModel {
    
    // MARK: - Properties
    
    var roleViewModels: [MenuNestedTableViewCellViewModel] = []
    
    var selectedSection: Int?
    
    weak var delegate: MenuViewModelDelegate?
    
    var isFetching: Bool = false
    
    private var roles: [Role]? = [] {
        didSet {
            roleViewModels.removeAll()
            roleViewModels = roles?.map({ MenuNestedTableViewCellViewModel(role: $0) }) ?? []
        }
    }
    
    private var networking: Networking!
    
    init() {
        networking = Networking()
    }
    
    // MARK: - Addional Helper Functions
    
    func getPlanings() {
        isFetching = true
        networking.getRoles { [weak self] (result) in
            guard let strongSelf = self else { return }
            strongSelf.isFetching = false
            switch result {
            case .success(let data):
                strongSelf.roles = data.data
                strongSelf.delegate?.didGetResponseForPlannig(is: nil)
            case .failure(let error):
                strongSelf.delegate?.didGetResponseForPlannig(is: error)
            }
        }
    }
    
    func getReladbleSections(newSelected section: Int) -> [Int] {
        var reloadable: [Int] = []
        if let selectedSection = selectedSection {
            if section == selectedSection {
                self.selectedSection = nil
            }else {
                self.selectedSection = section
                reloadable.append(section)
            }
            roleViewModels[selectedSection].selectedObjectiveIndex = nil
            reloadable.append(selectedSection)
        }else {
            selectedSection = section
            reloadable.append(section)
        }
        return reloadable
    }
}
