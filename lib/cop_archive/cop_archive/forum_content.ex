defmodule CopArchive.ForumContent do
  use Ecto.Schema
  alias Ecto.Query, as: Q
  use CopArchive.TopherDB

  @derive {Phoenix.Param, key: :oid}
  @primary_key {:oid, :integer, autogenerate: false}

  schema "ForumContent" do
    field :forumTopicContent_oid, :integer
    belongs_to :forum, CopArchive.Forum, foreign_key: :forum_oid, references: :oid
    has_many :topics, CopArchive.Topic, foreign_key: :oid, references: :forumTopicContent_oid
  end

  # mysql> describe ForumContent;
  # +-----------------------+------------+------+-----+---------+-------+
  # | Field                 | Type       | Null | Key | Default | Extra |
  # +-----------------------+------------+------+-----+---------+-------+
  # | oid                   | bigint(20) | NO   | PRI | NULL    |       |
  # | lastUpdateDatetime    | datetime   | NO   | MUL | NULL    |       |
  # | liveDatetime          | datetime   | NO   | MUL | NULL    |       |
  # | forum_oid             | bigint(20) | NO   | MUL | NULL    |       |
  # | forumTopicContent_oid | bigint(20) | NO   | MUL | NULL    |       |
  # +-----------------------+------------+------+-----+---------+-------+
  # 5 rows in set (0.00 sec)

  def apply_clause(query, :id, oid), do: Q.where(query, [r], r.oid == ^oid)
  def apply_clause(query, :order, :inserted_at), do: Q.order_by(query, [a], desc: a.liveDatetime)

  def apply_clause(query, :order, :updated_at),
    do: Q.order_by(query, [a], desc: a.lastUpdateDatetime)
end
