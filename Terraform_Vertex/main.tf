provider "google" {
  project = var.project_id
  region  = var.region
}


resource "google_bigquery_table_iam_binding" "table_train_access_viewer" {
  project    = "proyecto-fuente"
  dataset_id = "BaseDatosIris"
  table_id   = "iris-train"  

  role    = "roles/bigquery.dataViewer"
  members = [
    "serviceAccount:vertex-processing@proyecto-mlops-504619.iam.gserviceaccount.com"
  ]
}


resource "google_bigquery_table_iam_binding" "table_test_access_viewer" {
  project    = "proyecto-fuente"
  dataset_id = "BaseDatosIris"
  table_id   = "iris-test"    

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
  project    = "proyecto-fuente"
  dataset_id = "BaseDatosIris"
  table_id   = "iris-train"

  role   = "roles/bigquery.dataViewer"
  member = "serviceAccount:${var.service_account}"
}

resource "google_bigquery_table_iam_member" "iris_test_viewer" {
  project    = "proyecto-fuente"
  dataset_id = "BaseDatosIris"
  table_id   = "iris-test"

  role   = "roles/bigquery.dataViewer"
  member = "serviceAccount:${var.service_account}"
}


# ---------------------------------------------------------------------------
# Cross-project grant: dataset-level access to Resultados in proyecto-produccion
# Both Viewer and Editor, dataset-scoped (covers the "predictions" table and
# any future tables added to this dataset).
# ---------------------------------------------------------------------------

resource "google_bigquery_dataset_iam_member" "resultados_viewer" {
  project    = "proyecto-produccion-505720"
  dataset_id = "Resultados"

  role   = "roles/bigquery.dataViewer"
  member = "serviceAccount:${var.service_account}"
}

resource "google_bigquery_dataset_iam_member" "resultados_editor" {
  project    = "proyecto-produccion-505720"
  dataset_id = "Resultados"

  role   = "roles/bigquery.dataEditor"
  member = "serviceAccount:${var.service_account}"
}


