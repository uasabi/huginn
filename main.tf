provider "heroku" {
  email = "${var.env_email}"
  api_key = "${var.env_api_key}"
}

output "heroku_app_url" {
 value = "${heroku_app.huginn.web_url}"
}

output "heroku_app_hostname" {
 value = "${heroku_app.huginn.heroku_hostname}"
}

output "heroku_app_git_url" {
 value = "${heroku_app.huginn.git_url}"
}

resource "heroku_app" "huginn" {
  name = "${var.app_name}"
  region = "us"
}

resource "heroku_addon" "database" {
  app = "${heroku_app.huginn.name}"
  plan = "${var.postgres_plan}"
}

resource "heroku_addon" "newrelic" {
  app = "${heroku_app.huginn.name}"
  plan = "${var.newrelic_plan}"
}

resource "heroku_addon" "papertrail" {
  app = "${heroku_app.huginn.name}"
  plan = "${var.papertrail_plan}"
}
