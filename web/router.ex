defmodule FoodSplitServer.Router do
  use FoodSplitServer.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FoodSplitServer do
    pipe_through :browser # Use the default browser stack

    resources "users", UserController do
      resources "meals", MealController, except: [:index]
      resources "chatGroups", ChatGroupController, except: [:index]  do
        resources "messages", MessageController, only: [:create]
      end
    end
    resources "meals", MealController, only: [:index]
    
  end



  # Other scopes may use custom stacks.
  scope "/api", FoodSplitServer do
    pipe_through :api

    resources "users", UserController do
      resources "meals", MealController, except: [:index]
      resources "chatGroups", ChatGroupController, except: [:index]
    end
    resources "meals", MealController, only: [:index]

    # resources "/messages", MessageController
  end
end
