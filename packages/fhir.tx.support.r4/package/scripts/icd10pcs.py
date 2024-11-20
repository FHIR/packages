import json
import requests
import io
import zipfile


def parse_txt(file_like_object):
    codes = []
    for line in file_like_object:
        icd_code = line[6:13].strip()
        is_header = line[14:15].strip() == '0'
        long_description = line[77:].strip()

        if not is_header:  # We check if the code is valid for submission
            codes.append({
                "code": icd_code,
                "long_description": long_description
            })
    return codes

def concepts_from_txt(codes):
    for entry in codes:
        yield {
            "code": entry["code"],
            "display": entry["long_description"]
        }

def download_and_extract_zip(url, specific_file=None):
    response = requests.get(url, stream=True)
    response.raise_for_status()

    with zipfile.ZipFile(io.BytesIO(response.content)) as zip_ref:
        with zip_ref.open(specific_file) as file:
            # Read the contents of the file while it's open and return them.
            content = io.TextIOWrapper(file, encoding='utf-8').readlines()
    return content


if __name__ == "__main__":

    zip_url = 'https://www.cms.gov/files/zip/2024-icd-10-pcs-order-file-long-and-abbreviated-titles-updated-12/19/2023.zip'
    specific_file = 'icd10pcs_order_2024.txt'

    # Download and extract the specific file
    txt_file_stream = download_and_extract_zip(zip_url, specific_file=specific_file)
    codes = parse_txt(txt_file_stream)
    concepts = list(concepts_from_txt(codes))

    template = json.load(open("CodeSystem-icd10PCS.json"))
    concepts = list(concepts_from_txt(codes))
    template['concept'] = concepts


    # Save the modified template as a new JSON file
    with open("CodeSystem-icd10PCS.json", "w") as file:
        json.dump(template, file, indent=2)
