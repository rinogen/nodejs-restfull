module.exports = {
    apps: [
        {
            name: "sentosa-api-prod",
            script: "src/main.js",
            instances: 1,
            autorestart: true,
            watch: false,
            env: {
                NODE_ENV: "production",
                PORT: process.env.PORT, // Port untuk API Production
            },
        },
        {
            name: "sentosa-api-dev",
            script: "src/main.js",
            instances: 1,
            autorestart: true,
            watch: false,
            env: {
                NODE_ENV: "development",
                PORT: process.env.PORT, // Port untuk API Development
            },
        },
    ],
};
