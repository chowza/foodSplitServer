defmodule FoodSplitServer.UserMealTest do
  use FoodSplitServer.ModelCase

  alias FoodSplitServer.UserMeal

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserMeal.changeset(%UserMeal{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserMeal.changeset(%UserMeal{}, @invalid_attrs)
    refute changeset.valid?
  end
end
