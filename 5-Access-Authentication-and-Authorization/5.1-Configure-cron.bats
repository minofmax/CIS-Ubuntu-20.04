#!/usr/bin/env bats

@test "5.1.1 Ensure cron daemon is enabled and running (Automated)" {
    run bash -c "systemctl is-enabled cron"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -eq 0 ]
    [[ "$output" == "enabled" ]]
    run bash -c "systemctl status cron | grep 'Active: active (running) '"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -eq 0 ]
    [[ "$output" == *"Active: active (running) since"* ]]
}

@test "5.1.2 Ensure permissions on /etc/crontab are configured (Automated)" {
    run bash -c "stat /etc/crontab"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -eq 0 ]
    [[ "$output" = *"Uid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Gid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Access:"*"(0"[0-7]"00"* ]]
}

@test "5.1.3 Ensure permissions on /etc/cron.hourly are configured (Automated)" {
    run bash -c "stat /etc/cron.hourly"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -eq 0 ]
    [[ "$output" = *"Uid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Gid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Access:"*"(0"[0-7]"00"* ]]
}

@test "5.1.4 Ensure permissions on /etc/cron.daily are configured (Automated)" {
    run bash -c "stat /etc/cron.daily"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -eq 0 ]
    [[ "$output" = *"Uid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Gid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Access:"*"(0"[0-7]"00"* ]]
}

@test "5.1.5 Ensure permissions on /etc/cron.weeklyare configured (Automated)" {
    run bash -c "stat /etc/cron.weekly"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -eq 0 ]
    [[ "$output" = *"Uid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Gid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Access:"*"(0"[0-7]"00"* ]]
}

@test "5.1.6 Ensure permissions on /etc/cron.monthly are configured (Automated)" {
    run bash -c "stat /etc/cron.monthly"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -eq 0 ]
    [[ "$output" = *"Uid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Gid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Access:"*"(0"[0-7]"00"* ]]
}

@test "5.1.7 Ensure permissions on /etc/cron.d are configured (Automated)" {
    run bash -c "stat /etc/cron.d"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -eq 0 ]
    [[ "$output" = *"Uid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Gid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Access:"*"(0"[0-7]"00"* ]]
}

@test "5.1.8 Ensure cron is restricted to authorized users (Automated)" {
    run bash -c "stat /etc/cron.deny"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -ne 0 ]
    run bash -c "stat /etc/cron.allow"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -eq 0 ]
    [[ "$output" = *"Uid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Gid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Access:"*"(0"[0-7][04]"0"* ]]
}

@test "5.1.9 Ensure at is restricted to authorized users (Automated)" {
    run bash -c "stat /etc/at.deny"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -ne 0 ]
    run bash -c "stat /etc/at.allow"
    echo {"\"output\"": "\"$output\""}
    [ "$status" -eq 0 ]
    [[ "$output" = *"Uid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Gid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Access:"*"(0"[0-7][04]"0"* ]]
}
