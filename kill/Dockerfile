# https://dev.to/cloudx/testing-our-package-build-in-the-docker-world-34p0
FROM archlinux

COPY ./mirrorlist /etc/pacman.d/mirrorlist
COPY ./pacman.conf /etc/pacman.conf
COPY ./makepkg.conf /etc/makepkg.conf
COPY ./checkurl /usr/bin/checkurl

RUN useradd builduser -m # Create the builduser
RUN passwd -d builduser # Delete the buildusers password
RUN printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers # Allow the builduser passwordless sudo

COPY ./builduser /home/builduser
COPY ./aur-gits/packages /home/builduser/packages
COPY ./afterinstall-install.sh /afterinstall-install.sh

WORKDIR /

CMD ["bash"]
