# It Was an intresting technical Interview

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
