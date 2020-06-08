import Dip
import RxCocoa
import RxSwift
import os.log

class FeverDaysViewModel {
    private let symptomFlowManager: SymptomFlowManager

    let title = L10n.Ux.Fever.heading

    init(symptomFlowManager: SymptomFlowManager) {
        self.symptomFlowManager = symptomFlowManager
    }

    func onDaysChanged(daysStr: String) {
        if (daysStr.isEmpty) {
            symptomFlowManager.setFeverDays(.none).expect()
        } else {
            if let days: Int = Int(daysStr) {
                symptomFlowManager.setFeverDays(.some(SymptomInputs.Days(value: days))).expect()
            } else {
                // TODO handle
                os_log("Invalid input: %{public}@ TODO handle", log: servicesLog, type: .debug, "\(daysStr)")
            }
        }
    }

    func onSubmitTap() {
        symptomFlowManager.navigateForward()
    }

    func onUnknownTap() {
        symptomFlowManager.navigateForward()
    }

    func onSkipTap() {
        symptomFlowManager.navigateForward()
    }

    func onBack() {
        symptomFlowManager.onBack()
    }
}