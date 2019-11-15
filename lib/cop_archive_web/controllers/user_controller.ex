defmodule CopArchiveWeb.UserController do
  use CopArchiveWeb, :controller

  alias CopArchive.User

  def index(conn, _params) do
    users = User.all(order: :name)
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = User.get(id)
    render(conn, "show.html", user: user)
  end
end