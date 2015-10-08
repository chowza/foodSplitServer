defmodule FoodSplitServer.UserChatGroupTest do
  use FoodSplitServer.ModelCase

  alias FoodSplitServer.UserChatGroup

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserChatGroup.changeset(%UserChatGroup{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserChatGroup.changeset(%UserChatGroup{}, @invalid_attrs)
    refute changeset.valid?
  end
end
