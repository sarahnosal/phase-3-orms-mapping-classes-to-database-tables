class Song

  attr_accessor :name, :albumm :id

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
end
