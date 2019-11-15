defmodule CopArchiveWeb.ForumController do
  use CopArchiveWeb, :controller

  alias CopArchive.Forum

  def index(conn, _params) do
    forums = Forum.all(order: :date, preload: [:topics])
    render(conn, "index.html", forums: forums)
  end

  def show(conn, %{"id" => id}) do
    forum = Forum.get(id, preload: [:topics])
    render(conn, "show.html", forum: forum)
  end
end