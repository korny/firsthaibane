module Strip
  FILENAME_PATTERN = /\d+(?:extrabit|\.5)?/
  
  class << self
    def all
      @strips ||= find_all_strips
    end
    
    def strip_name_from_id id
      id = id.sub(/\d+/) { '%04d' % $&.to_i }
      "first_haibane_#{id}.gif"
    end
    
    def id_from_strip_name file_name
      File.basename(file_name)[/_(\d+[^_]*)\.gif/,1].sub(/^0+/,'')
    end
    
  protected
    
    def find_all_strips
      strip_files.map(&File.method(:basename)).sort_by do |file_name|
        if file_name =~ /_(\d+)([^_]*)\.gif/
          [$1.to_i, $2]
        else
          [0, '']
        end
      end
    end
    
    def strip_files
      Dir[Rails.root + 'public' + 'strips' + '*.gif']
    end
  end
end