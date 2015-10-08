defmodule FoodSplitServer.Message do
  use FoodSplitServer.Web, :model

  schema "messages" do
    field :sender, :string
    field :content, :string
    belongs_to :chat_group, FoodSplitServer.ChatGroup
    belongs_to :user, FoodSplitServer.User
    timestamps
  end

  @required_fields ~w(content chat_group_id user_id)
  @optional_fields ~w()

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
