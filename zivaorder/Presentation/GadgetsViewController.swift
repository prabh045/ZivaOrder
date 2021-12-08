//
//  GadgetsViewController.swift
//  zivaorder
//
//  Created by Prabhdeep Singh on 06/12/21.
//

import UIKit

class GadgetsViewController: UIViewController {
    //MARK: Properties
    private lazy var gadgetTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GadgetTableViewCell.self, forCellReuseIdentifier: GadgetTableViewCell.getResuseIdentifier())
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private var gadgetViewModel = GadgetsViewModel(productsRepo: DefaultProductsRepositroy())
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setUI()
        setViewModels()
    }
    
    //MARK: Set up UI
    private func setUI() {
        setGadgetsTableView()
    }
    
    private func setGadgetsTableView() {
        view.addSubview(gadgetTableView)
        gadgetTableView.backgroundColor = .systemGray2
        let safelayout = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            gadgetTableView.leadingAnchor.constraint(equalTo: safelayout.leadingAnchor),
            gadgetTableView.topAnchor.constraint(equalTo: safelayout.topAnchor),
            gadgetTableView.trailingAnchor.constraint(equalTo: safelayout.trailingAnchor),
            gadgetTableView.bottomAnchor.constraint(equalTo: safelayout.bottomAnchor),
        ])
    }
    
    private func setViewModels() {
        gadgetViewModel.bind { [weak self] in
            DispatchQueue.main.async {
                self?.gadgetTableView.reloadData()
            }
        }
        gadgetViewModel.fetchProducts()
    }
}
//MARK: TableView Extension
extension GadgetsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gadgetViewModel.getProductsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let gadgetCell = tableView.dequeueReusableCell(withIdentifier: GadgetTableViewCell.getResuseIdentifier(), for: indexPath) as? GadgetTableViewCell else {
            fatalError("No gadget cell found. Terminating app")
        }
        gadgetCell.setData(name: gadgetViewModel.getProductName(at: indexPath.row),
                           price: gadgetViewModel.getProductPrice(at: indexPath.row),
                           rating: gadgetViewModel.getProductRating(at: indexPath.row), imageUrl: gadgetViewModel.getProductImageUrl(at: indexPath.row))
        return gadgetCell
    }
}
