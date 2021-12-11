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
    private var gadgetViewModel = GadgetsViewModel(productsRepo: DefaultProductsRepositroy(), coreDataRepo: CoreDataRepo())
    var coordinator: HomeCoordinator?
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgroundColor
        setUI()
        setViewModels()
    }
    
    //MARK: Set up UI
    private func setUI() {
        navigationItem.title = "Gadgets"
        setGadgetsTableView()
        setBarButtonItem()
    }
    
    private func setGadgetsTableView() {
        view.addSubview(gadgetTableView)
        gadgetTableView.backgroundColor = Colors.backgroundColor
        let safelayout = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            gadgetTableView.leadingAnchor.constraint(equalTo: safelayout.leadingAnchor),
            gadgetTableView.topAnchor.constraint(equalTo: safelayout.topAnchor),
            gadgetTableView.trailingAnchor.constraint(equalTo: safelayout.trailingAnchor),
            gadgetTableView.bottomAnchor.constraint(equalTo: safelayout.bottomAnchor),
        ])
    }
    
    private func setBarButtonItem() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "cartIcon"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(goToCart), for: .touchUpInside)
        let cartButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = cartButton
    }
    
    @objc private func goToCart() {
        coordinator?.openCart()
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.frame.width, height: 50))
        label.backgroundColor = .init(red: 153/255, green: 255/255, blue: 204/255, alpha: 0.8)
        if section == 0 {
            label.text = "Less than 1000"
        } else {
            label.text = "Greater than 1000"
        }
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return gadgetViewModel.getSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gadgetViewModel.getProductsCount(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let gadgetCell = tableView.dequeueReusableCell(withIdentifier: GadgetTableViewCell.getResuseIdentifier(), for: indexPath) as? GadgetTableViewCell else {
            fatalError("No gadget cell found. Terminating app")
        }
        //gadgetCell.
        gadgetCell.setData(
            name: gadgetViewModel.getProductName(at: indexPath),
            price: gadgetViewModel.getProductPrice(at: indexPath),
            rating: gadgetViewModel.getProductRating(at: indexPath),
            imageUrl: gadgetViewModel.getProductImageUrl(at: indexPath), handler: { [weak self] in
                self?.gadgetViewModel.saveGadget(from: indexPath)
            }
        )
        return gadgetCell
    }
}
