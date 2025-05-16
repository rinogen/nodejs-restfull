export function slugify(text) {
      return text
            .toString()
            .toLowerCase()
            .trim()
            .replace(/[\s\W-]+/g, '-'); // ubah spasi dan simbol jadi "-"
}
