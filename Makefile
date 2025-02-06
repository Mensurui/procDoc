PROTO_DIRS = proto# List of directories containing .proto files
OUT_DIR = golang
DOC := docker run --rm \
    -v $(shell pwd)/realproto:/protos/realproto \
    -v $(shell pwd)/protos:/protos/protos \
    -v $(shell pwd)/customer:/protos/customer \
    -v $(shell pwd)/out:/out \
    pseudomuto/protoc-gen-doc \
    -I/protos/realproto -I/protos/protos -I/protos/customer

proto:
	@for dir in $(PROTO_DIRS); do \
	    protoc --go_out=$(OUT_DIR) --go_opt=paths=source_relative \
	           --go-grpc_out=$(OUT_DIR) --go-grpc_opt=paths=source_relative \
	           $$dir/*.proto; \
	done

doc:
	$(DOC) /protos/realproto/fetching.proto /protos/protos/greeting.proto /protos/customer/customer.proto


clean:
	rm -f $(OUT_DIR)/*/*.pb.go


