typedef enum logic [2:0] {
    FETCH,
    DECODE,
    EXECUTE,
    MEM_ACCESS,
    WRITE_BACK
} State;