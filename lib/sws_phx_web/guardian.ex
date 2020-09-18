defmodule SwsPhx.Guardian do
  use Guardian, otp_app: :sws_phx

  def subject_for_token(user, _claims) do
    sub = "#{user.id}"
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    user = claims["sub"]
    {:ok, user}
  end
end
