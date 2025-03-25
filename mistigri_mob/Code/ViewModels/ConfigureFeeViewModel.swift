import SwiftUI

class ConfigureFeeViewModel: ObservableObject {
    @Published var depositFee: Double = 0
    @Published var commissionFee: Double = 0
    @Published var depositState: String = ""
    @Published var commissionState: String = ""

    @Published var showAlert: Bool = false
    @Published var messageAlert: String = ""

    func fetchCommissionFee(completion: @escaping () -> Void) {
        let fetchAction = FetchCommissionFee()
        fetchAction.call(onSuccess: { response in
            DispatchQueue.main.async {
                self.commissionFee = response.CommissionFees[0].amount
                self.commissionState = response.CommissionFees[0].state
                completion()
            }
        }, onError: { error in
            print(error)
        })
    }

    func fetchDepositFee(completion: @escaping () -> Void) {
        let fetchAction = FetchDepositFee()
        fetchAction.call(onSuccess: { response in
            DispatchQueue.main.async {
                self.depositFee = response.depositFees[0].amount
                self.depositState = response.depositFees[0].state
                completion()
            }
        }, onError: { error in
            print(error)
        })
    }

    func updateDepositFee(completion: @escaping () -> Void) {
        let newDepositFee = updateDepositFeeRequest(state: depositState, amount: depositFee)
        let fetchAction = UpdateDepositFee(parameters: newDepositFee)

        fetchAction.call(onSuccess: { response in
            DispatchQueue.main.async {
                self.messageAlert = response.message
                self.showAlert = true
                completion()
            }
        }, onError: { error in
            DispatchQueue.main.async {
                self.messageAlert = error
                self.showAlert = true
            }
        })
    }

    func updateCommissionFee(completion: @escaping () -> Void) {
        let newCommissionFee = updateCommissionFeeRequest(state: commissionState, amount: commissionFee)
        let fetchAction = UpdateCommissionFee(parameters: newCommissionFee)

        fetchAction.call(onSuccess: { response in
            DispatchQueue.main.async {
                self.messageAlert = response.message
                self.showAlert = true
                completion()
            }
        }, onError: { error in
            DispatchQueue.main.async {
                self.messageAlert = error
                self.showAlert = true
            }
        })
    }
}
