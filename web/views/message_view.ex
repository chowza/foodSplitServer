defmodule FoodSplitServer.MessageView do
  use FoodSplitServer.Web, :view

  def render("index.json", %{messages: messages}) do
    render_many(messages, FoodSplitServer.MessageView, "message.json")
  end

  def render("show.json", %{message: message}) do
    render_one(message, FoodSplitServer.MessageView, "message.json")
  end

  def render("message.json", %{message: message}) do
    %{id: message.id,
      content: message.content
  	}
  end
end