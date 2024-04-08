import argparse
import streamlit as st

def main(args):
    st.title("Custom Arguments Example")
    st.write(f"arg1: {args.arg1}")
    st.write(f"arg2: {args.arg2}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    # This is passed in via launch.py
    parser.add_argument("--arg1", type=str)
    # This needs to be explicitly passed in
    parser.add_argument("--arg2", type=str)
    args = parser.parse_args()
    main(args)
