defmodule FoodSplitServer.Repo.Migrations.MakeUserIdBigIntForMessages do
  use Ecto.Migration

  def change do
  	alter table(:messages) do
		modify :user_id, :bigint
    end
  end
end
