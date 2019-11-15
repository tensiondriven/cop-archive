defmodule CopArchive.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Query, as: Q
  use CopArchive.TopherDB

  @derive {Phoenix.Param, key: :oid}
  @primary_key {:oid, :integer, autogenerate: false}

  # | oid                                            | bigint(20)   | NO   | PRI | NULL    |       |
  # | authZone                                       | bigint(20)   | NO   | MUL | NULL    |       |
  # | displayName                                    | varchar(40)  | NO   |     | NULL    |       |
  # | formatPreferences_languageLocale               | int(11)      | YES  |     | NULL    |       |
  # | formatPreferences_locale                       | varchar(8)   | NO   |     | NULL    |       |
  # | formatPreferences_timeZone                     | varchar(255) | YES  |     | NULL    |       |
  # | moderationReasons                              | bigint(20)   | NO   |     | NULL    |       |
  # | preferences_disableCommentWall                 | bit(1)       | NO   |     | NULL    |       |
  # | preferences_facebookPageId                     | varchar(255) | YES  |     | NULL    |       |
  # | preferences_facebookPageUserId                 | varchar(255) | YES  |     | NULL    |       |
  # | preferences_hasConfiguredMobilePush            | bit(1)       | NO   |     | NULL    |       |
  # | preferences_hideMeOnOnlineNow                  | bit(1)       | NO   |     | NULL    |       |
  # | preferences_hideMyBirthday                     | bit(1)       | NO   |     | NULL    |       |
  # | preferences_hideMyLikesPage                    | bit(1)       | NO   |     | NULL    |       |
  # | preferences_hideUserFeedAccountsTip            | bit(1)       | NO   |     | NULL    |       |
  # | preferences_includeSignatureByDefault          | bit(1)       | NO   |     | NULL    |       |
  # | preferences_instantDeliveryMethods             | tinyint(4)   | NO   |     | NULL    |       |
  # | preferences_lastDeactivationDatetime           | datetime     | YES  |     | NULL    |       |
  # | preferences_notifyMeOfCommentsToWatchedContent | bit(1)       | NO   |     | NULL    |       |
  # | preferences_notifyNewDialogPosts               | bit(1)       | NO   |     | NULL    |       |
  # | preferences_stripLocationInfo                  | bit(1)       | NO   |     | NULL    |       |
  # | preferences_subscribeToContentYouPostTo        | bit(1)       | NO   |     | NULL    |       |
  # | preferences_subscribeToParticipatingDialogs    | bit(1)       | NO   |     | NULL    |       |
  # | preferences_subscribeToYourNewContent          | bit(1)       | NO   |     | NULL    |       |
  # | preferences_suppressReplySignatures            | bit(1)       | NO   |     | NULL    |       |
  # | preferences_suspendAllEmails                   | bit(1)       | NO   |     | NULL    |       |
  # | preferences_wba28DayJourneyDeliveryMethods     | tinyint(4)   | NO   |     | NULL    |       |
  # | requiresReviewDatetime                         | datetime     | YES  |     | NULL    |       |
  # | signature                                      | longtext     | YES  |     | NULL    |       |
  # | twoFactorAuthenticationSecretKey               | tinytext     | YES  |     | NULL    |       |
  # | agreedToTosDatetime                            | datetime     | YES  |     | NULL    |       |
  # | emailAddress                                   | varchar(255) | NO   |     | NULL    |       |
  # | emailVerified                                  | bit(1)       | NO   |     | NULL    |       |
  # | registrationDate                               | datetime     | NO   |     | NULL    |       |
  # | registrationIp                                 | varchar(15)  | YES  |     | NULL    |       |
  # | registrationIpCountry                          | char(2)      | YES  |     | NULL    |       |
  # | userStatus                                     | int(11)      | NO   |     | NULL    |       |
  # | username                                       | varchar(40)  | YES  |     | NULL    |       |
  # | wallTopicCompositionPartitionOid               | bigint(20)   | YES  |     | NULL    |       |
  # | avatar_oid                                     | bigint(20)   | YES  | MUL | NULL    |       |
  # | stockAvatar_oid                                | bigint(20)   | YES  | MUL | NULL    |       |

  schema "User" do
    field :username, :string
    field :displayName, :string
    field :registrationDate, :naive_datetime
    has_many :area_users, CopArchive.AreaUser
    has_many :topics, through: [:area_users, :topics]
  end

  def apply_clause(query, :id, oid), do: Q.where(query, [r], r.oid == ^oid)
  def apply_clause(query, :order, :name), do: Q.order_by(query, [a], asc: a.displayName)

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
