module ATIS::Message::Sectionable

  extend ActiveSupport::Concern

  included do
    @sections = []
  end

  module ClassMethods

    def section(name, options = {})
      @sections << { name: name, options: options }
    end

    def sections
      @sections
    end

  end

end