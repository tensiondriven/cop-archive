defmodule CopArchive.AreaUser do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Query, as: Q
  use CopArchive.TopherDB

  @derive {Phoenix.Param, key: :oid}
  @primary_key {:oid, :integer, autogenerate: false}

  schema "AreaUser" do
    belongs_to :user, CopArchive.User, foreign_key: :user_oid, references: :oid
    has_many :topics, CopArchive.Topic, foreign_key: :areaUserRlm_oid, references: :oid
  end

  # mysql> describe AreaUser;
  # +----------------------------------------+-------------+------+-----+---------+-------+
  # | Field                                  | Type        | Null | Key | Default | Extra |
  # +----------------------------------------+-------------+------+-----+---------+-------+
  # | oid                                    | bigint(20)  | NO   | PRI | NULL    |       |
  # | acknowledgedNewsFlashDatetime          | datetime    | YES  |     | NULL    |       |
  # | acknowledgedWbaInviteNewsFlashDatetime | datetime    | YES  |     | NULL    |       |
  # | areaPoints                             | int(11)     | NO   | MUL | NULL    |       |
  # | birthdayMonthDay                       | char(4)     | YES  | MUL | NULL    |       |
  # | communityRank                          | int(11)     | NO   | MUL | NULL    |       |
  # | createdDatetime                        | datetime    | NO   | MUL | NULL    |       |
  # | displayName                            | varchar(40) | NO   | MUL | NULL    |       |
  # | followerCount                          | int(11)     | NO   |     | NULL    |       |
  # | preferences_notificationSettings       | bigint(20)  | NO   |     | NULL    |       |
  # | status                                 | int(11)     | NO   |     | NULL    |       |
  # | area_oid                               | bigint(20)  | NO   | MUL | NULL    |       |
  # | user_oid                               | bigint(20)  | YES  | MUL | NULL    |       |
  # +----------------------------------------+-------------+------+-----+---------+-------+
  # 13 rows in set (0.00 sec)

  def apply_clause(query, :id, oid), do: Q.where(query, [r], r.oid == ^oid)
  def apply_clause(query, :order, :name), do: Q.order_by(query, [a], asc: a.displayName)

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [])
    |> validate_required([])
  end
end
