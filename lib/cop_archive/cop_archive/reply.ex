defmodule CopArchive.Reply do
  use Ecto.Schema
  alias Ecto.Query, as: Q
  use CopArchive.TopherDB

  @derive {Phoenix.Param, key: :oid}
  @primary_key {:oid, :integer, autogenerate: false}

  # +-----------------------+-------------------------------------------------+------+-----+---------+-------+
  # | Field                 | Type                                            | Null | Key | Default | Extra |
  # +-----------------------+-------------------------------------------------+------+-----+---------+-------+
  # | oid                   | bigint(20)                                      | NO   | PRI | NULL    |       |
  # | body                  | mediumtext                                      | NO   |     | NULL    |       |
  # | collapseAttachmentBox | bit(1)                                          | NO   |     | NULL    |       |
  # | editDatetime          | datetime                                        | YES  |     | NULL    |       |
  # | editorUserOid         | bigint(20)                                      | YES  |     | NULL    |       |
  # | guestName             | varchar(40)                                     | YES  |     | NULL    |       |
  # | hasSignature          | bit(1)                                          | NO   |     | NULL    |       |
  # | lastActivityIp        | varchar(15)                                     | YES  |     | NULL    |       |
  # | liveDatetime          | datetime                                        | NO   |     | NULL    |       |
  # | moderationStatus      | enum('APPROVED','PENDING_APPROVAL','MODERATED') | NO   |     | NULL    |       |
  # | postBodySource        | tinyint(4)                                      | NO   |     | NULL    |       |
  # | postByEmail           | bit(1)                                          | NO   |     | NULL    |       |
  # | threadingOrder        | int(11)                                         | NO   | UNI | NULL    |       |
  # | userOid               | bigint(20)                                      | YES  |     | NULL    |       |
  # | whisper               | bit(1)                                          | NO   |     | NULL    |       |
  # | composition_oid       | bigint(20)                                      | NO   | MUL | NULL    |       |
  # | filePointerSet_oid    | bigint(20)                                      | YES  | UNI | NULL    |       |
  # | forkedComposition_oid | bigint(20)                                      | YES  | MUL | NULL    |       |
  # | mentions_oid          | bigint(20)                                      | YES  |     | NULL    |       |
  # +-----------------------+-------------------------------------------------+------+-----+---------+-------+
  # 19 rows in set (0.00 sec)

  schema "Reply" do
    field :body, :string
    field :editDatetime, :naive_datetime
    field :liveDatetime, :naive_datetime
    # belongs_to :comp, CopArchive.Composition, foriegn_key: "oid"

    belongs_to :user, CopArchive.User, foreign_key: :userOid, references: :oid
    belongs_to :topic, CopArchive.Topic, foreign_key: :composition_oid, references: :oid
  end

  def apply_clause(query, :id, oid), do: Q.where(query, [r], r.oid == ^oid)
  def apply_clause(query, :order, :date), do: Q.order_by(query, [a], desc: a.liveDatetime)

  def apply_clause(query, :has_topic, true),
    do: Q.where(query, [r], not is_nil(r.composition_oid))
end
