import XCTest
@testable import EmailTextField

@available(iOS 13.0, *)
class EmailTextFieldTests: XCTestCase {

    var emailTextField: EmailTextField!

    override func setUp() {
        super.setUp()
        emailTextField = EmailTextField(coder: NSCoder())
    }

    override func tearDown() {
        emailTextField = nil
        super.tearDown()
    }

    func testValidEmail() {
        emailTextField.text = "test@example.com"
        emailTextField.textFieldDidChange()

        XCTAssertTrue(emailTextField.validationLabel.isHidden)
        XCTAssertFalse(emailTextField.validImageView.isHidden)
    }

    func testInvalidEmail() {
        emailTextField.text = "invalid-email"
        emailTextField.textFieldDidChange()

        XCTAssertFalse(emailTextField.validationLabel.isHidden)
        XCTAssertEqual(emailTextField.validationLabel.text, "Invalid email address")
        XCTAssertTrue(emailTextField.validImageView.isHidden)
    }

    func testEmptyEmail() {
        emailTextField.text = ""
        emailTextField.textFieldDidChange()

        XCTAssertTrue(emailTextField.validationLabel.isHidden)
        XCTAssertTrue(emailTextField.validImageView.isHidden)
    }
}
