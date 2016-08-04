defmodule EctoRelations.StreamController do
  use EctoRelations.Web, :controller

  alias EctoRelations.Stream

  plug :scrub_params, "stream" when action in [:create, :update]

  def index(conn, _params) do
    streams = Repo.all(Stream)
    template = EctoRelations.Common.template(conn, "index")
    render(conn, template, streams: streams)
  end

  def new(conn, _params) do
    changeset = Stream.changeset(%Stream{}, :invalid)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"stream" => stream_params}) do
    changeset = Stream.changeset(%Stream{}, stream_params)

    case Repo.insert(changeset) do
      {:ok, _stream} ->
        conn
        |> put_flash(:info, "Stream created successfully.")
        |> redirect(to: stream_path(conn, :index))
      {:error, changeset} ->
        template = EctoRelations.Common.template(conn, "new")
        render(conn, template, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    stream = Repo.get!(Stream, id)
    template = EctoRelations.Common.template(conn, "show")
    render(conn, template, stream: stream)
  end

  def edit(conn, %{"id" => id}) do
    stream = Repo.get!(Stream, id)
    changeset = Stream.changeset(stream)
    render(conn, "edit.html", stream: stream, changeset: changeset)
  end

  def update(conn, %{"id" => id, "stream" => stream_params}) do
    stream = Repo.get!(Stream, id)
    changeset = Stream.changeset(stream, stream_params)

    case Repo.update(changeset) do
      {:ok, stream} ->
        conn
        |> put_flash(:info, "Stream updated successfully.")
        |> redirect(to: stream_path(conn, :show, stream))
      {:error, changeset} ->
        template = EctoRelations.Common.template(conn, "edit")
        render(conn, template, stream: stream, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    stream = Repo.get!(Stream, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(stream)

    conn
    |> put_flash(:info, "Stream deleted successfully.")
    |> redirect(to: stream_path(conn, :index))
  end
end
