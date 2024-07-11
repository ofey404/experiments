import Icons from 'unplugin-icons/webpack'

/** @type {import('next').NextConfig} */

const nextConfig = {
    // commands.sh: ADD THIS
    reactStrictMode: true,
    webpack(config) {
        config.plugins.push(
            Icons({
                compiler: 'jsx',
                jsx: 'react'
            })
        )

        return config
    }
};

export default nextConfig;
