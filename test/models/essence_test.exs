defmodule EctoRelations.EssenceTest do
  use EctoRelations.ModelCase

  alias EctoRelations.Essence

  @valid_attrs %{codec: "some content", kind: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Essence.changeset(%Essence{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Essence.changeset(%Essence{}, @invalid_attrs)
    refute changeset.valid?
  end
end
