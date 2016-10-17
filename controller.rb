require_relative "recipe"
require_relative "view"
require_relative "scrapper"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    recipes = @cookbook.recipes
    @view.display_recipes(recipes)
  end

  def create
    name = @view.ask_user_for_recipe_name
    description = @view.ask_user_for_recipe_description

    recipe = Recipe.new(name, description)

    if recipe.valid?
      @cookbook.add_recipe(recipe)
    else
      @view.say_dummy
      create
    end
  end

  def destroy
    list
    index = @view.ask_user_for_recipe_index_to_remove
    @cookbook.remove_recipe(index)
  end

  def import
    #1 View to ask the user to enter an ingredient
    ingredient = @view.ask_for_ingredient
    #Go on the url with the ingredient
    results = Scrapper.new.search(ingredient)
    #View to display the result
    #Ask the user for an index
    index = @view.ask_for_import_index(results)
    #Import the recipe
    recipe = results[index]
    description = Scrapper.new.get_description(recipe.url)

    recipe.description = description

    @cookbook.add_recipe(recipe)
  end

  def check_as_tested
    index = @view.ask_user_for_recipe_to_mark_tested(@cookbook.recipes)
    #Display the list of recipe with boxes
    #Ask the index we want to check
    recipe = @cookbook.find(index)
    #set the recipe to check
    recipe.tested! unless recipe.nil?
  end
end
