//
//  SingUpViewController.swift
//  Instagram App
//
//  Created by Dilan Pramodya on 2021-03-10.
//

import UIKit

class SingUpViewController: UIViewController {
    
    struct Constant {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username..."
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
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email Address..."
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

    
    private let passwordField: UITextField = {
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
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constant.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signUpButton)

        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        signUpButton.addTarget(self,
                               action: #selector(didTapSignUp),
                               for: .touchUpInside)
        
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        usernameField.frame = CGRect(
            x: 20,
            y: view.safeAreaInsets.top + 100,
            width: view.width - 40,
            height: 52.0)
        
        emailField.frame = CGRect(
            x: 20,
            y: usernameField.bottom + 10,
            width: view.width - 40,
            height: 52.0)
        
        passwordField.frame = CGRect(
            x: 20,
            y: emailField.bottom + 10,
            width: view.width - 40,
            height: 52.0)
        
        signUpButton.frame = CGRect(
            x: 20,
            y: passwordField.bottom + 10,
            width: view.width - 40,
            height: 52.0)
    }
    @objc private func didTapSignUp() {
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let username = usernameField.text, !username.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 0 else {
            return
        }
        
        AuthManager.shared.signUpNewUser(username: username, email: email, password: password) { registered in
            DispatchQueue.main.async {
                if registered {
                    //Good to go
                    let alert = UIAlertController(
                        title: "Signup",
                        message: "done",
                        preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(
                                        title: "Dismiss",
                                        style: .cancel,
                                        handler: nil))
                    
                    self.present(alert, animated: true)
                }
                else {
                    //Failed
                    let alert = UIAlertController(
                        title: " Error",
                        message: "WEe were unable to sign you up",
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
}

extension SingUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else {
            didTapSignUp()
        }
        
        return true
    }
}
