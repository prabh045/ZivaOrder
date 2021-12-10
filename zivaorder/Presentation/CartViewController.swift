//
//  CartViewController.swift
//  zivaorder
//
//  Created by Prabhdeep Singh on 08/12/21.
//

import UIKit

class CartViewController: UIViewController {
    //MARK: Properties
    private lazy var gadgetTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GadgetTableViewCell.self, forCellReuseIdentifier: GadgetTableViewCell.getResuseIdentifier())
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGreen
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private lazy var checkoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Checkout", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 14)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.systemYellow
        button.layer.cornerRadius = 7
        //button.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var gadgetViewModel = GadgetsViewModel(productsRepo: DefaultProductsRepositroy(), coreDataRepo: CoreDataRepo())
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        navigationItem.title = "My Cart"
        setUI()
        setViewModels()
    }
    
    //MARK: Set up UI
    private func setUI() {
        setGadgetsTableView()
        setupCheckoutButton()
        setupConstraints()
    }
    
    private func setGadgetsTableView() {
        view.addSubview(gadgetTableView)
    }
    
    private func setupCheckoutButton() {
        view.addSubview(checkoutButton)
    }
    
    private func setupConstraints() {
        let safelayout = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            gadgetTableView.leadingAnchor.constraint(equalTo: safelayout.leadingAnchor),
            gadgetTableView.topAnchor.constraint(equalTo: safelayout.topAnchor),
            gadgetTableView.trailingAnchor.constraint(equalTo: safelayout.trailingAnchor),
            gadgetTableView.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -10),
            checkoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkoutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.40),
            checkoutButton.heightAnchor.constraint(equalToConstant: 50),
            checkoutButton.bottomAnchor.constraint(equalTo: safelayout.bottomAnchor, constant: -15),
        ])
    }
    
    private func setViewModels() {
        gadgetViewModel.bind { [weak self] in
            DispatchQueue.main.async {
                self?.gadgetTableView.reloadData()
            }
        }
        gadgetViewModel.getCartItems()
    }
}
//MARK: TableView Extension
extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gadgetViewModel.getProductsCount(section: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let gadgetCell = tableView.dequeueReusableCell(withIdentifier: GadgetTableViewCell.getResuseIdentifier(), for: indexPath) as? GadgetTableViewCell else {
            fatalError("No gadget cell found. Terminating app")
        }
        gadgetCell.setData(
            name: gadgetViewModel.getProductName(at: indexPath, isForCart: true),
            price: gadgetViewModel.getProductPrice(at: indexPath, isForCart: true),
            rating: gadgetViewModel.getProductRating(at: indexPath, isForCart: true),
            imageUrl: gadgetViewModel.getProductImageUrl(at: indexPath, isForCart: true), handler: {}
        )
        gadgetCell.hideCartButton()
        return gadgetCell
    }
}
