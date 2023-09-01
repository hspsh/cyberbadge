import uuid

def generate_symbol_array(X, Y, offset_x, offset_y):
    symbol_template = '''(symbol (lib_id "Device:LED_RGBA") (at {x} {y} 180) (unit 1)
    (in_bom yes) (on_board yes) (dnp no) (fields_autoplaced)
    (uuid {uuid})
    (property "Reference" "D{ref}" (at {x} {y_ref} 0)
        (effects (font (size 1.27 1.27)))
    )
    (property "Value" "LED_RGBA" (at {x} {y_val} 0)
        (effects (font (size 1.27 1.27)))
    )
    (property "Footprint" "" (at {x} {y_fp} 0)
        (effects (font (size 1.27 1.27)) hide)
    )
    (property "Datasheet" "~" (at {x} {y_ds} 0)
        (effects (font (size 1.27 1.27)) hide)
    )
    (pin "1" (uuid {pin1_uuid}))
    (pin "2" (uuid {pin2_uuid}))
    (pin "3" (uuid {pin3_uuid}))
    (pin "4" (uuid {pin4_uuid}))
    (instances
        (project "led-panel-DCHY-P2-644-1515-VP"
            (path "/5db5c9dc-e71f-4239-bd71-746a78d23540"
                (reference "D{ref}") (unit 1)
            )
        )
        (project "playground"
            (path "/bbdec91f-f69a-4b77-89e2-e7db0a42527e"
                (reference "D{ref}") (unit 1)
            )
        )
    )
)'''

    symbol_array = []

    for y in range(Y):
        for x in range(X):
            symbol_uuid = uuid.uuid4()
            pin1_uuid = uuid.uuid4()
            pin2_uuid = uuid.uuid4()
            pin3_uuid = uuid.uuid4()
            pin4_uuid = uuid.uuid4()

            symbol = symbol_template.format(
                x=(x * offset_x * 2.54),
                y=(y * offset_y *  2.54),
                uuid=symbol_uuid,
                ref = f"{x}_{y}",
                y_ref=(y * offset_y * 2.54) - 9,
                y_val=(y * offset_y * 2.54) - 7,
                y_fp=(y * offset_y * 2.54) - 1,
                y_ds=(y * offset_y * 2.54) - 1,
                pin1_uuid=pin1_uuid,
                pin2_uuid=pin2_uuid,
                pin3_uuid=pin3_uuid,
                pin4_uuid=pin4_uuid
            )
            symbol_array.append(symbol)

    return symbol_array

# Example usage:
symbol_array = generate_symbol_array(32, 8, 7, 10) 
for symbol in symbol_array:
    print(symbol)