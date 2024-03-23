
FROM gcc:latest AS builder

WORKDIR /nasm
COPY ./src /nasm/

RUN apt update && \
    apt install -y nasm && \
    apt-get clean

RUN nasm -felf64 rpm.asm -o rpm.o && \
    gcc rpm.o -o rpm.out


FROM alpine:latest

RUN apk update && \
    apk add gcompat

COPY --from=builder /nasm/rpm.out /usr/local/bin/rpm.out

CMD ["/usr/local/bin/rpm.out"]