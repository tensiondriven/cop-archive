defmodule CopArchive.Composition do
  use Ecto.Schema
  alias Ecto.Query, as: Q
  use CopArchive.TopherDB

  @primary_key {:oid, :integer, autogenerate: false}

  # +-----------------------+-------------+------+-----+---------+-------+
  # | Field                 | Type        | Null | Key | Default | Extra |
  # +-----------------------+-------------+------+-----+---------+-------+
  # | oid                   | bigint(20)  | NO   | PRI | NULL    |       |
  # | areaOid               | bigint(20)  | NO   | MUL | NULL    |       | x
  # | body                  | mediumtext  | NO   |     | NULL    |       |
  # | collapseAttachmentBox | bit(1)      | NO   |     | NULL    |       |
  # | compositionType       | int(11)     | YES  |     | NULL    |       |
  # | editDatetime          | datetime    | YES  |     | NULL    |       |
  # | editorUserOid         | bigint(20)  | YES  |     | NULL    |       |
  # | guestName             | varchar(40) | YES  |     | NULL    |       |
  # | hasSignature          | bit(1)      | NO   |     | NULL    |       |
  # | postBodySource        | tinyint(4)  | NO   |     | NULL    |       |
  # | postByEmail           | bit(1)      | NO   |     | NULL    |       |
  # | userOid               | bigint(20)  | YES  |     | NULL    |       |
  # | filePointerSet_oid    | bigint(20)  | YES  | MUL | NULL    |       |
  # | mentions_oid          | bigint(20)  | YES  |     | NULL    |       |
  # +-----------------------+-------------+------+-----+---------+-------+

  schema "Composition" do
    field :body, :string
  end

  def apply_clause(query, :id, oid), do: Q.where(query, [r], r.oid == ^oid)
end

# +-------------------------------+
# | Tables_in_cop                 |
# +-------------------------------+
# | BlogEntry                     |
# | CalendarEventContent          |
# | ChatEventContent              |
# | ChatRoomContent               |
# | Composition                   |
# | CompositionMentions           |
# | CompositionReport             |
# | CompositionStats              |
# | DatabaseRecord                |
# | DialogCmp                     |
# | FilePointer                   |
# | FilePointerSet                |
# | ForumTopic                    |
# | QuestionSharkDocumentCmp      |
# | QuestionSharkProductFaqTopic  |
# | QuestionSharkTopic            |
# | QuestionSharkTopicEvent       |
# | Reply                         |
# | ReplyCcEmailAddress           |
# | ReplyMentions                 |
# | ReplyReport                   |
# | ReplyStats                    |
# | Survey                        |
# | SurveyAnswer                  |
# | SurveyQuestion                |
# | SurveyQuestionResponse        |
# | SurveyQuestionWriteInResponse |
# | SurveyResponse                |
# | UserLikedComposition          |
# | UserLikedReply                |
# | UserWallTopic                 |
# | WatchedContent                |
# +-------------------------------+
# 32 rows in set (0.00 sec)
