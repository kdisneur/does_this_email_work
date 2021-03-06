defmodule DoesThisEmailWork.Router do
  use DoesThisEmailWork.Web, :router

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

  scope "/", DoesThisEmailWork do
    pipe_through :browser # Use the default browser stack

    get "/", Validation.SingleController, :new
    post "/", Validation.SingleController, :create

    get "/file/import", Validation.FileController, :new
  end

  scope "/api", DoesThisEmailWork.API do
    pipe_through :api

    post "/validation", ValidationController, :create
  end
end
