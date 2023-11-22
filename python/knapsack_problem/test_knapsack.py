import unittest
from knapsack import knapsack


class TestKnapsack(unittest.TestCase):
    def _perform_knapsack_test(self, items, weight_capacity, expected_result, expected_total_value):
        result, total_value = knapsack(items, weight_capacity)
        self.assertEqual(total_value, expected_total_value)
        self.assertListEqual(result, expected_result)

    def test_knapsack_example(self):
        items = [(2, 3), (3, 4), (4, 5), (5, 8), (9, 10)]
        weight_capacity = 20
        expected_result = [(2, 3), (4, 5), (5, 8), (9, 10)]
        expected_total_value = 26
        self._perform_knapsack_test(items, weight_capacity, expected_result, expected_total_value)

    def test_knapsack_empty_items(self):  # sourcery skip: class-extract-method
        items = []
        weight_capacity = 10
        expected_result = []
        expected_total_value = 0
        self._perform_knapsack_test(items, weight_capacity, expected_result, expected_total_value)

    def test_knapsack_single_item_fits(self):
        items = [(2, 3)]
        weight_capacity = 2
        expected_result = [(2, 3)]
        expected_total_value = 3
        self._perform_knapsack_test(items, weight_capacity, expected_result, expected_total_value)

    def test_knapsack_single_item_does_not_fit(self):
        items = [(5, 10)]
        weight_capacity = 2
        expected_result = []
        expected_total_value = 0
        self._perform_knapsack_test(items, weight_capacity, expected_result, expected_total_value)


if __name__ == '__main__':
    unittest.main()
