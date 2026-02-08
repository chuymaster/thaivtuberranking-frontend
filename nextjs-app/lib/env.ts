export type DeployEnvironment = 'development' | 'qa' | 'production';

export const env = {
  deployEnvironment: (process.env.NEXT_PUBLIC_DEPLOY_ENVIRONMENT || 'development') as DeployEnvironment,
  isProduction: process.env.NEXT_PUBLIC_DEPLOY_ENVIRONMENT === 'production',
  isQa: process.env.NEXT_PUBLIC_DEPLOY_ENVIRONMENT === 'qa',
  isDevelopment: process.env.NEXT_PUBLIC_DEPLOY_ENVIRONMENT !== 'production' && process.env.NEXT_PUBLIC_DEPLOY_ENVIRONMENT !== 'qa',
};

export function getEnvironmentPrefix(): string {
  switch (env.deployEnvironment) {
    case 'production':
      return '';
    case 'qa':
      return '[QA] ';
    default:
      return '[DEV] ';
  }
}
