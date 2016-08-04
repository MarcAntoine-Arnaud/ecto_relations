defmodule EctoRelations.Repo.Migrations.CreateEssence do
  use Ecto.Migration

  def change do
    create table(:essences) do
      add :kind, :string
      add :codec, :string
      add :stream_id, references(:streams, on_delete: :nothing)

      timestamps
    end

    create table(:essences_streams) do
      add :essence_id, references(:essences)
      add :stream_id, references(:streams)
      timestamps
    end
  end
end
