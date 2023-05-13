module vpc {
  source = "../modules/vpc"
}

module rds {
  source = "../modules/rds"
  database_user = var.user
  database_password =  var.password
  database_name = "cw_test"
  rds_sg = module.vpc.rds_sg_out
  rds_subs = module.vpc.rds_subs_out
  storage = 5
  rds_identifier = "cw-test"
}

module cw {
  source = "../modules/cloudwatch"
  alarm_name = "test-for-rds"
  sns_topic =  module.sns.sns_topic_out
}

module sns {
  source = "../modules/sns"
  lambda_slack_arn = module.lambda.lambda_slack_arn_out
  email = var.email
}

module lambda {
  source = "../modules/lambda"
  sns_topic =  module.sns.sns_topic_out
  slack_webhook = var.slack_webhook
}
# To trigger the alarm for testing use:
# aws cloudwatch set-alarm-state --alarm-name "test-for-rds" --state-value ALARM --state-reason "testing purposes"
