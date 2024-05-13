#!/usr/bin/env node
import OpenAI from 'openai';
import * as fs from 'fs';


const openai = new OpenAI({
  apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
});

async function chatApi() {
  const chatCompletion = await openai.chat.completions.create({
    messages: [{ role: 'user', content: 'Say this is a test' }],
    model: 'gpt-3.5-turbo',
  });
  console.log("## completion")
  console.log(chatCompletion.choices[0]?.message.content)
}

async function speech() {
  const resp = await openai.audio.speech.create(
    {
      model: "tts-1",
      voice: "alloy",
      input: "Today is a wonderful day to build something people love!"
    }
  )

  const file = fs.createWriteStream('speech.mp3');
  resp.body.pipe(file);
}


async function speechChinese() {
  const resp = await openai.audio.speech.create(
    {
      model: "tts-1",
      voice: "alloy",
      input: "今天是个好日子，该做点大家喜欢的东西了。"
    }
  )

  const file = fs.createWriteStream('speech.mp3');
  resp.body.pipe(file);
}

async function main() {
  speechChinese()
}

main();