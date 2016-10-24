class BookingPolicy < ApplicationPolicy

	def create?
    Training.where(id: @record.training.id).exists? && @record.user == user
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
