defmodule CopArchive.Reply do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Query, as: Q
  use CopArchive.TopherDB

  @primary_key {:oid, :integer, autogenerate: false}

  # | oid                   | bigint(20)
  # | body                  | mediumtext
  # | collapseAttachmentBox | bit(1)
  # | editDatetime          | datetime
  # | editorUserOid         | bigint(20)
  # | guestName             | varchar(40)
  # | hasSignature          | bit(1)
  # | lastActivityIp        | varchar(15)
  # | liveDatetime          | datetime
  # | moderationStatus      | enum
  # | postBodySource        | tinyint(4)
  # | postByEmail           | bit(1)
  # | threadingOrder        | int(11)
  # | userOid               | bigint(20)
  # | whisper               | bit(1)
  # | composition_oid       | bigint(20)
  # | filePointerSet_oid    | bigint(20)
  # | forkedComposition_oid | bigint(20)
  # | mentions_oid          | bigint(20)
  #

  schema "Reply" do
    field :body, :string
  end

  def apply_clause(query, :id, oid), do: Q.where(query, [r], r.oid == ^oid)

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [])
    |> validate_required([])
  end
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
