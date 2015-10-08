defmodule FoodSplitServer.ChatGroupTest do
  use FoodSplitServer.ModelCase

  alias FoodSplitServer.ChatGroup

  @valid_attrs %{name: "some content", unreadMessages: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ChatGroup.changeset(%ChatGroup{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ChatGroup.changeset(%ChatGroup{}, @invalid_attrs)
    refute changeset.valid?
  end
end
