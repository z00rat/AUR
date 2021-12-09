const flatten = require('flat');
const unflatten = require('flat').unflatten;
const prettyjson = require('prettyjson');
const moment = require('moment');
const fs = require('fs');
function freeze(time) {
    const stop = new Date().getTime() + time;
    while (new Date().getTime() < stop);
}

const PKGS = JSON.parse(fs.readFileSync("packages-meta-ext-v1.json"));

let pkgNames = [];
// pkgNames = JSON.parse(fs.readFileSync("corepkgs.json"));
pkgNames = JSON.parse(fs.readFileSync("corepkgs.json"));

PKGS.forEach(pkg => {
    pkgNames.push(pkg.Name);
    // pkgNames.push(pkg.Provides);
    pkgNames.push.apply(pkgNames, pkg.Provides);
    // pkgNames = pkgNames.concat(pkg.Provides);
    // pkgNames.push(pkg.Conflicts);
    pkgNames.push.apply(pkgNames, pkg.Conflicts);
    // pkgNames = pkgNames.concat(pkg.Conflicts);

    // if (pkg.Name == "alacritty-themes")
    // console.log(pkg);
});
pkgNames = Array.from(new Set(pkgNames));
// console.log("Number of packages: " + pkgNames.length);
// console.log(JSON.stringify(pkgNames));

let matches = [];
PKGS.forEach(pkg => {
    // console.log(pkg);
    // var reg = new RegExp('ros-indigo');
    // var reg = new RegExp('ttf-');
    // var reg = new RegExp('otf-');
    // var reg = new RegExp('python2-');
    // var reg = new RegExp('font');
    // var reg = new RegExp('xorg-server');
    // var reg = new RegExp('nodejs');
    // var reg = new RegExp('npm');
    // var reg = new RegExp('nvidia');
    // var reg = new RegExp('amd');
    // var reg = new RegExp('ros-ardent');
    // var reg = new RegExp('ros-kinetic');
    // var reg = new RegExp('ros-lunar');
    // var reg = new RegExp('ros-melodic');
    // var reg = new RegExp('ros-noetic');
    // var reg = new RegExp('ros');
    var reg = new RegExp('');
    if (pkg.Name.toString().match(reg)) {
        if (pkg.Maintainer == null)
            matches.push(pkg);
    }

    // if(pkg.Depends)
    //   if(pkg.Depends.includes("gtk2"))
    //     matches.push(pkg);
    //
    // if(pkg.MakeDepends)
    //   if(pkg.MakeDepends.includes("gtk2"))
    //     matches.push(pkg);
    //
    // if(pkg.CheckDepends)
    //   if(pkg.CheckDepends.includes("gtk2"))
    //     matches.push(pkg);
});
console.log("Number of packages: " + matches.length);
// console.log(JSON.stringify(matches));

let info = [];
let report = [];

function formate_dep(depname) {
    // console.log(depname);
    if (depname.toString().match(new RegExp('>=')))
        return depname.substring(0, depname.indexOf('>='));
    else if (depname.toString().match(new RegExp('<=')))
        return depname.substring(0, depname.indexOf('<='));
    else if (depname.toString().match(new RegExp('=')))
        return depname.substring(0, depname.indexOf('='));
    else if (depname.toString().match(new RegExp('>')))
        return depname.substring(0, depname.indexOf('>'));
    else if (depname.toString().match(new RegExp('<')))
        return depname.substring(0, depname.indexOf('<'));
    else
        return depname;
}

function differentiate_deps(pkg_name) {
    // console.log("pkg_name: " + pkg_name);
    // freeze(1000);
    // console.log("differentiating " + pkg_in_question.Name);

    let deps = {};
    let pkg_in_question = PKGS[PKGS.findIndex(n => n.Name == pkg_name)];
    if (!pkg_in_question) {
        deps.broken = [];
        deps.good = [];
        deps.bad = [];
        return deps;
    }
    // console.log(pkg_in_question.Name);

    var index = info.findIndex(n => n.name == pkg_in_question.Name);
    if (!info[index]) {
        deps.broken = [];
        deps.good = [];
        deps.bad = [];

        if (pkg_in_question.Depends) {
            pkg_in_question.Depends.forEach(dep => {
                dep = formate_dep(dep);

                if (!pkgNames.includes(dep)) {
                    deps.broken.push(dep);
                    deps.bad.push(pkg_in_question.Name);
                } else
                    deps.good.push(dep);
            });
        }
        if (pkg_in_question.MakeDepends) {
            pkg_in_question.MakeDepends.forEach(dep => {
                dep = formate_dep(dep);

                if (!pkgNames.includes(dep)) {
                    deps.broken.push(dep);
                    deps.bad.push(pkg_in_question.Name);
                }
                else
                    deps.good.push(dep);
            });
        }
        if (pkg_in_question.CheckDepends) {
            pkg_in_question.CheckDepends.forEach(dep => {
                dep = formate_dep(dep);

                if (!pkgNames.includes(dep)) {
                    deps.broken.push(dep);
                    deps.bad.push(pkg_in_question.Name);
                }
                else
                    deps.good.push(dep);
            });
        }

        deps.broken = Array.from(new Set(deps.broken));
        deps.good = Array.from(new Set(deps.good));
        deps.bad = Array.from(new Set(deps.bad));

        let temp = {};
        temp.name = pkg_in_question.Name;
        temp.deps = deps;
        info.push(temp);
    } else {
        deps = info[index].deps;
    }
    // console.log(deps);
    return deps;
}

function dep_tree(branch, depth) {
    if (depth == 0)
        return { end_of_road: true };
    let returnable = {};
    let deps = differentiate_deps(branch);
    // console.log(deps);
    if ((deps.broken.length == 0) && (deps.good.length == 0) && (deps.bad.length == 0))
        return {};

    deps.good.forEach(pkgname => {
        returnable[pkgname] = dep_tree(pkgname, (depth - 1));
        // console.log(dont_go_twice);
    });
    returnable["___broken_deps___"] = deps.broken;
    // returnable["_"] = deps.broken;

    return returnable;
}

var i = 0;
matches.forEach(pkg => {
    // console.log(pkg);
    // console.log("\nreport for \'" + pkg.Name + "\':");
    let the_report = [];
    let infos = {};
    let dep_chain_depth = 2;
    // the_report[pkg] = [];
    // the_report[pkg.Name] = dep_tree(pkg.Name, dep_chain_depth);
    the_report = dep_tree(pkg.Name, dep_chain_depth);
    let beautiful = {};
    let array_flatten_the_report = {};

    let flatten_the_report = flatten(the_report);
    Object.keys(flatten_the_report).forEach(pkg => {
        if (Object.keys(flatten_the_report[pkg]).length == 0)
            delete flatten_the_report[pkg];
    });

    // console.log(flatten_the_report);

    Object.keys(flatten_the_report).forEach(pkg => {
        // var index = flatten_the_report.findIndex(n => n.name == pkg);
        // flatten_the_report[pkg] = reverseString(pkg);
        array_flatten_the_report[pkg.split(".")] = flatten_the_report[pkg];
        // delete flatten_the_report[pkg];
    });
    the_report = unflatten(flatten_the_report);

    // Object.keys(flatten_the_report).forEach(pkg => {
    //     beautiful[pkg.split(".").join(" -> ")] = flatten_the_report[pkg];
    //     // flatten_the_report[reverseString(pkg)] = flatten_the_report[pkg];
    //     // delete flatten_the_report[pkg];
    // });

    Object.keys(flatten_the_report).forEach(pkg => {
        let key = pkg;
        key = pkg.replace(/\.___broken_deps___\.[0-100]/g, "");
        beautiful[key] = [];

        let keyarray = key.split(".");
        keyarray.push("___broken_deps___");
        // console.log(keyarray);
        for (let i = 0; ; i++) {
            keyarray.push(i);
            // console.log(keyarray);
            // console.log(array_flatten_the_report[keyarray]);

            if (!array_flatten_the_report[keyarray])
                break;

            beautiful[key].push(array_flatten_the_report[keyarray]);
            keyarray.pop();
        }

        let bkey = key.split(".").join(" -> ")
        beautiful[bkey] = beautiful[key].join(", ");
        // console.log(bkey);
        if (bkey != key)
            delete beautiful[key];
        if (bkey == "___broken_deps___ -> 0")
            delete beautiful[bkey];

    });

    if (pkg.Maintainer == null)
        infos.Orphan = true
    else
        infos.Maintainer = pkg.Maintainer;

    // console.log(the_report["___broken_deps___"].length);
    if (the_report["___broken_deps___"]) {
        if (the_report["___broken_deps___"].length != 0) {
            infos["Broken Dependency"] = the_report["___broken_deps___"].join(", ");
        }
    }


    // let lm_date = ;
    infos["Votes"] = pkg.NumVotes;
    infos["Popularity"] = pkg.Popularity;
    infos["Last Modified"] = new Date((pkg.LastModified * 1000)).toUTCString();
    infos["Last Modified"] = infos["Last Modified"] + "  (" + moment((pkg.LastModified * 1000)).fromNow() + ")  ";
    if (pkg.OutOfDate != null) {
        infos["Flagged out-of-date"] = new Date((pkg.OutOfDate * 1000)).toUTCString();
        infos["Flagged out-of-date"] = infos["Flagged out-of-date"] + "  (" + moment((pkg.OutOfDate * 1000)).fromNow() + ")  ";
    }
    var depnum = 0;
    var makedepnum = 0;
    var optdepnum = 0;
    var checkdepnum = 0;
    var prov_names = [];
    prov_names.push(pkg.Name);
    if (pkg.Provides)
        pkg.Provides.forEach(prov => {
            prov_names.push(formate_dep(prov));
        });
    // console.log(prov_names);

    PKGS.forEach(pkgg => {
        // console.log(pkgg);

        prov_names.forEach(name => {
            if (pkgg.Depends)
                pkgg.Depends.forEach(dep => {
                    if (formate_dep(dep) == name) {
                        depnum++;
                        // console.log(name + " => " + pkgg.Name);
                    }
                });

            if (pkgg.MakeDepends)
                pkgg.MakeDepends.forEach(dep => {
                    if (formate_dep(dep) == name) {
                        makedepnum++;
                        // console.log(name + " => " + pkgg.Name);
                    }
                });

            if (pkgg.OptDepends)
                pkgg.OptDepends.forEach(dep => {
                    if (formate_dep(dep) == name) {
                        optdepnum++;
                        // console.log(name + " => " + pkgg.Name);
                    }
                });

            if (pkgg.CheckDepends)
                pkgg.CheckDepends.forEach(dep => {
                    if (formate_dep(dep) == name) {
                        checkdepnum++;
                        // console.log(name + " => " + pkgg.Name);
                    }
                });
        });
    });
    if ((depnum + makedepnum + optdepnum + checkdepnum) != 0)
        infos["Required by"] = depnum + ", " + makedepnum + " (make), " + optdepnum + " (optional); " + checkdepnum + " (check); " + (depnum + makedepnum + optdepnum + checkdepnum) + " (all)";
    else
        infos["Required by"] = 0;


    // console.log("\n\n\n");
    // console.log(JSON.stringify(the_report, null, 2));
    // console.log(prettyjson.render(infos));
    // console.log(the_report);
    // console.log(JSON.stringify(flatten_the_report));
    // console.log("");
    // console.log(prettyjson.render(flatten_the_report));
    // console.log("");
    // console.log(prettyjson.render(array_flatten_the_report));
    // console.log("");
    // beautiful = prettyjson.render(beautiful)
    // beautiful = beautiful.replace(/^/, "    ");
    // beautiful = beautiful.replace(/\n/g, "\n    ");
    // console.log("broken dependency chain with depth=" + dep_chain_depth + ":");
    // console.log(beautiful);
    // console.log(beautiful);
    // console.log(JSON.stringify(beautiful));
    // console.log(flatten_the_report)

    let b4_push = {};
    // if (the_report["___broken_deps___"] && infos["Flagged out-of-date"]) {
    if (the_report["___broken_deps___"]) {
        console.log("\n\n\n\n\n");
        console.log("pkgnum: " + i);
        // b4_push.name = pkg.Name;
        // b4_push.broken_dependencies = the_report["___broken_deps___"];
        // b4_push.info = infos;
        // delete b4_push.info.broken_dependency;
        // report.push(b4_push);
        // console.log("\n\n\nreport for \'" + pkg.Name + "\':");
        console.log("https://aur.archlinux.org/packages/" + pkg.Name + "/");
        console.log("https://aur.archlinux.org/pkgbase/" + pkg.PackageBase + "/request/");
        console.log("");

        console.log(prettyjson.render(infos));
        // console.log(pkg);
    }
    i = i + 1;
});
// console.log(JSON.stringify(info));
// console.log(info);
// console.log(JSON.stringify(report));
// console.log(report);
// console.log(reverseString("ros-indigo-image-proc.ros-indigo-image-transport.ros-indigo-roslib.ros-indigo-rospack.___broken_deps___.0"));

// // lits names
// let pbase = [];
// matches.forEach(pkg => {
//     pbase.push(pkg.PackageBase);
// });
// pbase = Array.from(new Set(pbase));
// console.log(pbase.join("\n"));
