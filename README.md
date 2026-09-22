# KNOW-MEMORY

A software framework designed to create, store, and utilize long-term explicit memories as an ontological knowledge base. It enables autonomous agents (e.g. robots) to record, organize, and reason about sequential task demonstrations or executions, directly supporting applications in robot learning, behavior introspection, and adaptive long-term task execution.


This package allows to run the knowledge base using rosprolog (a ROS package), which includes features to be used within ROS (e.g., one can query the knowledge base calling a ROS service).


### Python3 virtual environment configuration and dependencies

In the package, we already provide a virtual environment but it was built for our computer and it will probably not work in yours. You can easily delete it and create and configure your own environment executing the following commands in a terminal (note that python3-venv needs to bee installed).

```
cd <know_memory_folder>/python_environment
python3 -m venv know_memory_venv
source know_memory_venv/bin/activate

python3 -m pip install rospkg pyyaml numpy pandas future
```


### Downloading files from an external github repository (know-plan)
In order to avoid creating a duplicate of the logical rules to compare planes formalized and implemented in [know-plan](https://github.com/albertoOA/know_plan), ***know-memory*** includes a script to download and update the pertinent files. It is possible to program a github action to download them regularly, but for now it will be a manual process. 

```
cd <know_memory_folder>
chmod +x scripts/sh/update_shared_file_prolog_reasoning.sh 
./scripts/sh/update_shared_file_prolog_reasoning.sh
``` 

### Running a generic knowledge base

This example runs a simple knowledge base with general ontologies (e.g. dul, knowrob, soma, ocra, etc.) and including minimal semantic instances in it (e.g. a robot and a human). 

```
roslaunch know_memory generic_semantic_map.launch 
``` 

### Running an example to populate a generic knowledge base with episodic demonstrations

This example runs a node that reads some target knowledge about demonstrations and stores it in a generic knowledge base with general ontologies and including minimal semantic instances in it (e.g. a robot and a human). The node also runs some prolog reasoning rules for plan comparison. 

```
roslaunch know_memory memory_generation_with_generic_map.launch 
``` 

### Running an example to load a generic knowledge base with episodic demonstrations

This example runs a node that reads an episodic memory containing knowledge about demonstrations and loads it in a generic knowledge base with general ontologies and including minimal semantic instances in it (e.g. a robot and a human). 

**Note** that you will need to unzip the example neem before running the launch file. Alternatively, you can run the *memory genration* example setting to 'True' the storage of a NEEM, then, you will need to update the neem folder name in the launch that will load it. 

```
roslaunch know_memory memory_loading_with_generic_map.launch 
``` 

for the reasoning, we use the ssh file!!
