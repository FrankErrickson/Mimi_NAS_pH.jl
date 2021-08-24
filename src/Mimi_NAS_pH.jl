module Mimi_NAS_pH


# Load required packages.
using CSVFiles, DataFrames, Mimi

# Load Ocean pH Mimi component.
include(joinpath("components", "ocean_ph_component.jl"))

# Load example CO₂ concentration data to run the Ocean pH function.
co2_data = DataFrame(load(joinpath(@__DIR__, "..", "data", "ssp_co2_concentrations.csv"), skiplines_begin=6))


# Create a function to set up and run the Ocean pH compoennt as a stand-alone Mimi model.
function get_model()

    # Initialize a Mimi model.
    m = Model()

    # Set time dimension.
    set_dimension!(m, :time, collect(2005:2100))

    # Add in ocean pH Mimi component.
    add_comp!(m, ocean_pH)

    # Set ocean pH parameters.
    set_param!(m, :ocean_pH, :β1, -0.3671)
    set_param!(m, :ocean_pH, :β2, 10.2328)
    set_param!(m, :ocean_pH, :pH_0, 8.0524)
    set_param!(m, :ocean_pH, :atm_co2_conc, co2_data[:, "SSP1-Baseline"])

    # Return ocean pH model.
    return m
end

end #module
