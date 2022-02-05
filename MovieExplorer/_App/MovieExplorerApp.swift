//
//  MovieExplorer
//

import SwiftUI

@main
struct MovieExplorerApp: App {
    let diContainer = DIContainer()

    var body: some Scene {
        WindowGroup {
            PopularMoviesListViewComposer(diContainer).compose()
        }
    }
}
