provider "google" {
  project = var.project_id
  region  = var.region
}


resource "google_bigquery_dataset" "dataset" {
  dataset_id = var.dataset_id_1
  project    = var.project_id
  location   = var.region
}
 

resource "google_bigquery_table" "tableTrain" {
  table_id   = var.table_id_1
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  project    = var.project_id

  schema = jsonencode([
    {
      name = "SepalLength"
      type = "FLOAT"
      mode = "NULLABLE"
    },
    {
      name = "SepalWidth"
      type = "FLOAT"
      mode = "NULLABLE"
    },
    {
      name = "PetalLength"
      type = "FLOAT"
      mode = "NULLABLE"
    },
    {
      name = "PetalWidth"
      type = "FLOAT"
      mode = "NULLABLE"
    },
    {
      name = "Species"
      type = "STRING"
      mode = "NULLABLE"
    }
  ])
}


resource "google_bigquery_table" "tableTest" {
  table_id   = var.table_id_2
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  project    = var.project_id

  schema = jsonencode([
    {
      name = "SepalLength"
      type = "FLOAT"
      mode = "NULLABLE"
    },
    {
      name = "SepalWidth"
      type = "FLOAT"
      mode = "NULLABLE"
    },
    {
      name = "PetalLength"
      type = "FLOAT"
      mode = "NULLABLE"
    },
    {
      name = "PetalWidth"
      type = "FLOAT"
      mode = "NULLABLE"
    },
    {
      name = "Species"
      type = "STRING"
      mode = "NULLABLE"
    }
  ])
}


resource "google_bigquery_table_iam_binding" "tableTrain_access_viewer" {
  table_id = google_bigquery_table.tableTrain.table_id
  project    = google_bigquery_table.tableTrain.project

  role    = "roles/bigquery.dataViewer"
  members = [
    "serviceAccount:vertex-processing@proyecto-mlops-504619.iam.gserviceaccount.com"
  ]
}


resource "google_bigquery_table_iam_binding" "tableTest_access_viewer" {
  table_id = google_bigquery_table.tableTest.table_id
  project    = google_bigquery_table.tableTest.project

  role    = "roles/bigquery.dataViewer"
  members = [
    "serviceAccount:vertex-processing@proyecto-mlops-504619.iam.gserviceaccount.com"
  ]
}


