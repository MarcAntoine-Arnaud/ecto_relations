defmodule EctoRelations.EssenceControllerTest do
  use EctoRelations.ConnCase

  alias EctoRelations.Essence
  @valid_attrs %{codec: "some content", kind: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, essence_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing essences"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, essence_path(conn, :new)
    assert html_response(conn, 200) =~ "New essence"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, essence_path(conn, :create), essence: @valid_attrs
    assert redirected_to(conn) == essence_path(conn, :index)
    assert Repo.get_by(Essence, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, essence_path(conn, :create), essence: @invalid_attrs
    assert html_response(conn, 200) =~ "New essence"
  end

  test "shows chosen resource", %{conn: conn} do
    essence = Repo.insert! %Essence{}
    conn = get conn, essence_path(conn, :show, essence)
    assert html_response(conn, 200) =~ "Show essence"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, essence_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    essence = Repo.insert! %Essence{}
    conn = get conn, essence_path(conn, :edit, essence)
    assert html_response(conn, 200) =~ "Edit essence"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    essence = Repo.insert! %Essence{}
    conn = put conn, essence_path(conn, :update, essence), essence: @valid_attrs
    assert redirected_to(conn) == essence_path(conn, :show, essence)
    assert Repo.get_by(Essence, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    essence = Repo.insert! %Essence{}
    conn = put conn, essence_path(conn, :update, essence), essence: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit essence"
  end

  test "deletes chosen resource", %{conn: conn} do
    essence = Repo.insert! %Essence{}
    conn = delete conn, essence_path(conn, :delete, essence)
    assert redirected_to(conn) == essence_path(conn, :index)
    refute Repo.get(Essence, essence.id)
  end
end
