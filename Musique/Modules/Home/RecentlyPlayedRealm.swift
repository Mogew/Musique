import RealmSwift

class RecentlySong: Object {
//    @Persisted(primaryKey: true) var _id: ObjectId = ObjectId.generate()
    @Persisted var artistName: String?
    @Persisted var trackName: String?
    @Persisted(primaryKey: true) var previewUrl: String?
    @Persisted var artworkUrl100: String?

    convenience init(songObject: SearchTracks) {
       self.init()
        self.artistName = songObject.artistName
        self.trackName = songObject.trackName
        self.previewUrl = songObject.previewUrl
        self.artworkUrl100 = songObject.artworkUrl100
   }
}
