defmodule Mix.Tasks.Render do
  use Mix.Task

  alias CopArchive.{Forum, Topic, Reply, User}
  alias CopArchiveWeb.{ForumView, TopicView, ReplyView, UserView, PageView, LayoutView}

  use CopArchiveWeb, :view

  @shortdoc "Render content to files."
  def run(_) do
    Mix.Task.run("app.start")
    IO.puts("Rendering forum content to files...")
    mkdirs()
    copy_css()
    render_menu()
    render_forums()
    render_topics()
    render_replies()
    render_users()
  end

  defp render_menu() do
    str =
      Phoenix.View.render_to_string(PageView, "index.html",
        conn: conn(),
        layout: {LayoutView, "app.html"}
      )

    write("/index", str)
  end

  defp render_forums() do
    forums = Forum.all(order: :date, preload: [topics: :user])

    str =
      Phoenix.View.render_to_string(ForumView, "index.html",
        conn: conn(),
        forums: forums,
        layout: {LayoutView, "app.html"}
      )

    write("/forum/index", str)

    Enum.each(forums, fn forum ->
      str =
        Phoenix.View.render_to_string(ForumView, "show.html",
          conn: conn(),
          forum: forum,
          layout: {LayoutView, "app.html"}
        )

      Routes.forum_path(conn(), :show, forum) |> write(str)
    end)
  end

  defp render_topics() do
    topics = Topic.all(order: :date, preload: [:forum, :user, replies: :user])

    str =
      Phoenix.View.render_to_string(TopicView, "index.html",
        conn: conn(),
        topics: topics,
        layout: {LayoutView, "app.html"}
      )

    write("/topic/index", str)

    Enum.each(topics, fn topic ->
      str =
        Phoenix.View.render_to_string(TopicView, "show.html",
          conn: conn(),
          topic: topic,
          layout: {LayoutView, "app.html"}
        )

      Routes.topic_path(conn(), :show, topic) |> write(str)
    end)
  end

  defp render_replies() do
    replies = Reply.all(order: :date, preload: [:topic, :user])

    str =
      Phoenix.View.render_to_string(ReplyView, "index.html",
        conn: conn(),
        replies: replies,
        layout: {LayoutView, "app.html"}
      )

    write("/reply/index", str)

    Enum.each(replies, fn reply ->
      if reply.topic do
        str =
          Phoenix.View.render_to_string(ReplyView, "show.html",
            conn: conn(),
            reply: reply,
            layout: {LayoutView, "app.html"}
          )

        Routes.reply_path(conn(), :show, reply) |> write(str)
      end
    end)
  end

  defp render_users() do
    users = User.all(order: :name, preload: [:topics, :replies])

    str =
      Phoenix.View.render_to_string(UserView, "index.html",
        conn: conn(),
        users: users,
        layout: {LayoutView, "app.html"}
      )

    write("/user/index", str)

    Enum.each(users, fn user ->
      str =
        Phoenix.View.render_to_string(UserView, "show.html",
          conn: conn(),
          user: user,
          layout: {LayoutView, "app.html"}
        )

      Routes.user_path(conn(), :show, user) |> write(str)
    end)
  end

  defp mkdirs() do
    File.mkdir(path())
    File.mkdir("#{path()}/forum")
    File.mkdir("#{path()}/topic")
    File.mkdir("#{path()}/reply")
    File.mkdir("#{path()}/user")
  end

  defp copy_css() do
    File.mkdir("#{path()}/css")
    File.copy!("priv/static/css/app.css", "#{path()}/css/app.css")
  end

  defp conn() do
    CopArchiveWeb.Endpoint
  end

  defp path() do
    "docs"
  end

  defp write(file, str) do
    # Remove the prefix that github pages will add back in.
    file = String.replace(file, "/cop-archive", "")
    location = "#{path()}#{file}.html"
    IO.puts("  wrote #{location}")
    File.write(location, str)
  end
end
