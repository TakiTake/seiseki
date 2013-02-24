class Model
  @@table_name = 'seiseki'

  class << self
    def find_by_date(date)
    end
  end

  def save(attrs)
  end
end

class Normal < Model
  @@db = SQLite3::Database.new(File.expand_path('../../db/normal.db', __FILE__))

  class << self
    def create
      sql = 'DROP TABLE IF EXISTS seiseki'
      @@db.execute(sql)

      sql = %(
        CREATE TABLE seiseki (
          date text,
          student_id text,
          subject1 integer,
          subject2 integer,
          subject3 integer,
          subject4 integer,
          subject5 integer
        )
      )
      @@db.execute(sql)

      sql = "CREATE INDEX seiseki_idx on seiseki(date)"
      @@db.execute(sql)
    end

    def find_by_date(date)
      sql = "SELECT * FROM #{@@table_name} WHERE date = ?"
      @@db.execute(sql, date)
    end
  end

  def save(attrs)
    sql = "INSERT INTO #{@@table_name} VALUES (?, ?, ?, ?, ?, ?, ?)"
    rst = []
    @@db.execute(sql, attrs) do |row|
      rst << row
    end

    rst
  end
end

class Binary < Model
  @@db = SQLite3::Database.new(File.expand_path('../../db/binary.db', __FILE__))

  class << self
    def create
      sql = 'DROP TABLE IF EXISTS seiseki'
      @@db.execute(sql)

      sql = %(
        CREATE TABLE seiseki (
          date text,
          student_id text,
          subject bolb
        )
      )
      @@db.execute(sql)

      sql = "CREATE INDEX seiseki_idx on seiseki(date)"
      @@db.execute(sql)
    end

    def find_by_date(date)
      sql = "SELECT * FROM #{@@table_name} WHERE date = ?"
      rst = []
      @@db.execute(sql, date) do |row|
        rst << row
      end

      rst
    end
  end

  def save(attrs)
    month, student_id, *data = attrs
    sql = "INSERT INTO #{@@table_name} VALUES (?, ?, ?)"
    @@db.execute(sql, [month, student_id, data.pack('w5')])
  end
end
