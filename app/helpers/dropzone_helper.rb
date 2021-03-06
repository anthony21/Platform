# frozen_string_literal: true

module DropzoneHelper
  def dropzone(form, field, options = {}) # rubocop:disable Style/OptionHash
    class_list = options.delete(:class)
    class_list = ['dropzone', class_list].compact.join(' ')

    options[:max_file_size] /= 1.megabyte if options[:max_file_size]

    data = {
      controller: 'dropzone',
      dropzone_accepted_files: options.delete(:accepted_files) ||
        ActiveStorage.variable_content_types.join(',')
    }
    %i(
      croppable
      file_added_event
      file_drop_event
      file_drop_id
      file_drop_over_id
      file_progress_event
      file_removed_event
      file_start_event
      file_success_event
      max_file_size
      max_files
      max_thumbnail_file_size
      parallel_uploads
      queue_complete_event
      thumbnail_height
      thumbnail_width
    ).each do |key|
      data["dropzone_#{key}".to_sym] = options.delete(key) if options.key?(key)
    end

    content_tag :div, options.merge(class: class_list, data:) do
      render 'dropzone_input/dropzone', form: form, field: field do
        block_given? ? yield : render('dropzone_input/default_content')
      end
    end
  end
end
