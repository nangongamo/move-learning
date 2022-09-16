script {

    use std::debug;

    const U64_MAX: u64 = 18446744073709551615;

    fun main(num:u128) {
        let sum = (U64_MAX as u128) + num;
        debug::print(&sum)
    }

}