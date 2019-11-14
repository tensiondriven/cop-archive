defmodule CopArchive.Repo do
  use Ecto.Repo,
    otp_app: :cop_archive,
    adapter: Ecto.Adapters.MyXQL
end
