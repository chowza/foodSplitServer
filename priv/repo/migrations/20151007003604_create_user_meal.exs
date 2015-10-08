defmodule FoodSplitServer.Repo.Migrations.CreateUserMeal do
  use Ecto.Migration

  def change do
    create table(:userMeals) do
      add :user_id, references(:users)
      add :meal_id, references(:meals)

      timestamps
    end

    drop index(:meals, [:user_id])

    alter table(:meals) do
      remove :user_id
    end
    

    create index(:userMeals, [:user_id])
    create index(:userMeals, [:meal_id])

  end
end
