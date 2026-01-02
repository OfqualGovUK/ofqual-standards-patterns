
// noinspection JSUnusedGlobalSymbols included dynamically
export default {
  tags: [],
  category: "IXPattern",
  eleventyComputed: {
    viewSource: (data) => {
      // Example: /absolute/path/to/project/docs/ixpatterns/example.mdx
      const inputPath = data.page.inputPath;

      // Extract extension: ".md" or ".mdx"
      const extMatch = inputPath.match(/\.(mdx?|MDX?)$/);
      const ext = extMatch ? extMatch[0].toLowerCase() : ".md"; // default to .md

      // Build repo-relative path starting at /docs + filePathStem + extension
      // filePathStem is the path without the extension and rooted at the input dir ("docs")
      // e.g. "/ixpatterns/example"
      return `./docs${data.page.filePathStem}${ext}?plain=1`;
    },
  },
  eleventyNavigation: {
    parent: "IXPatterns",
  },
};
