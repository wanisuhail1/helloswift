import XCTest
@testable import Themes

class ThemeTests: XCTestCase {

  struct MyTheme: Theme {
    let color: UIColor
    let font: UIFont
    let placeholder: String
  }

  struct OtherTheme: Theme {

  }

  func testKey() {
    XCTAssertEqual(String(describing: MyTheme.self), "MyTheme")
    XCTAssertEqual(String(describing: OtherTheme.self), "OtherTheme")
  }

  func testTheme() {
    let theme1 = MyTheme(color: .red, font: .systemFont(ofSize: 12), placeholder: "theme 1")
    let theme2 = MyTheme(color: .green, font: .systemFont(ofSize: 10), placeholder: "theme 2")

    // theme 1
    ThemeManager.shared.currentTheme = theme1

    let textField = UITextField()

    textField.use(MyTheme.self) {
      $0.textColor = $1.color
      $0.font = $1.font
      $0.placeholder = $1.placeholder
    }

    // init with theme 1 immediately
    XCTAssertEqual(textField.textColor, UIColor.red)
    XCTAssertEqual(textField.font, UIFont.systemFont(ofSize: 12))
    XCTAssertEqual(textField.placeholder, "theme 1")

    // theme 2
    ThemeManager.shared.currentTheme = theme2

    // change to theme 2
    XCTAssertEqual(textField.textColor, UIColor.green)
    XCTAssertEqual(textField.font, UIFont.systemFont(ofSize: 10))
    XCTAssertEqual(textField.placeholder, "theme 2")

    // other theme

    ThemeManager.shared.currentTheme = OtherTheme()

    // textField is unchanged
    XCTAssertEqual(textField.textColor, UIColor.green)
    XCTAssertEqual(textField.font, UIFont.systemFont(ofSize: 10))
    XCTAssertEqual(textField.placeholder, "theme 2")
  }
}
