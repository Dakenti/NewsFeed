//
//  LoginView.swift
//  News
//
//  Created by Darkhan Serkeshev on 02.12.2024.
//

import UIKit

final class LoginView: UIView {
  private var isSecureTextEntry: Bool = true
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fill
    stackView.axis = .vertical
    stackView.spacing = 10
    
    return stackView
  }()
  
  private let containerView: UIView = {
    let view = UIView()
    return view
  }()
  
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
  
  private lazy var usernameTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Login.usernameTextFieldHint".localized
    textField.font = UIFont.systemFont(ofSize: 14)
    textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
    textField.borderStyle = .roundedRect
    textField.autocapitalizationType = .none
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
    textField.rightViewMode = .always
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
  
  private let eyeButtonContainer: UIView = {
    let view = UIView()
    return view
  }()
  
  private lazy var eyeButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "eye"), for: .normal)
    button.addTarget(self, action: #selector(toggleShowHide), for: .touchUpInside)
    
    return button
  }()
  
  weak var delegate: LoginViewControllerDelegate?
  
  convenience init(_ delegate: LoginViewControllerDelegate) {
    self.init()
    
    self.delegate = delegate
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  private func setupViews() {
    backgroundColor = .white
    addSubview(stackView)
    
    stackView.anchor(
      top: safeAreaLayoutGuide.topAnchor,
      leading: leadingAnchor,
      trailing: trailingAnchor,
      paddingTop: 56,
      paddingLeading: 24,
      paddingTrailing: 24
    )
    stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
    containerView.addSubview(circleView)
    containerView.anchor(height: 200)
    circleView.anchor(width: 200, height: 200)
    NSLayoutConstraint.activate([
      circleView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      circleView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
    ])
    circleView.addSubview(logoLabel)
    
    logoLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      logoLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
      logoLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor)
    ])
    
    stackView.addArrangedSubview(containerView)
    stackView.addArrangedSubview(usernameTextField)
    stackView.addArrangedSubview(passwordTextField)
    stackView.addArrangedSubview(loginButton)
    
    stackView.setCustomSpacing(36, after: containerView)
    stackView.setCustomSpacing(24, after: passwordTextField)
    loginButton.anchor(height: 44)
    
    passwordTextField.rightView = eyeButtonContainer
    eyeButtonContainer.addSubview(eyeButton)
    eyeButton.anchor(
      top: eyeButtonContainer.topAnchor,
      leading: eyeButtonContainer.leadingAnchor,
      trailing: eyeButtonContainer.trailingAnchor,
      bottom: eyeButtonContainer.bottomAnchor,
      paddingTop: 2,
      paddingTrailing: 8,
      width: 30,
      height: 30
    )
  }
}

// MARK: - Public Methods

extension LoginView {
  func resetInputs() {
    usernameTextField.text = ""
    passwordTextField.text = ""
    eyeButton.setImage(UIImage(named: "eye"), for: .normal)
    isSecureTextEntry = true
    loginButton.isEnabled = false
    loginButton.backgroundColor = UIColor(r: 149, g: 204, b: 244)
  }
}

// MARK: - Private Methods

extension LoginView {
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
  private func handleLoginButtonClick() {
    guard let username = usernameTextField.text,
          let password = passwordTextField.text
    else { return }
    delegate?.checkUserCredentials(username: username, password: password)
  }
  
  @objc
  private func toggleShowHide(button: UIButton) {
    isSecureTextEntry.toggle()
    let eyeIcon = isSecureTextEntry ? UIImage(named: "eye") : UIImage(named: "eyeCrossed")
    eyeButton.setImage(eyeIcon, for: .normal)
    passwordTextField.isSecureTextEntry = isSecureTextEntry
  }
}
