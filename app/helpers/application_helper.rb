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
  
  def breadcrumb_link_to(path,text=nil)
    
  content_tag "li" do    
    l=link_to path do
      text unless text.nil?
      yield if block_given?
    end
    
    a=image_tag 'arrow.png', width: 30
    
    l+a
  end 
  
  end
end
