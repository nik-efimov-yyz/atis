class METAR::Node::Base

  attr_accessor :match

  def initialize(match)
    @match = match
  end

  def self.property(name, options = {}, &block)
    @properties ||= []
    @properties << name
    define_method name do
      instance_eval &block if match.present?
    end
  end

  def self.properties
    @properties
  end

  def properties
    self.class.properties
  end

end