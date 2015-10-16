defmodule FoodSplitServer.Repo.Migrations.MakeUserIdbigInt do
  use Ecto.Migration

  def change do
  	alter table(:userMeals) do
		modify :user_id, :bigint
    end

    alter table(:userChatGroups) do
		modify :user_id, :bigint
    end
  end
end
