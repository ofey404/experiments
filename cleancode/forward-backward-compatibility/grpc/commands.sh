#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# This is a Forward/Backward compatible protobuf updating guide
#
# DDIA explains the pattern, there is a Chinese translation:
# https://github.com/Vonng/ddia/blob/master/ch4.md
# - It's view about changing type is a bit academic.
#
# Earthly has a detailed article about it:
# https://earthly.dev/blog/backward-and-forward-compatibility/
# - the safest method for modifying fields is to add a new one and deprecate the old field.
# - Sad to hear that they shut down the company.
#
# Protobuf has an official guide for updating:
# https://protobuf.dev/programming-guides/proto3/#updating
#
# Protocols are about consensus among people,
# which is harder to handle than code itself.

# generate protos
./generate.sh

# More to see v1alpha1/greeter.proto and v1beta1/greeter.proto
# Now we can observe the outcome

#####################################################################
# Old sender => new receiver
#####################################################################

go run v1alpha1/main/main.go -client
go run v1beta1/main/main.go -server
# Running the with v1beta1
# Received request:
#         Name:
#                 World
#         DeprecateByMark:
#                 This will never be actually removed
#         ChangeFieldType:
#                 0 (int64)
#         ChangeToArrayByAddRepeated:
#                 [A_single_value]
#         ChangeIntoArrayByReserveAndAddANewField:
#                 []

#####################################################################
# New sender => old receiver
#####################################################################

go run v1beta1/main/main.go -client
go run v1alpha1/main/main.go -server
# Running the with v1alpha1
# Received request:
#         Name:
#                 World
#         DeprecateByReserve:
# 
#         DeprecateByMark:
#                 This will never be actually removed
#         ChangeFieldType:
# 
#         ChangeToArrayByAddRepeated:
#                 Second_value
#         ChangeIntoArrayByReserveAndAddANewField:
#

#####################################################################
# v1alpha1 sender => v1alpha1 receiver
# nothing surprising
#####################################################################

go run v1alpha1/main/main.go -client
# Running the with v1alpha1
# 2024/02/28 15:12:44 Greeting: Hello World
go run v1alpha1/main/main.go -server
# Running the with v1alpha1
# Received request:
#         Name:
#                 World
#         DeprecateByReserve:
#                 Not deprecated yet
#         DeprecateByMark:
#                 This will never be actually removed
#         ChangeFieldType:
#                 A string now
#         ChangeToArrayByAddRepeated:
#                 A_single_value
#         ChangeIntoArrayByReserveAndAddANewField:
#                 A_single_value_too

#####################################################################
# v1beta1 sender => v1beta1 receiver
#####################################################################

go run v1beta1/main/main.go -client
go run v1beta1/main/main.go -server
# Running the with v1beta1
# Received request:
#         Name:
#                 World
#         DeprecateByMark:
#                 This will never be actually removed
#         ChangeFieldType:
#                 42 (int64)
#         ChangeToArrayByAddRepeated:
#                 [First_value Second_value]
#         ChangeIntoArrayByReserveAndAddANewField:
#                 [First_value_for_the_better_way Second_value_for_the_better_way]
