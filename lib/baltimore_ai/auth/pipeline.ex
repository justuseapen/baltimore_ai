defmodule BaltimoreAi.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :baltimore_ai,
    error_handler: BaltimoreAi.Auth.ErrorHandler,
    module: BaltimoreAi.Auth.Guardian
  # If there is a session token, validate it
  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  # If there is an authorization header, validate it
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  # Load the user if either of the verifications worked
  plug Guardian.Plug.LoadResource, allow_blank: true
  # By default Canary will look for a current_user map in the conn to handle
  # permissions.
  plug BaltimoreAi.Plugs.CurrentUser
end
