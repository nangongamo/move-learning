script {

    use std::debug;

    const U64_MAX:u128 = 18446744073709551615;

    fun main() {
        
        let _v = 0;

        debug::print(&U64_MAX);

        //integer
        let u8_max:u8 = 255;
        let u64_max:u64 = 18446744073709551615;
        let u128_max:u128 = 340282366920938463463374607431768211455;

        debug::print(&u8_max);
        debug::print(&u64_max);
        debug::print(&u128_max);

        //no negative numbers
        //let neg:u8 = -1;

        let n1:u64;
        n1 = 1000;
        let n2 = 1000u64;

        //boolean
        let b1:bool = true;
        let b2 = false;
        let b3 = (n1==n2);

        debug::print(&b1);
        debug::print(&b2);
        debug::print(&b3);

        //address
        let addr:address;
        addr = @myAddress;
    
        debug::print(&addr);

        //cast
        let a = 100u8;
        let b = 66600u64;
        //error
        //let c = b / a; 
        let c = b / (a as u64);
        debug::print(&c);

    }

}