defmodule FoodSplitServer.Repo.Migrations.CreateChatGroup do
  use Ecto.Migration

  def change do
    create table(:chatGroups) do
      add :name, :string
      add :unreadMessages, :boolean, default: false
      add :user_id, references(:users)

      timestamps
    end
    create index(:chatGroups, [:user_id])

  end
end
