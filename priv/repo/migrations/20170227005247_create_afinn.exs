defmodule Etlicus.Repo.Migrations.CreateAfinn do
  use Ecto.Migration

  def change do
    create table(:afinn) do
      add :word, :string
      add :score, :integer

      timestamps()
    end

  end
end
