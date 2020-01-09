
import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    private var vm: viewModel?
    let table = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 50))
    let bottomarea = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width, height: 50))
    let field = UITextField(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 50, height: 50))
//    let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 50, y: 0, width: 50, height: 50))
    let button = IconCollection(frame: CGRect(x: UIScreen.main.bounds.width - 50, y: 0, width: 50, height: 50))
    let disposeBag = DisposeBag()
    let todos = PublishRelay<[TODO]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.tintColor = .systemBlue
        button.iconKind = .forward
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        field.backgroundColor = .separator
        self.view.addSubview(table)
        self.view.addSubview(bottomarea)
        bottomarea.addSubview(field)
        bottomarea.addSubview(button)
        
        todos.bind(to: table.rx.items(cellIdentifier: "Cell")) { row, element, cell in
            let tap = UITapGestureRecognizer()
            tap.rx.event.subscribe(onNext: { _ in
                print("taped \(element.text ?? "nil")")
            }).disposed(by: self.disposeBag)
            cell.addGestureRecognizer(tap)
            cell.textLabel?.text = element.text
        }.disposed(by: disposeBag)
        
        vm = viewModel(saveBtn: button.rx.tap.asObservable(), todos: todos, todofield: field.rx.text)
        field.rx.text.orEmpty.bind(to: vm!.bh).disposed(by: disposeBag)
        
        /*/will not change... TODO: improve iconCollection
        field.rx.text.orEmpty.subscribe(onNext: { text in
            if text.isEmpty {
                self.button.tintColor = .gray
            } else {
                self.button.tintColor = .blue
            }
        }).disposed(by: disposeBag)
         */
        
        table.rx.itemDeleted.subscribe(onNext: {
            self.vm!.removeItem(at: $0)
        }).disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification, object: nil).subscribe(onNext: { notification in
            print(notification)
            self.keyboardWillShow(notification)
        }).disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification, object: nil).subscribe(onNext: { notification in
            self.keyboardWillHide(notification)
        }).disposed(by: disposeBag)
    }
    
    private func keyboardWillShow(_ notification: Notification) {
        guard let rect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        print("rect \(rect)")
        UIView.animate(withDuration: duration) {
            self.table.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 50 - rect.height)
            self.bottomarea.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 50 - rect.height, width: UIScreen.main.bounds.width, height: 50)
        }
    }
    private func keyboardWillHide(_ notification: Notification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        
        UIView.animate(withDuration: duration) {
            self.table.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 50)
            self.bottomarea.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width, height: 50)
        }
    }
}
