$(window).load ->
  bootlint.showLintReportForCurrentDocument([], alertOpts = {
    hasProblems: false,
    problemFree: false
  });
