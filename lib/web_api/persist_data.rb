class PersistData
    attr_accessor :data
    def initialize(data={})
        @data = data

    end

    def add_detail(key,value)
        @data.store(key,value)
    end

    def get_detail(key)
        if key == 'board'
            return @data[key] || Array.new(9,"-")
        end
        @data[key]
    end

end