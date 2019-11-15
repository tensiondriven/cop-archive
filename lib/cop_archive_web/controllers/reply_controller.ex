defmodule CopArchiveWeb.ReplyController do
  use CopArchiveWeb, :controller

  alias CopArchive.Reply

  def show(conn, %{"id" => id}) do
    reply = Reply.get(id, preload: [:user, topic: [:user, :forum]])
    render(conn, "show.html", reply: reply)
  end
end
