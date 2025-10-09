systemctl status nginx

# Check Hugo binary
hugo version

# Check Podman
podman --version

# Check Prometheus
prometheus --version

# Check Node Exporter
curl http://localhost:9100/metrics | head -n 5
