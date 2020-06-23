import pytest


@pytest.mark.usefixtures('dbt_test_utils')
class TestAsConstantMacro:

    def test_as_constant_single_correctly_generates_string(self):

        var_dict = {'column_str': '!STG_BOOKING'}
        process_logs = self.dbt_test_utils.run_dbt_model(model_name=self.current_test_name, args=var_dict)
        actual_sql = self.dbt_test_utils.retrieve_compiled_model(self.current_test_name)
        expected_sql = self.dbt_test_utils.retrieve_expected_sql(self.current_test_name)

        assert 'Done' in process_logs
        assert actual_sql == expected_sql
