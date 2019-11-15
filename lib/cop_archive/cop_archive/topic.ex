defmodule CopArchive.Topic do
  use Ecto.Schema
  alias Ecto.Query, as: Q
  use CopArchive.TopherDB

  @derive {Phoenix.Param, key: :prettyUrlString}
  @primary_key {:oid, :integer, autogenerate: false}

  #  +-------------------------+-------------------------------------------------+------+-----+---------+-------+
  # | Field                   | Type                                            | Null | Key | Default | Extra |
  # +-------------------------+-------------------------------------------------+------+-----+---------+-------+
  # | oid                     | bigint(20)                                      | NO   | PRI | NULL    |       |
  # | allowReplies            | bit(1)                                          | NO   |     | NULL    |       |
  # | avatarFileOnDiskOid     | bigint(20)                                      | YES  |     | NULL    |       |
  # | compositionPartitionOid | bigint(20)                                      | NO   |     | NULL    |       |
  # | contentStatus           | int(11)                                         | NO   |     | NULL    |       |
  # | contentSubType          | tinyint(4)                                      | NO   |     | NULL    |       |
  # | contentType             | int(11)                                         | NO   |     | NULL    |       |
  # | extract                 | varchar(500)                                    | NO   |     | NULL    |       |
  # | guestName               | varchar(40)                                     | YES  |     | NULL    |       |
  # | lastActivityIp          | varchar(15)                                     | YES  |     | NULL    |       |
  # | lastUpdateDatetime      | datetime                                        | NO   | MUL | NULL    |       |
  # | liveDatetime            | datetime                                        | NO   | MUL | NULL    |       |
  # | moderationStatus        | enum('APPROVED','PENDING_APPROVAL','MODERATED') | NO   |     | NULL    |       |
  # | premium                 | bit(1)                                          | NO   |     | NULL    |       |
  # | prettyUrlString         | varchar(255)                                    | YES  |     | NULL    |       |
  # | subject                 | varchar(255)                                    | NO   |     | NULL    |       |
  # | areaUserRlm_oid         | bigint(20)                                      | YES  | MUL | NULL    |       |
  # | featuredContent_oid     | bigint(20)                                      | YES  |     | NULL    |       |
  # | futureContent_oid       | bigint(20)                                      | YES  | MUL | NULL    |       |
  # | moderatedItem_oid       | bigint(20)                                      | YES  | MUL | NULL    |       |
  # | portfolio_oid           | bigint(20)                                      | NO   | MUL | NULL    |       |
  # +-------------------------+-------------------------------------------------+------+-----+---------+-------+
  # 21 rows in set (0.00 sec)

  schema "Content" do
    field :subject, :string
    field :extract, :string
    field :liveDatetime, :naive_datetime
    field :lastUpdateDatetime, :naive_datetime
    field :prettyUrlString, :string

    belongs_to :area_user, CopArchive.AreaUser, foreign_key: :areaUserRlm_oid, references: :oid
    has_one :user, through: [:area_user, :user]

    has_one :forum_content, CopArchive.ForumContent, foreign_key: :forumTopicContent_oid
    has_one :forum, through: [:forum_content, :forum]

    has_many :replies, CopArchive.Reply, foreign_key: :composition_oid, references: :oid
  end

  def apply_clause(query, :id, oid), do: Q.where(query, [r], r.oid == ^oid)
  def apply_clause(query, :slug, slug), do: Q.where(query, [r], r.prettyUrlString == ^slug)
  def apply_clause(query, :order, :date), do: Q.order_by(query, [a], desc: a.liveDatetime)
end
