defmodule Mix.Tasks.Sitemap do
  use Mix.Task

  alias CopArchive.{Forum, Topic, Reply}

  use CopArchiveWeb, :view

  use Sitemap,
    host: "https://community-archive.holacracy.org",
    compress: false,
    files_path: "docs/",
    public_path: ""

  def generate(paths) do
    create do
      Enum.each(paths, &add(&1))
    end

    # notify search engines (currently Google and Bing) of the updated sitemap
    # ping()
  end

  @shortdoc "Render sitemap to disk."
  def run(_) do
    Mix.Task.run("app.start")
    IO.puts("Generating sitemap...")

    paths =
      generate_forum_paths() ++
        generate_topic_paths() ++
        generate_reply_paths()

    generate(paths)
  end

  def generate_forum_paths() do
    forums =
      Forum.all(order: :thread, preload: [topics: [:replies, :user]])
      |> CopArchiveWeb.ForumView.sort_forum_topics()

    ["/"] ++
      Enum.map(forums, fn forum ->
        Routes.forum_path(conn(), :show, forum)
      end)
  end

  defp generate_topic_paths() do
    topics =
      Topic.all(order: :subject, preload: [:forum, :composition, :user, replies: :user])
      |> CopArchiveWeb.TopicView.sort_topic_replies()

    ["/topic"] ++
      Enum.map(topics, fn topic ->
        Routes.topic_path(conn(), :show, topic)
      end)
  end

  defp generate_reply_paths() do
    replies = Reply.all(order: :date, preload: [:user, topic: [:user, :forum]])

    (["/reply"] ++
       Enum.map(replies, fn reply ->
         if reply.topic do
           Routes.reply_path(conn(), :show, reply)
         end
       end))
    |> Enum.reject(&is_nil(&1))
  end

  # defp generate_user_paths() do
  #   users = User.all(order: :name, preload: [:topics, [replies: :topic]])

  #   write("/user/index", str)

  #   Enum.each(users, fn user ->
  #     Routes.user_path(conn(), :show, user)
  #   end)
  # end

  defp conn() do
    CopArchiveWeb.Endpoint
  end
end
