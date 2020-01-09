
import RxSwift
import RxCocoa

class viewModel {
    private let model = Model()
    let disposeBag = DisposeBag()
    let bh = BehaviorRelay<String>(value: "")
    let pr = PublishRelay<[TODO]>()
    
    //saveBtn: to save realmdata, todos: binded tableview
    init(saveBtn: Observable<Void>, todos: PublishRelay<[TODO]>, todofield: ControlProperty<String?>) {
        
        _ = saveBtn.subscribe(onNext:{ _ in
            self.save(text: self.bh.value)
            self.bh.accept("")
            self.pr.accept(self.allasarray())
            }).disposed(by: disposeBag)
        
        //to accept "" to field from ViewController
        bh.bind(to: todofield).disposed(by: disposeBag)
        pr.bind(to: todos).disposed(by: disposeBag)
        
        //table init
        pr.accept(self.allasarray())
    }
    
    func allasarray() -> [TODO] {
        return model.allasarray()
    }
    
    func save(text: String) {
        if !text.isEmpty {
            model.save(text)
        }
    }
    
    func removeItem(at: IndexPath) {
        let theItem = self.allasarray()[at.row]
        pr.accept(model.remove(theItem))
    }
}
