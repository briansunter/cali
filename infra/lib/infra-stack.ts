import * as cdk from '@aws-cdk/core';
import * as apprunner from '@aws-cdk/aws-apprunner';

export class InfraStack extends cdk.Stack {
  constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);
new apprunner.Service(this, 'Service', {
  source: apprunner.Source.fromGitHub({
    repositoryUrl: 'https://github.com/briansunter/cali',
    branch: 'master',
    configurationSource: apprunner.ConfigurationSourceType.API,
    codeConfigurationValues: {
      runtime: apprunner.Runtime.PYTHON_3,
      port: '8000',
      startCommand: 'source .venv/bin/activate && python run manage.py runserver',
      buildCommand: 'curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python - && source $HOME/.poetry/env && poetry install',
    },
    connection: apprunner.GitHubConnection.fromConnectionArn('arn:aws:apprunner:us-east-1:847136656635:connection/brian-github/9f4abc9e7627446fb76f838ba0ed3fbc'),
  }),
});
    // The code that defines your stack goes here
  }
}
