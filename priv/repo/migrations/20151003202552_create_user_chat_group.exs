defmodule FoodSplitServer.Repo.Migrations.CreateUserChatGroup do
  use Ecto.Migration

  def change do
    create table(:userChatGroups) do
      add :user_id, references(:users)
      add :chat_group_id, references(:chatGroups)

      timestamps
    end
    create index(:userChatGroups, [:user_id])
    create index(:userChatGroups, [:chat_group_id])

    drop index(:chatGroups, [:user_id])
    drop index(:users, [:chat_group_id])

    alter table(:users) do
      remove :chat_group_id
    end

    alter table(:chatGroups) do
      remove :user_id
    end
  end
end
