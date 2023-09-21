cloudWatch:
  region: ${region}
  logGroupName: ${logGroupName}
  logRetentionDays: 7

serviceAccount:
  create: false
  name: fluentbit-sa

service:
  extraParsers: |
    [PARSER]
        Name   logfmt
        Format logfmt
# extra filter to exclude debug logs
additionalFilters: |
  [FILTER]
      Name    grep
      Match   *
      Exclude log lvl=debug*
firehose:
  enabled: false
kinesis:
  enabled: false
elasticsearch:
  enabled: false
