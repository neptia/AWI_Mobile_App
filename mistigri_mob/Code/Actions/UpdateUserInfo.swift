import Foundation

struct UpdateUserInfo {
    var parameters: User

    func call(onSuccess: @escaping (String) -> Void, onError: @escaping (String) -> Void) {
        let alertManager:AlertManager = AlertManager()
        let path: String = "/users/" + parameters.id
        let fullUrlString = baseUrl + path
        guard let url = URL(string: fullUrlString) else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        do {
            request.httpBody = try JSONEncoder().encode(parameters)
        } catch {
            print("Unable to encode request parameters")
            onError("Unknown error. Please try again later.")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response from server")
                onError("Invalid response from server")
                return
            }

            // Vérifie le code de statut HTTP
            if (200...299).contains(httpResponse.statusCode) {
                // La requête a réussi, on essaie de décoder le message
                if let data = data {
                    do {
                        // Décodage de la réponse JSON
                        let jsonResponse = try JSONDecoder().decode([String: String].self, from: data)
                        if let message = jsonResponse["message"] {
                            alertManager.showAlertMessage(message:message)
                            onSuccess(message) // On passe le message de succès
                        } else {
                            onError("Unknown response format")
                        }
                    } catch {
                        print("Unable to decode response JSON")
                        onError("Unknown error. Please try again.")
                    }
                }
            } else {
                // Le serveur a répondu avec un code d'erreur
                if let data = data {
                    do {
                        // Décodage de la réponse pour récupérer l'erreur (message)
                        let jsonResponse = try JSONDecoder().decode([String: String].self, from: data)
                        if let message = jsonResponse["message"] {
                            alertManager.showAlertMessage(message:message)
                            onError(message) // On passe le message d'erreur
                        } else {
                            onError("Unknown error")
                        }
                    } catch {
                        print("Unable to decode response JSON")
                        onError("Unknown error. Please try again.")
                    }
                }
            }
        }
        task.resume()
    }
}
