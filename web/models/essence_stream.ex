defmodule EctoRelations.PostCategory do
  use EctoRelations.Web, :model

  schema "essences_streams" do
    belongs_to :essence, EctoRelations.Essence
    belongs_to :stream, EctoRelations.Stream
    timestamps
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [])
  end
end
