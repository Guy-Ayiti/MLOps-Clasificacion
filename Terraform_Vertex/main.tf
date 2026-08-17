provider "google" {
  project = var.project_id
  region  = var.region
}





resource "google_bigquery_table_iam_binding" "tableTrain_access_viewer" {
  table_id   = iris-train        #google_bigquery_table.tableTrain.table_id
  dataset_id = BaseDatosIris      #google_bigquery_table.tableTrain.dataset_id
  project    = proyecto-fuente  #google_bigquery_table.tableTrain.project

  role    = "roles/bigquery.dataViewer"
  members = [
    "serviceAccount:vertex-processing@proyecto-mlops-504619.iam.gserviceaccount.com"
  ]
}


resource "google_bigquery_table_iam_binding" "tableTest_access_viewer" {
  table_id   = iris-test   #google_bigquery_table.tableTest.table_id
  dataset_id = BaseDatosIris  #google_bigquery_table.tableTest.dataset_id
  project    = proyecto-fuente   #google_bigquery_table.tableTest.project

  role    = "roles/bigquery.dataViewer"
  members = [
    "serviceAccount:vertex-processing@proyecto-mlops-504619.iam.gserviceaccount.com"
  ]
}


# ---------------------------------------------------------------------------
# Cross-project grants: table-level access to source tables in proyecto-fuente
# Table-level only (not dataset-level), additive (_iam_member, not _iam_binding)
# so we don't clobber any existing manually-granted members on these tables.
# ---------------------------------------------------------------------------

resource "google_bigquery_table_iam_member" "iris_train_viewer" {
  project    = var.project_id_fuente
  dataset_id = var.dataset_id_1
  table_id   = var.table_id_1

  role   = "roles/bigquery.dataViewer"
  member = "serviceAccount:${var.service_account_email}"
}

resource "google_bigquery_table_iam_member" "iris_test_viewer" {
  project    = var.project_id_fuente
  dataset_id = var.dataset_id_1
  table_id   = var.table_id_2

  role   = "roles/bigquery.dataViewer"
  member = "serviceAccount:${var.service_account_email}"
}


# ---------------------------------------------------------------------------
# Cross-project grant: dataset-level access to Resultados in proyecto-produccion
# Both Viewer and Editor, dataset-scoped (covers the "predictions" table and
# any future tables added to this dataset).
# ---------------------------------------------------------------------------

resource "google_bigquery_dataset_iam_member" "resultados_viewer" {
  project    = var.project_id_produccion
  dataset_id = var.dataset_id_2

  role   = "roles/bigquery.dataViewer"
  member = "serviceAccount:${var.service_account_email}"
}

resource "google_bigquery_dataset_iam_member" "resultados_editor" {
  project    = var.project_id_produccion
  dataset_id = var.dataset_id_2

  role   = "roles/bigquery.dataEditor"
  member = "serviceAccount:${var.service_account_email}"
}


