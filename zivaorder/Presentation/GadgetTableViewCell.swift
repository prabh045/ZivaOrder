//
//  GadgetTableViewCell.swift
//  zivaorder
//
//  Created by Prabhdeep Singh on 06/12/21.
//

import UIKit
import Kingfisher

class GadgetTableViewCell: UITableViewCell {
    static func getResuseIdentifier() -> String {
        return "GadgetTableViewCell"
    }
    //MARK: Properties
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var gadgetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .checkmark
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica Neue", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: "Helvetica Neue", size: 14)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: "Helvetica Neue", size: 12)
        label.textColor = UIColor.green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productDetailStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var cartActionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to Cart", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 14)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var buttonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: Initialisation methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setUI() {
        contentView.backgroundColor = UIColor.systemGray2
        contentView.addSubview(containerView)
        containerView.addSubview(gadgetImageView)
        containerView.addSubview(productDetailStack)
        productDetailStack.addArrangedSubview(nameLabel)
        productDetailStack.addArrangedSubview(priceLabel)
        productDetailStack.addArrangedSubview(ratingLabel)
        containerView.addSubview(buttonContainer)
        buttonContainer.addSubview(cartActionButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            //container View
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            //ImageView
            gadgetImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            gadgetImageView.centerYAnchor.constraint(equalTo: productDetailStack.centerYAnchor),
            gadgetImageView.heightAnchor.constraint(equalToConstant: 50),
            gadgetImageView.widthAnchor.constraint(equalToConstant: 50),
            //Detail Stack
            productDetailStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            productDetailStack.leadingAnchor.constraint(equalTo: gadgetImageView.trailingAnchor, constant: 15),
            productDetailStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            //Cart Button
            buttonContainer.topAnchor.constraint(equalTo: productDetailStack.bottomAnchor, constant: 15),
            buttonContainer.leadingAnchor.constraint(equalTo: gadgetImageView.leadingAnchor),
            buttonContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),
            cartActionButton.topAnchor.constraint(equalTo: buttonContainer.topAnchor, constant: 0),
            cartActionButton.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor, constant: 10),
            cartActionButton.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor, constant: -10),
            cartActionButton.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor, constant: 0),
        ])
    }
    
    func setData(name: String, price: String, rating: Int, imageUrl: String) {
        nameLabel.text = name
        priceLabel.text = price
        ratingLabel.text = "\(rating)"
        guard let url = URL(string: imageUrl) else {
           return
        }
        gadgetImageView.kf.setImage(with: url)
    }
}
