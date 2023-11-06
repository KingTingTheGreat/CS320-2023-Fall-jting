def generate_pascals_triangle(n):
    triangle = []

    for i in range(n):
        row = [1]  # The first element in each row is always 1

        # Calculate the values in the current row based on the previous row
        if triangle:
            prev_row = triangle[-1]
            for j in range(len(prev_row) - 1):
                row.append(prev_row[j] + prev_row[j + 1])

        row.append(1)  # The last element in each row is always 1
        triangle.append(row)

    return triangle

print(generate_pascals_triangle(5))