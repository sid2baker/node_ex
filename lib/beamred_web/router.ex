defmodule BeamREDWeb.Router do
  use BeamREDWeb, :router

  pipeline :browser do
    # plug :accepts, ["html"]
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {BeamREDWeb.Layouts, :root}
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Phoenix.Plugs.DebugPlug, label: "Plug.Static"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  import Phoenix.NodeRed.Router

  scope "/", BeamREDWeb do
    pipe_through :browser

    nodered("/nodered", [])
    # get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", BeamREDWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard in development
  if Application.compile_env(:beamred, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: BeamREDWeb.Telemetry
    end
  end
end
