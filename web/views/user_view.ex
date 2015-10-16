defmodule FoodSplitServer.UserView do
  use FoodSplitServer.Web, :view
  alias FoodSplitServer.MealView
  alias FoodSplitServer.ChatGroupView
  alias FoodSplitServer.UserChatGroupView

  def render("index.json", %{users: users}) do
    render_many(users, FoodSplitServer.UserView, "user.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, FoodSplitServer.UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    
    IO.inspect(user)
    user = user |> FoodSplitServer.Repo.preload [:meals, :chatGroups]

    %{id: user.id,
      name: user.name,
      bio: user.bio,
      image: user.image,
      rating: user.rating,
	    meals: MealView.render("index.json", meals: user.meals),
      chatGroups: ChatGroupView.render("index.json", chatGroups: user.chatGroups)
  	}
  end
end