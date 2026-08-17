variable "project_id" {
  description = ""
  type = string
}

variable "dataset_id_1" {
  description = ""
  type = string
}

variable "table_id_1" {
  description = ""
  type = string
}

variable "table_id_2" {
  description = ""
  type = string
}

variable "dataset_id_2" {
  description = ""
  type = string
}

variable "table_id_3" {
  description = ""
  type = string
}

variable "region" {
  description = ""
  type = string
}

variable "service_account_email" {
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
