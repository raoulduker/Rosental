//
//  LoginVC.swift
//  Rosental
//
//  Created by Артем Петрюк on 02.09.2024.
//

import UIKit

class LoginVC: UIViewController {
    
    // MARK: - UI Components
    private let forgotPasswordButton = UIButton()
    private let loginLabel = UILabel()
    private let emailTextField = RosentalTextField()
    private let passwordTextField = RosentalTextField()
    private let loginButton = RosentalButton(title: "Войти")
    private let backButton = UIButton()
    
    var coordinator: AppCoordinator?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    // MARK: - Configure Views
    private func configure() {
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemBackground
        
        configureForgotPasswordButton()
        configureLoginLabel()
        configureEmailTextField()
        configurePasswordTextField()
        configureLoginButton()
        configureBackButton()
        
    }
    
    func configureBackButton() {
        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        view.setupView(backButton)
        
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: forgotPasswordButton.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }

    // MARK: - Forgot Password Button Configuration
    private func configureForgotPasswordButton() {
        forgotPasswordButton.setTitle("Забыли пароль?", for: .normal)
        forgotPasswordButton.setTitleColor(.gray, for: .normal)
        forgotPasswordButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        view.setupView(forgotPasswordButton)
        
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }

    // MARK: - Login Label Configuration
    private func configureLoginLabel() {
        loginLabel.text = "Вход в аккаунт"
        loginLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        view.setupView(loginLabel)
        
        NSLayoutConstraint.activate([
            loginLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70)
        ])
    }

    // MARK: - Email TextField Configuration
    private func configureEmailTextField() {
        emailTextField.setPlaceholderText(text: "E-mail")
        emailTextField.setIcon(named: "envelope")
        view.setupView(emailTextField)
        
        NSLayoutConstraint.activate([
            emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            emailTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            emailTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }

    // MARK: - Password TextField Configuration
    private func configurePasswordTextField() {
        passwordTextField.setPlaceholderText(text: "Пароль")
        passwordTextField.setIcon(named: "lock")
        passwordTextField.enablePasswordToggle()
        view.setupView(passwordTextField)
        
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            passwordTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }

    // MARK: - Login Button Configuration
    private func configureLoginButton() {
        view.setupView(loginButton)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            loginButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    // MARK: - Button Actions
    @objc private func loginButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Error", message: "Пожалуйста, введите E-mail и пароль")
            return
        }

        Task {
            do {
                try await NetworkManager.authenticate(username: email, password: password)
                coordinator?.showMainFlow()
            } catch {
                showAlert(title: "Ошибка входа", message: "Неправильный E-mail или пароль или вообще хз")
            }
        }
    }

    @objc func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - Show Alert
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
