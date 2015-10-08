defmodule FoodSplitServer.MealTest do
  use FoodSplitServer.ModelCase

  alias FoodSplitServer.Meal

  @valid_attrs %{cuisineType: "some content", latitude: "120.5", longitude: "120.5", name: "some content", servingSize: 42, servingTime: "2010-04-17 14:00:00"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Meal.changeset(%Meal{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Meal.changeset(%Meal{}, @invalid_attrs)
    refute changeset.valid?
  end
end
