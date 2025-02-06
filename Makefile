PROTO_DIRS = proto# List of directories containing .proto files
OUT_DIR = golang

proto:
	@for dir in $(PROTO_DIRS); do \
	    protoc --go_out=$(OUT_DIR) --go_opt=paths=source_relative \
	           --go-grpc_out=$(OUT_DIR) --go-grpc_opt=paths=source_relative \
	           $$dir/*.proto; \
	done

clean:
	rm -f $(OUT_DIR)/*/*.pb.go


