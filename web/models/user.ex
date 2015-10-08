defmodule FoodSplitServer.User do
  use FoodSplitServer.Web, :model

  schema "users" do
    field :email, :string
    field :name, :string
    field :bio, :string
    field :image, :string
    field :rating, :float
    has_many :userChatGroups, FoodSplitServer.UserChatGroup
    has_many :chatGroups, through: [:userChatGroups, :chat_group]
    has_many :userMeals, FoodSplitServer.UserMeal
    has_many :meals, through: [:userMeals, :meal]
    has_many :messages, FoodSplitServer.Message

    timestamps
  end

  @required_fields ~w(email name)
  @optional_fields ~w(bio image rating)

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
