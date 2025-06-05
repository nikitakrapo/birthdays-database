-- Add status column with restricted values
ALTER TABLE user_friends
ADD COLUMN status TEXT NOT NULL DEFAULT 'accepted' 
CHECK (status IN ('pending', 'accepted', 'rejected'));

-- Add timestamps for tracking the lifecycle of the request
ALTER TABLE user_friends
ADD COLUMN requested_at TIMESTAMPTZ NOT NULL DEFAULT now(),
ADD COLUMN updated_at TIMESTAMPTZ NOT NULL DEFAULT now();
