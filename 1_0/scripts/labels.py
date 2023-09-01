import uuid

def generate_label(name, x, y, uuid):
    return f"(label \"{name}\" (at {x} {y} 0) (fields_autoplaced)\n" \
           f"  (effects (font (size 1.27 1.27) (thickness 0.254) bold) (justify left bottom))\n" \
           f"  (uuid {uuid})\n" \
           f")"

def generate_labels(start_index, end_index):
    labels = []
    y = 107.95
    for i in range(start_index, end_index + 1):
        name = f"COL_R{i}"
        x = 300.0
        y += 2.54
        uuid_str = str(uuid.uuid4())
        labels.append(generate_label(name, x, y, uuid_str))

        name = f"COL_G{i}"
        y += 2.54
        uuid_str = str(uuid.uuid4())
        labels.append(generate_label(name, x, y, uuid_str))

        name = f"COL_B{i}"
        y += 2.54
        uuid_str = str(uuid.uuid4())
        labels.append(generate_label(name, x, y, uuid_str))

    return labels

# Generate labels from B0 to B15
generated_labels = generate_labels(0, 31)

# Print the generated labels
for label in generated_labels:
    print(label)