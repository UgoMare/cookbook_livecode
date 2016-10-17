class View
  def display_recipes(recipes)
    recipes.each_with_index do |recipe, index|
      puts "[#{recipe.tested? ? 'X' : ' '}] #{index + 1}. #{recipe.name} - #{recipe.description}"
    end
  end

  def ask_user_for_recipe_name
    ask_user_for "Name"
  end

  def ask_user_for_recipe_description
    ask_user_for "Description"
  end

  def ask_user_for_recipe_index_to_remove
    ask_user_for("Recipe id").to_i - 1
  end

  def say_dummy
    puts "Dummy!"
  end

  def ask_for_ingredient
    puts "What ingredient would you like to search ?"
    return gets.chomp
  end

  def ask_for_import_index(recipes)
    display_recipes(recipes)
    puts "Which recipe you want to import ?"
    return gets.chomp.to_i - 1
  end

  def ask_user_for_recipe_to_mark_tested(recipes)
    display_recipes(recipes)
    puts "Which recipe you want to check ?"
    return gets.chomp.to_i - 1
  end

  # DRY
  # Don't Repeat Yourself

  private

  def ask_user_for(label)
    puts "#{label}?"
    print "> "
    return gets.chomp
  end
end
