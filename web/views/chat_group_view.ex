defmodule FoodSplitServer.ChatGroupView do
  use FoodSplitServer.Web, :view
  alias FoodSplitServer.MessageView

  def render("index.json", %{chatGroups: chatGroups}) do
    render_many(chatGroups, FoodSplitServer.ChatGroupView, "chatGroup.json")
  end

  def render("show.json", %{chatGroup: chatGroup}) do
    render_one(chatGroup, FoodSplitServer.ChatGroupView, "chatGroup.json")
  end

  def render("chatGroup.json", %{chat_group: chatGroup}) do

    IO.inspect("---------------------------------")
    IO.inspect(chatGroup)
    chatGroup = chatGroup |> FoodSplitServer.Repo.preload [:messages]
    %{id: chatGroup.id,
      name: chatGroup.name,
      # unreadMessage: chatGroup.unreadMessage,
      messages: MessageView.render("index.json", messages: chatGroup.messages)
  	}
  end
end
