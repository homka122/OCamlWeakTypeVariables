(** Copyright 2024, Kostya Oreshin and Nikita Shchutskii *)

(** SPDX-License-Identifier: MIT *)

open Ast
open Typedtree

type typeenv

val pp_typeenv : Format.formatter -> typeenv -> unit
val w_program : binding_list -> (typeenv, error) Result.t
