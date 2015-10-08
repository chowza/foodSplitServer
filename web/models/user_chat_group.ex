defmodule FoodSplitServer.UserChatGroup do
  use FoodSplitServer.Web, :model

  schema "userChatGroups" do
    belongs_to :user, FoodSplitServer.User
    belongs_to :chat_group, FoodSplitServer.ChatGroup

    timestamps
  end

  @required_fields ~w(user_id)
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
