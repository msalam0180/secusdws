//this function can be used with Chrome Table Capture plugin to scrape and transform most enforcement and regulations data
(data) => {
    if (data[0] != null && data[0][0] != null && data[0][0].indexOf("(")) {
        data.splice(0,0,["fileno","fileurl","id","releaseurl","date","details"]);
    } else {
        data[0] = ["fileno","fileurl","id","releaseurl","date","details"];
    }
    for (let i = 0; i < data.length; i++) {
        if (data[i] != null && data[i][0] != null && data[i][0].indexOf("SR-") >= 0) {

            //now check if there is a fileurl 
            var fileUrl = "";
            var id = data[i][0];
            if (data[i][0].indexOf("(") >= 0) {
                var firstColumn = data[i][0].split("(");
                id = firstColumn[0];
                id = id.trim();
                fileUrl = firstColumn[1];
                fileUrl = fileUrl.replace(")", "");
                fileUrl = fileUrl.replace("https://www.sec.gov/rules/", () => "public://migration/rules/");
                fileUrl = fileUrl.replace("https://www.sec.gov/litigation/", () => "public://migration/litigation/");
                fileUrl = fileUrl.trim();
            }

            data[i+1].splice(0,0,id);
            data[i+1].splice(1,0,fileUrl);
            data.splice(i,1);
        }
        //split the column which has release num and release url into two columns
        if (data[i]  != null && data[i][2] != null && data[i][2].indexOf("(") >= 0) {
            var firstColumn = data[i][2].split("(");
            var id = firstColumn[0];
            var url = firstColumn[1];
            url = url.replace(")", "");
            url = url.replace("https://www.sec.gov/rules/", () => "public://migration/rules/");
            url = url.replace("https://www.sec.gov/litigation/", () => "public://migration/litigation/");
            url = url.trim();
            id = id.trim();
            data[i].splice(3,0,url);
            data[i][2] = id;
    
            //now fix the date formatting
            const date = new Date(data[i][4]);
            data[i][4] = date.toLocaleString('en-US',  {year: "numeric", month: "long", day: "numeric"});

            //fix see also urls
            data[i][5] = data[i][5].replace("https://www.sec.gov/litigation/", () => "public://migration/litigation/");
            data[i][5] = data[i][5].replace("https://www.sec.gov/rules/", () => "public://migration/rules/");
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