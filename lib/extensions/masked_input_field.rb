

module ActionView::Helpers
	class FormBuilder
		#This method extends the form builder with a new method to create masked text field,
		#An unobstrusive javascript helper has to be add
		def masked_text_field(method,mask,options={})
			@template.text_field @object_name, method,options.merge({"data-mask"=> mask})
			end
		end
	end

