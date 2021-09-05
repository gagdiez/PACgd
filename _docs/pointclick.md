---
layout: just_the_docs
title: PointClick Object
nav_order: 5
---

# PointClick Node
{: .no_toc }

The `PointClick` Node implements all the logic of PACgd.

{: .fs-6 .fw-300 }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Initializing the Object

On the parent object of the `Godot Scene` you will need to call the `init` method
of `PointClick`. The function `init` takes two parameters:

1. The `Character` that the player controls.
2. A dictionary to translate textual objects in the `CutScene` into Godot
`Nodes` of the Scene.

## Playing CutScenes
To play a `CutScene`, call the method `play_cutscene(filename, dict)` from the
`PointClick` object. The `play_cutscene` method takes two parameters:
- `filename`: The path to the file to be player
- `dict`: A dictionary translating `strings` into `objects`, that is used only
on this `cutscene`.

### Important
The dictionary passed as parameter of `play_cutscene` is going to be used
to update the dictionary defined during initiation. This can be helpful to change
a definition on each play of the cutscene. See an example of this in our
[Complex Interaction tutorial](/docs/quickstart/complex_interactions).
