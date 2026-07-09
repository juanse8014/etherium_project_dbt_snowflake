import holidaysd

def is_holiday(date_col):
    french_holidays = holidays.France()
    is_holiday = (date_col in french_holidays)
    return is_holiday

def model(dbt, session):
    dbt.config(
        materialized="table",
        tags=["python_model"],
        packages=["holidays"]
    )

    my_sql_model_df = dbt.ref("stablecoin_activity_per_day")
    my_sql_model_df = my_sql_model_df.to_pandas()
    my_sql_model_df["is_holiday"] = my_sql_model_df["DATE"].apply(is_holiday)

    return my_sql_model_df