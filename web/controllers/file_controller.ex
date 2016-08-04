defmodule EctoRelations.FileController do
  use EctoRelations.Web, :controller

  alias EctoRelations.File

  plug :scrub_params, "file" when action in [:create, :update]

  def index(conn, _params) do
    files = Repo.all(File)
    template = EctoRelations.Common.template(conn, "index")
    render(conn, template, files: files)
  end

  def new(conn, _params) do
    changeset = File.changeset(%File{}, :invalid)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"file" => file_params}) do
    changeset = File.changeset(%File{}, file_params)

    case Repo.insert(changeset) do
      {:ok, _file} ->
        conn
        |> put_flash(:info, "File created successfully.")
        |> redirect(to: file_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    file = Repo.get!(File, id)
    template = EctoRelations.Common.template(conn, "show")
    render(conn, template, file: file)
  end

  def edit(conn, %{"id" => id}) do
    file = Repo.get!(File, id)
    changeset = File.changeset(file)
    render(conn, "edit.html", file: file, changeset: changeset)
  end

  def update(conn, %{"id" => id, "file" => file_params}) do
    file = Repo.get!(File, id)
    changeset = File.changeset(file, file_params)

    case Repo.update(changeset) do
      {:ok, file} ->
        conn
        |> put_flash(:info, "File updated successfully.")
        |> redirect(to: file_path(conn, :show, file))
      {:error, changeset} ->
        template = EctoRelations.Common.template(conn, "edit")
        render(conn, template, file: file, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    file = Repo.get!(File, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(file)

    conn
    |> put_flash(:info, "File deleted successfully.")
    |> redirect(to: file_path(conn, :index))
  end
end
