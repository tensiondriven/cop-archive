defmodule CopArchiveWeb.Router do
  use CopArchiveWeb, :router

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

  scope "/", CopArchiveWeb do
    pipe_through :browser

    get "/", ForumController, :index

    resources "/forum", ForumController, only: [:index, :show]
    resources "/topic", TopicController, only: [:index, :show]
    resources "/reply", ReplyController, only: [:show]
    resources "/user", UserController, only: [:index, :show]

    get "/sitemap.xml", PageController, :sitemap
    get "/sitemap1.xml", PageController, :sitemap1
  end

  # Other scopes may use custom stacks.
  # scope "/api", CopArchiveWeb do
  #   pipe_through :api
  # end
end
