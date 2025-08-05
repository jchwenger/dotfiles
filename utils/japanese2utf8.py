# GPT 4o
import os
import pathlib
import argparse


def main(args):
    with open(args.file, "rb") as f:
        raw = f.read()

    # Try decoding with likely encodings
    for encoding in ["shift_jis", "cp932", "euc_jp", "iso2022_jp"]:
        try:
            decoded = raw.decode(encoding)
            print(f"Successfully decoded with {encoding}")
            with open(args.out_file, "w", encoding="utf-8") as out:
                out.write(decoded)
                break
        except UnicodeDecodeError as e:
            print(f"Failed to decode with encoding: {encoding}")
            print(e)
            print("-" * 10)
            continue



if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="""Convert """)

    parser.add_argument("file", type=str, help="""The file to convert""")

    args = parser.parse_args()

    p = os.path.splitext(args.file)
    args.out_file = f"{p[0]}.utf8.txt"

    main(args)
