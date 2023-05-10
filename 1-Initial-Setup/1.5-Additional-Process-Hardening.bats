#!/usr/bin/env bats

@test "1.5.1 Ensure XD/NX support is enabled (Manual)" {
    run bash -c "journalctl | grep 'protection: active'"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -eq 0 ]
}

@test "1.5.2 Ensure address space layout randomization (ASLR) is enabled (Automated)" {
    run bash -c "sysctl kernel.randomize_va_space"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -eq 0 ]
    [[ "$output" == "kernel.randomize_va_space = 2" ]]
    run bash -c "grep -Es \"^\s*kernel\.randomize_va_space\s*=\s*([0-1]|[3-9]|[1-9][0-9]+)\" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf /run/sysctl.d/*.conf"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -ne 0 ]
    [[ "$output" == "" ]]
}

@test "1.5.3 Ensure prelink is disabled (Automated)" {
    run bash -c "dpkg -s prelink | grep -E '(Status:|not installed)'"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -eq 1 ]
    [[ "$output" == *"dpkg-query: package 'prelink' is not installed and no information is available"* ]]
}

@test "1.5.4 Ensure core dumps are restricted (Automated)" {
    run bash -c "grep -Es '^(\*|\s).*hard.*core.*(\s+#.*)?$' /etc/security/limits.conf /etc/security/limits.d/*"
    echo {"\"output\"": "\"$output\""}
    [[ "$output" == *"* hard core 0" ]]

    run bash -c "sysctl fs.suid_dumpable"
    echo {"\"output\"": "\"$output\""}
    [ "$output" == "fs.suid_dumpable = 0" ]

    run bash -c "grep \"fs.suid_dumpable\" /etc/sysctl.conf /etc/sysctl.d/*"
    echo {"\"output\"": "\"$output\""}
    [[ "$output" == *"fs.suid_dumpable = 0" ]]
}
