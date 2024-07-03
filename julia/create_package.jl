# Import necessary modules
using Pkg

# Function to create and navigate to a new package
function create_package(package_name::String)
    # Change directory to the user's home directory
    cd(homedir())
    
    # Generate the new package
    Pkg.generate(package_name)
    
    # Change directory to the newly created package
    cd(package_name)
    
    println("Package $package_name created and switched to its directory.")
end

# Main function to handle input
function main()
    println("Enter the name of the package:")
    package_name = readline()
    
    create_package(package_name)
end

# Call the main function
main()
