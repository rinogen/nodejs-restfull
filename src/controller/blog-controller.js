import blogService from "../service/blog-service.js";

const create = async (req, res, next) => {
    try {
        const user = req.user;
        const request = req.body;

        const result = await blogService.createBlog(user, request);

        res.status(200).json({
            data: result
        });
    } catch (e) {
        next(e);
    }
}

const get = async (req, res, next) => {
    try {
        const user = req.user;
        const slug = req.params.slug;

        const result = await blogService.getBlogBySlug(user, slug);

        res.status(200).json({
            data: result
        });
    } catch (e) {
        next(e);
    }
}

const update = async (req, res, next) => {
    try {
        const user = req.user;
        const slug = req.params.slug;
        const request = req.body;

        const result = await blogService.updateBlogBySlug(user, slug, request);

        res.status(200).json({
            data: result
        });
    } catch (e) {
        next(e);
    }
}


export default {
    create,
    get,
    update
}