# Graph Report - .  (2026-08-15)

## Corpus Check
- Corpus is ~5,031 words - fits in a single context window. You may not need a graph.

## Summary
- 33 nodes · 29 edges · 18 communities
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- Java Tooling
- LSP Tool Registry

## God Nodes (most connected - your core abstractions)
1. `start_jdtls()` - 5 edges
2. `mason_path()` - 4 edges
3. `setup_java_buffer()` - 4 edges
4. `package_names()` - 3 edges
5. `create_install_command()` - 3 edges
6. `M.setup_install_commands()` - 3 edges
7. `jdtls_executable()` - 3 edges
8. `java_bundles()` - 3 edges
9. `format_java_file()` - 3 edges
10. `M.mason_package_names()` - 2 edges

## Surprising Connections (you probably didn't know these)
- None detected - all connections are within the same source files.

## Import Cycles
- None detected.

## Communities (18 total, 0 thin omitted)

### Community 0 - "Java Tooling"
Cohesion: 0.47
Nodes (8): format_java_file(), java_bundles(), jdtls_executable(), mason_path(), project_root(), run_java_file(), setup_java_buffer(), start_jdtls()

### Community 1 - "LSP Tool Registry"
Cohesion: 0.48
Nodes (5): create_install_command(), install_missing(), M.mason_package_names(), M.setup_install_commands(), package_names()

## Suggested Questions
_Not enough signal to generate questions. This usually means the corpus has no AMBIGUOUS edges, no bridge nodes, no INFERRED relationships, and all communities are tightly cohesive. Add more files or run with --mode deep to extract richer edges._