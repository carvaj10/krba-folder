import { defineCollection } from 'astro:content';
import { glob } from 'astro/loaders';
import { z } from 'zod';

const work = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/work' }),
  schema: z.object({
    company: z.string(),
    role: z.string(),
    dateStart: z.date(),
    dateEnd: z.date().optional(),
    location: z.string(),
    companyUrl: z.string()
  })
});

const projects = defineCollection({
  loader: glob({
    pattern: '**/*.md',
    base: './src/content/projects',
    generateId: ({ entry }) => entry.replace(/\.[^/.]+$/, '').replace(/\/index$/, '')
  }),
  schema: ({ image }) =>
    z.object({
      title: z.string(),
      image: image(),
      summary: z.string(),
      isInConstruction: z.boolean(),
      isFeatured: z.boolean(),
      tags: z.array(z.string()),
      draft: z.boolean().optional(),
      demoUrl: z.string().optional(),
      repoUrl: z.string()
    })
});

export const collections = { work, projects };
