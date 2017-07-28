provider "heroku" {
  email = "${var.env_email}"
  api_key = "${var.env_api_key}"
}

provider "cloudflare" {
  email = "${var.cloudflare_email}"
  token = "${var.cloudflare_token}"
}

resource "cloudflare_record" "www" {
  domain = "${var.cloudflare_www_domain}"
  name = "${var.cloudflare_www_name}"
  value = "${heroku_app.huginn.heroku_hostname}"
  type = "${var.cloudflare_www_type}"
}

resource "heroku_domain" "default" {
  app      = "${heroku_app.huginn.name}"
  hostname = "${var.cloudflare_www_name}.${var.cloudflare_www_domain}"
}

output "heroku_app_url" {
 value = "${heroku_app.huginn.web_url}"
}

output "heroku_config_vars" {
 value = "${heroku_app.huginn.all_config_vars}"
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
