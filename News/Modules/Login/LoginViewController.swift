//
//  LoginViewController.swift
//  News
//
//  Created by Darkhan Serkeshev on 26.11.2024.
//

import UIKit

protocol LoginViewControllerProtocol: AnyObject {}

protocol LoginViewControllerDelegate: AnyObject {
  func checkUserCredentials(username: String, password: String)
}

final class LoginViewController: UIViewController {
  private var loginView: LoginView!
  
  var presenter: LoginViewPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    addKeyboardObservers()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    loginView.resetInputs()
  }
  
  deinit {
    removeKeyboardObservers()
  }
}

// MARK: - LoginViewPresenterProtocol

extension LoginViewController: LoginViewControllerProtocol {}

// MARK: - Handling Views setup

extension LoginViewController {
  private func setupViews() {
    loginView = LoginView(self)
    view.addSubview(loginView)
    loginView.anchor(
      top: view.topAnchor,
      leading: view.leadingAnchor,
      trailing: view.trailingAnchor,
      bottom: view.bottomAnchor
    )
  }
}

// MARK: - LoginViewControllerDelegate

extension LoginViewController: LoginViewControllerDelegate {
  func checkUserCredentials(username: String, password: String) {
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
