defmodule FoodSplitServer.MealView do
  use FoodSplitServer.Web, :view

  def render("index.json", %{meals: meals}) do
    render_many(meals, FoodSplitServer.MealView, "meal.json")
  end

  def render("show.json", %{meal: meal}) do
    render_one(meal, FoodSplitServer.MealView, "meal.json")
  end

  def render("meal.json", %{meal: meal}) do
    
    user_id = List.first(meal.users).id
    
    %{id: meal.id,
      name: meal.name,
      servingSize: meal.servingSize,
      servingTime: meal.servingTime,
      cuisineType: meal.cuisineType,
      latitude: meal.latitude,
      longitude: meal.longitude,
      user_id: user_id
  	}
  end
end
