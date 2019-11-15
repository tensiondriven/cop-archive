defmodule CopArchiveWeb.SharedView do
  def date(datetime) do
    Timex.format!(datetime, "%Y-%m-%d (%m/%d/%Y)", :strftime)
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

defmodule CopArchiveWeb.UserView do
  use CopArchiveWeb, :view
  import CopArchiveWeb.SharedView
end
