//
//  AppDelegate.swift
//  akaLoodosCase
//
//  Created by Kaan AYDIN on 20.10.2022.
//

import UIKit
import SnapKit
import Kingfisher

class MovieDetailController: UIViewController {
    
    //MARK: - Flip Animation Enums
    private enum Side {
        case head
        case tail
    }
    //MARK: - Properties
    
    // Flip Card Active Side
    private var currentSide: Side = .head
    // Data
    private var detailResults: MovieDetailModel
    
    //MARK: - UI Elements
    private let movieImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.layer.borderColor = Color.appWhite.cgColor
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    private let containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let detailView : UIView = {
        let view = UIView()
        view.backgroundColor = Color.appBlack
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.layer.cornerRadius = 30
        view.layer.borderColor = Color.appWhite.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let voteView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray.withAlphaComponent(0.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = false
        view.layer.cornerRadius = 40
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 5
        return view
    }()
    
    private let voteLabel: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.numberOfLines = 0
        label.text = "Release Date"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let releaseDate: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private let runtimeLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.numberOfLines = 0
        label.text = "Runtime"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let runtime: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 5.0
        return stackView
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.text = """
        👆🏼
        Please touch the poster to see details
        """
        return label
    }()
    
    init(detailResults: MovieDetailModel) {
        self.detailResults = detailResults
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Functions
    func configure() {
        addSubviews()
        drawDesign()
        tapGesture()
        configureConstraits()
    }
    // Design
    func drawDesign() {
        // View
        view.backgroundColor = Color.appBlack
        // Navigation Bar
        guard let type = detailResults.type else { return }
        navigationItem.title = "\(String(describing: type)) Detail".firstUppercased
        // Nil Control
        guard let vote = detailResults.imdbRating, let date = detailResults.released, let time = detailResults.runtime else { return }
        // Image
        guard let movieImageURL = detailResults.poster else { return }
        let urlImage = URL(string: movieImageURL)
        movieImage.kf.setImage(with: urlImage)
        // Label Text
        titleLabel.text = detailResults.title
        overviewLabel.text = detailResults.plot
        releaseDate.text = "\(String(describing: date))"
        runtime.text = "\(String(describing: time)) min"
        // Label Multiline Text
        voteLabel.text = """
        VOTE
        \(String(describing: vote))
        """
    }
    // Subviews
    func addSubviews() {
        view.addSubview(containerView)
        view.addSubview(informationLabel)
        containerView.addSubview(movieImage)
        containerView.addSubview(voteView)
        containerView.addSubview(detailView)
        containerView.addSubview(voteLabel)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(overviewLabel)
        stackView.addArrangedSubview(releaseDateLabel)
        stackView.addArrangedSubview(releaseDate)
        stackView.addArrangedSubview(runtimeLabel)
        stackView.addArrangedSubview(runtime)
        
    }
    // Tap Gesture for Flip Animation
    func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapContainer))
        containerView.addGestureRecognizer(tapGesture)
    }
    // Labels Visibilty Status
    func hideLabels(_ status: Bool){
        titleLabel.isHidden = status
        overviewLabel.isHidden = status
        releaseDateLabel.isHidden = status
        releaseDate.isHidden = status
        runtimeLabel.isHidden = status
        runtime.isHidden = status
    }
    
    func reverseHideLabels(_ status: Bool){
        voteLabel.isHidden = status
        voteView.isHidden = status
        informationLabel.isHidden = status
    }
    // Selector for Tap Gesture
    @objc
    func tapContainer() {
        switch currentSide {
        case .head:
            UIView.transition(from: movieImage,
                              to: detailView,
                              duration: 1,
                              options: [.transitionFlipFromRight, .showHideTransitionViews],
                              completion: nil)
            currentSide = .tail
            hideLabels(false)
            reverseHideLabels(true)
        case .tail:
            UIView.transition(from: detailView,
                              to: movieImage,
                              duration: 1,
                              options: [.transitionFlipFromLeft, .showHideTransitionViews],
                              completion: nil)
            currentSide = .head
            hideLabels(true)
            reverseHideLabels(false)
        }
    }
}
//MARK: - SnapKit Extension
extension MovieDetailController {
    private func configureConstraits() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(200)
        }
        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(20)
            make.left.right.equalTo(containerView)
        }
        
        voteView.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(10)
            make.height.width.equalTo(80)
            make.right.equalTo(containerView).inset(10)
        }
        
        movieImage.snp.makeConstraints { make in
            make.center.equalTo(containerView)
            make.height.width.equalTo(containerView)
        }
        
        detailView.snp.makeConstraints { make in
            make.center.equalTo(containerView)
            make.height.width.equalTo(containerView)
        }
        
        voteLabel.snp.makeConstraints { make in
            make.center.equalTo(voteView)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.right.left.equalToSuperview()
        }
    }
}
