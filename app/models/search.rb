class Search < ApplicationRecord
    def self.dedupe
        # find all models and group them on keys which should be common
        grouped = all.group_by{|searches| [searches.search_id,searches.title] }
        grouped.values.each do |duplicates|
          # the first one we want to keep 
          first_one = duplicates.shift 
          # if there are any more left, they are duplicates
          # so delete all of them
          duplicates.each{|double| double.destroy} # duplicates can now be destroyed
        end
    end
end

Search.dedupe
