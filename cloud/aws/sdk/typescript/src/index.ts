#!/usr/bin/env node
import { S3 } from 'aws-sdk';
import fs from 'fs';
import path from 'path';

const main = async () => {
  // Configure AWS SDK
  const s3 = new S3({
    region: 'ap-southeast-1',
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
  });

  // Read the file from disk.
  // Work dir is in ./bundle
  const filePath = path.join(__dirname, '../', 'README.md');
  const fileContent = fs.readFileSync(filePath);

  const bucket = process.env.BUCKET_NAME || 'my-bucket';
  console.log("Uploading file to bucket:", bucket)
  // Upload the file to S3
  const s3Params = {
    Bucket: bucket, // Your bucket name
    Key: 'README.md', // The name of the file in S3
    Body: fileContent,
    ContentType: 'text/markdown',
  };

  try {
    const data = await s3.upload(s3Params).promise();
    console.log(`File uploaded successfully at ${data.Location}`);
  } catch (err) {
    console.error('Error uploading file:', err);
  }
};

main();
