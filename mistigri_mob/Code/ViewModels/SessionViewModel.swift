//
//  SessionViewModel.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 21/03/2025.
//

import SwiftUI

class SessionViewModel: ObservableObject {
    @Published var current: Session = Session(id:"",name:"",startDate: "",endDate: "")
    @Published var sessions: [Session] = []

    func fetchCurrentSession(completion: @escaping () -> Void) {
        let fetchAction = FetchCurrentSession()
        fetchAction.call(onSuccess: { response in
            DispatchQueue.main.async {
                self.current = response.currentSession
                completion()
            }
        }, onError: { error in
            print(error)
        })
    }

    func fetchAllSession(completion: @escaping () -> Void) {
        let fetchAction = FetchAllSession()
        fetchAction.call(onSuccess: { response in
            DispatchQueue.main.async {
                self.sessions = response.sessions
                completion()
            }
        }, onError: { error in
            print(error)
        })
    }
}
