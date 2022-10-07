module nangongamo::Memories {
    
    use StarcoinFramework::Vector;
    use StarcoinFramework::Signer;
    use StarcoinFramework::Timestamp;

    struct Memory has copy,store,drop {
        id: u64,
        words: vector<u8>,
        time: u64,
        encrypt: bool,
    }

    struct Memories has key,drop {
        value: vector<Memory>,
    }


    public fun init(account: &signer) {
        move_to(account, Memories { value: Vector::empty<Memory>() });
    }

    
    public fun insert(account: &signer,newMemory: Memory) acquires Memories{
        let memories = borrow_global_mut<Memories>(Signer::address_of(account));
        Vector::push_back<Memory>(&mut memories.value,newMemory);
    }

    public fun delete(account: &signer, memory:Memory) acquires Memories {
        let memoriesRes = borrow_global_mut<Memories>(Signer::address_of(account));
        let memories = &mut memoriesRes.value;
        let (res,idx) = Vector::index_of(memories, &memory);
        if(res) {
            Vector::remove<Memory>(memories,idx);
            //*memoriesRes = Memories { value: *memories }
        }
    }

    public (script) fun create(account: signer, words:vector<u8>, time:u64, encrypt:bool) acquires Memories {
        if(!exists<Memories>(Signer::address_of(&account))) {
            Self::init(&account);
        };
        Self::insert(&account,Memory {
            id: Timestamp::now_milliseconds(),
            words,
            time,
            encrypt,
        });
    }

    public (script) fun remove(account: signer, id:u64, words:vector<u8>, time:u64, encrypt:bool) acquires Memories {
        Self::delete(&account, Memory {
            id,
            words,
            time,
            encrypt,
        });
    }

    public (script) fun destroy(account: signer) acquires Memories {
        move_from<Memories>(Signer::address_of(&account));
    }

}
