//
//  CheckoutViewController.swift
//  zivaorder
//
//  Created by Prabhdeep Singh on 10/12/21.
//
import UIKit

class CheckoutViewController: UIViewController {
    //MARK: Properties
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = UIColor.white
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var orderPlacedLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Your order has been placed successfully"
        label.font = UIFont(name: "Helvetica Neue", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var orderMessageStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.lightGreen
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        showIndicator()
        hideIndicator()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(containerView)
        containerView.addSubview(orderMessageStack)
        orderMessageStack.addArrangedSubview(activityIndicator)
        orderMessageStack.addArrangedSubview(orderPlacedLabel)
    }
    
    private func setupConstraints() {
        let safelayout = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: safelayout.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: safelayout.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: safelayout.widthAnchor, multiplier: 0.60),
            containerView.heightAnchor.constraint(equalToConstant: 150),
            orderMessageStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            orderMessageStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            orderMessageStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            orderMessageStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),
        ])
    }
    
    private func hideIndicator() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            self.activityIndicator.stopAnimating()
            self.orderPlacedLabel.isHidden = false
        }
    }
    
    private func showIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.orderPlacedLabel.isHidden = true
        }
    }
}
