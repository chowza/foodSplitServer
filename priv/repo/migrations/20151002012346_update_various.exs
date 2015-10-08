defmodule FoodSplitServer.Repo.Migrations.UpdateVarious do
  use Ecto.Migration

  def change do
  	alter table(:users) do
  		add :fb_id, :integer
  		add :gcm_token, :string
  		add :chat_group_id, references(:chatGroups)
  	end

  	create index(:users, [:chat_group_id])
  end
end
