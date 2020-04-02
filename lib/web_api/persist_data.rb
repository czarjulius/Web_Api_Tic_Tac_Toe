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
        elsif key == 'player'
            return @data[key] || 'x'
        elsif key == 'opponent'
            return @data[key] || 'human'
        end
        @data[key]
    end

    def reset_detail
        @data.clear
        "Data reset to an empty hash"
    end

    
end