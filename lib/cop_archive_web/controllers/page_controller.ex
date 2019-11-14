defmodule CopArchiveWeb.PageController do
  use CopArchiveWeb, :controller

  alias CopArchive.Reply

  def index(conn, _params) do
    posts = Reply.all()
    txt = inspect(posts)
    render(conn, "index.html", posts: posts, txt: txt)
  end
end
