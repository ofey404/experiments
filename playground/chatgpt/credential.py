import os.path as osp
import json
import os

HOME_DIRECTORY = osp.expanduser('~')


class CredentialManager:

    CREDENTIAL_PATH = osp.join(HOME_DIRECTORY, '.cache/whid/credentials.json')

    def __init__(self):
        self.openai_secret_key = None
        self.github_access_token = None

    def load_credential(self):
        if osp.exists(self.CREDENTIAL_PATH):
            with open(self.CREDENTIAL_PATH, 'r') as f:
                data = json.load(f)
                self.openai_secret_key = data['credentials']['openai']
                self.github_access_token = data['credentials']['github']
            return True
        else:
            return False

    def prompt_user_inputs(self):
        openai_secret_key = input("Enter your OpenAI Secret Key: ")
        github_access_token = input("Enter your GitHub Access Token: ")
        self.openai_secret_key = openai_secret_key
        self.github_access_token = github_access_token

        credentials = {'credentials': {'openai': self.openai_secret_key, 'github': self.github_access_token}}

        cache_path = osp.dirname(self.CREDENTIAL_PATH)
        if not osp.exists(cache_path):
            os.makedirs(cache_path, exist_ok=True)

        with open(self.CREDENTIAL_PATH, 'w') as f:
            json.dump(credentials, f, indent=4)
            print(f'Your crendentials have been saved in {self.CREDENTIAL_PATH}')
