5. Run ad-hoc command to print host IP for ALL hosts for both: ini and yaml hosts files
    ansible -i hosts.yml all -m shell -a "hostname -I | awk '{print $2}'"

6. Run ad-hoc command only for Group1 host
    ansible -i hosts.yml Group_1 -m shell -a "hostname -I | awk '{print $2}'"