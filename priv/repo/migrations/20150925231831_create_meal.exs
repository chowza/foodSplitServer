defmodule FoodSplitServer.Repo.Migrations.CreateMeal do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add :name, :string
      add :servingSize, :integer
      add :servingTime, :datetime
      add :cuisineType, :string
      add :latitude, :float
      add :longitude, :float
      add :user_id, references(:users)

      timestamps
    end
    create index(:meals, [:user_id])

  end
end
