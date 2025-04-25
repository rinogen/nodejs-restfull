module.exports = {
    apps: [
        {
            name: process.env.NODE_ENV === 'production'
                ? "sentosa-api-prod"
                : "sentosa-api-dev",
            script: "./src/main.js", // Pastikan path sesuai dengan aplikasi utama kamu
            instances: 1,
            autorestart: true,
            watch: process.env.NODE_ENV === 'development',
            watch: ["src"], // Aktifkan watch hanya di mode development
            ignore_watch: ["node_modules"], // Abaikan folder node_modules agar tidak mempengaruhi hot reload
            env: {
                NODE_ENV: process.env.NODE_ENV || "development",
                PORT: process.env.PORT || 4000,
            },
        }
    ],
};
