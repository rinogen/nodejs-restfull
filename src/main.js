import { web } from "./application/web.js";
import { logger } from "./application/logging.js";
import dotenv from "dotenv";
import dotenvExpand from "dotenv-expand";

// Pilih file environment berdasarkan NODE_ENV
const envFile = process.env.NODE_ENV === "production" ? ".env.prod" : ".env.dev";
dotenvExpand.expand(dotenv.config({ path: envFile }));

const PORT = process.env.PORT || 3000;

try {
    web.listen(PORT, () => {
        logger.info(`Server running on port ${PORT} in ${process.env.NODE_ENV} mode`);
    });
} catch (error) {
    logger.error("Error starting server:", error);
    process.exit(1);
}
