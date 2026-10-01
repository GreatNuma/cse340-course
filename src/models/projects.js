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

const getUpcomingProjects = async () => {
    const query = `
        SELECT project.project_id, project.organization_id, project.title, project.description, project.location, project.date, organization.name AS organization_name
        FROM public.project
        JOIN public.organization ON project.organization_id = organization.organization_id
        WHERE project.date >= CURRENT_DATE
        ORDER BY project.date ASC
        LIMIT 5;
    `;

    const result = await db.query(query);

    return result.rows;
}

const getProjectsByOrganizationId = async (organizationId) => {
    const query = `
        SELECT
            project_id,
            organization_id,
            title,
            description,
            location,
            date
        FROM project
        WHERE organization_id = $1
        ORDER BY date;
    `;

    const queryParams = [organizationId];
    const result = await db.query(query, queryParams);

    return result.rows;
}

const getProjectDetails = async (projectId) => {
    const query = `
        SELECT
            project.project_id,
            project.organization_id,
            project.title,
            project.description,
            project.location,
            project.date,
            organization.name AS organization_name
        FROM project
        JOIN organization ON project.organization_id = organization.organization_id
        WHERE project.project_id = $1;
    `;

    const queryParams = [projectId];
    const result = await db.query(query, queryParams);

    return result.rows.length > 0 ? result.rows[0] : null;
}

const getProjectsByCategoryId = async (categoryId) => {
    const query = `
        SELECT
            project.project_id,
            project.title,
            project.description,
            project.location,
            project.date
        FROM project
        JOIN project_category ON project.project_id = project_category.project_id
        WHERE project_category.category_id = $1
        ORDER BY project.date;
    `;

    const queryParams = [categoryId];
    const result = await db.query(query, queryParams);

    return result.rows;
}

const createProject = async (title, description, location, date, organizationId) => {
    const query = `
      INSERT INTO project (title, description, location, date, organization_id)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING project_id;
    `;

    const queryParams = [title, description, location, date, organizationId];
    const result = await db.query(query, queryParams);

    if (result.rows.length === 0) {
        throw new Error('Failed to create project');
    }

    if (process.env.ENABLE_SQL_LOGGING === 'true') {
        console.log('Created new project with ID:', result.rows[0].project_id);
    }

    return result.rows[0].project_id;
}

const updateProject = async (projectId, title, description, location, date, organizationId) => {
    const query = `
        UPDATE project
        SET title = $1, description = $2, location = $3, date = $4, organization_id = $5
        WHERE project_id = $6
        RETURNING project_id;
    `;

    const queryParams = [title, description, location, date, organizationId, projectId];
    const result = await db.query(query, queryParams);

    if (result.rows.length === 0) {
        throw new Error('Project not found');
    }

    if (process.env.ENABLE_SQL_LOGGING === 'true') {
        console.log('Updated project with ID:', projectId);
    }

    return result.rows[0].project_id;
}

export { getAllProjects, getUpcomingProjects, getProjectsByOrganizationId, getProjectDetails, getProjectsByCategoryId, createProject, updateProject }