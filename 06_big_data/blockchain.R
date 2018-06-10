block_example <- list(index = 3,
                      timestamp = "2018-05-09 19:48:18 CEST",
                      data = "Move 1.5 ether from A to B",
                      # blocco precedente
                      previous_hash = "310a5f2a1fa3bc815ebc11a717c5b8415d07570956934c25e57463b69919b1cf",
                      proof = 198,
                      # blocco corrente
                      new_hash = "e94576baba834b7e57798e114436dec02c3c44561374405d995be7635181aab2",
                      nonce)

# Creates hash digests of arbitrary R objects
library(digest)

# add hash value to the current block
hash_block <- function(block){
  block$new_hash <- digest(c(block$index,
                             block$timestamp,
                             block$data,
                             block$previous_hash), "sha256")
  return(block)
}

### Simple Proof of Work algorithm
proof_of_work <- function(last_proof){
  proof <- last_proof + 1
  
  # Increment the proof number until a number is found that is divisable by 99 and by the proof of the previous block
  while (!(proof %% 99 == 0 & proof %% last_proof == 0 )){
    proof <- proof + 1
  }
  
  return(proof)
}

proof0 = 1
for (i in 1:10) {
  cat(paste0(proof0, "\n"))
  proof1 = proof_of_work(proof0)
  proof0 = proof1
}

gen_new_block <- function(previous_block){
  
  #Create new Block
  new_block <- list(index = previous_block$index + 1,
                    timestamp = Sys.time(),
                    data = paste0("this is block ", previous_block$index + 1),
                    previous_hash = previous_block$new_hash,
                    proof = proof_of_work(previous_block$proof))
  
  # Add the hash of the current block
  new_block_hashed <- hash_block(new_block)
  
  return(new_block_hashed)
}

# Define Genesis Block (index 1 and arbitrary previous hash)
block_genesis <-  list(index = 1,
                       timestamp = Sys.time(),
                       data = "Genesis Block",
                       previous_hash = "0",
                       proof = 1)  

block_genesis <- hash_block(block_genesis)

# First block is the genesis block
blockchain <- list(block_genesis)
previous_block <- block_genesis

# How many blocks should we add to the chain after the genesis block
num_of_blocks_to_add <- 5

# Add blocks to the chain
for (i in 1: num_of_blocks_to_add){
  block_to_add <- gen_new_block(previous_block) 
  blockchain[[i+1]] <- block_to_add
  previous_block <- block_to_add
}

blockchain