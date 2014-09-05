module ApplicationHelper

	def flash_class(type)
		case type
		when 'alert' then "alert"
		when 'notice' then "success" 
		else
			""
		end
	end
			
end
