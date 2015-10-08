defmodule FoodSplitServer.MessageView do
  use FoodSplitServer.Web, :view

  def render("index.json", %{messages: messages}) do
    %{data: render_many(messages, FoodSplitServer.MessageView, "message.json")}
  end

  def render("show.json", %{message: message}) do
    %{data: render_one(message, FoodSplitServer.MessageView, "message.json")}
  end

  def render("message.json", %{message: message}) do
    %{id: message.id,
      sender: message.sender,
      content: message.content
  	}
  end
end