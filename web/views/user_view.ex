defmodule FoodSplitServer.UserView do
  use FoodSplitServer.Web, :view
  alias FoodSplitServer.MealView
  alias FoodSplitServer.ChatGroupView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, FoodSplitServer.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, FoodSplitServer.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      email: user.email,
      bio: user.bio,
      image: user.image,
      rating: user.rating,
	    meals: MealView.render("index.json", meals: user.meals),
      chatGroups: ChatGroupView.render("index.json", chatGroups: user.chatGroups)
  	}
  end
end