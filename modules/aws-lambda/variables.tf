variable "lambda_function_payload" {
  description = "Path the the lambda function deployment package within the local file system"
}
variable "lambda_function_name" {
  description = "A unique name for your Lambda Function"
}
variable "lambda_function_handler" {
  description = "The function entrypoint in your code"
}
variable "lambda_function_runtime" {

}
variable "iam_policy_document" {

}
variable "environment" {
  description = "Environment configuration for the Lambda function"
  type        = "map"
  default     = {}
}