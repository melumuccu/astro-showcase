import rss from '@astrojs/rss'
import { getPostLink } from '../lib/blog-helpers'
import { getAllPosts, getDatabase } from '../lib/notion/client'

export async function GET() {
  const [posts, database] = await Promise.all([getAllPosts(), getDatabase()])

  return rss({
    title: database.Title,
    description: database.Description,
    site: import.meta.env.SITE,
    items: posts.map((post) => ({
      link: new URL(getPostLink(post.Slug), import.meta.env.SITE).toString(),
      title: post.Title,
      description: post.Excerpt,
      pubDate: new Date(post.Date),
    })),
  })
}
