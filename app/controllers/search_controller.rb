class SearchController < ApplicationController
    def index
    end

    def search 
        #searches = find_networks(params[:title])
        searches = find_networks


        unless searches
            flash[:alert] = 'Search not found'
            return render action :index
        end

        @response = searches
    end

    def request_api(url)
        response = Excon.get(
            url,
            headers:{
                'X-RapidAPI-Host' => 'watchmode.p.rapidapi.com',
                # 'X-RapidAPI-Key' => ENV.fetch('RAPIDAPI_API_KEY')
                'X-RapidAPI-Key' => '3f2560c7e3msh18d24d47fcda8f8p17b513jsn0a997cc33ab8'
            }
        )
        return nil if response.status !=200

        JSON.parse(response[0]["name"])
    end

    #def find_networks(title)
    def find_networks()
        request_api(
            "https://watchmode.p.rapidapi.com/title/3173903/sources/"
        
        )
    end
end
