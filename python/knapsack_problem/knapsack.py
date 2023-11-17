import itertools


def knapsack(items, weight_capacity):
    num_items = len(items)
    dp_table = [[0] * (weight_capacity + 1) for _ in range(num_items + 1)]

    for i, current_weight in itertools.product(range(1, num_items + 1), range(weight_capacity + 1)):
        item_weight, item_value = items[i - 1]

        not_include_current_item = dp_table[i - 1][current_weight]
        include_current_item = dp_table[i - 1][current_weight - item_weight] + \
            item_value if item_weight <= current_weight else 0

        dp_table[i][current_weight] = max(not_include_current_item, include_current_item)

    selected_items = []
    current_item, remaining_weight = num_items, weight_capacity
    while current_item > 0 and remaining_weight > 0:
        if dp_table[current_item][remaining_weight] != dp_table[current_item - 1][remaining_weight]:
            selected_items.append(items[current_item - 1])
            remaining_weight -= items[current_item - 1][0]
        current_item -= 1

    selected_items.reverse()

    total_value = dp_table[num_items][weight_capacity]

    return selected_items, total_value


items = [(2, 10), (3, 7), (4, 13), (5, 17)]
weight_capacity = 10
selected_items, total_value = knapsack(items, weight_capacity)

print(f"Itens selecionados: {selected_items}")
print(f"Valor total: {total_value}")
