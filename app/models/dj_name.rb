class DJName

  ALL = File.read('db/data/dj_names.txt').lines.map(&:chomp)

  class << self

    def rand
      "DJ #{ALL.shuffle.first(2).join(' ')}"
    end

  end

end
