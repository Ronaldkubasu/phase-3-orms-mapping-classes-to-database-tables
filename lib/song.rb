class Song

  attr_accessor :name, :album, :id

  def initialize(name:, album:, id:nil)
    @name = name
    @album = album
  end

  def self.create_table
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
    sql = <<-sql
      insert into songs(name,album)
      values (?,?)
    sql
    DB[:conn].execute(sql,self.name,self.album)

    self.id = DB[:conn].execute("Select last_insert_rowid() from songs")[0][0]
    self
  end

  def self.create(name:,album:)
    song = Song.new(name: name, album: album,)
    song.save
  end
  self

end