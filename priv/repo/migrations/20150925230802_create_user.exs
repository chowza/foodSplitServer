defmodule FoodSplitServer.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :name, :string
      add :bio, :string
      add :image, :string
      add :rating, :float

      timestamps
    end

  end
end
