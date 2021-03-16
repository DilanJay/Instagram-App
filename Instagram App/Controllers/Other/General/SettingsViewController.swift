//
//  SettingsViewController.swift
//  Instagram App
//
//  Created by Dilan Pramodya on 2021-03-10.
//

import UIKit
import SafariServices

struct SettingsCellModel {
    let title: String
    let handler: (() -> Void)
}

///ViewController to show user settings
final class SettingsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SettingsCellModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        data.append([
            SettingsCellModel(title: "Edit Profile") { [weak self] in
                self?.didTapEditProfile()
            },
            SettingsCellModel(title: "Invite Friends") { [weak self] in
                self?.didTapInviteFriends()
            },
            SettingsCellModel(title: "Save") { [weak self] in
                self?.didTapSave()
            }
        ])
        
        data.append([
            SettingsCellModel(title: "Terms of Service") { [weak self] in
                self?.openURL(type: .terms)
            },
            SettingsCellModel(title: "Privacy Policy") { [weak self] in
                self?.openURL(type: .privacy)
            },
            SettingsCellModel(title: "Help / Feedback") { [weak self] in
                self?.openURL(type: .help)
            }
        ])
        
        data.append([
            SettingsCellModel(title: "Log Out") { [weak self] in
                self?.didTapLogOut()
            }
        ])
    }
    
    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        present(navVc, animated: true)
    }
    
    private func didTapInviteFriends() {
        //Show share sheet to invite friends
    }
    
    private func didTapSave() {
        
    }
    
    enum SettingsURLType {
        case terms, privacy, help
    }
    
    private func openURL(type: SettingsURLType) {
        let urlString: String
        switch type {
        case .terms: urlString = "https://help.instagram.com/581066165581870?helpref=page_content"
        case .privacy: urlString = "https://help.instagram.com/519522125107875"
        case .help: urlString = "https://help.instagram.com"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }

    private func didTapLogOut() {
        let actionSheet = UIAlertController(
            title: "Log Out",
            message: "Are you sure you want to Log Out",
            preferredStyle: .actionSheet )
        
        actionSheet.addAction(UIAlertAction(
                                title: "Cancel",
                                style: .cancel,
                                handler: nil))
        
        actionSheet.addAction(UIAlertAction(
                                title: "Log Out",
                                style: .destructive,
                                handler: { _ in
                                    AuthManager.shared.logOut(completion: {success in
                                        DispatchQueue.main.async {
                                            if success {
                                                //Show login
                                                let loginVc = LoginViewController()
                                                loginVc.modalPresentationStyle = .fullScreen
                                                self.present(loginVc, animated: true) {
                                                    self.navigationController?.popToRootViewController(animated: false)
                                                    self.tabBarController?.selectedIndex = 0
                                                }
                                            }
                                            else {
                                                //Error
                                                fatalError("Could not log out user")
                                            }
                                        }
                                    })
                                }))
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds

        
        present(actionSheet, animated: true)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         //Handle cell selection
        data[indexPath.section][indexPath.row].handler()
    }
    
}
