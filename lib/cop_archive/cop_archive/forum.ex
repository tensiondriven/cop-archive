defmodule CopArchive.Forum do
  use Ecto.Schema
  alias Ecto.Query, as: Q
  use CopArchive.TopherDB

  @derive {Phoenix.Param, key: :oid}
  @primary_key {:oid, :integer, autogenerate: false}

  # +----------------------------------+--------------+------+-----+---------+-------+
  # | Field                            | Type         | Null | Key | Default | Extra |
  # +----------------------------------+--------------+------+-----+---------+-------+
  # | oid                              | bigint(20)   | NO   | PRI | NULL    |       |
  # | avatarFileOnDiskOid              | bigint(20)   | YES  |     | NULL    |       |
  # | deletionStatus                   | int(11)      | NO   |     | NULL    |       |
  # | description                      | mediumtext   | YES  |     | NULL    |       |
  # | intro                            | mediumtext   | YES  |     | NULL    |       |
  # | name                             | varchar(255) | NO   |     | NULL    |       |
  # | overrideWidgets                  | bit(1)       | NO   |     | NULL    |       |
  # | prettyUrlString                  | varchar(255) | YES  |     | NULL    |       |
  # | promoteForumTopicCreationByEmail | bit(1)       | NO   |     | NULL    |       |
  # | rightSidebarAdOverride           | mediumtext   | YES  |     | NULL    |       |
  # | showIntroOnTopicPages            | bit(1)       | NO   |     | NULL    |       |
  # | supportForumTopicCreationByEmail | bit(1)       | NO   |     | NULL    |       |
  # | themeOid                         | bigint(20)   | YES  |     | NULL    |       |
  # | threadingOrder                   | int(11)      | NO   |     | NULL    |       |
  # | titleImageOnDiskOid              | bigint(20)   | YES  |     | NULL    |       |
  # | category_oid                     | bigint(20)   | NO   | MUL | NULL    |       |
  # | portfolio_oid                    | bigint(20)   | NO   | MUL | NULL    |       |
  # +----------------------------------+--------------+------+-----+---------+-------+
  # 17 rows in set (0.00 sec)

  schema "Forum" do
    field :name, :string
    field :intro, :string
    field :description, :string
    field :threadingOrder, :integer
    has_many :forum_contents, CopArchive.ForumContent, foreign_key: :forum_oid
    has_many :topics, through: [:forum_contents, :topics]
  end

  def apply_clause(query, :id, oid), do: Q.where(query, [r], r.oid == ^oid)
  def apply_clause(query, :order, _), do: Q.order_by(query, [a], asc: a.threadingOrder)
end
