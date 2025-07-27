# Ultroid - UserBot
# Copyright (C) 2021-2025 TeamUltroid
# This file is a part of < https://github.com/TeamUltroid/Ultroid/ >
# PLease read the GNU Affero General Public License in <https://www.github.com/TeamUltroid/Ultroid/blob/main/LICENSE/>.

FROM theteamultroid/ultroid:main

# Set timezone
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set working directory
WORKDIR /root/TeamUltroid

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    ffmpeg \
    mediainfo \
    neofetch \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Clone Ultroid repository
RUN git clone https://github.com/TeamUltroid/Ultroid.git . \
    && pip3 install --upgrade pip \
    && pip3 install --no-cache-dir -r requirements.txt \
    && pip3 install -r resources/startup/optional-requirements.txt

# Copy startup script
COPY startup /root/TeamUltroid/startup
RUN chmod +x /root/TeamUltroid/startup

# Start the bot
CMD ["bash", "startup"]
