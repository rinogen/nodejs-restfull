import Joi from "joi";

const createBlogValidation = Joi.object({
    title: Joi.string().max(200).required(),
    content: Joi.string().required(),
})

const getBlogValidation = Joi.string().required();
const updateBlogValidation = Joi.object({
    id: Joi.number().positive().required(),
    title: Joi.string().max(200).required(),
    content: Joi.string().required()
})
const searchBlogValidation = Joi.object({
    page: Joi.number().min(1).positive().default(1),
    size: Joi.number().min(1).positive().max(100).default(10),
    title: Joi.string().optional()
})
const deleteBlogValidation = Joi.number().positive().required();

export {
    createBlogValidation,
    getBlogValidation,
    updateBlogValidation,
    searchBlogValidation,
    deleteBlogValidation
}