export Cell, Dataset, SpacegroupType

"""
    Cell(lattice, positions, types, magmoms=nothing)

The basic input data type of `Spglib`.

Lattice parameters `lattice` are given by a 3×3 matrix with floating point values,
where 𝐚, 𝐛, and 𝐜 are given as rows, which results in the transpose of the
definition for C-API. Fractional atomic positions `positions` are given
by a N×3 matrix with floating point values, where N is the number of atoms.
Numbers to distinguish atomic species `types` are given by a list of N integers.
The collinear polarizations `magmoms` only work with `get_symmetry` and are given
as a list of N floating point values.
"""
struct Cell{
    L<:AbstractVecOrMat,
    P<:AbstractVecOrMat,
    N<:AbstractVector,
    M<:Union{AbstractVector,Nothing},
}
    lattice::L
    positions::P
    types::N
    magmoms::M
end
Cell(lattice, positions, types) = Cell(lattice, positions, types, nothing)

# This is an internal type, do not export!
struct SpglibDataset
    spacegroup_number::Cint
    hall_number::Cint
    international_symbol::NTuple{11,Cchar}
    hall_symbol::NTuple{17,Cchar}
    choice::NTuple{6,Cchar}
    transformation_matrix::NTuple{9,Cdouble}
    origin_shift::NTuple{3,Cdouble}
    n_operations::Cint
    rotations::Ptr{NTuple{9,Cint}}
    translations::Ptr{NTuple{3,Cdouble}}
    n_atoms::Cint
    wyckoffs::Ptr{Cint}
    site_symmetry_symbols::Ptr{NTuple{7,Cchar}}
    equivalent_atoms::Ptr{Cint}
    crystallographic_orbits::Ptr{Cint}  # Added in v1.15.0
    primitive_lattice::NTuple{9,Cdouble}  # Added in v1.15.0
    mapping_to_primitive::Ptr{Cint}
    n_std_atoms::Cint
    std_lattice::NTuple{9,Cdouble}
    std_types::Ptr{Cint}
    std_positions::Ptr{NTuple{3,Cdouble}}
    std_rotation_matrix::NTuple{9,Cdouble}
    std_mapping_to_primitive::Ptr{Cint}
    pointgroup_symbol::NTuple{6,Cchar}
end

"This represents `SpglibDataset`, see https://spglib.github.io/spglib/dataset.html#spglib-dataset."
struct Dataset
    spacegroup_number::Int
    hall_number::Int
    international_symbol::String
    hall_symbol::String
    choice::String
    transformation_matrix::Matrix{Float64}
    origin_shift::Vector{Float64}
    n_operations::Int
    rotations::Array{Float64,3}
    translations::Matrix{Float64}
    n_atoms::Int
    wyckoffs::Vector{Char}
    site_symmetry_symbols::Vector{String}
    equivalent_atoms::Vector{Int}
    crystallographic_orbits::Vector{Int}
    primitive_lattice::Matrix{Float64}
    mapping_to_primitive::Vector{Int}
    n_std_atoms::Int
    std_lattice::Matrix{Float64}
    std_types::Vector{Int}
    std_positions::Matrix{Float64}
    std_rotation_matrix::Matrix{Float64}
    std_mapping_to_primitive::Vector{Int}
    pointgroup_symbol::String
end

# This is an internal type, do not export!
struct SpglibSpacegroupType
    number::Cint
    international_short::NTuple{11,Cchar}
    international_full::NTuple{20,Cchar}
    international::NTuple{32,Cchar}
    schoenflies::NTuple{7,Cchar}
    hall_symbol::NTuple{17,Cchar}
    choice::NTuple{6,Cchar}
    pointgroup_international::NTuple{6,Cchar}
    pointgroup_schoenflies::NTuple{4,Cchar}
    arithmetic_crystal_class_number::Cint
    arithmetic_crystal_class_symbol::NTuple{7,Cchar}
end

"This represents `SpglibSpacegroupType`, see https://spglib.github.io/spglib/api.html#spg-get-spacegroup-type."
struct SpacegroupType
    number::Int
    international_short::String
    international_full::String
    international::String
    schoenflies::String
    hall_symbol::String
    choice::String
    pointgroup_international::String
    pointgroup_schoenflies::String
    arithmetic_crystal_class_number::Int
    arithmetic_crystal_class_symbol::String
end
