defmodule BaltimoreAiWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use BaltimoreAiWeb, :controller
      use BaltimoreAiWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: BaltimoreAiWeb

      import Plug.Conn
      import BaltimoreAiWeb.Gettext
      # TODO: the alias below could be an import instead so that we could use
      # its helpers without calling the module name.
      alias BaltimoreAiWeb.Router.Helpers, as: Routes
      import Canary.Plugs
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/baltimore_ai_web/templates",
        namespace: BaltimoreAiWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import BaltimoreAiWeb.ErrorHelpers
      import BaltimoreAiWeb.Gettext
      import BaltimoreAiWeb.ViewHelpers
      alias BaltimoreAiWeb.Router.Helpers, as: Routes

      def render_shared(template, assigns \\ []) do
        render(BaltimoreAiWeb.SharedView, template, assigns)
      end

      def user_logged_in?(conn), do: !is_nil(Map.get(conn.assigns, :current_user))
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import BaltimoreAiWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
