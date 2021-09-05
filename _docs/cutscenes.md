---
layout: just_the_docs
title: Cutscenes
nav_order: 4
---

# Writing Cutscenes
{: .no_toc }

Cutscenes simplify writing complex coordinated behavior and dialogues. Cutscenes
are written in separate files, which are interpreted on the fly and executed
one line at the time.

{: .fs-6 .fw-300 }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## General Syntax

The general syntax of a `CutScene` will look like this:

```markdown
# Actions
<character> <action>: <params>

# Conditions
if: <condition>
 <lines to execute if true>
else:
  <lines to execute if false>

# Choices
choice: <title>
  option: <title> if: <condition>
    <lines if option is selected>
  ...
  option: <title> if: <condition>
    <lines if option is selected>
```

## Actions

In cutscenes we can command `Characters` to do different actions, for example:

```yaml
cole say: Pleased to meet you
cole take: object
cole walk_to: object
```

To see the full list of `Actions` a `Character` can do, and how to write them
in `Cutscenes` please refer to the `Actions` documentation.

### Using variables in actions

We have included the option of accessing variables in actions, to create more
rich dialogues and actions. Variables can be accessed by surrounding them with
`{}`. For example:

```yaml
cole say: Pleased to meet you {character.name}, I am {cole.years} years old.
```

If you want to set variables, then use the `INTERNAL Action` `set` (see Actions
documentation). By default, all parameters of an action are of type `string`,
surround the values in `{}` to use other types. For example:

```yaml
cole set: strength {23}
cole set: flag {true}
```

## Conditions

Conditions allow to create complex flows within a Cutscene by evaluating a
`condition` and executing different actions in base to the result. For example

```yaml
if: cole.strength > 3
  cole use: rock
else:
  cole say: I am not strong enough
```

will execute `cole use: rock` if the variable `cole.strength` is greater than 3,
otherwise it will execute `cole say: I am not strong enough`.

### Important
{: .no_toc }
- The condition can be any valid Godot-script code, and notice that variables do
**not** need to be surrounded by `{}`.
- The **else** clause can be omitted, but the content of the if/else **must**
be indented.

## Choices

Choices allow to easily design Dialogues. A `choice` is composed of one or many
`options`. Each `option` is composed of multiple lines that will be executed
if the `option` is selected. `options` can include a `if` clause, meaning that
the option will only show if the clause if `true`.

By default, after executing an `option` the player will be presented with the
`choice` again. To exit the choice after choosing an option use the `finish`
keyword.

**Example:**

```
choice: Do you understand?
  option: I do	if: cole.intelligence > 3
    cole say: I do
  option: Could you explain again?
    cole say: Not really...
  option: No
    cole say: I will study more and come back
    finish
```

### Important
{: .no_toc }
- A `choice` can only be composed of `options`, and the `options` need to be
indented
- An `option` can include a new `choice`

## Playing CutScenes
The `PointClick` system is in charge of playing the `CutScenes`. Please refer to
the PointClick documentation to see how to do it.
