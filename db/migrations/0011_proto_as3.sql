SET search_path = game, client, raw, meta, public;

ALTER TABLE client.proto_messages
  ADD COLUMN source     text NOT NULL DEFAULT 'proto.json' CHECK (source IN ('proto.json', 'as3')),
  ADD COLUMN module     text,
  ADD COLUMN source_ref text;
COMMENT ON COLUMN client.proto_messages.source IS 'proto.json = presente em protocol/proto.json; as3 = só nas classes AS3 decompiladas (≈222 mensagens, incl. CampaignNodeMsg, PosMsg, WildLandMsg, BossMsg...).';
COMMENT ON COLUMN client.proto_messages.module IS 'Módulo do cliente onde a classe está (core_module, m3...).';
COMMENT ON COLUMN client.proto_messages.source_ref IS 'Arquivo .as da classe.';

ALTER TABLE client.proto_fields
  ADD COLUMN message_type text,
  ADD COLUMN source_ref   text;
COMMENT ON COLUMN client.proto_fields.message_type IS 'Para campos MESSAGE: a mensagem concreta (de readFromSlice `new XMsg()` ou da declaração do campo). Ex.: PosMoveMsg.routes → RouteMsg.';
COMMENT ON COLUMN client.proto_fields.source_ref IS 'arquivo:linha do writeTag na classe AS3.';
CREATE INDEX ON client.proto_fields (message_type);

INSERT INTO meta.schema_migrations(version, description) VALUES ('0011', 'protobuf from AS3 classes') ON CONFLICT DO NOTHING;
