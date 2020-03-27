class ResultRenderer
    def render(result)
        {message: result}.to_json
    end
end