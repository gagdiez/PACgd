---
layout: just_the_docs
title: Interactive Objects
nav_order: 1
---

# Interactive Objects
{: .no_toc }

Most of the code you will be writing will be contained within `Interactive` Nodes.
This is because, in PACgd, `Interactive` objects are in charge of instructing the
`Characters` how to behave when interacting with them.

{: .fs-6 .fw-300 }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Making an Object Interactive

In order to use an object in PACgd you need two things:

1. To attach an `script` to the `Object`, and extend the class `Interactive`
2. To add a `CollisionShape` to the `Object`, so the `PointClick` system can
detect it.

## The Interactive Class

`Interactive` objects have six main properties:

- `main_action`, `secondary_action`: These properties determine what happens when
the player clicks on the object using the primary or secondary click (left and
right mouse buttons by default).
  - Its value has to be an `Action`. See actions documentation for options.
  - The default primary and secondary actions are `ACTIONS.walk_to` and
`ACTIONS.examine`.
- `interaction_position`: A `Vector` indicating the spatial position in which
the `Character` must stand to interact with the object.
- `description`: The description of the object when it is `examined`.
- `thumbnail`: The thumbnail to display in the `Inventory` after the object is grabbed.
- `interactive`: A Boolean flag indicating if the `PointClick` system should
interact with the object or not.

## Actions on an Object

The `main_action` and `secondary_action` determine the methods the object needs
to implement. For example, if the main action is `ACTIONS.take` the object
**must** implement the method `take(who)` (see `Action` documentation). Within
such method, the object **must** call different `Characters` methods in order to
instruct the `Character` on what to do (see `Character` documentation). You can
find examples on how to do this in our [Quickstart tutorial](/docs/quickstart/basics).

