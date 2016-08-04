defmodule EctoRelations.Repo.Migrations.CreateStream do
  use Ecto.Migration

  def change do
    create table(:streams) do
      add :index, :integer
      add :file_id, references(:files, on_delete: :nothing)

      timestamps
    end
    create index(:streams, [:file_id])

  end
end
