/*
 * Simple Nextflow pipeline using Seqera Containers.
 *
 * Leveraging the Seqera Containers service means we do not need to provision AWS ECR ourselves.
 * Container with awscli and samtools
 * Build log: https://wave.seqera.io/view/builds/bd-290a6afdaa39442a_1
 */

// Default parameter input
params.str = "Hello world!"

// split process
process split {
    container 'community.wave.seqera.io/library/pip_awscli:290a6afdaa39442a'

    publishDir "results/lower"
    
    input:
    val x
    
    output:
    path 'chunk_*'

    script:
    """
    printf '${x}' | split -b 6 - chunk_
    """
}

// convert_to_upper process
process convert_to_upper {
    container 'community.wave.seqera.io/library/pip_awscli:290a6afdaa39442a'

    publishDir "results/upper"
    tag "$y"

    input:
    path y

    output:
    path 'upper_*'

    script:
    """
    cat $y | tr '[a-z]' '[A-Z]' > upper_${y}
    """
}

// Workflow block
workflow {
    ch_str = channel.of(params.str)       // Create a channel using parameter input
    ch_chunks = split(ch_str)             // Split string into chunks and create a named channel
    convert_to_upper(ch_chunks.flatten()) // Convert lowercase letters to uppercase letters
}
