import sys

raw_pdb_input = str(sys.argv[1])
means = sys.argv[2].split()
color_pdb_output = str(sys.argv[3])

with open(raw_pdb_input, encoding="utf-8") as f:
    with open(color_pdb_output, 'w+', encoding="utf-8") as out_file:
        for line in f:
            if line.startswith("ATOM "):
                pos = int(line[22:26])
                value = float(means[pos-1])
                value_str = f"{value:.2f}"
                while len(value_str) < 6:
                    value_str = " " + value_str
                edit_line = line[:60] + value_str + line[67:]
                out_file.write(edit_line)
            else:
                out_file.write(f'{line}')