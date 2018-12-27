defmodule KoinoniaWeb.Router do
  use KoinoniaWeb, :router

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

  pipeline :frontend do
    plug KoinoniaWeb.Plugs.LoadUser
  end

  scope "/", KoinoniaWeb do
    pipe_through [:browser, :frontend]

    get "/", PageController, :index
    resources "/prayer_requests", PrayerRequestController, only: [:index]
    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create
    get "/login", SessionController, :new
    post "/login", SessionController, :create
  end

  scope "/", KoinoniaWeb do
    pipe_through [:browser, :frontend, KoinoniaWeb.Plugs.AuthenticateUser]

    get "/logout", SessionController, :delete
    resources "/prayer_requests", PrayerRequestController, except: [:index]
  end

  # Other scopes may use custom stacks.
  # scope "/api", KoinoniaWeb do
  #   pipe_through :api
  # end
end
