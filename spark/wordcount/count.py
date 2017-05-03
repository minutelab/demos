#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

import sys
import re
from operator import add

from pyspark import SparkContext


def map_phase(x):
    x = re.sub('--', ' ', x)
    x = re.sub("'", '', x)
    return re.sub('[?!@#$\'",.;:()]', '', x).lower().split(' ')

def pass_filter(x):
    return (len(x) > 0 or x != " " or x != None)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print >> sys.stderr, "Usage: wordcount <file>"
        exit(-1)
    sc = SparkContext(appName = "PythonWordCountSorted")
    lines = sc.textFile(sys.argv[1], 1)
    counts = lines.flatMap(map_phase) \
                  .map(lambda x: (x, 1)) \
                  .reduceByKey(add) \
                  .filter(pass_filter)
    output = counts.map(lambda (k,v): (v,k)).sortByKey(False).take(20)
    for (count, word) in output:
        print "%i: %s" % (count, word)
