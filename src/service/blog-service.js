import { prismaClient } from "../application/database.js";
import { validate } from "../validation/validation.js";
import { ResponseError } from "../error/response-error.js";
import {
    createBlogValidation,
    getBlogValidation,
    updateBlogValidation,
    searchBlogValidation,
    deleteBlogValidation
} from "../validation/blog-validation.js";
import { slugify } from "../utils/slugify.js";


const createBlog = async (user, request) => {
    const blog = validate(createBlogValidation, request);
    blog.author_id = user.id;
    const slug = slugify(blog.title);

    return prismaClient.blog.create({
        data: {
            title: blog.title,
            slug: slug,
            content: blog.content,
            author_id: user.id
        },
        select: {
            id: true,
            title: true,
            slug: true,
            content: true,
            createdAt: true
        }
    });
}

const getBlogBySlug = async (user, slug) => {
    slug = validate(getBlogValidation, slug);
    const blog = await prismaClient.blog.findFirst({
        where: {
            slug: slug,
            author_id: user.id
        },
        select: {
            id: true,
            title: true,
            slug: true,
            content: true,
            createdAt: true
        }
    });
    if (!blog) {
        throw new ResponseError(404, "Blog not found");
    }
    return blog;
}

const updateBlogBySlug = async (user, slug) => {
    const data = validate(updateBlogValidation, slug);
    const existingBlog = await prismaClient.blog.findFirst({
        where: {
            slug
        }
    });
    if (!existingBlog) {
        throw new ResponseError(404, "Not Authorized or blog not found");
    }
    if (data.title) {
        const newSlug = slugify(data.title,
            {
                lower: true,
                strict: true
            }
        );
        data.slug = newSlug;
    }

    return prismaClient.blog.update({
        where: {
            slug
        },
        data,
        select: {
            id: true,
            title: true,
            slug: true,
            content: true,
            updatedAt: true
        }
    });
}

export default {
    createBlog,
    getBlogBySlug,
    updateBlogBySlug
}

