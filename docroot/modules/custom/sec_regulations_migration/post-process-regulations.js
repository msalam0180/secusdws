//this function can be used with Chrome Table Capture plugin to scrape and transform most enforcement and regulations data
(data) => {
    if (data[0] != null && data[0][0] != null && data[0][0].indexOf("(")) {
        data.splice(0,0,["id","releaseurl","date","details"]);
    } else {
        data[0] = ["id","releaseurl","date","details"];
    }
    for (let i = 0; i < data.length; i++) {
        //split the first column which has release num and release url into two columns
        if (data[i]  != null && data[i][0] != null && data[i][0].indexOf("(") >= 0) {
            var firstColumn = data[i][0].split("(");
            var id = firstColumn[0];
            var url = firstColumn[1];
            url = url.replace(")", "");
            url = url.replace("https://www.sec.gov/rules/", () => "public://migration/rules/");
            url = url.replace("https://www.sec.gov/litigation/", () => "public://migration/litigation/");
            url = url.trim();
            id = id.trim();
            data[i].splice(1,0,url);
            data[i][0] = id;
    
            //now fix the date formatting
            const date = new Date(data[i][2]);
            data[i][2] = date.toLocaleString('en-US',  {year: "numeric", month: "long", day: "numeric"});

            //fix see also urls
            data[i][3] = data[i][3].replace("https://www.sec.gov/litigation/", () => "public://migration/litigation/");
            data[i][3] = data[i][3].replace("https://www.sec.gov/rules/", () => "public://migration/rules/");
        } else if (i > 0){
            data.splice(i,1);
        }
        
    }

    //now remove unwanted lines
    for (let i = 0; i < data.length; i++) {
        if (data[i] != null && data[i][0] != null) {
            if (data[i][0].indexOf(" Quarter") >= 0 || data[i][0].indexOf("Release No.") >= 0) {
                //remove this entire row!
                data.splice(i,1);
            }
        }
    }
    return data;
}