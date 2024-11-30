//
//  LoginViewController.swift
//  News
//
//  Created by Darkhan Serkeshev on 26.11.2024.
//

import UIKit

protocol LoginViewControllerProtocol: AnyObject {}

final class LoginViewController: UIViewController {
  private let circleView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 100
    view.layer.masksToBounds = true
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 3.0
    return view
  }()
  
  private let logoLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 32)
    label.text = "Login.logoText".localized
    return label
  }()
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fillEqually
    stackView.axis = .vertical
    stackView.spacing = 10
    
    return stackView
  }()
  
  private lazy var usernameTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Login.usernameTextFieldHint".localized
    textField.font = UIFont.systemFont(ofSize: 14)
    textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
    textField.borderStyle = .roundedRect
    textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    
    return textField
  }()
  
  private lazy var passwordTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Login.passwordTextFieldHint".localized
    textField.isSecureTextEntry = true
    textField.font = UIFont.systemFont(ofSize: 14)
    textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
    textField.borderStyle = .roundedRect
    textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    
    return textField
  }()
  
  private lazy var loginButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Login.loginButton".localized, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 8
    button.clipsToBounds = true
    button.isEnabled = false
    button.backgroundColor = UIColor(r: 149, g: 204, b: 244)
    button.addTarget(self, action: #selector(handleLoginButtonClick), for: .touchUpInside)
    
    return button
  }()
  
  var presenter: LoginViewPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    addKeyboardObservers()
  }
  
  deinit {
    removeKeyboardObservers()
  }
}

// MARK: - LoginViewPresenterProtocol

extension LoginViewController: LoginViewControllerProtocol {}

// MARK: - Handling Views Constraints

extension LoginViewController {
  private func setupViews() {
    view.backgroundColor = .white
    
    setupLogoCircleConstraints()
    setupStackViewConstraints()
  }
  
  private func setupLogoCircleConstraints() {
    view.addSubview(circleView)
    circleView.addSubview(logoLabel)
    
    circleView.anchor(
      top: view.safeAreaLayoutGuide.topAnchor,
      paddingTop: 56,
      width: 200,
      height: 200
    )
    circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    logoLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      logoLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
      logoLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor)
    ])
  }
  
  private func setupStackViewConstraints() {
    view.addSubview(stackView)
    
    stackView.anchor(
      top: circleView.bottomAnchor,
      leading: view.leadingAnchor,
      trailing: view.trailingAnchor,
      paddingTop: 36,
      paddingLeading: 24,
      paddingTrailing: 24
    )
    stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    stackView.addArrangedSubview(usernameTextField)
    stackView.addArrangedSubview(passwordTextField)
    stackView.addArrangedSubview(loginButton)
    
    stackView.setCustomSpacing(24, after: passwordTextField)
    loginButton.anchor(height: 44)
  }
}

// MARK: - Handling Actions

extension LoginViewController {
  @objc
  private func handleTextInputChange() {
    guard let isUsernameEmpty = usernameTextField.text?.isEmpty,
          let isPasswordEmpty = passwordTextField.text?.isEmpty
    else { return }
    
    if !isUsernameEmpty && !isPasswordEmpty {
      loginButton.isEnabled = true
      loginButton.backgroundColor = UIColor(r: 17, g: 154, b: 237)
    } else {
      loginButton.isEnabled = false
      loginButton.backgroundColor = UIColor(r: 149, g: 204, b: 244)
    }
  }
  
  @objc
  private func handleLoginButtonClick(){
//    let signUpController = SignUpController()
//    navigationController?.pushViewController(signUpController, animated: true)
    guard let username = usernameTextField.text,
          let password = passwordTextField.text
    else { return }
    presenter.checkCredentials(username: username, password: password)
  }
}

// MARK: - Handling Keyboard Appearence

extension LoginViewController {
  private func addKeyboardObservers() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillHide),
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
  }
  
  private func removeKeyboardObservers() {
    NotificationCenter.default.removeObserver(
      self,
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    NotificationCenter.default.removeObserver(
      self,
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
  }
  
  @objc
  private func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      if view.frame.origin.y == 0 {
        view.frame.origin.y -= keyboardSize.height * 0.2
      }
    }
  }
  
  @objc
  private func keyboardWillHide(notification: NSNotification) {
    if view.frame.origin.y != 0 {
      view.frame.origin.y = 0
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
    super.touchesBegan(touches, with: event)
  }
}
