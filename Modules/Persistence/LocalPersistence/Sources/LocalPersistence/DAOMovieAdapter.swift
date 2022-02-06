//
//  LocalPersistence
//

import Foundation
import CoreData
import Domain

class DAOMovieAdapter {
    public enum Error: Swift.Error {
        case failedToCreateEntity
        case invalidPropertyValue(error: String)
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

    static func movie(from dao: MovieDAO) throws -> Movie {
        guard let id = dao.identifier?.intValue,
              let title = dao.title,
              let overview = dao.overview,
              let releaseDate = dao.releaseDate,
              let posterPath = dao.posterPath,
              let backdropPath = dao.backdropPath,
              let voteAverage = dao.voteAverage?.floatValue else {

                  throw Error.invalidPropertyValue(error: "MovieDAO is incomplete")
        }

        return Movie(
            id: id,
            title: title,
            overview: overview,
            releaseDate: releaseDate,
            posterPath: posterPath,
            backdropPath: backdropPath,
            voteAverage: voteAverage)
    }
}
