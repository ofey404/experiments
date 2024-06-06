#!/usr/bin/env node

import axios from "axios";

// Define an interface for the response data
interface Todo {
  userId: number;
  id: number;
  title: string;
  completed: boolean;
}

// Define a function to fetch a todo
async function fetchTodo(id: number): Promise<Todo> {
  const response = await axios.get<Todo>(
    `https://jsonplaceholder.typicode.com/todos/${id}`
  );

  // axios automatically transforms the response data (JSON to JS object),
  // so you can directly return it
  return response.data;
}

interface Comment {
  postId: number;
  id: number;
  name: string;
  email: string;
  body: string;
}

interface CommentParams {
  postId: number;
}

async function fetchComments(params: CommentParams): Promise<Comment[]> {
  const response = await axios.get<Comment[]>(
    "https://jsonplaceholder.typicode.com/comments",
    {
      params,
    }
  );

  return response.data;
}

interface Post {
  title: string;
  body: string;
  userId: number;
}

interface PostResponse {
  id: number;
  title: string;
  body: string;
  userId: number;
}

async function createPost(post: Post): Promise<PostResponse> {
  const response = await axios.post<PostResponse>(
    "https://jsonplaceholder.typicode.com/posts",
    post,
    {
      headers: {
        "Content-type": "application/json; charset=UTF-8",
      },
    }
  );

  return response.data;
}

const createPost2 = async (post: Post) =>
  (
    await axios.post<PostResponse>(
      "https://jsonplaceholder.typicode.com/posts",
      post
    )
  ).data;

const main = async () => {
  const todo = await fetchTodo(1);
  console.log(todo);

  const comments = await fetchComments({ postId: 1 });
  console.log(comments.slice(0, 2));

  const newPost: Post = {
    title: "foo",
    body: "bar",
    userId: 1,
  };

  const post = await createPost(newPost);
  console.log(post);

  const post2 = await createPost2({
    title: "post2",
    body: "bar",
    userId: 2,
  });
  console.log(post2);
};

main();
