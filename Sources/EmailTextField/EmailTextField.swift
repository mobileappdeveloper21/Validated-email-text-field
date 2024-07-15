//
//  EmailTextField.swift
//  EmailTextField
//
//  Created by Glocify technology on 04/07/24.
//



import UIKit

@available(iOS 13.0, *)
class EmailTextField: UITextField {
    
    //MARK: - Creating Label and customization of font size and colour
    var lblValidation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
   //MARK: - Creating imageview and customization colour of the image
    var imgVwValidation: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "checkmark.circle")
        imageView.tintColor = .green
        imageView.isHidden = true
        return imageView
        
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupValidation()
        setupValidImage()
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupValidation()
        setupValidImage()
    }
    
    //MARK: - Positioning error code label and adding constraints

    func setupValidation() {
        addSubview(lblValidation)
        NSLayoutConstraint.activate([
            lblValidation.topAnchor.constraint(equalTo: bottomAnchor, constant: 4),
            lblValidation.leadingAnchor.constraint(equalTo: leadingAnchor),
            lblValidation.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    //MARK: - Positioning image to right side
    func setupValidImage() {
        rightView = imgVwValidation
        rightViewMode = .always
    }
    
     //MARK: - Validating email while typing
    @objc func textFieldDidChange() {
        if let text = text, !text.isEmpty {
            if isValidEmail(text) {
                lblValidation.isHidden = true
                imgVwValidation.isHidden = false
            } else {
                lblValidation.text = "Invalid email address"
                lblValidation.isHidden = false
                imgVwValidation.isHidden = true
            }
        } else {
            lblValidation.isHidden = true
            imgVwValidation.isHidden = true
        }
    }
    
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    func isValidEmail(_ email: String) -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
