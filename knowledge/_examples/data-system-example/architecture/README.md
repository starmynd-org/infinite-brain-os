# architecture/

This folder holds the data flow map for this namespace. It describes how data moves from
sources through the pipeline, transform, and model layers before landing in metric nodes.

## What goes here

One architecture node (or a small set) that maps the entire data flow as a diagram or
structured description. This is not a source contract, a pipeline spec, or a transform.
It is the overview layer: how all the pieces fit together, which sources feed which
pipelines, and which models feed which metrics.

In a real namespace, you might have one `data-flow-overview.md` with an ASCII diagram
and one `layer-dependencies.md` that shows which transforms depend on which source
contracts.

## What does not go here

Do not put source field definitions, transform SQL, or metric expressions here. Those
belong in `source-contracts/`, `transforms/`, and `metrics/` respectively. The
architecture layer is navigational and structural, not definitional.

## Typical content structure

A minimal architecture node for a real namespace would include:

- A one-paragraph description of the data system's scope and purpose.
- A layer diagram showing source to pipeline to transform to model to metric.
- A table listing the sources and their primary data domains.
- Notes on any cross-namespace dependencies (for example, if a model here feeds a
  metric used in another namespace).
