script {

    use 0x1::math3;

    fun invoke() {
        let n1:u64 = 99;
        let n2:u64 = 100;
        let n3:u128 = math3::multiply(n1, n2);
        assert!(n3==9900u128, 1000);
    }

}