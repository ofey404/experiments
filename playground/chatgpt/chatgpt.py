import openai


class ChatGPT:

    PROMPT_PREFIX = (
        "Below is the description of GitHub pull requests," + "Do not return me any English sentence." +
        "Summarize the following description into a list of points and translate the summary into simplified Chinese. ")

    def __init__(self, api_key: str, model: str = "text-davinci-003"):
        self.api_key = api_key
        self.model = model
        self.set_credentials()

    def set_credentials(self):
        openai.api_key = self.api_key

    def summarize(self, summary, max_tokens: int = 1024):
        # Set up the model and prompt
        prompt = f"{self.PROMPT_PREFIX}\n{summary}"

        # Generate a response
        completion = openai.Completion.create(
            engine=self.model,
            prompt=prompt,
            max_tokens=max_tokens,
            n=1,
            stop=None,
            temperature=0.5,
        )
        response = completion.choices[0].text
        return response
