import UIKit
import RxSwift

class CoughDaysViewController: UIViewController {
    private let viewModel: CoughDaysViewModel

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!

    @IBOutlet weak var unknownButtonLabel: UIButton!
    @IBOutlet weak var submitButtonLabel: UIButton!
    @IBOutlet weak var skipButtonLabel: UIButton!

    @IBOutlet weak var daysInput: UITextField!

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

    init(viewModel: CoughDaysViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: nil)
        title = viewModel.title
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

        titleLabel.text = L10n.Ux.Cough.title2
        skipButtonLabel.setTitle(L10n.Ux.skip, for: .normal)
        daysLabel.text = L10n.Ux.days

        unknownButtonLabel.setTitle(L10n.Ux.unknown, for: .normal)
        submitButtonLabel.setTitle(L10n.Ux.submit, for: .normal)

        ButtonStyles.applyUnselected(to: unknownButtonLabel)
        ButtonStyles.applyRoundedEnds(to: submitButtonLabel)
        ButtonStyles.applyShadows(to: submitButtonLabel)

        viewModel.submitButtonEnabled
            .drive(submitButtonLabel.rx.isEnabled)
            .disposed(by: disposeBag)

        viewModel.submitButtonEnabled
            .map { $0 ? .systemBlue : .lightGray }
            .drive(submitButtonLabel.rx.backgroundColor)
            .disposed(by: disposeBag)

        daysInput.rx.text
            .distinctUntilChanged()
            .subscribe(onNext: { [viewModel] text in
                viewModel.onDaysChanged(daysStr: text ?? "")
            })
            .disposed(by: disposeBag)

        daysInput.rx.controlEvent(.editingChanged).subscribe(onNext: { [weak self] in
             if let text = self?.daysInput.text {
                 self?.daysInput.text = String(text.prefix(2))
              }
          }).disposed(by: disposeBag)

     }
}

class CustomTextFieldCough: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
