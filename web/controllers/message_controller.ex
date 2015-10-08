defmodule FoodSplitServer.MessageController do
  use FoodSplitServer.Web, :controller
  alias FoodSplitServer.Message
  import Ecto.Query

  def create(conn,%{"message" => message_params, "user_id" => user_id}) do


    changeset = Message.changeset(%Message{}, message_params)

    if get_format(conn) == "html" do
      htmlCreate(conn,changeset)
    else
      apiCreate(conn,changeset)
    end
  end

  def htmlCreate(conn,changeset) do
    case Repo.insert(changeset) do
        {:ok, message} ->
          conn
          |> put_flash(:info, "ChatGroup created successfully.")
          |> redirect(to: user_chat_group_path(conn, :show, conn.params["user_id"], message.chat_group_id))
        {:error, changeset} ->
          
          render(conn, "show.html", changeset: changeset)
      end
  end

  def apiCreate(conn,changeset) do
    case Repo.insert(changeset) do
      {:ok, message} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_chat_group_path(conn, :show, conn.params["user_id"], message.chat_group_id))
        |> render("show.json", message: message)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(FoodSplitServer.ChangesetView, "error.json", changeset: changeset)
    end
  end

end
