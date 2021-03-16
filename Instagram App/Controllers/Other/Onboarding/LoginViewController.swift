//
//  LoginViewController.swift
//  Instagram App
//
//  Created by Dilan Pramodya on 2021-03-10.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    struct Constant {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constant.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let password: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constant.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constant.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let terms = UIButton()
        terms.setTitle("Terms of Service", for: .normal)
        terms.setTitleColor(.secondaryLabel, for: .normal)
        return terms
    }()
    
    private let privacyButton: UIButton = {
        let privacy = UIButton()
        privacy.setTitle("Privacy Policy", for: .normal)
        privacy.setTitleColor(.secondaryLabel, for: .normal)
        return privacy
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("New User? Create an Account...", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backGroundImageView = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backGroundImageView)
        return header
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton .addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        
        usernameEmailField.delegate = self
        password.delegate = self
        
        addSubViews()

        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //Assign frames
        headerView.frame = CGRect(
            x: 0,
            y: 0.0,
            width: view.width,
            height: view.height/3.0)
        
        usernameEmailField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 40,
            width: view.width - 50,
            height: 52.0)
        
        password.frame = CGRect(
            x: 25,
            y: usernameEmailField.bottom + 10,
            width: view.width - 50,
            height: 52.0)
        
        loginButton.frame = CGRect(
            x: 25,
            y: password.bottom + 10,
            width: view.width - 50,
            height: 52.0)
        
        createAccountButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 10,
            width: view.width - 50,
            height: 52.0)
        
        termsButton.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 100,
            width: view.width - 20,
            height: 50.0)
        
        privacyButton.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 50,
            width: view.width - 20,
            height: 50.0)
        
        configureHeaderView()
         
    }
     
    public func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
        }
        
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        
        //Add logo
        let textImage = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(textImage)
        textImage.contentMode = .scaleAspectFit
        textImage.frame = CGRect(
            x: headerView.width/4.0 ,
            y: view.safeAreaInsets.top,
            width: headerView.width/2.0,
            height: headerView.height - view.safeAreaInsets.top)
    }
    
    private func addSubViews() {
        view.addSubview(usernameEmailField)
        view.addSubview(password)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(headerView)
        view.addSubview(createAccountButton)
    }
    
    @objc private func didTapLoginButton() {
        password.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
              let pw = password.text, !pw.isEmpty, pw.count >= 8 else {
            return
        }
        //Login functionality
        var username: String?
        var email: String?
        
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            //Email
            email = usernameEmail
        }
        else {
            //Username
            username = usernameEmail
        }
        
        AuthManager.shared.loginUser(username: username, email: email, password: pw) { success in
            DispatchQueue.main.async {
                if success {
                    //Log on
                    self.dismiss(animated: true, completion: nil)
                }
                else {
                    //Error
                    let alert = UIAlertController(
                        title: "Login Error",
                        message: "WEe were unable to log you in",
                        preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(
                                        title: "Dismiss",
                                        style: .cancel,
                                        handler: nil))
                    
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc private func didTapTermsButton() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870?helpref=page_content") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapPrivacyButton() {
        guard let url = URL(string: "https://help.instagram.com/519522125107875") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapCreateAccountButton() {
        let vc = SingUpViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc ), animated: true)
        
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            password.becomeFirstResponder()
        }
        else if textField == password {
            didTapLoginButton()
        }
        return true
    }
}
