defmodule FoodSplitServer.MealView do
  use FoodSplitServer.Web, :view

  def render("index.json", %{meals: meals}) do
    render_many(meals, FoodSplitServer.MealView, "meal.json")
  end

  def render("show.json", %{meal: meal}) do
    render_one(meal, FoodSplitServer.MealView, "meal.json")
  end

  def render("meal.json", %{meal: meal}) do
    %{id: meal.id,
      name: meal.name,
      servingSize: meal.servingSize,
      servingTime: meal.servingTime,
      cuisineType: meal.cuisineType,
      latitude: meal.latitude,
      longitude: meal.longitude
  	}
  end
end
