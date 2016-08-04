defmodule EctoRelations.Essence do
  use EctoRelations.Web, :model

  alias Ecto.Changeset

  schema "essences" do
    field :kind, :string
    field :codec, :string
    many_to_many :streams, EctoRelations.Stream, join_through: EctoRelations.PostCategory
    timestamps
  end

  @required_fields ~w(kind codec)
  @optional_fields ~w(streams)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, ~w())
    |> Changeset.cast_assoc(:streams, [])
  end

end
