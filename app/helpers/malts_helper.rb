module MaltsHelper

  def form_error_notification(object)
    if object.errors.any?
      tag.div class: "alert alert-danger", role: "alert" do
        object.errors.full_messages.to_sentence.capitalize
      end
    end
  end

end
