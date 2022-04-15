require 'uri'
require 'net/http'
require 'openssl'

class SearchController < ApplicationController

    before_action :init_results

    def index
    end

    def init_results
        @resultsName = []
        @resultsURL= []
    end

    def showsearch(titleName)
        id_url = URI("https://watchmode.p.rapidapi.com/search/?search_field=name&search_value=#{titleName}")

        http = Net::HTTP.new(id_url.host, id_url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        idrequest = Net::HTTP::Get.new(id_url)
        idrequest["x-rapidapi-host"] = 'watchmode.p.rapidapi.com'
        idrequest["x-rapidapi-key"] = '3f2560c7e3msh18d24d47fcda8f8p17b513jsn0a997cc33ab8'

        @idresponse = http.request(idrequest)
        @idresult = JSON.parse(@idresponse.read_body)
        i=0
        while i < @idresult.size
            while @idresult['title_results'][i]['id'] != nil
                @id = @idresult['title_results'][i]['id']
                @titles = @idresult['title_results'][i]['name']
                @search = Search.create(search_id: @id, title: @titles)
                break
            end
            i = i + 1
        end
        return "show search successful"
    end

    def networksearch(searchid)
        services_url = URI("https://watchmode.p.rapidapi.com/title/#{searchid}/sources/")
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
                @network_name = @services_result[j]['name']
                @network_url = @services_result[j]['web_url']
                @network = Network.create(search_id: searchid, network_name: @network_name, network_url: @network_url)
            end
            j = j + 1
        end
        return "network search successful"
    end

    def show
        titleName = params[:search][:title]
        #API call is made only if the record does not exist
        if !Search.exists?(title: titleName)
            showsearch(titleName)
       end
        # streaming services results
        searchid = Search.select("search_id").where(title: titleName)
        searchid.each_with_index do |i|
            searchid = i.search_id
        end

        if !Network.exists?(search_id: searchid)
            networksearch(searchid)
        end

        @all_networks = Network.where(search_id:searchid).select("network_name")
        @all_networks.each_with_index do |i|
            @all_networks = i.network_name
            @resultsName.push(@all_networks)
        end
        @all_urls = Network.where(search_id:searchid).select("network_url")
        @all_urls.each_with_index do |i|
            @all_urls = i.network_url
            @resultsURL.push(@all_urls)
        end
        return "Show results successful"
    end
end
