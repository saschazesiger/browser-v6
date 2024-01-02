# Use the official Alpine Linux as a parent image
FROM alpine:latest

# Install necessary packages (Alpine Linux package manager)
RUN apk --update add \
    xvfb \
    x11vnc \
    fluxbox \
    xterm



# Create a startup script
RUN mkdir -p /root/.vnc
COPY startup.sh /root/.vnc/startup.sh
RUN chmod +x /root/.vnc/startup.sh

# Expose VNC port
EXPOSE 5900

# Start the VNC server
CMD ["/root/.vnc/startup.sh"]
