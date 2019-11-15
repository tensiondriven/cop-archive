defmodule CopArchiveWeb.SharedView do
  import Phoenix.HTML, only: [raw: 1]

  def date(datetime) do
    Timex.format!(datetime, "%Y-%m-%d (%m/%d/%Y)", :strftime)
  end

  def format(string) do
    (string || "") |> String.replace("https://community-archive.holacracy.org", "") |> raw()
  end
end

defmodule CopArchiveWeb.PageView do
  use CopArchiveWeb, :view
  import CopArchiveWeb.SharedView
end

defmodule CopArchiveWeb.ForumView do
  use CopArchiveWeb, :view
  import CopArchiveWeb.SharedView
end

defmodule CopArchiveWeb.TopicView do
  use CopArchiveWeb, :view
  import CopArchiveWeb.SharedView
end

defmodule CopArchiveWeb.ReplyView do
  use CopArchiveWeb, :view
  import CopArchiveWeb.SharedView
end

defmodule CopArchiveWeb.UserView do
  use CopArchiveWeb, :view
  import CopArchiveWeb.SharedView
  import Phoenix.HTML.SimplifiedHelpers.Truncate, only: [truncate: 2]
  import HtmlSanitizeEx, only: [strip_tags: 1]
end
