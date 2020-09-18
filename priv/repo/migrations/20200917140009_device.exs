defmodule SwsPhx.Repo.Migrations.Device do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :name, :string
      add :user_id, references(:users)
    end
  end
end
