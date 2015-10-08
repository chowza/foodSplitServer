defmodule FoodSplitServer.UserTest do
  use FoodSplitServer.ModelCase

  alias FoodSplitServer.User

  @valid_attrs %{bio: "some content", email: "some content", image: "some content", name: "some content", rating: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
