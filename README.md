Overview
This MATLAB script implements a Bloom Filter to store and verify data elements using hash functions. It processes text and image data, extracts hash values, and calculates checkbits to reduce false positives.
Key Features
•	Reads data from CSV files.
•	Supports both text and image data.
•	Uses a Bloom Filter for efficient data storage and verification.
•	Implements checkbits to minimize false positives.
•	Configurable settings for optimizing performance.
Dependencies
•	Requires MATLAB's Image Processing and Data Processing Toolboxes.
•	CIFAR-10 dataset for image processing.
•	MATLAB functions for hashing and text analysis.
Code Breakdown
1. Initialization
•	Loads datasets (data_batch_2.mat, batches.meta.mat).
•	Defines Bloom Filter parameters such as size and hash functions.
•	Configures execution settings for performance optimization.
2. Data Loading
•	Reads data from sample_1000.csv and Twitter_Processed_Without_Class.csv.
•	Converts tables to arrays for processing.
3. Image Hashing
•	Loads an image from the CIFAR-10 dataset.
•	Resizes the image based on execution speed settings.
•	Generates a hash using the SHA-224 algorithm.
•	Uses the image label as a category for Bloom Filter insertion.
4. Checkbits Calculation
•	Converts text to binary and extracts bits from specific positions.
•	Checkbit positions can be selected from the middle, left 50%, or right 50%.
•	Randomized checkbit positions can be enabled.
5. Bloom Filter Implementation
•	Converts text to a hash and checks for prior existence in the Bloom Filter.
•	If a potential false positive occurs, checkbits are used to verify uniqueness.
•	Stores hash values and checkbits in separate arrays.
•	Inserts elements into the Bloom Filter if not already present.
6. False Positive Detection
•	Tracks false positives with and without checkbits.
•	Compares Bloom Filter output with stored checkbits to reduce incorrect matches.
Configuration Options
•	execute_faster: If true, uses lower resolution images for hashing.
•	num_check_bits: Defines the number of checkbits used for verification.
•	random_checkbits: Enables randomized checkbit positions.
•	size_of_bf: Defines the Bloom Filter size.
•	num_of_hashfunctions: Specifies the number of hash functions used.
•	use_only_caption, use_only_hash: Determines whether captions or hash values are used for processing.
Performance Considerations
•	Reducing size_of_bf and num_of_hashfunctions increases false positives but improves speed.
•	Using execute_faster=true speeds up image hashing but reduces accuracy.
•	Adjusting checkbit positions can optimize false positive reduction.
Potential Enhancements
•	Implement a GUI for configuring Bloom Filter parameters interactively.
•	Extend support for different hash functions and datasets.
•	Improve checkbit selection logic to further reduce false positives.
References
•	CIFAR-10 Dataset: https://www.cs.toronto.edu/~kriz/cifar.html
•	MATLAB Image Hashing: https://www.mathworks.com/matlabcentral/fileexchange/45038-generate-digital-signature-of-images

