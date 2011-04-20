module ApplicationHelper
	def default_editable_field(object, field,options={})
		editable_field object, field,	{:submitdata => {:remote=>true},
										#:cancel     => 'Cancel',
										#:submit     => 'OK',
										:indicator  => 'Loading',
										:tooltip    => 'Click to edit...',
										:cssclass	=> 'jeditable_form',
										#:style		=> "display:inline",
										:width		=> "200"}.merge(options)
	end
end
