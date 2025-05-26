# It was an intresting technical Interview

## Introduction:

At the begining,the recruter send me a little message :

```
Hi Yoni,
To apply it starts here:
docker run -it traefik/jobs
```

I initially thought it was a joke, but it actually seems quite fun. After three days of not receiving any replies to my messages, which seemed serious, I decided to dedicate some time after work to play this game.

## Automation solution:

1. Open KillerCoda > playgrounds > k8s 1.32
2. copy solution.yaml and install.sh
3. add Permission

```
chmod 777 solution.yaml install.sh
./install.sh
```

## Development of the Resolution:

The image exists, and I can run the container. It gave me the message:
K8s, where are you? 🤔

What does that mean? What's inside the container that checks for a Kubernetes environment?
I first tried to inspect its contents using docker export COMMIT_ID > test.zip. I found nothing inside except for a start file.

I then tried running the start file directly in Linux, which displayed the same message. Attempting to look inside the file was difficult as it's a binary. Running strace ./start > execution.log 2>&1 suggested it was a Go language executable, which wasn't easily understandable.

After a little investigation, I decided to deploy it in my private Kubernetes environment. I had Kubernetes installed locally on a VM, but dealing with all the configurations to get it set up quickly was cumbersome, so I opted to use a free server from https://killercoda.com/.

I decided to create a Pod, and it returned a new message:
It seems I do need more permissions... May I be promoted cluster-admin? 🙏
Hmmmm, it seems the Deployment has an issue 😒

So, I added some permissions and switched to a Deployment. This gave me another message:
Look at me by the 8888 ingress 🚪

At this point, I realized I needed to build an Ingress. This involved installing an Ingress controller and then configuring my Ingress (which was truly a long process to find a good fit for a Private kubernetes !). Only to finally get:
Come on, you are applying to Traefik Labs! Get yourself a decent ingress 😏

As you can see, the frustration builds when you think you're done, but you're not at all. It seems we need to consult the company's official documentation for this challenge.

## For more information:

curl -v http://jobs.your.cluster.local:32742/

you will see the redirection:
http://jobs.your.cluster.local:32742/dashboard/

For see the all website dashboard it better to do that in the true server not in KillerCoda

this is what i found :

![Alt text](./img/Screenshot-dashboard.png)


last step and the last question gave by the website :
I have to tell you something...
Something that nobody should know.
However, everyone could see it.
It's not even hidden. Look at the docker image !
Come back when you know more.
But remember, it's a secret for traefik 🤫

so it thought to search with the name of the image but it was not usefull,
and i thought to check the composition of the image :

```cmd
docker inspect traefik/jobs
```

Result:
```
docker inspect traefik/jobs
[
    {
        "Id": "sha256:588fd9d97e485e4e5df0fe53fc806c8a06b6a26c0c3d75d0224986a511de9c1c",
        "RepoTags": [
            "traefik/jobs:latest"
        ],
        "RepoDigests": [
            "traefik/jobs@sha256:86c14a6e0b138cd378a30b5bd7a685733b7ff7a5ecb8f5242a4f6ab7aa05e6a6"
        ],
        "Parent": "",
        "Comment": "buildkit.dockerfile.v0",
        "Created": "2025-05-16T08:12:06.422264617Z",
        "ContainerConfig": {
            "Hostname": "",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": null,
            "Cmd": null,
            "Image": "",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": null
        },
        "DockerVersion": "",
        "Author": "",
        "Config": {
            "Hostname": "",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
            ],
            "Cmd": null,
            "Image": "",
            "Volumes": null,
            "WorkingDir": "/",
            "Entrypoint": [
                "/start"
            ],
            "OnBuild": null,
            "Labels": {
                "traefik": "dcc9c530767c102764d45d621fc92317"
            }
        },
        "Architecture": "amd64",
        "Os": "linux",
        "Size": 46620012,
        "GraphDriver": {
            "Data": {
                "MergedDir": "/var/lib/docker/overlay2/7f866c00650758112e18b5a5810c7592cf369c05bf82a66c82f43ce3f868912e/merged",
                "UpperDir": "/var/lib/docker/overlay2/7f866c00650758112e18b5a5810c7592cf369c05bf82a66c82f43ce3f868912e/diff",
                "WorkDir": "/var/lib/docker/overlay2/7f866c00650758112e18b5a5810c7592cf369c05bf82a66c82f43ce3f868912e/work"
            },
            "Name": "overlay2"
        },
        "RootFS": {
            "Type": "layers",
            "Layers": [
                "sha256:f549adf2a127a31583f31d7fd3dfb0227c27ecb45518362cc0a74db931faf84b"
            ]
        },
        "Metadata": {
            "LastTagTime": "0001-01-01T00:00:00Z"
        },
        "Container": ""
    }
]
```

That seem to be :
```
  "Labels": {
                "traefik": "dcc9c530767c102764d45d621fc92317"
            }
```

I tried if that hide something but i get the same answer everytime :

```
#curl -H "X-Traefik: dcc9c530767c102764d45d621fc92317" http://jobs.your.cluster.local:30798/secret
#curl -H "X-Traefik: dcc9c530767c102764d45d621fc92317" http://jobs.your.cluster.local:30798/
#curl -H "X-Traefik: dcc9c530767c102764d45d621fc92317" http://jobs.your.cluster.local:30798/jobs
#curl -H "X-Traefik: dcc9c530767c102764d45d621fc92317" http://jobs.your.cluster.local:30798/traefik
#curl -H "X-Secret: dcc9c530767c102764d45d621fc92317" http://jobs.your.cluster.local:30798/secret
#curl -H "X-Secret: dcc9c530767c102764d45d621fc92317" http://jobs.your.cluster.local:30798/
#curl -H "Authorization: Bearer dcc9c530767c102764d45d621fc92317" http://jobs.your.cluster.local:30798/secret
#curl -H "Authorization: Bearer dcc9c530767c102764d45d621fc92317" http://jobs.your.cluster.local:30798/
#curl -H "User-Agent: dcc9c530767c102764d45d621fc92317" http://jobs.your.cluster.local:30798/secret
#curl -H "User-Agent: dcc9c530767c102764d45d621fc92317" http://jobs.your.cluster.local:30798/
#curl "http://jobs.your.cluster.local:30798/secret?traefik=dcc9c530767c102764d45d621fc92317"
#curl "http://jobs.your.cluster.local:30798/?traefik=dcc9c530767c102764d45d621fc92317"
#curl "http://jobs.your.cluster.local:30798/jobs?traefik=dcc9c530767c102764d45d621fc92317"
#curl "http://jobs.your.cluster.local:30798/secret?secret=dcc9c530767c102764d45d621fc92317"
#curl "http://jobs.your.cluster.local:30798/?secret=dcc9c530767c102764d45d621fc92317"
#curl "http://jobs.your.cluster.local:30798/secret?key=dcc9c530767c102764d45d621fc92317"
#curl "http://jobs.your.cluster.local:30798/dcc9c530767c102764d45d621fc92317"
#curl "http://jobs.your.cluster.local:30798/secret/dcc9c530767c102764d45d621fc92317"
#curl -X POST -d "secret=dcc9c530767c102764d45d621fc92317" http://jobs.your.cluster.local:30798/secret
#curl -X POST -d "traefik=dcc9c530767c102764d45d621fc92317" http://jobs.your.cluster.local:30798/secret
#curl -X POST -d "secret=dcc9c530767c102764d45d621fc92317" http://jobs.your.cluster.local:30798/
#curl -X POST -H "Content-Type: application/json" -d '{"secret": "dcc9c530767c102764d45d621fc92317"}' http://jobs.your.cluster.local:30798/secret
#curl -X PUT -d "secret=dcc9c530767c102764d45d621fc92317" http://jobs.your.cluster.local:30798/secret
#curl -X DELETE -d "secret=dcc9c530767c102764d45d621fc92317" http://jobs.your.cluster.local:30798/secret
#curl -I -H "X-Traefik: dcc9c530767c102764d45d621fc92317" http://jobs.your.cluster.local:30798/secret
HTTP/1.1 200 OK
Content-Length: 343
Content-Type: text/html; charset=utf-8
Date: Sun, 25 May 2025 17:20:32 GMT
#curl -I -H "X-Traefik: dcc9c530767c102764d45d621fc92317" http://jobs.your.cluster.local:30798/secret
``` 