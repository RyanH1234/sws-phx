defmodule SwsPhx.Repo.Migrations.User do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password, :string
    end
  end
end
