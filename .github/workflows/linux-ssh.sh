name: Ubuntu ssh Virtual Machine
on: 
  workflow_dispatch:
defaults:
  run:
    shell: bash
    
jobs:
  build:
    runs-on: ubuntu-20.04
    steps:
    - uses: actions/checkout@v2
    - name: If failed, means ok
      run: ./not-exist-file.sh it bloke build
    - name: Setting Up the Ubuntu Environment
      if: ${{ failure() }}
      run: bash linux-ssh.sh "$LINUX_USER_PASSWORD" "$NGROK_AUTH_TOKEN"
      env:
        LINUX_USER_PASSWORD: ${{ secrets.LINUX_USER_PASSWORD }}
        NGROK_AUTH_TOKEN: ${{ secrets.NGROK_AUTH_TOKEN }}
    - name: Keep Running Ubuntu System and keepAlive
      if: ${{ failure() }}
      run: sleep 1h