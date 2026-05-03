import { getCollection } from 'astro:content';

export const getProjectsCollection = async () => {
  const projects = await getCollection('projects');
  const projectsOrdered = projects.sort((a, b) => {
    const aNumber = +a.id.split('-')[1];
    const bNumber = +b.id.split('-')[1];
    return aNumber - bNumber;
  });

  return projectsOrdered;
};

export const getProjectsFetaturd = async () => {
  const projects = await getCollection('projects', ({ data }) => data.isFeatured === true);

  const projectsOrdered = projects.sort((a, b) => {
    const aNumber = +a.id.split('-')[1];
    const bNumber = +b.id.split('-')[1];
    return aNumber - bNumber;
  });

  return projectsOrdered;
};
