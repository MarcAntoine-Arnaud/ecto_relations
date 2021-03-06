defmodule EctoRelations.Stream do
  use EctoRelations.Web, :model

  schema "streams" do
    field :index, :integer
    belongs_to :file, EctoRelations.File, foreign_key: :file_id
    timestamps
  end

  @required_fields ~w(index file_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
