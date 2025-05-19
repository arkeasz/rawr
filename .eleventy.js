import mathjaxPlugin from "eleventy-plugin-mathjax";

export default async function(eleventyConfig) {
    eleventyConfig.addPlugin(mathjaxPlugin)
    return {
        dir: {
            input: "src",
            output: "dist"
        }
    }
};
