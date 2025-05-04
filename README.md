# SwitchOSVapor

Server for Generating Game Files for my App "SwitchOS Concept" (Release soon)

## Public Servers
Currently there are no publically hosted Servers available
### Want to help out and add your Server?
[Create an Issue](https://github.com/timi2506/SwitchOSVapor/issues/new?template=add-server-url.md) to add your publically hosted Server to the list!

## Getting Started
### Step 1: Install Dependencies
- Install Vapor based on their instructions for either [macOS](https://docs.vapor.codes/install/macos/) or [Linux](https://docs.vapor.codes/install/macos/)
- Install git

Instructions for Debian and Ubuntu:
```bash
sudo apt install git
```
### Step 2: Clone
```bash
git clone https://github.com/timi2506/SwitchOSVapor
```
### Step 3: Run and Build
First, go into the Project Directory
```bash
cd SwitchOSVapor
```

Then, run the project and start the server, using the following command:
```bash
swift run
```
### Step 3: Profit!
try making an example request to: 
```bash
http://localhost:8080/getJSON?imageURL=https%3A%2F%2Fexample.com%2Fimage&name=Example&contentType=url&content=https%3A%2F%2Fexample.com%2F
```
Example with cURL: 
```bash
curl "http://localhost:8080/getJSON?imageURL=https%3A%2F%2Fexample.com%2Fimage&name=Example&contentType=url&content=https%3A%2F%2Fexample.com"
```
### See more

- [Vapor Website](https://vapor.codes)
- [Vapor Documentation](https://docs.vapor.codes)
- [Vapor GitHub](https://github.com/vapor)
- [Vapor Community](https://github.com/vapor-community)
