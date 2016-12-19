defmodule EctoRelations.EssenceController do
  use EctoRelations.Web, :controller

  alias EctoRelations.Essence

  require Logger

  plug :scrub_params, "essence" when action in [:create, :update]

  def index(conn, _params) do
    essences = Repo.all(Essence) |> Repo.preload(:streams)
    template = EctoRelations.Common.template(conn, "index")
    render(conn, template, essences: essences)
  end

  def new(conn, _params) do
    changeset = Essence.changeset(%Essence{}, :invalid)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"essence" => essence_params}) do
    Logger.info "new essence parameters: #{inspect essence_params}"
    changeset = Essence.changeset(%Essence{}, essence_params)

    case Repo.insert(changeset) do
      {:ok, _essence} ->
        conn
        |> put_flash(:info, "Essence created successfully.")
        |> redirect(to: essence_path(conn, :index))
      {:error, changeset} ->
        template = EctoRelations.Common.template(conn, "new")
        render(conn, template, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    essence = Repo.get!(Essence, id) |> Repo.preload(:streams)
    template = EctoRelations.Common.template(conn, "show")
    render(conn, template, essence: essence)
  end

  def edit(conn, %{"id" => id}) do
    essence = Repo.get!(Essence, id) |> Repo.preload(:streams)
    changeset = Essence.changeset(essence)
    template = EctoRelations.Common.template(conn, "edit")
    render(conn, template, essence: essence, changeset: changeset)
  end

  def update(conn, %{"id" => id, "essence" => essence_params}) do
    essence = Repo.get!(Essence, id) |> Repo.preload(:streams)
    # changeset = Essence.changeset(essence, essence_params)

    changeset =
      essence
      |> Ecto.Changeset.change
      |> Ecto.Changeset.put_assoc(:streams, [essence_params])


    case Repo.update(changeset) do
      {:ok, essence} ->
        conn
        |> put_flash(:info, "Essence updated successfully.")
        |> redirect(to: essence_path(conn, :show, essence))
      {:error, changeset} ->
        template = EctoRelations.Common.template(conn, "edit")
        render(conn, template, essence: essence, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    essence = Repo.get!(Essence, id) |> Repo.preload(:streams)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(essence)

    conn
    |> put_flash(:info, "Essence deleted successfully.")
    |> redirect(to: essence_path(conn, :index))
  end
end
