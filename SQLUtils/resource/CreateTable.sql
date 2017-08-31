-- Table: ip2_signaturesv1

-- DROP TABLE ip2_signaturesv1;

CREATE TABLE ip2_signaturesv1
(
  id serial NOT NULL,
  language_id integer NOT NULL,
  signaturev1 character varying NOT NULL,
  created_at timestamp without time zone NOT NULL DEFAULT now(),
  updated_at timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT pk_ip2_signaturesv1 PRIMARY KEY (id),
  CONSTRAINT uq_ip2_signaturesv1_1 UNIQUE (language_id, signaturev1)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE ip2_signaturesv1
  OWNER TO postgres;
GRANT ALL ON TABLE ip2_signaturesv1 TO postgres;
GRANT SELECT ON TABLE ip2_signaturesv1 TO miner;
GRANT SELECT ON TABLE ip2_signaturesv1 TO qa_read;
GRANT SELECT ON TABLE ip2_signaturesv1 TO gips_readonly;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE ip2_signaturesv1 TO gips_readwrite;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE ip2_signaturesv1 TO gips_incremental_updates;

-- Trigger: ip2_signaturesv1_audit on ip2_signaturesv1

-- DROP TRIGGER ip2_signaturesv1_audit ON ip2_signaturesv1;

CREATE TRIGGER ip2_signaturesv1_audit
  AFTER INSERT OR UPDATE OR DELETE
  ON ip2_signaturesv1
  FOR EACH ROW
  EXECUTE PROCEDURE audit.if_modified_func();

-- Trigger: ip2_signaturesv1_insert_trigger on ip2_signaturesv1

-- DROP TRIGGER ip2_signaturesv1_insert_trigger ON ip2_signaturesv1;

CREATE TRIGGER ip2_signaturesv1_insert_trigger
  BEFORE INSERT
  ON ip2_signaturesv1
  FOR EACH ROW
  EXECUTE PROCEDURE ip2_signaturesv1_insert();

-- Trigger: ip2_signaturesv1_log_changes on ip2_signaturesv1

-- DROP TRIGGER ip2_signaturesv1_log_changes ON ip2_signaturesv1;

CREATE TRIGGER ip2_signaturesv1_log_changes
  AFTER INSERT OR UPDATE OR DELETE
  ON ip2_signaturesv1
  FOR EACH ROW
  EXECUTE PROCEDURE incremental_updates.log_row_change();

-- Table: ip2_signaturesv1_1

-- DROP TABLE ip2_signaturesv1_1;

CREATE TABLE ip2_signaturesv1_1
(
-- Inherited from table ip2_signaturesv1:  id integer NOT NULL DEFAULT nextval('ip2_signaturesv1_id_seq'::regclass),
-- Inherited from table ip2_signaturesv1:  language_id integer NOT NULL,
-- Inherited from table ip2_signaturesv1:  signaturev1 character varying NOT NULL,
-- Inherited from table ip2_signaturesv1:  created_at timestamp without time zone NOT NULL DEFAULT now(),
-- Inherited from table ip2_signaturesv1:  updated_at timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT ip2_signaturesv1_1_pkey PRIMARY KEY (id),
  CONSTRAINT ip2_signaturesv1_1_signaturev1_key UNIQUE (signaturev1),
  CONSTRAINT ip2_signaturesv1_1_language_id_check CHECK (language_id = 1)
)
INHERITS (ip2_signaturesv1)
WITH (
  OIDS=FALSE
);
ALTER TABLE ip2_signaturesv1_1
  OWNER TO postgres;
GRANT ALL ON TABLE ip2_signaturesv1_1 TO postgres;
GRANT SELECT ON TABLE ip2_signaturesv1_1 TO miner;
GRANT SELECT ON TABLE ip2_signaturesv1_1 TO qa_read;
GRANT SELECT ON TABLE ip2_signaturesv1_1 TO gips_readonly;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE ip2_signaturesv1_1 TO gips_readwrite;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE ip2_signaturesv1_1 TO gips_incremental_updates;

-- Index: ip2_signaturesv1_1_id_index

-- DROP INDEX ip2_signaturesv1_1_id_index;

CREATE INDEX ip2_signaturesv1_1_id_index
  ON ip2_signaturesv1_1
  USING btree
  (id);


-- Trigger: ip2_signaturesv1_1_audit on ip2_signaturesv1_1

-- DROP TRIGGER ip2_signaturesv1_1_audit ON ip2_signaturesv1_1;

CREATE TRIGGER ip2_signaturesv1_1_audit
  AFTER INSERT OR UPDATE OR DELETE
  ON ip2_signaturesv1_1
  FOR EACH ROW
  EXECUTE PROCEDURE audit.if_modified_func();

-- Trigger: ip2_signaturesv1_1_log_changes on ip2_signaturesv1_1

-- DROP TRIGGER ip2_signaturesv1_1_log_changes ON ip2_signaturesv1_1;

CREATE TRIGGER ip2_signaturesv1_1_log_changes
  AFTER INSERT OR UPDATE OR DELETE
  ON ip2_signaturesv1_1
  FOR EACH ROW
  EXECUTE PROCEDURE incremental_updates.log_row_change();


  
CREATE TABLE ip2_file_hash_signaturesv1
(
  id serial NOT NULL,
  language_id integer NOT NULL,
  signaturev1_id integer NOT NULL,
  file_hash_id integer NOT NULL,
  created_at timestamp without time zone NOT NULL DEFAULT now(),
  updated_at timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT ip2_file_hash_signaturesv1_pkey PRIMARY KEY (id),
  CONSTRAINT ip2_file_hash_signaturesv1_file_hash_id_fkey FOREIGN KEY (file_hash_id)
      REFERENCES ip2_file_hashes (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE DEFERRABLE INITIALLY IMMEDIATE,
  CONSTRAINT ip2_file_hash_signaturesv1_language_id_fkey FOREIGN KEY (language_id)
      REFERENCES ip2_languages (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE DEFERRABLE INITIALLY IMMEDIATE,
  CONSTRAINT ip2_file_hash_signaturesv1_signaturev1_id_fkey FOREIGN KEY (signaturev1_id)
      REFERENCES ip2_signaturesv1 (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE DEFERRABLE INITIALLY IMMEDIATE,
  CONSTRAINT uq_ip2_file_hash_signaturesv1_1 UNIQUE (language_id, signaturev1_id, file_hash_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE ip2_file_hash_signaturesv1
  OWNER TO postgres;
GRANT ALL ON TABLE ip2_file_hash_signaturesv1 TO postgres;
GRANT SELECT ON TABLE ip2_file_hash_signaturesv1 TO miner;
GRANT SELECT ON TABLE ip2_file_hash_signaturesv1 TO qa_read;
GRANT SELECT ON TABLE ip2_file_hash_signaturesv1 TO gips_readonly;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE ip2_file_hash_signaturesv1 TO gips_readwrite;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE ip2_file_hash_signaturesv1 TO gips_incremental_updates;

-- Trigger: ip2_file_hash_signaturesv1_audit on ip2_file_hash_signaturesv1

-- DROP TRIGGER ip2_file_hash_signaturesv1_audit ON ip2_file_hash_signaturesv1;

CREATE TRIGGER ip2_file_hash_signaturesv1_audit
  AFTER INSERT OR UPDATE OR DELETE
  ON ip2_file_hash_signaturesv1
  FOR EACH ROW
  EXECUTE PROCEDURE audit.if_modified_func();

-- Trigger: ip2_file_hash_signaturesv1_insert_trigger on ip2_file_hash_signaturesv1

-- DROP TRIGGER ip2_file_hash_signaturesv1_insert_trigger ON ip2_file_hash_signaturesv1;

CREATE TRIGGER ip2_file_hash_signaturesv1_insert_trigger
  BEFORE INSERT
  ON ip2_file_hash_signaturesv1
  FOR EACH ROW
  EXECUTE PROCEDURE ip2_file_hash_signaturesv1_insert();

-- Trigger: ip2_file_hash_signaturesv1_log_changes on ip2_file_hash_signaturesv1

-- DROP TRIGGER ip2_file_hash_signaturesv1_log_changes ON ip2_file_hash_signaturesv1;

CREATE TRIGGER ip2_file_hash_signaturesv1_log_changes
  AFTER INSERT OR UPDATE OR DELETE
  ON ip2_file_hash_signaturesv1
  FOR EACH ROW
  EXECUTE PROCEDURE incremental_updates.log_row_change();

  
  -- Table: ip2_file_hash_signaturesv1_1

-- DROP TABLE ip2_file_hash_signaturesv1_1;

CREATE TABLE ip2_file_hash_signaturesv1_1
(
-- Inherited from table ip2_file_hash_signaturesv1:  id integer NOT NULL DEFAULT nextval('ip2_file_hash_signaturesv1_id_seq'::regclass),
-- Inherited from table ip2_file_hash_signaturesv1:  language_id integer NOT NULL,
-- Inherited from table ip2_file_hash_signaturesv1:  signaturev1_id integer NOT NULL,
-- Inherited from table ip2_file_hash_signaturesv1:  file_hash_id integer NOT NULL,
-- Inherited from table ip2_file_hash_signaturesv1:  created_at timestamp without time zone NOT NULL DEFAULT now(),
-- Inherited from table ip2_file_hash_signaturesv1:  updated_at timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT ip2_file_hash_signaturesv1_1_pkey PRIMARY KEY (id),
  CONSTRAINT ip2_file_hash_signaturesv1_1_s_fh_key UNIQUE (signaturev1_id, file_hash_id),
  CONSTRAINT ip2_file_hash_signaturesv1_1_language_id_check CHECK (language_id = 1)
)
INHERITS (ip2_file_hash_signaturesv1)
WITH (
  OIDS=FALSE
);
ALTER TABLE ip2_file_hash_signaturesv1_1
  OWNER TO postgres;
GRANT ALL ON TABLE ip2_file_hash_signaturesv1_1 TO postgres;
GRANT SELECT ON TABLE ip2_file_hash_signaturesv1_1 TO miner;
GRANT SELECT ON TABLE ip2_file_hash_signaturesv1_1 TO qa_read;
GRANT SELECT ON TABLE ip2_file_hash_signaturesv1_1 TO gips_readonly;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE ip2_file_hash_signaturesv1_1 TO gips_readwrite;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE ip2_file_hash_signaturesv1_1 TO gips_incremental_updates;

-- Index: ip2_file_hash_signaturesv1_1_file_hash_id_index

-- DROP INDEX ip2_file_hash_signaturesv1_1_file_hash_id_index;

CREATE INDEX ip2_file_hash_signaturesv1_1_file_hash_id_index
  ON ip2_file_hash_signaturesv1_1
  USING btree
  (file_hash_id);

-- Index: ip2_file_hash_signaturesv1_1_signaturev1_id_index

-- DROP INDEX ip2_file_hash_signaturesv1_1_signaturev1_id_index;

CREATE INDEX ip2_file_hash_signaturesv1_1_signaturev1_id_index
  ON ip2_file_hash_signaturesv1_1
  USING btree
  (signaturev1_id);


-- Trigger: ip2_file_hash_signaturesv1_1_audit on ip2_file_hash_signaturesv1_1

-- DROP TRIGGER ip2_file_hash_signaturesv1_1_audit ON ip2_file_hash_signaturesv1_1;

CREATE TRIGGER ip2_file_hash_signaturesv1_1_audit
  AFTER INSERT OR UPDATE OR DELETE
  ON ip2_file_hash_signaturesv1_1
  FOR EACH ROW
  EXECUTE PROCEDURE audit.if_modified_func();

-- Trigger: ip2_file_hash_signaturesv1_1_log_changes on ip2_file_hash_signaturesv1_1

-- DROP TRIGGER ip2_file_hash_signaturesv1_1_log_changes ON ip2_file_hash_signaturesv1_1;

CREATE TRIGGER ip2_file_hash_signaturesv1_1_log_changes
  AFTER INSERT OR UPDATE OR DELETE
  ON ip2_file_hash_signaturesv1_1
  FOR EACH ROW
  EXECUTE PROCEDURE incremental_updates.log_row_change();

