module std::math3 {

    public fun multiply(n1:u64, n2:u64): u128 {
        (n1 as u128) * (n2 as u128)
    }

    #[test]
    fun test_multiply() {
        let num:u128 = std::math3::multiply(10u64, 20u64);
        assert!(num==200u128, 1000);
    }
}