class BookingPolicy < ApplicationPolicy

	def index?
		true
	end

	def create?
    Training.where(id: @record.training.id).exists? && @record.user == user
	end

  def destroy?
    record.user == user
  end

  class Scope < Scope
    def resolve
      scope.where('user_id = ?', user.id).upcoming
    end
  end
end
