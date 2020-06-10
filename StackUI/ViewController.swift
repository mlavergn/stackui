//
//  ViewController.swift
//  StackUI
//
//  Created by Lavergne, Marc on 6/9/20.
//  Copyright © 2020 Lavergne, Marc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let view = demoStackUI()
        self.view.addSubview(view)
        view.constrain(.top, superview: self.view)
        view.constrain(.horizontal, superview: self.view)
    }
    
    func demoStackView() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false

        let text = UITextView()
        text.text = "StackUI"
        stack.addArrangedSubview(text)
        
        let button = UIButton(type: .custom)
        button.setTitle("OK", for: .normal)
        stack.addArrangedSubview(button)

        return stack
    }

    func demoStackUI() -> UIStackView {
        let usernameLabel = UI.Text("Email").font(.caption1)
        let username = UI.TextField()
            .placeholderText("Email")
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .clearButton(.whileEditing)
            .clears(true)

        let passwordLabel = UI.Text("Password").font(.caption1)
        let password = UI.SecureField()
            .placeholderText("Password")
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .clearButton(.whileEditing)
            .clears(true)

        let showPassword = UI.Checkbox(action: {
            password.secure = !password.secure
        })
        let showPasswordLabel = UI.Text("Show Password").font(.caption1)
        
        let enableFaceID = UI.Checkbox()
        let enableFaceIDLabel = UI.Text("Enable Face ID").font(.caption1)

        let login = UI.Button("Sign In") {
            let usernameText = username.text ?? ""
            let passwordText = password.text ?? ""
            let json = "{\"username\":\"\(usernameText)\",\"password\":\"\(passwordText)\"}"
            print(json)
        }
        .background(.lightGray)
        .foregroundColor(.white)
        .cornerRadius(10)
        .padding(.horizontal, 20)
        
        let forgot = UI.Button("Forgot Password?") {
            let alert = UI.Alert(title: "Forgot", message: "Try to remember!", dismissButton: "OK")
            self.present(alert, animated: true, completion: nil)
        }
        .foregroundColor(.blue)
        .padding()

        let view = UI.VStack { body in
            body.views = [
                usernameLabel,
                username,
                UI.Spacer(),
                passwordLabel,
                password,
                UI.Spacer(),
                UI.HStack { body in
                    body.views = [
                        showPassword,
                        showPasswordLabel,
                        UI.Spacer(),
                        enableFaceID,
                        enableFaceIDLabel,
                        UI.Spacer(),
                    ]
                },
                UI.Spacer(),
                login,
                forgot,
            ]
        }.padding()
        
        return view
    }

}

