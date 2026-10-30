
output "cpu_alarm_name" {
  description = "CloudWatch CPU alarm name"
  value       = aws_cloudwatch_metric_alarm.cpu_alarm.alarm_name
}

output "cpu_alarm_arn" {
  description = "CloudWatch CPU alarm ARN"
  value       = aws_cloudwatch_metric_alarm.cpu_alarm.arn
}
