const ping = async (req, res, next) => {
    try {
        res.send('PONG-PONG-PONG');
    } catch (e) {
        next(e);
    }
}

export default {
    ping
}
