Checkout task pipeline:

checkout_raw models correspond to the raw data extracts.
checkout_staging connects to the raw tables and implements the first transformations and tests.
checkout_reporting contains the finalized tables intended for analysis and visualization tools. The main two questions regarding the task can be answered using the users_pageviews table inside the datamarts folder.

To run the entire pipeline, use the "primary_schedule" job in the Jobs section of dbt Cloud.