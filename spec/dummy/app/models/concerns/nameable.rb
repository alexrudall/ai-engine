module Nameable
  def to_s
    "#{self.class.name}: #{name}"
  end
end
