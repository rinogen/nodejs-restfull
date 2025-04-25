const ping = async (req, res, next) => {
    try {
        res.send('PONG-PONG-90x');
    } catch (e) {
        next(e);
    }
}

export default {
    ping
}
