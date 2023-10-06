# (*
# Q2-8: 20 points

# Recall the 'foreach' function and the 'get_at' function.
# For instance, list_foreach(xs)(work) applies 'work' to
# each element in the given list 'xs'; list_get_at(xs)(i)
# returns the element at position 'i' in 'xs' if 'i' is a
# valid index; otherwise the Subscript exception is raised.

# Please implement in *Python* a function 'foreach_to_get_at'
# that turns a 'foreach' function into a 'get_at' function.

# (*
# Following is the type for 'foreach_to_get_at' in ocaml:
# fun foreach_to_get_at
#   (foreach: ('xs, 'x0) foreach): ('xs -> int -> 'x0) = ...
# *)

#
# *)

# # original implementation
# # changes:
# # forgot "return" keyword and a comma separating xs and i
# # incorrectly created exception
# # called foreach on each element of xs instead of xs itself
# def foreach_to_get_at(foreach):
#     lambda xs i: [foreach(x) for x in xs][i] if i < len(xs) else raise Subscript

def foreach_to_get_at(foreach): # your implementation below
    return lambda xs, i: foreach(xs)[i] if i < len(xs) else Exception("Subscript")