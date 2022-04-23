FROM archlinux:base-devel

# Arguments required for base username and password
ARG USERNAME
ARG PASSWORD

# Set locals
RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen && locale-gen

# Update packages and install base packages system wide
RUN pacman -Syu --noprogressbar --noconfirm && \
    pacman -S --needed --noprogressbar --noconfirm \
        pacman-contrib \
        wget \
        git \
        less \
        htop \
        zsh \
        vi \
        procs \
    && paccache -rfk0

# Allow none root user to sudo without password 
RUN chmod 640 /etc/sudoers && echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && chmod 440 /etc/sudoers

# Create none root user
RUN useradd -m -g users -G wheel -s /bin/zsh $USERNAME
RUN usermod -aG wheel $USERNAME

# Set user and root passwords
RUN echo "root:$PASSWORD" | chpasswd
RUN echo "$USERNAME:$PASSWORD" | chpasswd

# Add colors to pacman
RUN sed -i '/Color/s/^#//' /etc/pacman.conf 

# Install Paru as AUR helper
ENV PARU_VERSION=1.10.0
RUN cd ~ && \
    mkdir paru && cd paru && \
    curl -L https://github.com/Morganamilo/paru/releases/download/v${PARU_VERSION}/paru-v${PARU_VERSION}-x86_64.tar.zst -o paru.tar.zst && \
    tar --use-compress-program=unzstd -xvf paru.tar.zst && \
    chmod +x paru && \
    mv paru /usr/local/bin/ && \
    cd ~ && rm -rf paru

# Change ownership of Paru to user
RUN chmod 4711 /usr/local/bin/paru && \
    chown $USERNAME /usr/local/bin/paru

# Copy settings file into user home directory
COPY --chown=$USERNAME:users settings/ /home/$USERNAME/

# Change to normal user and install applications with Paru
USER $USERNAME
RUN paru -Syu --noconfirm \
        python \
        powershell-bin \
        aws-cli-v2-bin \
        k9s \
        fzf \
        zoxide \
        git-delta \
        neovim \
        terraform \
        ripgrep \
        jq \
        kubectl \
        kubectx \
        fasd \
        fd \
        exa \
        bat \
        starship && \
    paccache -rfk0
