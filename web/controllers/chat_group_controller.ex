defmodule FoodSplitServer.ChatGroupController do
  use FoodSplitServer.Web, :controller
  alias FoodSplitServer.User
  alias FoodSplitServer.ChatGroup
  alias FoodSplitServer.UserChatGroup
  alias FoodSplitServer.Message
  import Ecto.Query
  
  def create(conn, %{"chat_group" => chat_group_params, "user_id" => user_id}) do


    # userIds = users |> Enum.flat_map(fn {k,v} -> v end) |> Enum.reduce([], fn {k,v}, acc -> acc ++ [v] end)
    # query = from u in User, where: u.id in ^userIds
    # members = query |> Repo.all()

    #remove blank fields if they exist
    params = 
      chat_group_params 
        |> Map.update!("userChatGroups", fn(innerMap) -> Enum.filter(innerMap,fn{k,v} -> byte_size(v["user_id"]) !=0 end) end)
        |> Map.update!("userChatGroups", fn(innerMap) -> Enum.into(innerMap,%{}) end)
    
    changeset = ChatGroup.changeset(%ChatGroup{}, params)
    
    if get_format(conn) == "html" do
      htmlCreate(conn,changeset)
    else
      apiCreate(conn,changeset)
    end
  end

  def update(conn, %{"id" => id, "chat_group" => chat_group_params}) do
    chatGroup = ChatGroup |> Repo.get!(id) |> Repo.preload [:userChatGroups]
    changeset = ChatGroup.changeset(chatGroup, chat_group_params)
    if get_format(conn) == "html" do
      htmlUpdate(conn,changeset, chatGroup)
    else
      apiUpdate(conn, changeset, chatGroup)
    end
  end

  def delete(conn, %{"id" => id, "user_id" => user_id}) do

    userChatGroupRelation = UserChatGroup |> where([ucg], ucg.chat_group_id == ^id and ucg.user_id == ^user_id) |> select([ucg], ucg) |> Repo.one
    # query = from ucg in UserChatGroup, where: ucg.chat_group_id == ^id and ucg.user_id == ^user_id
    # userChatGroupRelation = query |> Repo.all
    

    # Deleting the user chat group relation removes that user from the chat group
    Repo.delete!(userChatGroupRelation)

    if get_format(conn) == "html" do
      conn
      |> put_flash(:info, "ChatGroup deleted successfully.")
      |> redirect(to: user_path(conn, :show, conn.params["user_id"]))
    else
      send_resp(conn, :no_content, "")
    end
  end

  #html only
  def new(conn, %{"user_id" => user_id}) do
    changeset = ChatGroup.changeset(%ChatGroup{userChatGroups: [%UserChatGroup{user_id: user_id}]}) 
    render(conn, "new.html", changeset: changeset)
  end

  def htmlUpdate(conn,changeset,chatGroup) do
    case Repo.update(changeset) do
      {:ok, chatGroup} ->
        conn
        |> put_flash(:info, "ChatGroup updated successfully.")
        |> redirect(to: user_chat_group_path(conn, :show, conn.params["user_id"], chatGroup))
      {:error, changeset} ->
        render(conn, "edit.html", chatGroup: chatGroup, changeset: changeset)
    end
  end

  def htmlCreate(conn,changeset) do
    case Repo.insert(changeset) do
        {:ok, _chatGroup} ->
          IO.inspect("------------------REPO HTML CREATE")
          IO.inspect(_chatGroup)
          conn
          |> put_flash(:info, "ChatGroup created successfully.")
          |> redirect(to: user_path(conn, :show, conn.params["user_id"]))
        {:error, changeset} ->
          IO.inspect("--------------HTML CREATE CHANGESET ERROR")
          IO.inspect(changeset)
          render(conn, "new.html", changeset: changeset)
      end
  end

  def show(conn, %{"id" => id, "user_id" => user_id}) do

    # TODO: set up only showing where user_id = the person logged in. So I Can't see other ppls chats by putting it in urls

    #can't allow someone to directly access chatGroup id path
    chatGroup = ChatGroup |> join(:left,[chatGroup], user in assoc(chatGroup, :users)) |> where([_,user], user.id == ^user_id) |> select([chatGroup, _], chatGroup) |> Repo.get(id)

    if is_nil(chatGroup) do
      render(conn, :show, chatGroup: chatGroup)
    else
      changeset = Message.changeset(%Message{chat_group_id: id, user_id: user_id})
      chatGroup = chatGroup |> Repo.preload [:messages, :users]
      render(conn, :show, chatGroup: chatGroup, changeset: changeset)
    end  
  end

  def edit(conn, %{"id" => id, "user_id" => user_id}) do
    chatGroup = Repo.get!(ChatGroup, id) |> Repo.preload [:messages, :userChatGroups]
    changeset = ChatGroup.changeset(chatGroup)
    render(conn, "edit.html", chatGroup: chatGroup, changeset: changeset)
  end
  
  #API only 
  def apiCreate(conn,changeset) do
    case Repo.insert(changeset) do
      {:ok, chatGroup} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_chat_group_path(conn, :show, conn.params["user_id"], chatGroup))
        |> render("show.json", chatGroup: chatGroup)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(FoodSplitServer.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def apiUpdate(conn,changeset,chatGroup) do
    case Repo.update(changeset) do
      {:ok, chatGroup} ->
        render(conn, "show.json", chatGroup: chatGroup)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(FoodSplitServer.ChangesetView, "error.json", changeset: changeset)
    end
  end

end
