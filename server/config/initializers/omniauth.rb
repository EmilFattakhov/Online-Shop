# Step 3 - OmniAuth: Creating this file and the confuring it like this 👇🏻
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV["GITHUB_KEY"], ENV["GITHUB_SECRET"], scope: "read:user, user:email"
end
