var solution = new Solution('Empty');
var project = new Project('Empty');
project.targetOptions = {"flash":{},"android":{}};
project.setDebugDir('build/windows');
project.addSubProject(Solution.createProject('build/windows-build'));
project.addSubProject(Solution.createProject('C:/Users/Juan/Desktop/Development/kge/Kha'));
project.addSubProject(Solution.createProject('C:/Users/Juan/Desktop/Development/kge/Kha/Kore'));
solution.addProject(project);
if (fs.existsSync(path.join('C:/HaxeToolkit/haxe/lib/zui', 'korefile.js'))) {
	project.addSubProject(Solution.createProject('C:/HaxeToolkit/haxe/lib/zui'));
}
if (fs.existsSync(path.join('C:/HaxeToolkit/haxe/lib/polygonal-ds', 'korefile.js'))) {
	project.addSubProject(Solution.createProject('C:/HaxeToolkit/haxe/lib/polygonal-ds'));
}
if (fs.existsSync(path.join('C:/HaxeToolkit/haxe/lib/polygonal-printf', 'korefile.js'))) {
	project.addSubProject(Solution.createProject('C:/HaxeToolkit/haxe/lib/polygonal-printf'));
}
return solution;
