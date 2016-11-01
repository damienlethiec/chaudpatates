class TrainingPolicy < ApplicationPolicy

	def index?
		user.is_coach
	end

	def destroy?
    record.city.coach == user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
