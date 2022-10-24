//
//  SplashScreen.swift
//  akaLoodosCase
//
//  Created by Kaan AYDIN on 24.10.2022.
//

import UIKit
import FirebaseRemoteConfig
import SnapKit

class SplashScreen: UIViewController {

    // MARK: View
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 30)
        return title
    }()
    
    // MARK: Properties
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        checkInternetConnection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

// MARK: - Public funcs

extension SplashScreen {
    
    func checkInternetConnection() {
        NetworkMonitor.shared.isConnected ? configure() : showAlert(message: "No Internet Connection")
    }
    
    func configure() {
        addSubviews()
        configureConstraits()
        getValueFromFirebase(withExpirationDuration: 0)
        pushToMainVC(time: 3)
    }
    
    private func addSubviews() {
        view.addSubview(titleLabel)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Title", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {
                UIAlertAction in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    func pushToMainVC(time: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.navigationController?.push(viewController: MovieController(), transitionType: .fade, duration: 0.5)
        }
    }
    
    func getValueFromFirebase(withExpirationDuration: TimeInterval) {
        
        let setting = RemoteConfigSettings()
        setting.minimumFetchInterval = 0
        remoteConfig.configSettings = setting
        
        self.remoteConfig.fetch(withExpirationDuration: withExpirationDuration) { status, error in
            if status == .success, error == nil {
                self.remoteConfig.activate { [weak self] isSucces, error in
                    guard let self = self, error == nil else {
                        return
                    }
                    
                    if let value = self.remoteConfig.configValue(forKey: Constant.FirebaseConsant.REMOTE_CONFIG_KEY).stringValue {
                        DispatchQueue.main.async {
                            self.titleLabel.text = value
                        }
                    }
                }
            } else {
            }
        }
    }
}

//MARK: - Snapkit Extension
extension SplashScreen {
    private func configureConstraits() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
