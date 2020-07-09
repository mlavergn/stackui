//
//  StackUI.swift
//  StackUI
//
//  Created by Lavergne, Marc on 6/4/20.
//  Copyright © 2020 Lavergne, Marc. All rights reserved.
//

import UIKit

/// StackUI
///
/// A SwiftUI-like API for UIKit to allow progressive adoption of SwiftUI
///
/// SwiftUI Style
/// - uses a "call chaining" -like pattern
/// - no setter/getter patterns
/// - inline declarations
///
/// TODO
/// - Form - UITableView with sections?
/// - Picker - pickerStyle(.radioGroup)
/// - Divider
/// - Environment
/// - colorScheme - .dark : .light
/// - contentSize - .large : .axLarge : .small
/// - locale - en_US
/// - NavigationView / NavigationLink
///
/// FIX
/// - View property "chained" calls propagate based on the call order and the nesting order
///

public struct StackUI {
    let version: String = "0.0.1"
    
    static var windowScene: UIWindowScene? {
        return UIApplication.shared.connectedScenes.first { scene in
            scene.activationState == .foregroundActive
        } as? UIWindowScene
    }
    
    static var keyWindow: UIWindow? {
        return Self.windowScene?.windows.first { window in
            window.isKeyWindow
        }
    }
    
    static var rootViewController: UIViewController? {
        return Self.keyWindow?.rootViewController
    }

    static var presentedViewController: UIViewController? {
        return Self.rootViewController?.presentedViewController ?? Self.rootViewController
    }
}

/// SwiftUI style edge specifiers
public enum SEdge: Int, CaseIterable {
    case bottom
    case leading
    case top
    case trailing
}

/// SwiftUI style alignment specifiers
public enum SAlignment: Int {
    case topLeading
    case top
    case topTrailing
    case leading
    case center
    case trailing
    case bottomLeading
    case bottom
    case bottomTrailing

    var stackAlignment: [UIStackView.Alignment] {
        switch self {
        case .topLeading:
            return [.top, .leading]
        case .top:
            return [.top]
        case .topTrailing:
            return [.top, .trailing]
        case .leading:
            return [.leading]
        case .center:
            return [.center]
        case .trailing:
            return [.trailing]
        case .bottomLeading:
            return [.bottom, .leading]
        case .bottom:
            return [.bottom]
        case .bottomTrailing:
            return [.bottom, .trailing]
        }
    }
}

/// SwiftUI style vertical alignment specifiers
public enum SVerticalAlignment: Int {
    case bottom
    case center
    case top

    var stackAlignment: UIStackView.Alignment {
        switch self {
        case .bottom:
            return UIStackView.Alignment.bottom
        case .center:
            return UIStackView.Alignment.center
        case .top:
            return UIStackView.Alignment.top
        }
    }
}

/// SwiftUI style horizontal alignment specifiers
public enum SHorizontalAlignment: Int {
    case center
    case leading
    case trailing
    
    var stackAlignment: UIStackView.Alignment {
        switch self {
        case .center:
            return UIStackView.Alignment.center
        case .leading:
            return UIStackView.Alignment.leading
        case .trailing:
            return UIStackView.Alignment.trailing
        }
    }
}

// MARK: extensions

/// SwiftUI extensions on UIView
extension UIView {
    @discardableResult
    public func background(_ color: UIColor, cornerRadius radius: CGFloat? = nil) -> Self {
        self.backgroundColor = color
        if let radius = radius {
            self.cornerRadius(radius)
        }
        return self
    }

    @discardableResult
    public func clipped() -> Self {
        self.clipsToBounds = true
        return self
    }

    @discardableResult
    public func cornerRadius(_ radius: CGFloat) -> Self {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        return self
    }

    @discardableResult
    public func frame(height: CGFloat = 0, width: CGFloat = 0) -> Self {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }

    @discardableResult
    public func opacity(_ opacity: Float) -> Self {
        self.layer.opacity = opacity
        return self
    }
}

/// SwiftUI extensions on UIView padding
extension UIView {
    @discardableResult
    func edgesIgnoringSafeArea(_ edge: SEdge) -> Self {
        if let superview = self.superview {
            switch edge {
            case .bottom:
                self.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            case .leading:
                self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
            case .top:
                self.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            case .trailing:
                self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
            }
        }
        return self
    }

    @discardableResult
    public func padding(_ insets: UIEdgeInsets) -> Self {
        self.layoutMargins = insets
        return self
    }

    @discardableResult
    public func padding(_ inset: CGFloat) -> Self {
        let insets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        return padding(insets)
    }

    @discardableResult
    public func padding() -> Self {
        let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return padding(insets)
    }
}

/// SwiftUI extensions on UIButton
extension UIButton {
    @discardableResult
    public func font(_ font: UIFont) -> Self {
        self.titleLabel?.font = font
        return self
    }

    @discardableResult
    public func font(_ style: UIFont.TextStyle) -> Self {
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: style)
        return self
    }

    @discardableResult
    public func foregroundColor(_ color: UIColor) -> Self {
        self.titleLabel?.textColor = color
        return self
    }
}

/// SwiftUI extensions on UITextView
extension UILabel {
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }

    @discardableResult
    public func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }

    @discardableResult
    public func font(_ style: UIFont.TextStyle) -> Self {
        self.font = UIFont.preferredFont(forTextStyle: style)
        return self
    }

    @discardableResult
    public func foregroundColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }

    @discardableResult
    public func lineLimit(_ lines: Int) -> Self {
        self.numberOfLines = lines
        return self
    }
}

/// SwiftUI extensions on UITextField
extension UITextField {
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }

    @discardableResult
    public func autocapitalization(_ type: UITextAutocapitalizationType) -> Self {
        self.autocapitalizationType = type
        return self
    }

    @discardableResult
    public func clears(_ clears: Bool) -> Self {
        self.clearsOnBeginEditing = clears
        return self
    }

    @discardableResult
    func clearButton(_ mode: UITextField.ViewMode) -> Self {
        self.clearButtonMode = mode
        return self
    }

    @discardableResult
    func disableAutocorrection(_ disable: Bool) -> Self {
        self.autocorrectionType = disable ? .no : .yes
        return self
    }

    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }

    @discardableResult
    func font(_ style: UIFont.TextStyle) -> Self {
        self.font = UIFont.preferredFont(forTextStyle: style)
        return self
    }

    @discardableResult
    func foregroundColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }

    @discardableResult
    func placeholderText(_ text: String) -> Self {
        self.placeholder = text
        return self
    }

    @discardableResult
    func textFieldStyle(_ style: UITextField.BorderStyle) -> Self {
        self.borderStyle = style
        return self
    }
}

/// SwiftUI extensions on UITextView
extension UITextView {
    @discardableResult
    func alignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }

    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }

    @discardableResult
    func font(_ style: UIFont.TextStyle) -> Self {
        self.font = UIFont.preferredFont(forTextStyle: style)
        return self
    }

    @discardableResult
    func foregroundColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }

    @discardableResult
    func lineLimit(_ lines: Int) -> Self {
        self.textContainer.maximumNumberOfLines = lines
        return self
    }
}

/// SwiftUI extensions on UIStackView
extension UIStackView {
    // viewBuilder
    var build: [UIView] {
        get {
            self.arrangedSubviews
        }
        set(views) {
            views.forEach{ view in
                self.addArrangedSubview(view)
            }
        }
    }

    @discardableResult
    func spacing(_ spacing: UIStackView.Distribution = .fillProportionally) -> Self {
        self.distribution = spacing
        return self
    }

    // alignment is already defined on UIStackView
    @discardableResult
    func align(_ alignment: UIStackView.Alignment = .center) -> Self {
        self.alignment = alignment
        return self
    }
}

/// SwiftUI support for action closures
extension UIControl {
    /// Inspect view state for the given UIEvent and return an appropriate UIControl.Event
    /// - Parameter event: UIEvent to attempt to convert
    /// - Returns: UIControl.Event
    func uiEventToControlEvent(_ event: UIEvent) -> UIControl.Event {
        // non-UIButton actions will typically have a nil UIEvent
        guard let touch = event.allTouches?.first else {
            return .primaryActionTriggered
        }
        let isInside = self.bounds.contains(touch.location(in: self))
        let wasInside = self.bounds.contains(touch.previousLocation(in: self))
        // let isEdit = self.isKind(of: UITextField.self)
        // TODO support editing events
        switch touch.phase {
        case .began:
            return touch.tapCount > 1 ? .touchDownRepeat : .touchDown
        case .moved:
            switch (wasInside, isInside) {
            case (true, true):
                return .touchDragInside
            case (false, true):
                return .touchDragEnter
            case (true, false):
                return .touchDragExit
            case (false, false):
                return .touchDragOutside
            }
        case .ended:
            return isInside ? .touchUpInside : .touchUpOutside
        case .cancelled:
            return .touchCancel
        case .stationary:
            return .primaryActionTriggered
        default:
            return .primaryActionTriggered
        }
    }
}

// MARK: list

// SwiftUI style List
public final class SList: UITableView {
    var controller: SListController?
    var cellHandler: (Any) -> UIView = { _ in
        return UIView()
    }

    init(_ data: [AnyObject]) {
        super.init(frame: .zero, style: .plain)
        self.translatesAutoresizingMaskIntoConstraints = false

        let listController = SListController()
        listController.data = data
        self.dataSource = listController
        self.delegate = listController
        self.register(UITableViewCell.self, forCellReuseIdentifier: listController.cellId)
        // created the controller, so hold a reference
        controller = listController
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @discardableResult
    func ForEach(_ handler: @escaping (Any) -> UIView) -> Self {
        cellHandler = handler
        return self
    }

    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let superview = self.superview {
            self.widthAnchor.constraint(equalTo: superview.layoutMarginsGuide.widthAnchor).isActive = true
        }
    }

    /// map the optimal intrinsic size to the content size
    override public var intrinsicContentSize: CGSize {
        return contentSize
    }
}

// SwiftUI rename to Coordinator
final class SListController: UITableViewController {
    var data: [Any] = []
    let cellId: String = "cell"

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // bridge back
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if let list = tableView as? SList {
            // not optimal, find a pattern for reuse
            let view = list.cellHandler(data[indexPath.row])
            cell.addSubview(view)
        }
        return cell
    }
}

// MARK: types

public final class SAlert: UIAlertController {
    public convenience init(title: String, message: String? = nil, dismissButton: String = "OK") {
        let messageText = message ?? title
        let titleText = message == nil ? "" : title
        self.init(title: titleText, message: messageText, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: dismissButton, style: .default, handler: nil)
        self.addAction(defaultAction)
    }
}

public final class SImage: UIImageView {
    public init(_ named: String) {
        let image = UIImage(named: named)
        super.init(image: image)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public final class SButton: UIButton {
    var events: [UInt: (UIEvent) -> Void] = [:]
    var binding: SState<Bool>?

    public convenience init(action: @escaping (UIEvent) -> Void, label: () -> [UIView]) {
        self.init(type: .system)
        self.translatesAutoresizingMaskIntoConstraints = false
        label().forEach { view in
            if let text = view as? SText<String> {
                self.setTitle(text.value, for: .normal)
            }
        }
        self.event(.touchUpInside, action: action)
    }
    
    deinit {
        self.events.removeAll()
        self.binding?.unsubscribe(self)
    }

    public func event(_ event: UIControl.Event, action: @escaping (UIEvent) -> Void) {
        events[event.rawValue] = action
        self.addTarget(self, action: #selector(handler), for: event)
    }

    @objc
    func handler(_ sender: UIControl, forEvent event: UIEvent) {
        let controlEvent = uiEventToControlEvent(event)
        events[controlEvent.rawValue]?(event)
    }
    
    public func alert(isPresented: SState<Bool>, _ value: @escaping () -> SAlert) -> Self {
        self.binding = isPresented
        self.binding?.projectedValue(self) { isPresented in
            if isPresented.wrappedValue {
                StackUI.presentedViewController?.show(value(), sender: nil)
                isPresented.wrappedValue = false
            }
        }
        return self
    }
}

public final class SCheckbox: UIButton {
    var events: [UInt: (UIEvent) -> Void] = [:]
    var binding: SState<Bool>

    public init(_ binding: SState<Bool>, _ action: ((Bool) -> Void)? = nil) {
        self.binding = binding
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 44).isActive = true
        self.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.setImage(UIImage(named: "checkbox-off"), for: .normal)
        self.setImage(UIImage(named: "checkbox-on"), for: .selected)
        self.event(.touchUpInside) { _ in
            self.isSelected = !self.isSelected
            action?(self.isSelected)
        }
        self.isSelected = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.events.removeAll()
        self.binding.unsubscribe(self)
    }

    public func event(_ event: UIControl.Event, action: @escaping (UIEvent) -> Void) {
        events[event.rawValue] = action
        self.addTarget(self, action: #selector(handler), for: event)
    }

    @objc
    func handler(_ sender: UIControl, forEvent event: UIEvent) {
        let controlEvent = uiEventToControlEvent(event)
        events[controlEvent.rawValue]?(event)
    }
}

public class SText<T>: UILabel {
    var events: [UIGestureRecognizer: () -> Void] = [:]
    var binding: SState<T>

    public init(_ binding: SState<T>, value: (() -> String)? = nil) {
        self.binding = binding
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = value?() ?? ""
        self.binding.projectedValue(self) { _ in
            self.text = value?() ?? ""
        }
    }

    public convenience init(_ value: T) {
        self.init(SState(value), value: { "\(value)" })
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        self.events.removeAll()
        self.binding.unsubscribe(self)
    }

    public var value: T {
        return binding.wrappedValue
    }
    
    public func onTapGesture(_ action: @escaping () -> Void) -> Self {
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handler))
        self.events[tapGesture] = action
        self.addGestureRecognizer(tapGesture)
        return self
    }
    
    @objc
    func handler(_ sender: UITapGestureRecognizer) {
        self.events[sender]?()
    }
}

public class STextField: UITextField, UITextFieldDelegate {
    var events: [UInt: (UIEvent) -> Void] = [:]
    var binding: SState<String>?
    
    public init(_ placeholder: String? = nil, text: SState<String>? = nil) {
        super.init(frame: .zero)
        self.binding = text
        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = placeholder
        self.text = text?.wrappedValue
        self.delegate = self
        self.binding?.projectedValue(self) { _ in
            self.text = self.binding?.wrappedValue
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.events.removeAll()
        self.binding?.unsubscribe(self)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.binding?.wrappedValue = textField.text ?? ""
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
}

public class SSecureField: STextField {
    public override init(_ placeholder: String? = nil, text: SState<String>? = nil) {
        super.init(placeholder, text: text)
        self.isSecureTextEntry = true
        self.autocorrectionType = .no
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func secure(_ state: SState<Bool>) -> Self {
        state.projectedValue(self) { state in
            self.isSecureTextEntry = state.wrappedValue
        }
        return self
    }
}

public final class SStepper: UIStepper {
    var events: [UInt: (UIEvent) -> Void] = [:]
    var binding: SState<Double> = SState(0.0)

    public convenience init(_ text: String, value: SState<Double>, in range: ClosedRange<Double>, action: (() -> Void)? = nil) {
        self.init(value: value, in: range, action: action)
        self.binding = value
        self.event(.touchUpInside) { _ in
            self.binding.wrappedValue = self.value
        }
    }

    public init(value: SState<Double>, in range: ClosedRange<Double>, action: (() -> Void)? = nil) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.minimumValue = range.lowerBound
        self.maximumValue = range.upperBound
        self.event(.primaryActionTriggered) { _ in
            action?()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.binding.unsubscribe(self)
        self.events.removeAll()
    }

    func event(_ event: UIControl.Event, action: @escaping (UIEvent) -> Void) {
            events[event.rawValue] = action
            self.addTarget(self, action: #selector(handler), for: event)
    }
    @objc
    func handler(_ sender: UIControl, forEvent event: UIEvent) {
        let controlEvent = uiEventToControlEvent(event)
        events[controlEvent.rawValue]?(event)
    }
}

public final class SToggle: UISwitch {
    var events: [UInt: (UIEvent) -> Void] = [:]
    var binding = SState<Bool>(false)

    public init(isOn binding: SState<Bool>, action: (() -> Void)? = nil, _ subviews: (() -> [UIView])? = nil) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.binding = binding
        self.isOn = self.binding.wrappedValue
        self.event(.primaryActionTriggered) { _ in
            self.binding.wrappedValue = self.isOn
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.binding.unsubscribe(self)
        self.events.removeAll()
    }
    
    public func disabled(_ observe: SState<Bool>) -> Self {
        self.isEnabled = observe.wrappedValue
        return self
    }

    public func event(_ event: UIControl.Event, action: @escaping (UIEvent) -> Void) {
        events[event.rawValue] = action
        self.addTarget(self, action: #selector(handler), for: event)
    }

    @objc
    func handler(_ sender: UIControl, forEvent event: UIEvent) {
        let controlEvent = uiEventToControlEvent(event)
        events[controlEvent.rawValue]?(event)
    }
}

// MARK: layout helpers

public final class SDivider: UIView {
    public convenience init() {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black
        self.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
    }
    
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let superview = self.superview {
            self.widthAnchor.constraint(equalTo: superview.layoutMarginsGuide.widthAnchor).isActive = true
        }
    }
}

public final class SSpacer: UIView {
    public convenience init() {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        // spacer req lowest hugging priority so it is always the stretched view
        self.setContentHuggingPriority(.defaultLow, for: .vertical)
        self.setContentHuggingPriority(.defaultLow, for: .horizontal)
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        self.widthAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
    }
}


// MARK: layout containers

public class SStack: UIStackView {
    public convenience init(_ alignment: UIStackView.Alignment, spacing: CGFloat, content: () -> [UIView]) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isLayoutMarginsRelativeArrangement = true
        self.distribution = .fill
        self.alignment = alignment
        self.spacing = spacing
        content().forEach { view in
            self.addArrangedSubview(view)
        }
    }
    
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let superview = self.superview {
            self.heightAnchor.constraint(equalTo: superview.layoutMarginsGuide.heightAnchor).isActive = true
            self.widthAnchor.constraint(equalTo: superview.layoutMarginsGuide.widthAnchor).isActive = true
        }
    }
}

public final class SVStack: SStack {
    public convenience init(alignment: SHorizontalAlignment = .center, spacing: CGFloat = 0, content: () -> [UIView]) {
        self.init(alignment.stackAlignment, spacing: spacing, content: content)
        self.axis = .vertical
    }
}

public final class SHStack: SStack {
    public convenience init(alignment: SVerticalAlignment = .center, spacing: CGFloat = 0, content:  () -> [UIView]) {
        self.init(alignment.stackAlignment, spacing: spacing, content: content)
        self.axis = .horizontal
    }
}

public final class SZStack: SView {
    public convenience init(alignment: SAlignment = .center, spacing: CGFloat = 0, content: () -> [UIView]) {
        self.init()
        content().forEach { view in
            self.addSubview(view)
            view.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        }
    }
}

// MARK: view

open class SView: UIView {
    public init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        if let view = self.body() {
            self.addSubview(view)
        }
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func body() -> UIView? {
        return nil
    }

    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let superview = self.superview {
            self.heightAnchor.constraint(equalTo: superview.layoutMarginsGuide.heightAnchor).isActive = true
            self.widthAnchor.constraint(equalTo: superview.layoutMarginsGuide.widthAnchor).isActive = true
        }
    }
}

// MARK: observables

/// State
/// Observable with concrete value
public class SState<T>: CustomStringConvertible {
    var subscribers: [AnyHashable: (SState<T>) -> Void] = [:]

    public var wrappedValue: T {
        didSet(value) {
            self.update()
        }
    }

    public init(_ wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }

    public func projectedValue(_ subscriber: AnyHashable, callback: @escaping (SState<T>) -> Void) {
        self.subscribers[subscriber] = callback
    }

    public var description: String {
        return "\(self.wrappedValue)"
    }

    // called prior to rendering
    public func update() {
        self.subscribers.forEach { kv in
            kv.value(self)
        }
    }
    
    public func unsubscribe(_ subscriber: AnyHashable) {
        self.subscribers.removeValue(forKey: subscriber)
    }
}

/// Binding
/// Observable with a parameterized value
public class SBinding<T>: SState<T> {
    public init(_ state: SState<T>) {
        super.init(state.wrappedValue)
    }
}

/// ObservedObject sub-class
public class SObservedObject<T>: SState<T> {
}
