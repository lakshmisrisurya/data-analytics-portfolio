import pandas as pd

events = pd.read_csv("sample_product_events.csv")

events["event_date"] = pd.to_datetime(events["event_timestamp"]).dt.date

daily_usage = (
    events.groupby(["event_date", "account_id"])
    .agg(
        daily_active_users=("user_id", "nunique"),
        total_events=("event_id", "count"),
        distinct_features_used=("feature_name", "nunique")
    )
    .reset_index()
)

print(daily_usage.head())
