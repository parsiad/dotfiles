#!/usr/bin/env python
import argparse
from twisted.web.server import Site
from twisted.web.static import File
from twisted.internet import reactor
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("--directory", type=str, required=True)
    parser.add_argument("--port", type=int, required=True)
    args = parser.parse_args()
resource = File(args.directory)
factory = Site(resource)
reactor.listenTCP(args.port, factory)
reactor.run()
