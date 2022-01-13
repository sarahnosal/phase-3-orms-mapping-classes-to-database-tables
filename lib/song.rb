class Song

  attr_accessor :name, :album, :id

  def initialize(name:, album:, id: nil)
    # initialize with an id attribute cuz each row needs an id value for primary key
    # set it to nil cuz it gets an id only when it is saved to database
    @id = id
    @name = name
    @album = album
  end

  # responsibility of class to create its own table
  def self.create_table
    # use <<- for strings that take up multiple lines- SQl means special word for beginning of doc
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS songs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        album TEXT
      )
      SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO songs (name, album)
      VALUES (?, ?)
    SQL

    # insert the song
    DB[:conn].execute(sql, self.name, self.album)

    # get the song ID from the database and save it to the Ruby instance
    self.id = DB[:conn].execute('SELECT last_insert_rowid() FROM songs')[0][0]

    # return the ruby instance
    self
  end
  def self.create(name:, album:)
    song = Song.new(name: name, album: album)
    song.save
  end
end
