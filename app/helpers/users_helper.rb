module UsersHelper
    def all_category_name(categories) 
        category_name = [];
        categories.each do |category|
            category_name << category.name
        end
        return category_name.join(",")
    end
end
