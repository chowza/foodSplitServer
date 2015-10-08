defmodule FoodSplitServer.UserController do
  use FoodSplitServer.Web, :controller

  alias FoodSplitServer.User

  plug :scrub_params, "user" when action in [:create, :update]

  # shared

  def show(conn, %{"id" => id}) do
    user = User |> Repo.get!(id) |> Repo.preload [:meals, :chatGroups]
    render(conn, :show, user: user)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    
    if get_format(conn) == "html" do
      htmlCreate(conn,changeset)
    else
      apiCreate(conn,changeset)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    if get_format(conn) == "html" do
      htmlUpdate(conn,changeset,user)
    else
      apiUpdate(conn,changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    if get_format(conn) == "html" do
      conn
      |> put_flash(:info, "User deleted successfully.")
      |> redirect(to: user_path(conn, :index))
    else
      send_resp(conn, :no_content, "")
    end
  end

  # HTML only

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def htmlCreate(conn,changeset) do
    case Repo.insert(changeset) do
        {:ok, _user} ->
          conn
          |> put_flash(:info, "User created successfully.")
          |> redirect(to: user_path(conn, :index))
        {:error, changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
  end

  def htmlUpdate(conn,changeset,user) do
    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  #API only 
  def apiCreate(conn,changeset) do
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_path(conn, :show, user))
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(FoodSplitServer.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def apiUpdate(conn,changeset) do
    case Repo.update(changeset) do
      {:ok, user} ->
        render(conn, "show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(FoodSplitServer.ChangesetView, "error.json", changeset: changeset)
    end
  end

  # UNUSED
  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def index(conn, _params) do
    users = User |> Repo.all |> Repo.preload [:meals,:chatGroups]
    render(conn, :index, users: users)
  end


end
