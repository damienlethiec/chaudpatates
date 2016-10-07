class City < ApplicationRecord
  belongs_to :user

  alias_attribute :user, :coach
end
