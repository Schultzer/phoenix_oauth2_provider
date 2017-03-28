defmodule ExOauth2Phoenix do
  @moduledoc """
  A module that provides OAuth 2 based server for Phoenix applications.
  ## Configuration
      config :ex_oauth2_phoenix, ExOauth2Phoenix,
        current_resource_owner: :current_user,
        module: MyApp,
        router: MyApp.Router
  """
  @config             Application.get_env(:ex_oauth2_phoenix, ExOauth2Phoenix, [])
  @module             Keyword.get(@config, :module, Mix.Phoenix.base())
  @router_helpers     Module.concat([Keyword.get(@config, :router, Module.concat([@module, "Router"])), "Helpers"])
  @resource_owner_key Keyword.get(@config, :current_resource_owner, :current_user)

  @doc false
  def router_helpers, do: @router_helpers

  # @doc """
  # Will get current resource owner from endpoint
  # """
  def current_resource_owner(conn) do
    case conn.assigns[@resource_owner_key] do
      nil -> raise "Resource owner was not found with :#{@resource_owner_key} assigns"
      resource_owner -> resource_owner
    end
  end
end