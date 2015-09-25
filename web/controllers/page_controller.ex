defmodule FoodSplitServer.PageController do
  use FoodSplitServer.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
