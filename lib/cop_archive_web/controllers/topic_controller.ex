defmodule CopArchiveWeb.TopicController do
  use CopArchiveWeb, :controller

  alias CopArchive.Topic

  def index(conn, _params) do
    topics = Topic.all(order: :date, preload: [:forum, :composition, :user, replies: :user])
    render(conn, "index.html", topics: topics)
  end

  def show(conn, %{"id" => id}) do
    topic = Topic.get_by!(slug: id, preload: [:forum, :composition, :user, replies: :user])
    render(conn, "show.html", topic: topic)
  end
end
