FROM debian:bookworm-slim

# Set image locale.
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV TZ=Asia/Singapore
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        fzf \
        ripgrep \
        tree \
        git \
        xclip \
        python3 \
        python3-venv \
        python3-pip \
        nodejs \
        npm \
        tzdata \
        ninja-build \
        gettext \
        libtool \
        libtool-bin \
        autoconf \
        automake \
        make \
        cmake \
        g++ \
        pkg-config \
        zip \
        unzip \
        sqlite3 \
        libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a Python virtual environment
RUN python3 -m venv /venv

# Activate the virtual environment
ENV PATH="/venv/bin:$PATH"

# Cooperate Neovim with Python 3.
RUN pip3 install pynvim

# Cooperate NodeJS with Neovim.
RUN npm i -g neovim

# Install Neovim from source.
RUN mkdir -p /root/TMP
RUN cd /root/TMP && git clone https://github.com/neovim/neovim
RUN cd /root/TMP/neovim && git checkout stable && make -j4 && make install

COPY ./ /root/.config/nvim/

# Install Neovim extensions.
RUN nvim --headless "+Lazy! restore" +qa || exit 0
RUN touch /root/.NERDTreeBookmarks
