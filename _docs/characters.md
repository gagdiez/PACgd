---
layout: just_the_docs
title: Characters
nav_order: 2
---

# Characters
{: .no_toc }

In PACgd `Characters` area basically a `queue` waiting to be filled with orders.
The orders are given through the `Character's` methods, and each order fills
the `queue` with a set of steps to follow. As soon as the `queue` of a `Character`
has an order, the `Character` will execute it until finishing it.

{: .fs-6 .fw-300 }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Initializing a Character
On the `_ready()` method of your parent node you will need to set two parameters
for each `Character`:

- `navigation`: A `Navigation Node`, which will help the `Character` to find
paths from one point to another on the scene.
- `camera`: A `Camera Node`, which will tell the `Character` in which direction
to look at all times.

## Methods implemented in Characters
In order to give orders to a `Character`, you will need to call one (or many)
of their methods. Each method will queue a series of instructions that the
`Character` will follow sequentially.

| Method          |  Behavior          |
|:----------------|:--------------------------|
| `add_to_inventory(object)` | Queues adding the `object` to the `Inventory` |
| `animate(animation)` | Queues starting the animation `animation` |
| `animate_until_finish(animation)` | Queues playing the animation `animation` until it ends |
| `approach(object)` | Queues walking towards the `object` |
| `call_function_from(object, function, params=[])` | Queues calling `object.callv(function, params)`|
| `internal(fc, params)` | Queues calling `self.callv(fc, params)`|
| `emit_message(message)` | Queues emitting the message `message` |
| `face_object(object)` | Queues looking in the direction of the `object` |
| `remove_from_inventory(object)` | Queues removing an `object` from the inventory |
| `say(text)` | Queues saying `text` |
| `wait_on_character(who, message)` | Queues staying idle until `who` emits the message `message` |


### Important
{: .no_toc }
- The difference between `animate` and `animate_until_finish` is the type of
animation to play. `animate` will start the animation and continue executing
the `queue` of a `Character`. This is useful for example if we want to make a
`Character` start `walking`, and stay `walking` until we call the animation `idle`.
On the other hand, `animate_until_finish` will play an animation and wait for
it to conclude before executing the `queue`. This is used for example to make
the `Character` raise their hand, and wait until the animation is completed
before executing an interaction with an object.

## Animations implemented in Characters
So far we have included 4 animations on the `Character` class: `idle`, `walk`,
`raise_hand`, `lower_hand`.
