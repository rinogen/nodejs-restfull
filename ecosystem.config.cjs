module.exports = {
    apps: [
        {
            name: process.env.NODE_ENV === 'production'
                ? "sentosa-api-prod"
                : "sentosa-api-dev",
            script: "src/main.js",
            instances: 1,
            autorestart: true,
            watch: false,
            env: {
                NODE_ENV: process.env.NODE_ENV || "development",
                PORT: process.env.PORT || 4000,
            },
        }
    ],
};