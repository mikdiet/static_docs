module StaticDocs
  class Page < ActiveRecord::Base

    class << self
      def matching(path)
        where(:path => path).first!
      end
    end

  end
end
