//
//  RestaurantTableViewCell.swift
//  ForkTest
//
//  Created by Wilmar on 10/02/22.
//

import UIKit

protocol RestaurantTableViewCellDelegate: AnyObject {
    func didSelectFavorite(isSelected: Bool, restaurant: RestaurantViewModel)
}

class RestaurantTableViewCell: UITableViewCell {
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var addressLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var restaurantImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    var favoriteIcon: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "empty-heart"), for: .normal)
        button.setBackgroundImage(UIImage(named: "filled-heart"), for: .selected)
        button.addTarget(self, action: #selector(onFavorite(button:)), for: .touchUpInside)
        
        return button
    }()
    
    static let cellIdentifier = "RestaurantTableViewCellIdentifier"
    var viewModel: RestaurantViewModel?
    weak var delegate: RestaurantTableViewCellDelegate?
    
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(restaurantImage)
        contentView.addSubview(favoriteIcon)
        
        NSLayoutConstraint.activate([
            restaurantImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            restaurantImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            restaurantImage.heightAnchor.constraint(equalToConstant: 100),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 20),
            favoriteIcon.widthAnchor.constraint(equalToConstant: 20),
            favoriteIcon.leadingAnchor.constraint(equalTo: restaurantImage.trailingAnchor, constant: 5),
            favoriteIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            favoriteIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: restaurantImage.bottomAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            ratingLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            ratingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(restaurantViewModel: RestaurantViewModel?) {
        viewModel = restaurantViewModel
        nameLabel.text = restaurantViewModel?.name
        ratingLabel.text = restaurantViewModel?.formattedRating
        addressLabel.text = restaurantViewModel?.address
        favoriteIcon.isSelected = restaurantViewModel?.isFavorite ?? false
        
        guard let imageURL = restaurantViewModel?.imageURL else { return }
        restaurantImage.image(fromURL: imageURL)
    }
    
    @objc func onFavorite(button: UIButton) {
        button.isSelected.toggle()
        guard let viewModel = viewModel else { return }
        delegate?.didSelectFavorite(isSelected: button.isSelected, restaurant: viewModel)
    }
}
