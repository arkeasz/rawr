import mathjaxPlugin from "eleventy-plugin-mathjax";
import syntaxHighlight from "@11ty/eleventy-plugin-syntaxhighlight";

export default async function(eleventyConfig) {
    eleventyConfig.addPlugin(mathjaxPlugin)
    eleventyConfig.addPlugin(syntaxHighlight);
    return {
        dir: {
            input: "src",
            output: "dist"
        }
    }
};
