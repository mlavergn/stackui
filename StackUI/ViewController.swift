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

//		let view = demoView()
//		let view = demoStackUISimple()
//		let view = demoStackUI()
        let view = demoStackUIPort()
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

    func demoStackUIPort() -> SView {
        class Demo: SView {
            private var toggleEnabled = SState(false)
            private var step: SState<Double> = SState(0)
            private var text = SState("")
            private var buttonActive = SState(true)
            private var showAlert = SState(false)

            override func body() -> UIView {
                SVStack(alignment: .leading) {[
                    SToggle(isOn: toggleEnabled, {[
                        SText("Toggle")
                    ]}),
                    SText(toggleEnabled, value: {"Toggle: \(self.toggleEnabled.wrappedValue ? "ok" : "nok")"}),
                    SDivider(),
                    SStepper("Click", value: step, in: 0...10),
                    SText(step, value: {"Step: \(self.step)"}),
                    STextField("Input", text: text),
                    SText("Text: \(self.text)"),
                    SButton(action: { _ in
                        self.showAlert.wrappedValue = true
                    }, label: {[
                        SText("Tap")
                    ]})
                    .alert(isPresented: showAlert) {
                        SAlert(title: "ALERT")
                    },
                    SSpacer()
                ]}
            }
        }

        return Demo()
    }

    func demoStackUISimple() -> UIView {
        class SwiftUIView: SView {
            private var myBinding = SState(false)
            override func body() -> UIView {
                SVStack {[
                    SHStack {[
                        SButton(action: { _ in
                            print(self.myBinding)
                        }, label: {[
                            SText("OK")
                        ]})
                        .frame(height: 100, width: 40),
                        SSpacer()
                    ]},
                    SSpacer()
                ]}
            }
        }
        return SwiftUIView()
    }

    func demoStackUI() -> UIView {
        let usernameLabel = SText("Email").font(.caption1)
        let username = STextField()
            .placeholderText("Email")
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .clearButton(.whileEditing)
            .clears(true)

        let passwordLabel = SText("Password").font(.caption1)
        let password = SSecureField()
            .placeholderText("Password")
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .clearButton(.whileEditing)
            .clears(true)

        let showPassword = SCheckbox() { _ in
            password.secure = !password.secure
        }
        let showPasswordLabel = SText("Show Password").font(.caption1)

        let enableFaceID = SCheckbox() { selected in
            print(selected)
        }
        let enableFaceIDLabel = SText("Enable Face ID").font(.caption1)

        let login = SButton(action: { _ in
            let usernameText = username.text ?? ""
            let passwordText = password.text ?? ""
            let json = "{\"username\":\"\(usernameText)\",\"password\":\"\(passwordText)\"}"
            print(json)
        }, label: {[
            SText("Sign In")
        ]})
        .background(.lightGray)
        .foregroundColor(.white)
        .cornerRadius(10)
        .padding(.horizontal, 20)
        .frame(height: 40, width: 100)

        let forgot = SButton(action: { _ in
            let alert = SAlert(title: "Forgot", message: "Try to remember!", dismissButton: "OK")
            self.present(alert, animated: true, completion: nil)
        }, label: {[
            SText("Forgot Password?")
        ]})
        .foregroundColor(.blue)
        .padding()

        let toggle = SToggle(isOn: SState(false), action: {
            print("toggle")
        }) {[
            SText("Toggle")
        ]}

        let stepper = SStepper(value: SState(0), in: 1...10) {
            print("step")
        }

        let list = SList(["hello", "world", "demo", "test", "foo", "bar"] as [AnyObject])
        list.ForEach { data in
            return SHStack {[
                SText(data as? String ?? "").font(.subheadline).foregroundColor(.blue)
            ]}
        }

        return SVStack {[
                usernameLabel,
                username,
                SSpacer(),
                passwordLabel,
                password,
                SSpacer(),
                SHStack {[
                    showPassword,
                    showPasswordLabel,
                    SSpacer(),
                    enableFaceID,
                    enableFaceIDLabel,
                    SSpacer(),
                ]},
                SSpacer(),
                login,
                forgot,
                toggle,
                stepper,
                list,
            ]}.padding()
    }
}

