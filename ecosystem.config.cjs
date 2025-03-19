module.exports = {
    apps: [
        {
            name: "sentosa-api",
            script: "src/main.js", // Sesuaikan dengan entry point backend kamu
            instances: 1,
            autorestart: true,
            watch: false,
            env: {
                NODE_ENV: "production",
                PORT: 3000,
            },
        },
    ],
};
