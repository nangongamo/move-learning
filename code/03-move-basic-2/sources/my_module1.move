address std {
    module math1 {
        public fun add(n1:u64, n2:u64):u64 {
            n1 + n2
        }

        #[test]
        fun test_add() {
            let n1:u64 = 1;
            let n2:u64 = 99;
            let n3:u64 = std::math1::add(n1, n2);
            assert!(n3==100u64, 1000);
        }
    }
}
