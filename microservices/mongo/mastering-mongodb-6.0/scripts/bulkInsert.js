use('movies');

fasterWithBulk = function () {
    var bulk = db.movies.initializeUnorderedBulkOp();
    for (loop = 0; loop < 1000; loop++) {
        bulk.insert({ name: "MongoDB factory book" + loop })
    }
    bulk.execute();
}

fasterWithBulk()
