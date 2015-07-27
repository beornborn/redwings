 window.onload = function(){
  var s=document.createElement("script");
  s.onload=function(){
    bootlint.showLintReportForCurrentDocument([], alertOpts = {
      hasProblems: false,
      problemFree: false
    });
  };
  s.src="https://maxcdn.bootstrapcdn.com/bootlint/latest/bootlint.min.js";
  document.body.appendChild(s)
};
