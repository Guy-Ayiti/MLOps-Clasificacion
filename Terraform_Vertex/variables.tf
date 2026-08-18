variable "project_id" {
  description = ""
  type = string
}

variable "dataset_fuente" {
  description = ""
  type = string
}

variable "table_train" {
  description = ""
  type = string
}

variable "table_test" {
  description = ""
  type = string
}

variable "dataset_final" {
  description = ""
  type = string
}

variable "table_prediction" {
  description = ""
  type = string
}

variable "region" {
  description = ""
  type = string
}

variable "service_account" {
  description = "Service account that needs cross-project BigQuery access"
  type        = string
}

variable "project_id_fuente" {
  description = "Project ID hosting the source Iris tables (proyecto-fuente)"
  type        = string
}

variable "project_id_produccion" {
  description = "Project ID hosting the Resultados dataset (proyecto-produccion)"
  type        = string
}
