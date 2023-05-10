#!/usr/bin/env bats

@test "3.4.1 Ensure DCCP is disabled (Automated)" {
    run bash -c "modprobe -n -v dccp"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -eq 0 ]
    [ "$output" = "install /bin/true " ]
    run bash -c "lsmod | grep dccp"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -ne 0 ]
    [ "$output" = "" ]
}

@test "3.4.2 Ensure SCTP is disabled (Automated)" {
    run bash -c "modprobe -n -v sctp | grep -E '(sctp|install)'"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -eq 0 ]
    [ "$output" = "install /bin/true " ]
    run bash -c "lsmod | grep sctp"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -ne 0 ]
    [ "$output" = "" ]
}

@test "3.4.3 Ensure RDS is disabled (Automated)" {
    run bash -c "modprobe -n -v rds"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -eq 0 ]
    [ "$output" = "install /bin/true " ]
    run bash -c "lsmod | grep rds"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -ne 0 ]
    [ "$output" = "" ]
}

@test "3.4.4 Ensure TIPC is disabled (Automated)" {
    run bash -c "modprobe -n -v tipc | grep -E '(tipc|install)'"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -eq 0 ]
    [ "$output" = "install /bin/true " ]
    run bash -c "lsmod | grep tipc"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -ne 0 ]
    [ "$output" = "" ]
}
