defmodule EctoRelations.Repo.Migrations.CreateFile do
  use Ecto.Migration

  def change do
    create table(:files) do
      add :path, :string

      timestamps
    end

  end
end
