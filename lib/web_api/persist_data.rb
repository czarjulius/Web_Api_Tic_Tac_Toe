class PersistData
    attr_accessor :data
    def initialize(data={})
        @data = data
    end

    def add_detail(key,value)
        @data.store(key,value)
    end

    def get_detail(key)
        @data[key]
    end

end