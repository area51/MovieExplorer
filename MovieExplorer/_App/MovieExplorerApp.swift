//
//  MovieExplorer
//

import SwiftUI

@main
struct MovieExplorerApp: App {
    let diContainer = DIContainer()
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            PopularMoviesListViewComposer(diContainer).compose()
        }.onChange(of: scenePhase) { phase in
            switch phase {
            case .background:
                savePersistenceContext()
            default:
                break
            }
        }
    }

    private func savePersistenceContext() {
        diContainer.persistenceController.saveContext()
    }
}
