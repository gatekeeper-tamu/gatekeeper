require 'uri'
require 'net/http'
require 'openssl'


class SearchController < ApplicationController
    def index
    end   

    def show 
        id_url = URI("https://watchmode.p.rapidapi.com/list-titles/?types=movie%2Ctv_series&regions=US")

        http = Net::HTTP.new(id_url.host, id_url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        
        idrequest = Net::HTTP::Get.new(id_url)
        idrequest["x-rapidapi-host"] = 'watchmode.p.rapidapi.com'
        idrequest["x-rapidapi-key"] = '3f2560c7e3msh18d24d47fcda8f8p17b513jsn0a997cc33ab8'
        
        @idresponse = http.request(idrequest)
        @idresult = JSON.parse(@idresponse.read_body)

        i = 0
        while i < @idresult['titles'].size
            puts i
            if @idresult['titles'][i]['title'] === "Fresh"
                @id = @idresult['titles'][i]['id']
                puts @id
                break
            end
            i = i + 1
        end

        # #streaming services results
        # services_url = URI("https://watchmode.p.rapidapi.com/title/{@id}/sources/")

        # http = Net::HTTP.new(services_url.host, services_url.port)
        # http.use_ssl = true
        # http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        # services_request = Net::HTTP::Get.new(services_url)
        # services_request["x-rapidapi-host"] = 'watchmode.p.rapidapi.com'
        # services_request["x-rapidapi-key"] = '3f2560c7e3msh18d24d47fcda8f8p17b513jsn0a997cc33ab8'

        # @services_response = http.request(services_request)
        # @services_result = JSON.parse(@services_response.read_body)

        # while i < @services_result.size
        #     if @services_result[i]['type'] === "sub"
        #         puts @services_result[i]['name']
        #         break
        #     end
        #     i = i + 1
        # end

    end
end