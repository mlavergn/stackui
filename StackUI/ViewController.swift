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
        view.constrain(.all, superview: self.view)
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
        let usernameLabel = Text("Email").font(.caption1)
        let username = TextField()
            .placeholderText("Email")
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .clearButton(.whileEditing)
            .clears(true)

        let passwordLabel = Text("Password").font(.caption1)
        let password = SecureField()
            .placeholderText("Password")
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .clearButton(.whileEditing)
            .clears(true)

        let showPassword = Checkbox() { _ in
            password.secure = !password.secure
        }
        let showPasswordLabel = Text("Show Password").font(.caption1)
        
        let enableFaceID = Checkbox() { selected in
            print(selected)
        }
        let enableFaceIDLabel = Text("Enable Face ID").font(.caption1)

        let login = Button("Sign In") { _ in
            let usernameText = username.text ?? ""
            let passwordText = password.text ?? ""
            let json = "{\"username\":\"\(usernameText)\",\"password\":\"\(passwordText)\"}"
            print(json)
        }
        .background(.lightGray)
        .foregroundColor(.white)
        .cornerRadius(10)
        .padding(.horizontal, 20)
		.frame(height: 40, width: 100)
        
        let forgot = Button("Forgot Password?") { _ in
            let alert = Alert(title: "Forgot", message: "Try to remember!", dismissButton: "OK")
            self.present(alert, animated: true, completion: nil)
        }
        .foregroundColor(.blue)
        .padding()

        let toggle = Toggle(isOn: false) { selected in
            print(selected)
        }

        let stepper = Stepper(in: 1...10) { value in
            print(value)
        }
        
        let list = List(["hello", "world", "demo", "test", "foo", "bar"] as [AnyObject])
        list.ForEach { data in
            return HStack { body in
                body.views = [
                    Text(data as? String ?? "").font(.subheadline).foregroundColor(.blue)
                ]
            }
        }

        let view = VStack { body in
            body.views = [
                usernameLabel,
                username,
                Spacer(),
                passwordLabel,
                password,
                Spacer(),
                HStack { body in
                    body.views = [
                        showPassword,
                        showPasswordLabel,
                        Spacer(),
                        enableFaceID,
                        enableFaceIDLabel,
                        Spacer(),
                    ]
                },
                Spacer(),
                login,
                forgot,
                toggle,
                stepper,
                list,
            ]
        }.padding()
        
        return view
    }

}

