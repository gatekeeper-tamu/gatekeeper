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

    #Makes an API call to search for is based on user search input
    def showsearch(title_name)

        #preparing to make first API call for show title
        id_url = URI("https://watchmode.p.rapidapi.com/search/?search_field=name&search_value=#{title_name}")
        http = Net::HTTP.new(id_url.host, id_url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        idrequest = Net::HTTP::Get.new(id_url)
        #response from API call
        idrequest["x-rapidapi-host"] = ENV["RAPIDAPI_API_URL"]
        idrequest["x-rapidapi-key"] = ENV["RAPIDAPI_API_KEY"]
        @idresponse = http.request(idrequest)
        @idresult = JSON.parse(@idresponse.read_body)

        #parsing valid response for id, title to create new entry in Searches table
        i=0
        inResults = false
        while i < @idresult.size
            if @idresult['title_results'] == []
                redirect_to '/index' and return
            elsif  @idresult['title_results'] == nil
                redirect_to '/search/empty' and return
            else
                if  @idresult['title_results'] != nil
                    if @idresult['title_results'][i] != nil
                        if title_name == @idresult['title_results'][i]['name']
                            inResults = true
                        end
                    end
                    if @idresult != nil && @idresult['title_results'][i] != nil
                        while @idresult['title_results'][i]['id'] != nil
                            @id = @idresult['title_results'][i]['id']
                            @titles = @idresult['title_results'][i]['name']
                            @search = Search.create(search_id: @id, title: @titles)
                            break
                        end
                    end
                end
            end
            i = i + 1

        end
        if inResults == false
            redirect_to '/search/empty' and return
        end
        return "show search successful"
    end

    #uses id to find networks available for a particular search input
    def networksearch(searchid)
        #preparing second API call
        services_url = URI("https://watchmode.p.rapidapi.com/title/#{searchid}/sources/")
        http = Net::HTTP.new(services_url.host, services_url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        services_request = Net::HTTP::Get.new(services_url)
        services_request["x-rapidapi-host"] = 'watchmode.p.rapidapi.com'
        services_request["x-rapidapi-key"] = '3f2560c7e3msh18d24d47fcda8f8p17b513jsn0a997cc33ab8'

        #response from API call
        @services_response = http.request(services_request)
        @services_result = JSON.parse(@services_response.read_body)

        if @services_result.size === 0  #no result found
            puts 'empty'
        end
      
        #parsing second API call response to find available network providers
        j=0
        while j < @services_result.size
            if @services_result[j]['type'] === "sub"
                @network_name = @services_result[j]['name']
                @network_url = @services_result[j]['web_url']
                @network = Network.create(search_id: searchid, network_name: @network_name, network_url: @network_url)
                if @services_result[j] == nil
                    redirect_to '/search/empty' and return
                end
            end
            j = j + 1
        end
        return "network search successful"
    end

    # show function

    def show
        titleName = params[:search][:title]
        title_name = titleName.titleize()

        #API call is made only if the record does not exist
        if !Search.exists?(title: title_name)
            showsearch(title_name)
       end

       #search for record in database
        search_id = []
        searchid = Search.select("search_id").where(title: title_name)
        searchid.each_with_index do |i|
            search_id.push(i.search_id)
        end

        # streaming services results
        i=0
        while i < search_id.size
            if !Network.exists?(search_id: search_id[i])
                networksearch(search_id[i])
            end
            @all_networks = Network.where(search_id:search_id[i]).select("network_name")
            @all_networks.each_with_index do |i|
                @all_networks = i.network_name
                @resultsName.push(@all_networks)
            end
            @all_urls = Network.where(search_id:search_id[i]).select("network_url")
            @all_urls.each_with_index do |i|
                @all_urls = i.network_url
                @resultsURL.push(@all_urls)
            end
            i = i+1
        end
        return "Show results successful"
    end
end
