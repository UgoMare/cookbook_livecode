require "csv"

class Cookbook
  attr_reader :recipes

  def initialize(csv_file)
    @recipes = []
    @csv_file = csv_file
    load_csv
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_to_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_to_csv
  end

  def find(index)
    @recipes[index]
  end

  def save_to_csv
    CSV.open(@csv_file, 'w') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.tested?]
      end
    end
  end

  private

  def load_csv
    CSV.foreach(@csv_file) do |row| # Array
      @recipes << Recipe.new(row[0], row[1], row[2])
    end
  end


end
