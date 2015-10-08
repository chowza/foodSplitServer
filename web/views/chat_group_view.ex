defmodule FoodSplitServer.ChatGroupView do
  use FoodSplitServer.Web, :view
  alias FoodSplitServer.MessageView
  alias FoodSplitServer.UserChatGroup

  def render("index.json", %{chatGroups: chatGroups}) do
    %{data: render_many(chatGroups, FoodSplitServer.ChatGroupView, "chatGroup.json")}
  end

  def render("show.json", %{chatGroup: chatGroup}) do
    %{data: render_one(chatGroup, FoodSplitServer.ChatGroupView, "chatGroup.json")}
  end

  def render("chatGroup.json", %{chatGroup: chatGroup}) do
    %{id: chatGroup.id,
      name: chatGroup.name,
      unreadMessage: chatGroup.unreadMessage,
      messages: MessageView.render("index.json", messages: chatGroup.messages)
  	}
  end
end
