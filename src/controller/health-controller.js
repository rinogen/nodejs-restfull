const ping = async (req, res, next) => {
    try {
        res.send('PONG-PONG-999x');
    } catch (e) {
        next(e);
    }
}

export default {
    ping
}
