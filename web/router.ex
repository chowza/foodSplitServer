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
    plug CORSPlug, [origin: "http://localhost:8080"]
    plug :accepts, ["json"]
  end

  scope "/", FoodSplitServer do
    pipe_through :browser # Use the default browser stack

    resources "users", UserController do
      resources "meals", MealController

      resources "chatGroups", ChatGroupController, except: [:index]  do
        resources "messages", MessageController, only: [:create]
      end
      resources "chatGroups", ChatGroupController, only: [:index]
    end
    get "/meals", MealController, :all
    
  end



  # Other scopes may use custom stacks.
  scope "/api", FoodSplitServer do
    pipe_through :api

    resources "users", UserController do
      resources "meals", MealController
      resources "chatGroups", ChatGroupController, except: [:index]  do
        resources "messages", MessageController, only: [:create]
      end
      resources "chatGroups", ChatGroupController, only: [:index]
    end
    get "/meals", MealController, :all

    # resources "/messages", MessageController
  end
end
