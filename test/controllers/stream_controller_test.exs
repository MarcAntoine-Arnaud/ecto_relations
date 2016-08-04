defmodule EctoRelations.StreamControllerTest do
  use EctoRelations.ConnCase

  alias EctoRelations.Stream
  @valid_attrs %{index: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, stream_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing streams"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, stream_path(conn, :new)
    assert html_response(conn, 200) =~ "New stream"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, stream_path(conn, :create), stream: @valid_attrs
    assert redirected_to(conn) == stream_path(conn, :index)
    assert Repo.get_by(Stream, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, stream_path(conn, :create), stream: @invalid_attrs
    assert html_response(conn, 200) =~ "New stream"
  end

  test "shows chosen resource", %{conn: conn} do
    stream = Repo.insert! %Stream{}
    conn = get conn, stream_path(conn, :show, stream)
    assert html_response(conn, 200) =~ "Show stream"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, stream_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    stream = Repo.insert! %Stream{}
    conn = get conn, stream_path(conn, :edit, stream)
    assert html_response(conn, 200) =~ "Edit stream"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    stream = Repo.insert! %Stream{}
    conn = put conn, stream_path(conn, :update, stream), stream: @valid_attrs
    assert redirected_to(conn) == stream_path(conn, :show, stream)
    assert Repo.get_by(Stream, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    stream = Repo.insert! %Stream{}
    conn = put conn, stream_path(conn, :update, stream), stream: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit stream"
  end

  test "deletes chosen resource", %{conn: conn} do
    stream = Repo.insert! %Stream{}
    conn = delete conn, stream_path(conn, :delete, stream)
    assert redirected_to(conn) == stream_path(conn, :index)
    refute Repo.get(Stream, stream.id)
  end
end
