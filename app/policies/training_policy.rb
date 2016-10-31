class TrainingPolicy < ApplicationPolicy

	def index?
		true
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
