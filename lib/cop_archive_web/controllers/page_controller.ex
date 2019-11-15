defmodule CopArchiveWeb.PageController do
  use CopArchiveWeb, :controller

  alias CopArchive.Reply

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
