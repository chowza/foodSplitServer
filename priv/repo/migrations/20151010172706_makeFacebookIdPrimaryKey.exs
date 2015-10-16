defmodule FoodSplitServer.Repo.Migrations.MakeFacebookIdPrimaryKey do
  use Ecto.Migration

  def change do
  	alter table(:users) do
		remove :facebook_id
    end

    alter table(:users) do
    	modify :id, :bigint
    end
  end
end
