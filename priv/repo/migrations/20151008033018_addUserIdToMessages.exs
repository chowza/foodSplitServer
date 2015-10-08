defmodule FoodSplitServer.Repo.Migrations.AddUserIdToMessages do
  use Ecto.Migration

  def change do
  	alter table(:messages) do
  		add :user_id, :integer
  	end
  end
end
