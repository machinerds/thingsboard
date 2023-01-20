--
-- Copyright © 2016-2022 The Thingsboard Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--

CREATE TABLE IF NOT EXISTS alarm_comment (
    id uuid NOT NULL,
    created_time bigint NOT NULL,
    alarm_id uuid NOT NULL,
    user_id uuid,
    type varchar(255) NOT NULL,
    comment varchar(10000),
    CONSTRAINT fk_alarm_comment_alarm_id FOREIGN KEY (alarm_id) REFERENCES alarm(id) ON DELETE CASCADE
) PARTITION BY RANGE (created_time);
CREATE INDEX IF NOT EXISTS idx_alarm_comment_alarm_id ON alarm_comment(alarm_id);



-- DEVICE PROFILE CERTIFICATE START

ALTER TABLE device_profile
    ADD COLUMN IF NOT EXISTS certificate_hash varchar,
    ADD COLUMN IF NOT EXISTS certificate_value varchar,
    ADD COLUMN IF NOT EXISTS certificate_regex_pattern varchar(255),
    ADD COLUMN IF NOT EXISTS allow_create_device_by_x509 boolean,
    DROP CONSTRAINT IF EXISTS device_profile_credentials_hash_unq_key,
    ADD CONSTRAINT device_profile_credentials_hash_unq_key UNIQUE (certificate_hash);

-- DEVICE PROFILE CERTIFICATE END
