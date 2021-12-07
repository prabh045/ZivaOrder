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
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GadgetTableViewCell.self, forCellReuseIdentifier: GadgetTableViewCell.getResuseIdentifier())
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setUI()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Set up UI
    private func setUI() {
        setGadgetsTableView()
    }
    
    private func setGadgetsTableView() {
        view.addSubview(gadgetTableView)
        let safelayout = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            gadgetTableView.leadingAnchor.constraint(equalTo: safelayout.leadingAnchor),
            gadgetTableView.topAnchor.constraint(equalTo: safelayout.topAnchor),
            gadgetTableView.trailingAnchor.constraint(equalTo: safelayout.trailingAnchor),
            gadgetTableView.bottomAnchor.constraint(equalTo: safelayout.bottomAnchor),
        ])
    }
}
//MARK: TableView Extension
extension GadgetsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let gadgetCell = tableView.dequeueReusableCell(withIdentifier: GadgetTableViewCell.getResuseIdentifier(), for: indexPath) as? GadgetTableViewCell else {
            fatalError("No gadget cell found. Terminating app")
        }
        return gadgetCell
    }
}
