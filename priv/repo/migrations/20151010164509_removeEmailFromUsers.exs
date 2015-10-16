defmodule FoodSplitServer.Repo.Migrations.RemoveEmailFromUsers do
  use Ecto.Migration

  def change do
  	alter table(:users) do
		add :facebook_id, :bigint
    end

    alter table(:users) do
    	remove :email
    end
  end
end
