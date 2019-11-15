defmodule CopArchiveWeb.ReplyController do
  use CopArchiveWeb, :controller

  alias CopArchive.Reply

  def index(conn, _params) do
    replies = Reply.all(order: :date, preload: [:topic, :user])
    render(conn, "index.html", replies: replies)
  end

  def show(conn, %{"id" => id}) do
    reply = Reply.get(id, preload: [:topic, :user])
    render(conn, "show.html", reply: reply)
  end
end
