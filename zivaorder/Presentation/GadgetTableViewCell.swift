//
//  GadgetTableViewCell.swift
//  zivaorder
//
//  Created by Prabhdeep Singh on 06/12/21.
//

import UIKit
class GadgetTableViewCell: UITableViewCell {
    static func getResuseIdentifier() -> String {
        return "GadgetTableViewCell"
    }
    //MARK: Properties
    private lazy var gadgetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .checkmark
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name Label"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "INR 200"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "Five Star"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productDetailStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        contentView.addSubview(gadgetImageView)
        contentView.addSubview(productDetailStack)
        productDetailStack.addArrangedSubview(nameLabel)
        productDetailStack.addArrangedSubview(priceLabel)
        productDetailStack.addArrangedSubview(ratingLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            gadgetImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            gadgetImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            gadgetImageView.heightAnchor.constraint(equalToConstant: 30),
            gadgetImageView.widthAnchor.constraint(equalToConstant: 30),
            productDetailStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            productDetailStack.leadingAnchor.constraint(equalTo: gadgetImageView.trailingAnchor, constant: 15),
            productDetailStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    func setData(name: String, price: String, rating: Int) {
        nameLabel.text = name
        priceLabel.text = price
        ratingLabel.text = "\(rating)"
    }
}
