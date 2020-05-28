import UIKit
import RxSwift

class FeverTempViewController: UIViewController {
    private let viewModel: FeverTempViewModel
    
    var scale = ""

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var numberInput: UITextField!

    @IBOutlet weak var unknownButtonLabel: UIButton!
    @IBOutlet weak var submitButtonLabel: UIButton!
    @IBOutlet weak var skipButtonLabel: UIButton!
    @IBOutlet weak var scaleButtonLabel: UIButton!

    private let disposeBag = DisposeBag()

    @IBAction func unknownButtonAction(_ sender: UIButton) {
        viewModel.onUnknownTap()
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        viewModel.onSubmitTap()
    }
    
    @IBAction func skipButtonAction(_ sender: UIButton) {
        viewModel.onSkipTap()
    }
    
    @IBAction func scaleButtonAction(_ sender: UIButton) {
        
        if scale == "F"{
            let attributedTextScale = NSMutableAttributedString(string: L10n.Ux.Fever.f, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 35)])
            
             attributedTextScale.append(NSMutableAttributedString(string: "/", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40)]))
            
            attributedTextScale.append(NSMutableAttributedString(string: L10n.Ux.Fever.c, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40)]))
            scaleButtonLabel.setAttributedTitle(attributedTextScale, for: .normal)
            scale = "C"
        }
        else{
            let attributedTextScale = NSMutableAttributedString(string: L10n.Ux.Fever.f, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40)])
            
             attributedTextScale.append(NSMutableAttributedString(string: "/", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40)]))
            
            attributedTextScale.append(NSMutableAttributedString(string: L10n.Ux.Fever.c, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 35)]))
            scaleButtonLabel.setAttributedTitle(attributedTextScale, for: .normal)
            scale = "F"
        }
        
        
        

    }
    
    
    
    init(viewModel: FeverTempViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: nil)
        title = viewModel.title
        UINavigationBar.appearance().titleTextAttributes = [.font: Fonts.robotoRegular]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if parent == nil {
            viewModel.onBack()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background_white.png")!)
        
        titleLabel.text = L10n.Ux.Fever.title4
        skipButtonLabel.setTitle(L10n.Ux.skip, for: .normal)
        //daysLabel.text = L10n.Ux.days
        
        scale = "F"
        
        let attributedTextScale = NSMutableAttributedString(string: L10n.Ux.Fever.f, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40)])
        
         attributedTextScale.append(NSMutableAttributedString(string: "/", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40)]))
        
        attributedTextScale.append(NSMutableAttributedString(string: L10n.Ux.Fever.c, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 35)]))
        scaleButtonLabel.setAttributedTitle(attributedTextScale, for: .normal)
        scaleButtonLabel.tintColor = .black
        
        
        
        unknownButtonLabel.setTitle(L10n.Ux.unknown, for: .normal)
        submitButtonLabel.setTitle(L10n.Ux.submit, for: .normal)

        numberInput.rx.text
            .distinctUntilChanged()
            .subscribe(onNext: { [viewModel] text in
                viewModel.onTempChanged(tempStr: text ?? "")
            })
            .disposed(by: disposeBag)
     }
}
