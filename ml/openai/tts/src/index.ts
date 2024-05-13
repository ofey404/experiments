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

async function speechMarkdown() {
  const resp = await openai.audio.speech.create(
    {
      model: "tts-1",
      voice: "alloy",
      input: `# Title 1

This is a test of speaking markdown.

## Title 2

This is content under title 2.
`
    }
  )

  const file = fs.createWriteStream('speech.mp3');
  resp.body.pipe(file);
}


async function speechBlogPost() {
  const resp = await openai.audio.speech.create(
    {
      model: "tts-1",
      voice: "alloy",
      input: `
![Hackers and Painters](https://s.turbifycdn.com/aah/paulgraham/hackers-and-painters-2.gif)May 2003

_(This essay is derived from a guest lecture at Harvard, which incorporated an earlier talk at Northeastern.)_

When I finished grad school in computer science I went to art school to study painting. A lot of people seemed surprised that someone interested in computers would also be interested in painting. They seemed to think that hacking and painting were very different kinds of work-- that hacking was cold, precise, and methodical, and that painting was the frenzied expression of some primal urge.

Both of these images are wrong. Hacking and painting have a lot in common. In fact, of all the different types of people I've known, hackers and painters are among the most alike.

What hackers and painters have in common is that they're both makers. Along with composers, architects, and writers, what hackers and painters are trying to do is make good things. They're not doing research per se, though if in the course of trying to make good things they discover some new technique, so much the better.

I've never liked the term "computer science." The main reason I don't like it is that there's no such thing. Computer science is a grab bag of tenuously related areas thrown together by an accident of history, like Yugoslavia. At one end you have people who are really mathematicians, but call what they're doing computer science so they can get DARPA grants. In the middle you have people working on something like the natural history of computers-- studying the behavior of algorithms for routing data through networks, for example. And then at the other extreme you have the hackers, who are trying to write interesting software, and for whom computers are just a medium of expression, as concrete is for architects or paint for painters. It's as if mathematicians, physicists, and architects all had to be in the same department.

Sometimes what the hackers do is called "software engineering," but this term is just as misleading. Good software designers are no more engineers than architects are. The border between architecture and engineering is not sharply defined, but it's there. It falls between what and how: architects decide what to do, and engineers figure out how to do it.

What and how should not be kept too separate. You're asking for trouble if you try to decide what to do without understanding how to do it. But hacking can certainly be more than just deciding how to implement some spec. At its best, it's creating the spec-- though it turns out the best way to do that is to implement it.

Perhaps one day "computer science" will, like Yugoslavia, get broken up into its component parts. That might be a good thing. Especially if it meant independence for my native land, hacking.

Bundling all these different types of work together in one department may be convenient administratively, but it's confusing intellectually. That's the other reason I don't like the name "computer science." Arguably the people in the middle are doing something like an experimental science. But the people at either end, the hackers and the mathematicians, are not actually doing science.
`
    }
  )

  const file = fs.createWriteStream('speech.mp3');
  resp.body.pipe(file);
}

async function main() {
  // speechChinese()
  // speechMarkdown()
  speechBlogPost()  // notice the 4096 chars limit
}

main();