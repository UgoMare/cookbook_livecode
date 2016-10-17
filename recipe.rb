class Recipe
  attr_reader :name
  attr_accessor :url, :description

  def initialize(name, description, tested = false)
    @name = name
    @description = description
    @tested = tested
  end

  def valid?
    if @name == nil || @name == ""
      return false
    elsif @description.length < 10
      return false
    else
      return true
    end
  end

  def tested?
    @tested
  end

  def tested!
    @tested = true
  end


end
