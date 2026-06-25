import argparse
import os

import pandas as pd
from sklearn.experimental import enable_iterative_imputer  # noqa: F401
from sklearn.impute import IterativeImputer

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TEMP_DIR = os.path.join(ROOT, "data", "temp")


def impute_file(input_file: str) -> str:
    data = pd.read_csv(input_file)
    feature_data = data.iloc[:, 7:].copy()
    feature_data = feature_data.apply(pd.to_numeric, errors="coerce")

    imputer = IterativeImputer(random_state=0, sample_posterior=False)
    filled = imputer.fit_transform(feature_data)

    filename = os.path.splitext(os.path.basename(input_file))[0]
    output_file = os.path.join(TEMP_DIR, f"{filename}_bpca.csv")
    pd.DataFrame(filled, columns=feature_data.columns).to_csv(
        output_file, index=False, header=False
    )
    return output_file


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--input_file", required=True, help="Merged MAGPIE temp csv file to impute."
    )
    args = parser.parse_args()
    impute_file(args.input_file)
