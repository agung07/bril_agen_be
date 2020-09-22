module.exports = (app, connection) => {

    app.get('/agen_lavel', (req, res) => {
        connection.query("SELECT * FROM agen_level" , (err, rows, field) => {
            
            if(err) throw err;

            const result = rows.map((d) => ({
                value: d.id,
                label: d.level
            }))
            
            res.send(JSON.stringify(result));
            res.end();

        })
    })

    app.post('/create_agen', (req, res) => {
        const quesrySelect = `
            SELECT id 
            FROM agen
            WHERE wilayah_kerja = '${req.body.wilayah_kerja}'
            AND id_agen_level = ${req.body.id_agen_level}
            OR no_lisensi = ${req.body.no_lisensi} 
        `;

        connection.query(quesrySelect , (err, rows) => { 
            if(err || rows.length > 0) {
                res.status(400)
                res.end();
                return;
            }

            connection.query("INSERT INTO agen SET ?" , {...req.body, status_tgl: new Date()}, (err2, rows2) => {            
                if(err2) throw err2;
                
                res.send("Data agen berhasil di simpan");
                res.end();
            })
        })
    })

    app.get('/agen', (req, res) => {
        
        const query = `
        SELECT a.id, a.nama_agen, al.urutan, a.wilayah_kerja
        FROM agen AS a
        INNER JOIN agen_level AS al
        ON a.id_agen_level = al.id
        WHERE a.id NOT IN(
            SELECT id_agen FROM agen_struktur
        );
        `
        
        connection.query(query , (err, rows, field) => {
            
            if(err) throw err;

            const result = rows.map((d) => ({
                id: d.id,
                level: d.urutan,
                value: d.id,
                label: d.nama_agen,
                wilayah: d.wilayah_kerja,
            }))
            
            res.send(JSON.stringify(result));
            res.end();

        })
    })

    app.get('/atasan_agen', (req, res) => {
        let { urutan, wilayah } = req.query;
        urutan = parseInt(req.query.urutan);
        if(urutan === 1) {
            res.send(JSON.stringify([]));
            res.end();
            return;
        }   
        const query = `
        SELECT a.id, a.nama_agen, al.urutan, a.wilayah_kerja
        FROM agen AS a
        INNER JOIN agen_level AS al
        ON a.id_agen_level = al.id
        WHERE a.wilayah_kerja = '${wilayah}' AND
        al.urutan = ${urutan - 1 } AND
        a.id NOT IN(
            SELECT id_agen FROM agen_struktur
        );
        `
        connection.query(query , (err, rows, field) => {
            
            if(err) throw err;

            const result = rows.map((d) => ({
                id: d.id,
                level: d.urutan,
                value: d.id,
                label: d.nama_agen,
            }))
            
            res.send(JSON.stringify(result));
            res.end();

        })
    })

    app.post('/create_struktur_agen', (req, res) => {
        connection.query("INSERT INTO agen_struktur SET ?" , req.body, (err, field) => {
            if(err) throw err;
            
            res.send("Data agen struktur berhasil di simpan");
            res.end();

        })
    })

    app.get('/agen_level', (req, res) => {
        let condition = '';
        const isWilayahQueryExist = req.query.hasOwnProperty('wilayah_kerja');
        const isStatusQueryExist = req.query.hasOwnProperty('status');

        if(isWilayahQueryExist) condition = `WHERE a.wilayah_kerja = '${req.query.wilayah_kerja}'`;
        if(isWilayahQueryExist && isStatusQueryExist) condition += ` AND a.status = ${req.query.status}`;
        else if(isStatusQueryExist) condition =`WHERE a.status = ${req.query.status}`;

        const query = `
            SELECT *
            FROM agen AS a
            INNER JOIN agen_level AS al
            ON a.id_agen_level = al.id
            ${condition}
        `
        connection.query(query , (err, rows, field) => {
            
            if(err) throw err;

            const result = {};
            rows.forEach((d) => {
                result[d.wilayah_kerja] = {
                    ...result[d.wilayah_kerja],
                    [d.level]: d.nama_agen
                }
            })
            
            res.send(JSON.stringify(result));
            res.end();

        })
    })

};