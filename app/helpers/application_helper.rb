module ApplicationHelper

    def search_by_title reference_title
        where("title ilike ?", "%#{reference_title}%")
    end
end
