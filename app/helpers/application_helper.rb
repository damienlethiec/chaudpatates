module ApplicationHelper

	WEEKDAY_NAMES = [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

	def wday(day)
		wday_from_name =  Hash[*WEEKDAY_NAMES.each_with_index.to_a.flatten]
		wday_from_name[day]
	end
end
