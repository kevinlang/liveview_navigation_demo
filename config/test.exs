import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :liveview_navigation_demo, LiveviewNavigationDemoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "V9N8EVicJSmS9e0QJAtt8+Bz69KqDFCTtdTXFzhVi3U13Sl1Ltix3sVW9yWpb13b",
  server: false

# In test we don't send emails.
config :liveview_navigation_demo, LiveviewNavigationDemo.Mailer,
  adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
