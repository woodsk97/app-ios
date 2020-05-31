import UIKit

class SymptomReportCell: UITableViewCell {
    private var symptomView: SymptomView!

    var onChecked: ((SymptomViewData) -> ())? {
        didSet {
            symptomView.onChecked = onChecked
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    private func setupUI() {
        let view: SymptomView = SymptomView.fromNib()
        contentView.addSubview(view)
        view.pinAllEdgesToParent()

        self.symptomView = view
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setQuestion(question: SymptomViewData) {
        symptomView.setQuestion(question: question)
        symptomView.onChecked = onChecked
    }
}

class SymptomView: UIView {

    @IBOutlet weak var button: UIButton!

    public var onChecked: ((SymptomViewData) -> ())?

    private var question: SymptomViewData?

    public func setQuestion(question: SymptomViewData) {
        self.question = question
        button.setTitle(question.text, for: .normal)

        let (imageName, fg): (String, UIColor) = {
            if question.checked {
                return ("smallOvalButton_Selected", .white)
            } else {
                return ("smallOvalButton", .coEpiPurple)
            }
        }()
        button.setBackgroundImage(UIImage(named: imageName), for: .normal)
        button.setTitleColor(fg, for: .normal)
    }

    @IBAction func onSymptomTap(_ sender: UIButton) {
        if let question = question {
            onChecked?(question)
        }
    }
}