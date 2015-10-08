defmodule FoodSplitServer.ChatGroup do
  use FoodSplitServer.Web, :model

  schema "chatGroups" do
    field :name, :string
    field :unreadMessages, :boolean, default: false
    has_many :messages, FoodSplitServer.Message
    has_many :userChatGroups, FoodSplitServer.UserChatGroup
    has_many :users, through: [:userChatGroups, :user]

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(unreadMessages userChatGroups)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
