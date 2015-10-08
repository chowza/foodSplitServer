defmodule FoodSplitServer.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :sender, :string
      add :content, :string
      add :chat_group_id, references(:chatGroups)

      timestamps
    end
    create index(:messages, [:chat_group_id])

  end
end
