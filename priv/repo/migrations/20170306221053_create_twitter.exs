defmodule Etlicus.Repo.Migrations.CreateTwitter do
  use Ecto.Migration

  def change do
    create table(:twitter) do

      timestamps()
    end

  end
end
