defmodule CopArchiveWeb.UserController do
  use CopArchiveWeb, :controller

  alias CopArchive.User

  def index(conn, _params) do
    users = User.all(order: :name, preload: [:topics, [replies: :topic]])
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = User.get(id, preload: [:topics, [replies: :topic]])

    render(conn, "show.html", user: user)
  end
end
