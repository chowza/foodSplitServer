defmodule FoodSplitServer.MealController do
  use FoodSplitServer.Web, :controller
  alias FoodSplitServer.User
  alias FoodSplitServer.Meal
  alias FoodSplitServer.UserMeal

  import Ecto.Query
  

  plug :scrub_params, "meal" when action in [:create, :update]

  # shared

  def index(conn, _) do
    
    #for all meals
    meals = Meal |> Repo.all
    render(conn, :index, meals: meals)
  end

  def show(conn, %{"id" => id, "user_id" => user_id}) do

    # get any meal by id... 
    # meal = Meal |> Repo.get!(id) |> Repo.preload [:user]
    # render(conn, :show, meal: meal)

    #can't allow someone to directly access meal id path

    meal = Meal |> join(:left,[meal], user in assoc(meal, :users)) |> where([_,user], user.id == ^user_id) |> select([meal, _], meal) |> Repo.get(id)

    if is_nil(meal) do
      render(conn, :show, meal: meal)
    else
      render(conn, :show, meal: meal |> Repo.preload [:users])
    end  
  end

  def create(conn, %{"meal" => meal_params}) do
    changeset = Meal.changeset(%Meal{}, meal_params)

    if get_format(conn) == "html" do
      htmlCreate(conn,changeset)
    else
      apiCreate(conn,changeset)
    end
  end

  def update(conn, %{"id" => id, "meal" => meal_params}) do
    meal = Meal |> Repo.get!(id) |> Repo.preload [:userMeals]
    changeset = Meal.changeset(meal, meal_params)
    if get_format(conn) == "html" do
      htmlUpdate(conn,changeset, meal)
    else
      apiUpdate(conn, changeset, meal)
    end
  end

  def delete(conn, %{"id" => id, "user_id" => user_id}) do

    userMealRelation = UserMeal |> where([um], um.meal_id == ^id and um.user_id == ^user_id) |> select([um], um) |> Repo.one
    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(userMealRelation)

    if get_format(conn) == "html" do
      conn
      |> put_flash(:info, "Meal deleted successfully.")
      |> redirect(to: user_path(conn, :show, conn.params["user_id"]))
    else
      send_resp(conn, :no_content, "")
    end
  end

  # HTML only

  def new(conn, %{"user_id" => user_id}) do
    changeset = Meal.changeset(%Meal{userMeals: [%UserMeal{user_id: user_id}]})
    render(conn, "new.html", changeset: changeset)
  end

  def edit(conn, %{"id" => id, "user_id" => user_id}) do
    meal = Repo.get!(Meal, id) |> Repo.preload [:users]
    changeset = Meal.changeset(meal)
    render(conn, "edit.html", meal: meal, changeset: changeset)
  end

  def htmlCreate(conn,changeset) do
    case Repo.insert(changeset) do
        {:ok, _meal} ->
          conn
          |> put_flash(:info, "Meal created successfully.")
          |> redirect(to: user_path(conn, :show, conn.params["user_id"]))
        {:error, changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
  end

  def htmlUpdate(conn,changeset,meal) do
    case Repo.update(changeset) do
      {:ok, meal} ->
        conn
        |> put_flash(:info, "Meal updated successfully.")
        |> redirect(to: user_meal_path(conn, :show, conn.params["user_id"], meal))
      {:error, changeset} ->
        render(conn, "edit.html", meal: meal, changeset: changeset)
    end
  end

  #API only 
  def apiCreate(conn,changeset) do
    case Repo.insert(changeset) do
      {:ok, meal} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_meal_path(conn, :show, conn.params["user_id"], meal))
        |> render("show.json", meal: meal)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(FoodSplitServer.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def apiUpdate(conn,changeset,meal) do
    case Repo.update(changeset) do
      {:ok, meal} ->
        render(conn, "show.json", meal: meal)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(FoodSplitServer.ChangesetView, "error.json", changeset: changeset)
    end
  end

end
