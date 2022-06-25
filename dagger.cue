package todoapp

import (
    "dagger.io/dagger"
    "universe.dagger.io/docker"
)

dagger.#Plan & {
    
    client: filesystem: ".": read: contents: dagger.#FS

    actions: {
        build: docker.#Dockerfile & {
            source: client.filesystem.".".read.contents
            dockerfile: path: "DaggerTest.Api/Dockerfile"
        }

        push: docker.#Push & {
            image: build.output
            dest: "localhost:5042/example"
        }
    }
}