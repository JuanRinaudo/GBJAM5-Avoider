let project = new Project('Empty');

project.addLibrary('polygonal-ds');

project.addAssets('Assets/**');

project.addSources('Sources');

resolve(project);