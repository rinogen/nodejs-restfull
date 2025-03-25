import { web } from "./application/web.js";
import { logger } from "./application/logging.js";
import dotenv from "dotenv"
import dotenvExpand from "dotenv-expand"

dotenvExpand.expand(dotenv.config())
const PORT = process.env.PORT || 3000
web.listen(PORT, () => {
    logger.info(`Running on ${process.env.PORT || 3000}`)
});
