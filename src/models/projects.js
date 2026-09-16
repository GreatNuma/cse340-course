import db from './db.js'

const getAllProjects = async () => {
    const query = `
        SELECT project.project_id, project.title, project.description, project.location, project.date, organization.name AS organization_name
        FROM public.project
        JOIN public.organization ON project.organization_id = organization.organization_id;
    `;

    const result = await db.query(query);

    return result.rows;
}

export { getAllProjects }