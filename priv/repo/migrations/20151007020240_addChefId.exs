defmodule FoodSplitServer.Repo.Migrations.AddChefId do
  use Ecto.Migration

  def change do
  	alter table(:meals) do
      add :chef_id, :integer
    end
  end
end
