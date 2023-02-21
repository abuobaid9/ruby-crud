class Entry < ApplicationRecord
    validates :calories, :proteins, :carbohydrater, :fats, :meal_type, presence: true
    def day
        self.created_at.strftime("%b %e, %y")
end
end

