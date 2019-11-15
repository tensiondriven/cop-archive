defmodule CopArchiveWeb.TopicController do
  use CopArchiveWeb, :controller

  alias CopArchive.Repo
  alias CopArchive.{Topic, User}

  def index(conn, _params) do
    topics = Topic.all(order: :date)
    render(conn, "index.html", topics: topics)
  end

  def show(conn, %{"id" => id}) do
    topic = Topic.get(id) |> Repo.preload([:forum, :user])
    render(conn, "show.html", topic: topic)
  end
end
