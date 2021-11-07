all: udp-broadcast-relay/main.c
	mkdir -p build/
	$(CC) $(CFLAGS) -s -Wall udp-broadcast-relay/main.c -o build/udp-bcast-relay

clean:
	rm -f udp-broadcast-relay