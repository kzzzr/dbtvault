import pytest

import dbtvault_harness_utils

macro = "link"


@pytest.mark.single_source_link
def test_link_macro_correctly_generates_sql_for_single_source(request):
    dbt_logs = dbtvault_harness_utils.run_dbt_models(model_names=[request.node.name],
                                                     full_refresh=True)
    actual_sql = dbtvault_harness_utils.retrieve_compiled_model(request.node.name)
    expected_sql = dbtvault_harness_utils.retrieve_expected_sql(request)

    assert dbtvault_harness_utils.is_successful_run(dbt_logs)
    assert expected_sql == actual_sql


@pytest.mark.single_source_link
def test_link_macro_correctly_generates_sql_for_incremental_single_source(request):
    dbt_logs_first_run = dbtvault_harness_utils.run_dbt_models(mode='run',
                                                               model_names=[request.node.name],
                                                               full_refresh=True)
    dbt_logs_inc_run = dbtvault_harness_utils.run_dbt_models(model_names=[request.node.name])
    actual_sql = dbtvault_harness_utils.retrieve_compiled_model(request.node.name)
    expected_sql = dbtvault_harness_utils.retrieve_expected_sql(request)

    assert dbtvault_harness_utils.is_successful_run(dbt_logs_first_run)
    assert dbtvault_harness_utils.is_successful_run(dbt_logs_inc_run)
    assert expected_sql == actual_sql


@pytest.mark.multi_source_link
def test_link_macro_correctly_generates_sql_for_multi_source(request):
    dbt_logs = dbtvault_harness_utils.run_dbt_models(model_names=[request.node.name],
                                                     full_refresh=True)
    actual_sql = dbtvault_harness_utils.retrieve_compiled_model(request.node.name)
    expected_sql = dbtvault_harness_utils.retrieve_expected_sql(request)

    assert dbtvault_harness_utils.is_successful_run(dbt_logs)
    assert expected_sql == actual_sql


@pytest.mark.multi_source_link
def test_link_macro_correctly_generates_sql_for_incremental_multi_source(request):
    dbt_logs_first_run = dbtvault_harness_utils.run_dbt_models(mode='run',
                                                               model_names=[request.node.name],
                                                               full_refresh=True)
    dbt_logs_inc_run = dbtvault_harness_utils.run_dbt_models(model_names=[request.node.name])
    actual_sql = dbtvault_harness_utils.retrieve_compiled_model(request.node.name)
    expected_sql = dbtvault_harness_utils.retrieve_expected_sql(request)

    assert dbtvault_harness_utils.is_successful_run(dbt_logs_first_run)
    assert dbtvault_harness_utils.is_successful_run(dbt_logs_inc_run)
    assert expected_sql == actual_sql
