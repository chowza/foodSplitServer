defmodule FoodSplitServer.Meal do
  use FoodSplitServer.Web, :model

  schema "meals" do
    field :name, :string
    field :servingSize, :integer
    field :servingTime, Ecto.DateTime
    field :cuisineType, :string
    field :latitude, :float
    field :longitude, :float
    has_many :userMeals, FoodSplitServer.UserMeal
    has_many :users, through: [:userMeals, :user]

    timestamps
  end

  @required_fields ~w(name servingSize cuisineType userMeals)
  @optional_fields ~w(latitude longitude servingTime)

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
