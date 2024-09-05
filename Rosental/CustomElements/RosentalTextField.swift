import UIKit

class RosentalTextField: UITextField {
    
    private let iconImageView = UIImageView()
    private let toggleButton = UIButton()
    private let floatingPlaceholderLabel = UILabel()
    
    private let iconSize: CGFloat = 24
    private let padding: CGFloat = 8
    
    private var isPasswordField = false
    private var passwordHidden = true
    private var placeholderIsFloating = false
    
    private let floatingPlaceholderFontSize: CGFloat = 12
    private let placeholderFontSize: CGFloat = 14
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupFloatingPlaceholder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    private func configure() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = CGColor(gray: 0.8, alpha: 1)
        font = .systemFont(ofSize: 14)
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = UIColor(cgColor: CGColor(gray: 0.8, alpha: 1))
        addSubview(iconImageView)
        
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        
        toggleButton.tintColor = .gray
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        addSubview(toggleButton)
        
        // Only listen for editing changes
        addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
    }
    
    private func setupFloatingPlaceholder() {
        floatingPlaceholderLabel.font = .systemFont(ofSize: placeholderFontSize)
        floatingPlaceholderLabel.textColor = .gray
        floatingPlaceholderLabel.alpha = 0.0 // Initially hidden
        addSubview(floatingPlaceholderLabel)
    }
    
    func setPlaceholderText(text: String) {
        floatingPlaceholderLabel.text = text
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gray,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold)
            ]
        )
    }
    
    func setIcon(named iconName: String) {
        iconImageView.image = UIImage(systemName: iconName)
    }
    
    func enablePasswordToggle() {
        isPasswordField = true
        isSecureTextEntry = true
        toggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
    }
    
    @objc private func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
        passwordHidden.toggle()
        toggleButton.setImage(isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye"), for: .normal)
    }
    
    // MARK: - Floating Placeholder Logic
    @objc private func handleEditingChanged() {
        if let text = text, !text.isEmpty {
            if !placeholderIsFloating {
                animatePlaceholder(toFloat: true)
            }
        } else {
            if placeholderIsFloating {
                animatePlaceholder(toFloat: false)
            }
        }
    }
    
    private func animatePlaceholder(toFloat: Bool) {
        placeholderIsFloating = toFloat
        
        UIView.animate(withDuration: 0.25) {
            if toFloat {
                self.floatingPlaceholderLabel.font = .systemFont(ofSize: self.floatingPlaceholderFontSize)
                self.floatingPlaceholderLabel.frame = CGRect(
                    x: self.padding,
                    y: -self.floatingPlaceholderFontSize - 2, // Move it above the text field
                    width: self.bounds.width,
                    height: self.floatingPlaceholderFontSize + 4
                )
                self.floatingPlaceholderLabel.alpha = 1.0
            } else {
                self.floatingPlaceholderLabel.font = .systemFont(ofSize: self.placeholderFontSize)
                self.floatingPlaceholderLabel.frame = CGRect(
                    x: self.padding,
                    y: (self.bounds.height - self.placeholderFontSize) / 2,
                    width: self.bounds.width,
                    height: self.placeholderFontSize
                )
                self.floatingPlaceholderLabel.alpha = 0.0
            }
        }
    }
    
    // MARK: - Text Field Overrides
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: padding, y: (bounds.height - iconSize) / 2, width: iconSize, height: iconSize)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let leftInset = padding + iconSize + padding
        let rightInset = isPasswordField ? padding + iconSize + padding : padding
        return bounds.inset(by: UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let width = iconSize
        return CGRect(x: bounds.width - width - padding, y: (bounds.height - width) / 2, width: width, height: width)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.frame = leftViewRect(forBounds: bounds)
        if isPasswordField {
            toggleButton.frame = rightViewRect(forBounds: bounds)
        }
        if placeholderIsFloating {
            floatingPlaceholderLabel.frame = CGRect(
                x: padding,
                y: -floatingPlaceholderFontSize - 2,
                width: bounds.width,
                height: floatingPlaceholderFontSize + 4
            )
        } else {
            floatingPlaceholderLabel.frame = CGRect(
                x: padding,
                y: (bounds.height - placeholderFontSize) / 2,
                width: bounds.width,
                height: placeholderFontSize
            )
        }
    }
}
