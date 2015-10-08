defmodule FoodSplitServer.Repo.Migrations.RemoveChefId do
  use Ecto.Migration

  def change do
  	alter table(:meals) do
      remove :chef_id
    end
  end
end
