module ApplicationHelper
  # Render flashes messages in the DOM
  def render_turbo_stream_flash_messages
    turbo_stream.prepend "flash", partial: "layouts/flash"
  end

  # Builds nested dom ids to turbo_stream
  def nested_dom_id(*args)
    args.map { |arg| arg.respond_to?(:to_key) ? dom_id(arg) : arg }.join("_")
  end

  # Adds active class to links
  def link_to_active( text = nil, path = nil, **options, &block )
    link = block_given? ? text : path

    options[:class] = class_names(options[:class], 'active') if current_page? link

    if block_given?
      link_to text, options, &block
    else
      link_to text, path, options
    end
  end

  # This helper shows the available events for an object with aasm status management
  def available_events_for(lot)
    lot.aasm.permitted_transitions.map { |t| t[:event] }
  end
end
