defmodule CopArchiveWeb.ForumController do
  use CopArchiveWeb, :controller

  alias CopArchive.Forum

  def index(conn, _params) do
    forums = Forum.all(order: :thread, preload: [topics: [:replies, :user]])
    render(conn, "index.html", forums: forums)
  end

  def show(conn, %{"id" => id}) do
    forum =
      Forum.get(id, preload: [topics: [:replies, :user]])
      |> CopArchiveWeb.ForumView.reverse_topics()

    forum = render(conn, "show.html", forum: forum)
  end
end
