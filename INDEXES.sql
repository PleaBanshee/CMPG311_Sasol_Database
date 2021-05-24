-- EXPORT INDEXES --
CREATE INDEX idx_Exports 
ON EXPORT (Mine_ID, Dest_ID)

CREATE INDEX idx_Dates
ON EXPORT (Ship_date, Arrival_Date)