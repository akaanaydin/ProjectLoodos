//
//  AppDelegate.swift
//  akaLoodosCase
//
//  Created by Kaan AYDIN on 20.10.2022.
//

import UIKit
import SnapKit
import Kingfisher

class MovieTableCell: UITableViewCell {
    
    // MARK: - Identifier
    enum Identifier: String {
        case custom = "cellIdentifier"
    }
    //MARK: - UI Elements
    private let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.appBlack
        view.layer.cornerRadius = 12
        view.layer.shadowColor = Color.appWhite.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 12
        return view
    }()
    
    private let movieImage: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    private let cellRightArrow: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "arrow.right")
        iv.tintColor = Color.appWhite
        return iv
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        return label
    }()
    
    private let releaseYearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        return label
    }()
    
    
    private let movieTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing   = 5.0
        return stackView
    }()
    
    //MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    private func configure() {
        subviews()
        drawDesign()
        configureConstraits()
    }
    
    private func drawDesign() {
        contentView.backgroundColor = .lightGray.withAlphaComponent(0.05)
    }
    
    private func subviews() {
        contentView.addSubview(baseView)
        contentView.addSubview(movieImage)
        contentView.addSubview(cellRightArrow)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(movieTypeLabel)
        stackView.addArrangedSubview(movieNameLabel)
        stackView.addArrangedSubview(releaseYearLabel)
    }
    //MARK: - Datas for Cell
    func saveMovieModel(model: Search) {
        // Release Year
        guard let text = model.year else { return }
        releaseYearLabel.text = text
        // Vote
        guard let type = model.type else { return }
        movieTypeLabel.text = type.firstUppercased
        
        // Movie Name
        movieNameLabel.text = model.title
        // Movie Image
        guard let posterURL = model.poster else { return }
        movieImage.kf.setImage(with: URL(string: posterURL))
    }
    
}
//MARK: - SnapKit Extensions
extension MovieTableCell {
    private func configureConstraits() {
        baseView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(30)
        }
        
        movieImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.bottom.equalTo(baseView.snp.bottom).inset(15)
            make.left.equalTo(baseView.snp.left).offset(15)
            make.width.equalTo(baseView).multipliedBy(0.36)
        }
        
        cellRightArrow.snp.makeConstraints { make in
            make.centerY.equalTo(baseView)
            make.right.equalToSuperview().inset(25)
            make.width.equalTo(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(cellRightArrow)
            make.left.equalTo(movieImage.snp.right).offset(5)
            make.right.equalTo(cellRightArrow.snp.left).offset(-5)
        }
    }
}
