require 'uri'
require 'net/http'
require 'openssl'


class SearchController < ApplicationController

    before_action :init_results

    def index
    end

    def init_results
        @resultsName = []
    end

    def show
        #search by title name
        @titleName = params[:search][:title]
        id_url = URI("https://watchmode.p.rapidapi.com/search/?search_field=name&search_value=#@titleName")
        puts "title: is "
        puts params[:search][:title]
        puts params

        http = Net::HTTP.new(id_url.host, id_url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        idrequest = Net::HTTP::Get.new(id_url)
        idrequest["x-rapidapi-host"] = 'watchmode.p.rapidapi.com'
        idrequest["x-rapidapi-key"] = '3f2560c7e3msh18d24d47fcda8f8p17b513jsn0a997cc33ab8'

        @idresponse = http.request(idrequest)
        @idresult = JSON.parse(@idresponse.read_body)

        i=0
        #while loop for multiple shows with the same name (use riverdale as an example)
        @resultsURL = []
        @services_result
        while i < @idresult.size
            while @idresult['title_results'][i]['id'] != nil
                @id = @idresult['title_results'][i]['id']
                puts @id
                break
            end

        #streaming services results
            services_url = URI("https://watchmode.p.rapidapi.com/title/#@id/sources/")
            http = Net::HTTP.new(services_url.host, services_url.port)
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE

            services_request = Net::HTTP::Get.new(services_url)
            services_request["x-rapidapi-host"] = 'watchmode.p.rapidapi.com'
            services_request["x-rapidapi-key"] = '3f2560c7e3msh18d24d47fcda8f8p17b513jsn0a997cc33ab8'

            @services_response = http.request(services_request)
            @services_result = JSON.parse(@services_response.read_body)

            if @services_result.size === 0
                puts 'empty'
            end

            j=0
            while j < @services_result.size
                if @services_result[j]['type'] === "sub"
                    @resultsName.push @services_result[j]['name']
                    @resultsName.push @services_result[j]['web_url']
                end
                j = j + 1
            end
            i = i + 1
        end
        puts @resultsName

    end
end
