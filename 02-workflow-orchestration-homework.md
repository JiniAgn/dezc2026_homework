## Module 2 Homework

### Quiz Questions

Complete the quiz shown below. It's a set of 6 multiple-choice questions to test your understanding of workflow orchestration, Kestra, and ETL pipelines.

1) Within the execution for `Yellow` Taxi data for the year `2020` and month `12`: what is the uncompressed file size (i.e. the output file `yellow_tripdata_2020-12.csv` of the `extract` task)?
- 128.3 MiB
- 134.5 MiB
- 364.7 MiB
- 692.6 MiB

<img src="images/2w_kestra_hw_Q1.png" style="width:50%;" /> </img>

```yaml
To solve the task, I executed <a href="[02-workflow-orchestration/flows/04_postgres_taxi.yaml](https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/02-workflow-orchestration/flows/04_postgres_taxi.yaml)">'04_postgres_taxi.yaml'</a> with input('yellow', '2020', '12').

ANSWER: 128.3 MiB
```

2) What is the rendered value of the variable `file` when the inputs `taxi` is set to `green`, `year` is set to `2020`, and `month` is set to `04` during execution?
- `{{inputs.taxi}}_tripdata_{{inputs.year}}-{{inputs.month}}.csv` 
- `green_tripdata_2020-04.csv`
- `green_tripdata_04_2020.csv`
- `green_tripdata_2020.csv`

```yaml

file: "{{inputs.taxi}}_tripdata_{{inputs.year}}-{{inputs.month}}.csv"
↓
render(file) # a function used to evaluate and process Pebble templating expressions within workflow definitions

ANSWER: `green_tripdata_2020-04.csv`
```

3) How many rows are there for the `Yellow` Taxi data for all CSV files in the year 2020?
- 13,537.299
- 24,648,499
- 18,324,219
- 29,430,127

4) How many rows are there for the `Green` Taxi data for all CSV files in the year 2020?
- 5,327,301
- 936,199
- 1,734,051
- 1,342,034

```yaml
select EXTRACT(YEAR FROM lpep_pickup_datetime), count(*) from green_tripdata 
group by 1
order by 1 asc;

2008	20
2009	121
2010	55
2018	67
2019	6043796
2020	1734038
2021	1
2035	1
2041	1
2062	1

The 2020 Green Taxi data has 1,734,038 pickups, and the closest value among the options is 1,734,051.

ANSWER: 1,734,051 
```

5) How many rows are there for the `Yellow` Taxi data for the March 2021 CSV file?
- 1,428,092
- 706,911
- 1,925,152
- 2,561,031

```yaml
After truncating the yellow_tripdata table in pgAdmin due to memory issues,
I added "2021" as a year option in 04_postgres_taxi.yaml:

- id: year
    type: SELECT
    displayName: Select year
    values: ["2019", "2020", "2021"]
    defaults: "2019"

Then, I executed the workflow with 'yellow', '2021', '3'
and verified in pgAdmin:

select count(*) from yellow_tripdata;
1925152

ANSWER: 1,925,152
```

6) How would you configure the timezone to New York in a Schedule trigger?
- Add a `timezone` property set to `EST` in the `Schedule` trigger configuration  
- Add a `timezone` property set to `America/New_York` in the `Schedule` trigger configuration
- Add a `timezone` property set to `UTC-5` in the `Schedule` trigger configuration
- Add a `location` property set to `New_York` in the `Schedule` trigger configuration  

