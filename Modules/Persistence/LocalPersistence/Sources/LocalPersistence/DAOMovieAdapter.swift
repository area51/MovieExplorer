//
//  LocalPersistence
//

import Foundation
import CoreData
import Domain

class DAOMovieAdapter {
    public enum Error: String, Swift.Error {
        case failedToCreateEntity
    }

    static func dao(
        from movie: Movie,
        in context: NSManagedObjectContext) throws -> MovieDAO {

            guard let entity = NSEntityDescription.entity(
                forEntityName: String(describing: MovieDAO.self),
                in: context) else {

                    throw DAOMovieAdapter.Error.failedToCreateEntity
                }

            let dao = MovieDAO(entity: entity, insertInto: context)
            dao.identifier = NSNumber(value: movie.id)
            dao.title = movie.title
            dao.overview = movie.overview
            dao.releaseDate = movie.releaseDate
            dao.posterPath = movie.posterPath
            dao.backdropPath = movie.backdropPath
            dao.voteAverage = NSNumber(value: movie.voteAverage)

            return dao
        }
}
