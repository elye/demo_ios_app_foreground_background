import UIKit

class ViewController: UIViewController {

    private var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        textField = createTextField()
    }

    func createTextField() -> UITextField {
        let textField = UITextField()
        view.addSubview(textField)
        textField.textAlignment = .center
        textField.setupView(parentView: self.view, color: .gray)
        return textField
    }
}

extension UIView {
    func setupView(parentView: UIView, color: UIColor) {
        parentView.addSubview(self)
        self.backgroundColor = color
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            self.heightAnchor.constraint(equalToConstant: 60),
            self.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
}
