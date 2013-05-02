module StaticDocs
  class Page < ActiveRecord::Base

    class << self
      def matched(path)
        where(:path => path).first!
      end
    end

  end
end
