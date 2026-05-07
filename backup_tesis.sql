--
-- PostgreSQL database dump
--

\restrict edDjcX7xLY8aC8GTdG6Zb6IkWvXFL9mcMz8yz4JhawUeJZAF8p9oeRKnKPeeaY9

-- Dumped from database version 13.23 (Debian 13.23-1.pgdg13+1)
-- Dumped by pg_dump version 13.23 (Debian 13.23-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64),
    details_json text
);


ALTER TABLE public.admin_event_entity OWNER TO dacs_user;

--
-- Name: alumno; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.alumno (
    id integer NOT NULL,
    nombre character varying(256),
    apellido character varying(256)
);


ALTER TABLE public.alumno OWNER TO dacs_user;

--
-- Name: alumno_id_seq; Type: SEQUENCE; Schema: public; Owner: dacs_user
--

ALTER TABLE public.alumno ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.alumno_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO dacs_user;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO dacs_user;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO dacs_user;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO dacs_user;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO dacs_user;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO dacs_user;

--
-- Name: cirugia; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.cirugia (
    id bigint NOT NULL,
    anestesia character varying(255) NOT NULL,
    estado character varying(255) NOT NULL,
    fecha_hora_inicio timestamp(6) without time zone NOT NULL,
    prioridad character varying(255) NOT NULL,
    paciente_id bigint,
    quirofano_id bigint,
    tipo character varying(255),
    servicio_id bigint,
    nivel_urgencia integer
);


ALTER TABLE public.cirugia OWNER TO dacs_user;

--
-- Name: cirugia_id_seq; Type: SEQUENCE; Schema: public; Owner: dacs_user
--

ALTER TABLE public.cirugia ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.cirugia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: client; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO dacs_user;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO dacs_user;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO dacs_user;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO dacs_user;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO dacs_user;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO dacs_user;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO dacs_user;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO dacs_user;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO dacs_user;

--
-- Name: component; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO dacs_user;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO dacs_user;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO dacs_user;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer,
    version integer DEFAULT 0
);


ALTER TABLE public.credential OWNER TO dacs_user;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO dacs_user;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO dacs_user;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO dacs_user;

--
-- Name: equipo_medico; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.equipo_medico (
    id bigint NOT NULL,
    fecha_asignacion timestamp(6) without time zone,
    rol character varying(255),
    id_cirugia bigint,
    id_personal bigint NOT NULL,
    id_urgencia bigint
);


ALTER TABLE public.equipo_medico OWNER TO dacs_user;

--
-- Name: equipo_medico_id_seq; Type: SEQUENCE; Schema: public; Owner: dacs_user
--

ALTER TABLE public.equipo_medico ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.equipo_medico_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: equipo_medico_urgencia; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.equipo_medico_urgencia (
    id bigint NOT NULL,
    fecha_asignacion timestamp(6) without time zone,
    rol character varying(255),
    id_personal bigint NOT NULL,
    id_urgencia bigint NOT NULL
);


ALTER TABLE public.equipo_medico_urgencia OWNER TO dacs_user;

--
-- Name: equipo_medico_urgencia_id_seq; Type: SEQUENCE; Schema: public; Owner: dacs_user
--

ALTER TABLE public.equipo_medico_urgencia ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.equipo_medico_urgencia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO dacs_user;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO dacs_user;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO dacs_user;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO dacs_user;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO dacs_user;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO dacs_user;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO dacs_user;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO dacs_user;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO dacs_user;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO dacs_user;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO dacs_user;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO dacs_user;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean,
    authenticate_by_default boolean,
    realm_id character varying(36),
    add_token_role boolean,
    trust_email boolean,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean,
    organization_id character varying(255),
    hide_on_login boolean
);


ALTER TABLE public.identity_provider OWNER TO dacs_user;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO dacs_user;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO dacs_user;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO dacs_user;

--
-- Name: intervencion; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.intervencion (
    id bigint NOT NULL,
    observaciones text,
    cirugia_id bigint,
    tipo_intervencion_id bigint NOT NULL,
    urgencia_id bigint,
    id_urgencia bigint
);


ALTER TABLE public.intervencion OWNER TO dacs_user;

--
-- Name: intervencion_id_seq; Type: SEQUENCE; Schema: public; Owner: dacs_user
--

ALTER TABLE public.intervencion ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.intervencion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: jgroups_ping; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.jgroups_ping (
    address character varying(200) NOT NULL,
    name character varying(200),
    cluster_name character varying(200) NOT NULL,
    ip character varying(200) NOT NULL,
    coord boolean
);


ALTER TABLE public.jgroups_ping OWNER TO dacs_user;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL,
    description character varying(255)
);


ALTER TABLE public.keycloak_group OWNER TO dacs_user;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO dacs_user;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO dacs_user;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO dacs_user;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0,
    remember_me boolean
);


ALTER TABLE public.offline_user_session OWNER TO dacs_user;

--
-- Name: org; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO dacs_user;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO dacs_user;

--
-- Name: org_invitation; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.org_invitation (
    id character varying(36) NOT NULL,
    organization_id character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    created_at integer NOT NULL,
    expires_at integer,
    invite_link character varying(2048)
);


ALTER TABLE public.org_invitation OWNER TO dacs_user;

--
-- Name: paciente; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.paciente (
    id bigint NOT NULL,
    altura character varying(10) NOT NULL,
    direccion character varying(100) NOT NULL,
    dni character varying(25) NOT NULL,
    nombre character varying(50) NOT NULL,
    peso character varying(10) NOT NULL,
    telefono character varying(20) NOT NULL,
    apellido character varying(50),
    fecha_nacimiento date DEFAULT CURRENT_DATE NOT NULL,
    active boolean DEFAULT true
);


ALTER TABLE public.paciente OWNER TO dacs_user;

--
-- Name: paciente_id_seq; Type: SEQUENCE; Schema: public; Owner: dacs_user
--

ALTER TABLE public.paciente ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.paciente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: personal; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.personal (
    id bigint NOT NULL,
    especialidad character varying(100) NOT NULL,
    estado character varying(100) NOT NULL,
    legajo character varying(100) NOT NULL,
    nombre character varying(100) NOT NULL,
    rol character varying(100) NOT NULL,
    telefono character varying(15) NOT NULL,
    dni character varying(15),
    apellido character varying(100)
);


ALTER TABLE public.personal OWNER TO dacs_user;

--
-- Name: personal_id_seq; Type: SEQUENCE; Schema: public; Owner: dacs_user
--

ALTER TABLE public.personal ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.personal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO dacs_user;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO dacs_user;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO dacs_user;

--
-- Name: quirofano; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.quirofano (
    id bigint NOT NULL,
    estado character varying(100) NOT NULL,
    nombre character varying(100) NOT NULL,
    ubicacion character varying(100)
);


ALTER TABLE public.quirofano OWNER TO dacs_user;

--
-- Name: quirofano_id_seq; Type: SEQUENCE; Schema: public; Owner: dacs_user
--

ALTER TABLE public.quirofano ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.quirofano_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: realm; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO dacs_user;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO dacs_user;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO dacs_user;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO dacs_user;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO dacs_user;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO dacs_user;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO dacs_user;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO dacs_user;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO dacs_user;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO dacs_user;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO dacs_user;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO dacs_user;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO dacs_user;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO dacs_user;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO dacs_user;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO dacs_user;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO dacs_user;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO dacs_user;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO dacs_user;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO dacs_user;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO dacs_user;

--
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO dacs_user;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO dacs_user;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO dacs_user;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO dacs_user;

--
-- Name: server_config; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.server_config (
    server_config_key character varying(255) NOT NULL,
    value text NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.server_config OWNER TO dacs_user;

--
-- Name: servicio; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.servicio (
    id bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    duracion_minutos integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.servicio OWNER TO dacs_user;

--
-- Name: servicio_id_seq; Type: SEQUENCE; Schema: public; Owner: dacs_user
--

ALTER TABLE public.servicio ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.servicio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tipo_intervencion; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.tipo_intervencion (
    id bigint NOT NULL,
    descripcion character varying(255),
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.tipo_intervencion OWNER TO dacs_user;

--
-- Name: tipo_intervencion_id_seq; Type: SEQUENCE; Schema: public; Owner: dacs_user
--

ALTER TABLE public.tipo_intervencion ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tipo_intervencion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: turno; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.turno (
    id bigint NOT NULL,
    estado character varying(100),
    fecha_hora_inicio timestamp(6) without time zone NOT NULL,
    cirugia_id bigint,
    quirofano_id bigint NOT NULL,
    urgencia_id bigint
);


ALTER TABLE public.turno OWNER TO dacs_user;

--
-- Name: turno_id_seq; Type: SEQUENCE; Schema: public; Owner: dacs_user
--

ALTER TABLE public.turno ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.turno_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: urgencia; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.urgencia (
    id bigint NOT NULL,
    anestesia character varying(255) NOT NULL,
    estado character varying(255) NOT NULL,
    fecha_hora_inicio timestamp(6) without time zone NOT NULL,
    nivel_urgencia integer,
    prioridad character varying(255),
    tipo character varying(255) NOT NULL,
    paciente_id bigint,
    quirofano_id bigint,
    servicio_id bigint,
    CONSTRAINT urgencia_estado_check CHECK (((estado)::text = ANY ((ARRAY['PENDIENTE'::character varying, 'PROGRAMADA'::character varying, 'EN_CURSO'::character varying, 'FINALIZADA'::character varying, 'CANCELADA'::character varying])::text[])))
);


ALTER TABLE public.urgencia OWNER TO dacs_user;

--
-- Name: urgencia_id_seq; Type: SEQUENCE; Schema: public; Owner: dacs_user
--

ALTER TABLE public.urgencia ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.urgencia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO dacs_user;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO dacs_user;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO dacs_user;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO dacs_user;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO dacs_user;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO dacs_user;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO dacs_user;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO dacs_user;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO dacs_user;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO dacs_user;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO dacs_user;

--
-- Name: usuario; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.usuario (
    id bigint NOT NULL,
    email character varying(100) NOT NULL,
    enabled boolean NOT NULL,
    keycloak_id character varying(100) NOT NULL,
    username character varying(100) NOT NULL,
    id_personal bigint NOT NULL
);


ALTER TABLE public.usuario OWNER TO dacs_user;

--
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: dacs_user
--

ALTER TABLE public.usuario ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO dacs_user;

--
-- Name: workflow_state; Type: TABLE; Schema: public; Owner: dacs_user
--

CREATE TABLE public.workflow_state (
    execution_id character varying(255) NOT NULL,
    resource_id character varying(255) NOT NULL,
    workflow_id character varying(255) NOT NULL,
    resource_type character varying(255),
    scheduled_step_id character varying(255),
    scheduled_step_timestamp bigint
);


ALTER TABLE public.workflow_state OWNER TO dacs_user;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type, details_json) FROM stdin;
\.


--
-- Data for Name: alumno; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.alumno (id, nombre, apellido) FROM stdin;
1	Lucas	Carotta
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
3fccce04-5384-4450-89e3-386ba73a7348	\N	auth-cookie	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	81c64f59-c6e5-42a8-be0e-2a65a4386b14	2	10	f	\N	\N
b126e68d-f84d-433b-971e-5ecc37c65762	\N	auth-spnego	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	81c64f59-c6e5-42a8-be0e-2a65a4386b14	3	20	f	\N	\N
f4e4983e-9171-4c57-aca5-788b78bc8fd1	\N	identity-provider-redirector	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	81c64f59-c6e5-42a8-be0e-2a65a4386b14	2	25	f	\N	\N
b15223e8-731a-45c7-aead-638de1f0c9fb	\N	\N	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	81c64f59-c6e5-42a8-be0e-2a65a4386b14	2	30	t	e0f042cc-839a-47c5-ad69-2ab2091e9d83	\N
a6b88042-c8e9-4edd-a4c4-b162563f69a7	\N	auth-username-password-form	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	e0f042cc-839a-47c5-ad69-2ab2091e9d83	0	10	f	\N	\N
071ca0b4-7ff1-4cba-a14d-4f0410141d77	\N	\N	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	e0f042cc-839a-47c5-ad69-2ab2091e9d83	1	20	t	9d432c0b-a643-43f4-a7b9-8d8a5e372d1e	\N
81523fda-a2da-4250-a1a8-47001aa3a3d9	\N	conditional-user-configured	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	9d432c0b-a643-43f4-a7b9-8d8a5e372d1e	0	10	f	\N	\N
b87536be-1559-443b-ad6e-ef4263d9c327	\N	conditional-credential	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	9d432c0b-a643-43f4-a7b9-8d8a5e372d1e	0	20	f	\N	96258e9d-3637-4c8e-89c9-af73f3dbea46
4cc7c21d-aa0a-458b-8268-82905adf58c5	\N	auth-otp-form	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	9d432c0b-a643-43f4-a7b9-8d8a5e372d1e	2	30	f	\N	\N
05ad2b64-110e-452f-8aaa-9b5f9c451d80	\N	webauthn-authenticator	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	9d432c0b-a643-43f4-a7b9-8d8a5e372d1e	3	40	f	\N	\N
434c477e-04f2-4ad5-8d13-7bf6be5b74aa	\N	auth-recovery-authn-code-form	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	9d432c0b-a643-43f4-a7b9-8d8a5e372d1e	3	50	f	\N	\N
8daf5c6d-6f4a-4ee1-be0b-ef2b90b1da72	\N	direct-grant-validate-username	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	f4ee410d-e26e-4972-a1e3-999afe4a4257	0	10	f	\N	\N
06b5a723-3b79-4a59-949a-3a143de9a202	\N	direct-grant-validate-password	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	f4ee410d-e26e-4972-a1e3-999afe4a4257	0	20	f	\N	\N
ff67bbd4-b9be-4c08-b0bf-963fac25183a	\N	\N	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	f4ee410d-e26e-4972-a1e3-999afe4a4257	1	30	t	abf6a546-cdfa-4155-aab5-f84643d67ecb	\N
08821da9-ba0d-443c-be1b-71e7efee78c1	\N	conditional-user-configured	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	abf6a546-cdfa-4155-aab5-f84643d67ecb	0	10	f	\N	\N
f787fce5-8bd5-435c-9f96-d9825e0a8a4c	\N	direct-grant-validate-otp	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	abf6a546-cdfa-4155-aab5-f84643d67ecb	0	20	f	\N	\N
a3f77b4e-fc9e-4fc1-9dbb-0b881877ac6c	\N	registration-page-form	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	ab247d35-2c31-412f-9823-62b2006de5f9	0	10	t	505acf6a-5ef5-4e16-b960-4463299b028c	\N
bfde14ae-e410-4e50-bf3d-f40754d46cf3	\N	registration-user-creation	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	505acf6a-5ef5-4e16-b960-4463299b028c	0	20	f	\N	\N
93ce45c1-6530-4c32-9fd8-51776ce8673d	\N	registration-password-action	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	505acf6a-5ef5-4e16-b960-4463299b028c	0	50	f	\N	\N
a751f591-ebb5-4804-9663-291c9e2ba98f	\N	registration-recaptcha-action	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	505acf6a-5ef5-4e16-b960-4463299b028c	3	60	f	\N	\N
8ad27abb-c962-403b-be27-c49015261b74	\N	registration-terms-and-conditions	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	505acf6a-5ef5-4e16-b960-4463299b028c	3	70	f	\N	\N
b9794b64-3a84-40a8-b9cf-031dedd2a525	\N	reset-credentials-choose-user	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	438c4c42-dd11-4bfd-819f-1b2924ddef4e	0	10	f	\N	\N
525b9be6-b180-40de-abf0-0adbf53b521a	\N	reset-credential-email	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	438c4c42-dd11-4bfd-819f-1b2924ddef4e	0	20	f	\N	\N
854aa094-549f-4f20-a712-b3eb2498d9f2	\N	reset-password	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	438c4c42-dd11-4bfd-819f-1b2924ddef4e	0	30	f	\N	\N
9f8b1df0-bbc7-4cf7-b485-1faf525ce08d	\N	\N	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	438c4c42-dd11-4bfd-819f-1b2924ddef4e	1	40	t	ac5f8f00-25dc-4967-9c51-8bd5a9ab8ffc	\N
b5edc19e-d08d-4ef9-bfec-fed7bcbfa073	\N	conditional-user-configured	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	ac5f8f00-25dc-4967-9c51-8bd5a9ab8ffc	0	10	f	\N	\N
daef8cc4-b6c5-4230-b953-b58dd84b7dd5	\N	reset-otp	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	ac5f8f00-25dc-4967-9c51-8bd5a9ab8ffc	0	20	f	\N	\N
65bc8565-0bc5-4513-891e-8227bcca7a3a	\N	client-secret	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	f7b66a8f-1645-4e15-9729-a54ea1e7912f	2	10	f	\N	\N
090f01fb-42ea-4ad1-b8f1-66ec23a13daa	\N	client-jwt	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	f7b66a8f-1645-4e15-9729-a54ea1e7912f	2	20	f	\N	\N
22236f8c-7e37-440b-84eb-347added6ad4	\N	client-secret-jwt	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	f7b66a8f-1645-4e15-9729-a54ea1e7912f	2	30	f	\N	\N
eb2beca5-3381-4522-9cdd-92fbd8f8c7c3	\N	client-x509	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	f7b66a8f-1645-4e15-9729-a54ea1e7912f	2	40	f	\N	\N
9cf3e5bb-c9b3-45e4-8daf-5709e4a948e9	\N	idp-review-profile	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	47156c63-0b6d-4f95-bdac-e5d8103ef8e6	0	10	f	\N	f826656a-1f4b-408d-8239-0222cfe0657d
61aff118-5df0-4873-be1d-d45ad3000da4	\N	\N	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	47156c63-0b6d-4f95-bdac-e5d8103ef8e6	0	20	t	d81ff6e7-11be-4719-8c16-707bd25b6dcc	\N
8f0492fd-2f93-4866-aad6-0537a98d11e9	\N	idp-create-user-if-unique	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	d81ff6e7-11be-4719-8c16-707bd25b6dcc	2	10	f	\N	19770a2b-2fec-47d4-a10b-641ff13aa2af
9db54ff2-2029-4448-ace7-57d73129bec3	\N	\N	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	d81ff6e7-11be-4719-8c16-707bd25b6dcc	2	20	t	27e53686-043c-4faf-ae7e-262a633eac11	\N
0e37a71f-61ab-4c58-a7c9-884d4078e49e	\N	idp-confirm-link	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	27e53686-043c-4faf-ae7e-262a633eac11	0	10	f	\N	\N
7eb95670-4f71-433b-8928-69912d39f637	\N	\N	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	27e53686-043c-4faf-ae7e-262a633eac11	0	20	t	3e1fa8d0-2db5-41f0-bd37-d06e9730fe2b	\N
79e528b1-0b12-408f-a9de-648d7fd7fffc	\N	idp-email-verification	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	3e1fa8d0-2db5-41f0-bd37-d06e9730fe2b	2	10	f	\N	\N
f9e9a81c-2c4f-4546-8424-62af258c71e8	\N	\N	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	3e1fa8d0-2db5-41f0-bd37-d06e9730fe2b	2	20	t	e9afafa1-4e38-49e3-80ba-a4d245761078	\N
9cb25908-214b-46d0-abfb-6f505419902a	\N	idp-username-password-form	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	e9afafa1-4e38-49e3-80ba-a4d245761078	0	10	f	\N	\N
300e3dd3-b15b-4058-95cb-bc919a44a78b	\N	\N	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	e9afafa1-4e38-49e3-80ba-a4d245761078	1	20	t	9e675b74-b1a2-420d-892e-e8b087183dc7	\N
a5725376-1929-40c1-a13b-c2120815f6b1	\N	conditional-user-configured	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	9e675b74-b1a2-420d-892e-e8b087183dc7	0	10	f	\N	\N
8778e327-6f5c-4de3-978b-41bd87045f80	\N	conditional-credential	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	9e675b74-b1a2-420d-892e-e8b087183dc7	0	20	f	\N	86931da0-ef30-45cc-9f48-f3643120f047
b81c5f2d-28fd-48a2-8b53-a1477431df1c	\N	auth-otp-form	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	9e675b74-b1a2-420d-892e-e8b087183dc7	2	30	f	\N	\N
e097b160-16d1-403a-90a4-42d5fa1b7b38	\N	webauthn-authenticator	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	9e675b74-b1a2-420d-892e-e8b087183dc7	3	40	f	\N	\N
f84adaa7-4a99-4f76-8d37-8f323bb021a6	\N	auth-recovery-authn-code-form	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	9e675b74-b1a2-420d-892e-e8b087183dc7	3	50	f	\N	\N
a007e703-ccd8-466e-ad66-d1b7d061d862	\N	http-basic-authenticator	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	f0601223-938e-4201-952d-b7de923aaa11	0	10	f	\N	\N
b77e7aaa-60e6-4256-b817-4086c5e03ad9	\N	docker-http-basic-authenticator	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	f84cb0c3-373a-4f3a-9441-4ca79426d5e6	0	10	f	\N	\N
84d4c5fe-6877-45db-b785-707bcaaea1b0	\N	auth-cookie	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	5b71a30c-86a5-4aa7-9dcc-f585f9971709	2	10	f	\N	\N
84936a20-06cc-4c60-8435-85af7acd99f6	\N	auth-spnego	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	5b71a30c-86a5-4aa7-9dcc-f585f9971709	3	20	f	\N	\N
818728ce-4dc8-42ac-89b2-2b8b13723e0e	\N	identity-provider-redirector	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	5b71a30c-86a5-4aa7-9dcc-f585f9971709	2	25	f	\N	\N
7e1d2656-e547-4c7b-81f3-72e0cbf43e60	\N	\N	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	5b71a30c-86a5-4aa7-9dcc-f585f9971709	2	30	t	72f44600-62fd-48fd-877b-79ed8a27f6c5	\N
d83c3d61-5af3-47b3-9341-9046bb2e58cd	\N	auth-username-password-form	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	72f44600-62fd-48fd-877b-79ed8a27f6c5	0	10	f	\N	\N
faad9101-315b-48a1-89bf-ff724d658e63	\N	\N	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	72f44600-62fd-48fd-877b-79ed8a27f6c5	1	20	t	10234cbd-39fc-4acf-92c9-2d593b17b7b3	\N
d6e465ba-1197-41de-a14b-c5587d2600d5	\N	conditional-user-configured	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	10234cbd-39fc-4acf-92c9-2d593b17b7b3	0	10	f	\N	\N
4b1f6af5-265f-4776-9571-e0c8fdfe056b	\N	conditional-credential	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	10234cbd-39fc-4acf-92c9-2d593b17b7b3	0	20	f	\N	b9a011b7-49cd-4e41-9667-53a32b080574
2a1eb7f3-3929-40b3-b151-3ec7340cb451	\N	auth-otp-form	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	10234cbd-39fc-4acf-92c9-2d593b17b7b3	2	30	f	\N	\N
01a3cde9-338e-43c6-abf9-3de7c5689691	\N	webauthn-authenticator	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	10234cbd-39fc-4acf-92c9-2d593b17b7b3	3	40	f	\N	\N
4a47e2d1-ea5f-4f87-960a-ddc43d01228e	\N	auth-recovery-authn-code-form	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	10234cbd-39fc-4acf-92c9-2d593b17b7b3	3	50	f	\N	\N
5f72ada0-39e0-47d2-bf9f-246f667b030f	\N	\N	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	5b71a30c-86a5-4aa7-9dcc-f585f9971709	2	26	t	db4958bf-190d-486f-add5-7dcb5ebe23d3	\N
32016510-d668-44ca-a509-24b9f6bea0ed	\N	\N	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	db4958bf-190d-486f-add5-7dcb5ebe23d3	1	10	t	f3642563-4b52-447f-a50f-8acb707469f9	\N
356d23d1-229a-4485-a903-c0df80a52b24	\N	conditional-user-configured	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	f3642563-4b52-447f-a50f-8acb707469f9	0	10	f	\N	\N
79700a37-44ea-42b3-ba6d-8c5f26a1d571	\N	organization	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	f3642563-4b52-447f-a50f-8acb707469f9	2	20	f	\N	\N
a90ba8d5-07eb-430b-88bd-084c5dedf1ef	\N	direct-grant-validate-username	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	6f3565d5-09bc-4034-8143-39ce036a58b0	0	10	f	\N	\N
9a6df4b2-af69-4463-a9ab-50737d979f9c	\N	direct-grant-validate-password	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	6f3565d5-09bc-4034-8143-39ce036a58b0	0	20	f	\N	\N
c6d797e5-e102-4eee-b4f4-f49db3ba1d35	\N	\N	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	6f3565d5-09bc-4034-8143-39ce036a58b0	1	30	t	dbc4cb14-283d-4211-b5e2-0e3712e4098b	\N
54999dd0-6be3-46a1-b03a-d6aaf15ae2df	\N	conditional-user-configured	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dbc4cb14-283d-4211-b5e2-0e3712e4098b	0	10	f	\N	\N
a005b7ff-c530-45f0-b993-89b70fc9b4c7	\N	direct-grant-validate-otp	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dbc4cb14-283d-4211-b5e2-0e3712e4098b	0	20	f	\N	\N
81df706b-9343-4e4e-8676-aba314689c35	\N	registration-page-form	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	993d1787-2eee-4541-a884-04e693df4cb8	0	10	t	39dec1b5-cfe0-4945-825b-2f78b7cf8b31	\N
98e2d479-3cfc-44e6-8567-0034a111430b	\N	registration-user-creation	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	39dec1b5-cfe0-4945-825b-2f78b7cf8b31	0	20	f	\N	\N
1b58d94e-fe25-4b0a-a27d-78462d7a0bba	\N	registration-password-action	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	39dec1b5-cfe0-4945-825b-2f78b7cf8b31	0	50	f	\N	\N
2a36cc58-7341-4ff6-8df5-a687f5d6fa87	\N	registration-recaptcha-action	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	39dec1b5-cfe0-4945-825b-2f78b7cf8b31	3	60	f	\N	\N
fc446fbc-986a-402e-ba63-98c6563c8fa4	\N	registration-terms-and-conditions	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	39dec1b5-cfe0-4945-825b-2f78b7cf8b31	3	70	f	\N	\N
9a007af6-b851-430c-87c1-9123d5836e3e	\N	reset-credentials-choose-user	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	4603d110-c8f0-4bdf-b6f8-493cc9fb4b1b	0	10	f	\N	\N
3c305e98-dbbe-48eb-8a85-5202b2670bdb	\N	reset-credential-email	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	4603d110-c8f0-4bdf-b6f8-493cc9fb4b1b	0	20	f	\N	\N
b1bd74cd-6133-4583-9b40-90d45d4b393a	\N	reset-password	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	4603d110-c8f0-4bdf-b6f8-493cc9fb4b1b	0	30	f	\N	\N
00cd9422-97ac-49ce-a6c4-d34df9d994d1	\N	\N	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	4603d110-c8f0-4bdf-b6f8-493cc9fb4b1b	1	40	t	c72ca588-306b-44e7-88ac-5b8fc15a9d05	\N
e4a24d09-002d-47a7-9d78-deb109219123	\N	conditional-user-configured	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	c72ca588-306b-44e7-88ac-5b8fc15a9d05	0	10	f	\N	\N
3cf142a5-6f38-4991-b7f8-9a01fc4d3d58	\N	reset-otp	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	c72ca588-306b-44e7-88ac-5b8fc15a9d05	0	20	f	\N	\N
1812987a-e93f-45e1-a0d9-d9a144b41d33	\N	client-secret	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	2f5574ef-a5d1-4feb-a5b3-b633f6fabb49	2	10	f	\N	\N
712747d7-9080-42d8-9ed6-d0756c8d67c9	\N	client-jwt	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	2f5574ef-a5d1-4feb-a5b3-b633f6fabb49	2	20	f	\N	\N
56d6fd10-679f-4a0a-bdb9-6564be6ffc65	\N	client-secret-jwt	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	2f5574ef-a5d1-4feb-a5b3-b633f6fabb49	2	30	f	\N	\N
cc0f3359-131b-440f-83af-60442acf4c84	\N	client-x509	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	2f5574ef-a5d1-4feb-a5b3-b633f6fabb49	2	40	f	\N	\N
68cea896-3d07-4f1a-8408-ce73287a94bf	\N	idp-review-profile	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	bd9914c4-fb6f-4f58-8e33-8ed038f99173	0	10	f	\N	3a14d0e0-1b2e-4a21-b0ad-a1ce4ef04c48
19466803-368a-4419-af63-f47c2dd2daa7	\N	\N	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	bd9914c4-fb6f-4f58-8e33-8ed038f99173	0	20	t	248258d0-a3ef-4efb-9f42-7cf5cec28c6e	\N
fef37064-a210-4ab1-a364-d3ff787f9666	\N	idp-create-user-if-unique	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	248258d0-a3ef-4efb-9f42-7cf5cec28c6e	2	10	f	\N	d4cc328c-cbb1-4ee0-9b1d-7f94bf85e3a7
8c71871a-7b5b-4534-a565-269c5f16e392	\N	\N	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	248258d0-a3ef-4efb-9f42-7cf5cec28c6e	2	20	t	a1c263e8-9930-4f3d-acf1-d8f4b8956e55	\N
70c00a99-385c-40a9-a724-adf752740eb7	\N	idp-confirm-link	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	a1c263e8-9930-4f3d-acf1-d8f4b8956e55	0	10	f	\N	\N
f226e46f-5191-402a-b2cc-88155feb8ac7	\N	\N	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	a1c263e8-9930-4f3d-acf1-d8f4b8956e55	0	20	t	68882f45-f392-457c-b7a4-e358055e1497	\N
12ec8bb8-d277-4966-9d7d-70d61c7f4162	\N	idp-email-verification	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	68882f45-f392-457c-b7a4-e358055e1497	2	10	f	\N	\N
13d722aa-1f1f-459e-8592-ae7c19a9b22e	\N	\N	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	68882f45-f392-457c-b7a4-e358055e1497	2	20	t	88fd171c-511d-4ccf-8033-adf83fa4e83e	\N
df09b9b2-9e31-495c-83cf-aac55b8ec95d	\N	idp-username-password-form	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	88fd171c-511d-4ccf-8033-adf83fa4e83e	0	10	f	\N	\N
a630faf2-afc0-4ed7-a1ae-64aeca98a6fa	\N	\N	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	88fd171c-511d-4ccf-8033-adf83fa4e83e	1	20	t	53630e08-e619-47bb-afa8-d6fd4caad5bb	\N
f3accf64-395a-477f-b0e8-faf84ecd7c8a	\N	conditional-user-configured	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	53630e08-e619-47bb-afa8-d6fd4caad5bb	0	10	f	\N	\N
d9cc0c7e-5785-40ae-b34e-337821a91188	\N	conditional-credential	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	53630e08-e619-47bb-afa8-d6fd4caad5bb	0	20	f	\N	64249d50-1771-401a-8e77-5eeea344882e
bf12f092-f961-4682-b6b0-825694bbe927	\N	auth-otp-form	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	53630e08-e619-47bb-afa8-d6fd4caad5bb	2	30	f	\N	\N
dbf24d8f-a6ab-43d4-a888-08b232517b9b	\N	webauthn-authenticator	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	53630e08-e619-47bb-afa8-d6fd4caad5bb	3	40	f	\N	\N
bd2cab29-1cea-45ce-94af-501008e99e96	\N	auth-recovery-authn-code-form	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	53630e08-e619-47bb-afa8-d6fd4caad5bb	3	50	f	\N	\N
ae66b8d7-3fa9-4ccf-9b79-081bf2f19c48	\N	\N	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	bd9914c4-fb6f-4f58-8e33-8ed038f99173	1	60	t	caf0a194-f3e3-4f5c-9aa2-c656c032d241	\N
16613ae0-6f3e-47bc-adbb-e857e49a968d	\N	conditional-user-configured	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	caf0a194-f3e3-4f5c-9aa2-c656c032d241	0	10	f	\N	\N
0b33b849-0cf8-4946-a6c7-ae16f98356f4	\N	idp-add-organization-member	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	caf0a194-f3e3-4f5c-9aa2-c656c032d241	0	20	f	\N	\N
cdf0b1e6-1f8a-4cd0-a877-163ba4b12122	\N	http-basic-authenticator	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	4a051546-c9e4-43ef-83a6-171321880164	0	10	f	\N	\N
722a3a94-56d2-4dd3-bf39-3930d52aa5b4	\N	docker-http-basic-authenticator	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	6ad1fe17-e8e3-423d-a4bf-0eed127804c5	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
81c64f59-c6e5-42a8-be0e-2a65a4386b14	browser	Browser based authentication	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	basic-flow	t	t
e0f042cc-839a-47c5-ad69-2ab2091e9d83	forms	Username, password, otp and other auth forms.	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	basic-flow	f	t
9d432c0b-a643-43f4-a7b9-8d8a5e372d1e	Browser - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	basic-flow	f	t
f4ee410d-e26e-4972-a1e3-999afe4a4257	direct grant	OpenID Connect Resource Owner Grant	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	basic-flow	t	t
abf6a546-cdfa-4155-aab5-f84643d67ecb	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	basic-flow	f	t
ab247d35-2c31-412f-9823-62b2006de5f9	registration	Registration flow	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	basic-flow	t	t
505acf6a-5ef5-4e16-b960-4463299b028c	registration form	Registration form	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	form-flow	f	t
438c4c42-dd11-4bfd-819f-1b2924ddef4e	reset credentials	Reset credentials for a user if they forgot their password or something	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	basic-flow	t	t
ac5f8f00-25dc-4967-9c51-8bd5a9ab8ffc	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	basic-flow	f	t
f7b66a8f-1645-4e15-9729-a54ea1e7912f	clients	Base authentication for clients	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	client-flow	t	t
47156c63-0b6d-4f95-bdac-e5d8103ef8e6	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	basic-flow	t	t
d81ff6e7-11be-4719-8c16-707bd25b6dcc	User creation or linking	Flow for the existing/non-existing user alternatives	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	basic-flow	f	t
27e53686-043c-4faf-ae7e-262a633eac11	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	basic-flow	f	t
3e1fa8d0-2db5-41f0-bd37-d06e9730fe2b	Account verification options	Method with which to verity the existing account	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	basic-flow	f	t
e9afafa1-4e38-49e3-80ba-a4d245761078	Verify Existing Account by Re-authentication	Reauthentication of existing account	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	basic-flow	f	t
9e675b74-b1a2-420d-892e-e8b087183dc7	First broker login - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	basic-flow	f	t
f0601223-938e-4201-952d-b7de923aaa11	saml ecp	SAML ECP Profile Authentication Flow	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	basic-flow	t	t
f84cb0c3-373a-4f3a-9441-4ca79426d5e6	docker auth	Used by Docker clients to authenticate against the IDP	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	basic-flow	t	t
5b71a30c-86a5-4aa7-9dcc-f585f9971709	browser	Browser based authentication	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	basic-flow	t	t
72f44600-62fd-48fd-877b-79ed8a27f6c5	forms	Username, password, otp and other auth forms.	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	basic-flow	f	t
10234cbd-39fc-4acf-92c9-2d593b17b7b3	Browser - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	basic-flow	f	t
db4958bf-190d-486f-add5-7dcb5ebe23d3	Organization	\N	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	basic-flow	f	t
f3642563-4b52-447f-a50f-8acb707469f9	Browser - Conditional Organization	Flow to determine if the organization identity-first login is to be used	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	basic-flow	f	t
6f3565d5-09bc-4034-8143-39ce036a58b0	direct grant	OpenID Connect Resource Owner Grant	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	basic-flow	t	t
dbc4cb14-283d-4211-b5e2-0e3712e4098b	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	basic-flow	f	t
993d1787-2eee-4541-a884-04e693df4cb8	registration	Registration flow	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	basic-flow	t	t
39dec1b5-cfe0-4945-825b-2f78b7cf8b31	registration form	Registration form	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	form-flow	f	t
4603d110-c8f0-4bdf-b6f8-493cc9fb4b1b	reset credentials	Reset credentials for a user if they forgot their password or something	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	basic-flow	t	t
c72ca588-306b-44e7-88ac-5b8fc15a9d05	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	basic-flow	f	t
2f5574ef-a5d1-4feb-a5b3-b633f6fabb49	clients	Base authentication for clients	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	client-flow	t	t
bd9914c4-fb6f-4f58-8e33-8ed038f99173	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	basic-flow	t	t
248258d0-a3ef-4efb-9f42-7cf5cec28c6e	User creation or linking	Flow for the existing/non-existing user alternatives	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	basic-flow	f	t
a1c263e8-9930-4f3d-acf1-d8f4b8956e55	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	basic-flow	f	t
68882f45-f392-457c-b7a4-e358055e1497	Account verification options	Method with which to verity the existing account	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	basic-flow	f	t
88fd171c-511d-4ccf-8033-adf83fa4e83e	Verify Existing Account by Re-authentication	Reauthentication of existing account	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	basic-flow	f	t
53630e08-e619-47bb-afa8-d6fd4caad5bb	First broker login - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	basic-flow	f	t
caf0a194-f3e3-4f5c-9aa2-c656c032d241	First Broker Login - Conditional Organization	Flow to determine if the authenticator that adds organization members is to be used	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	basic-flow	f	t
4a051546-c9e4-43ef-83a6-171321880164	saml ecp	SAML ECP Profile Authentication Flow	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	basic-flow	t	t
6ad1fe17-e8e3-423d-a4bf-0eed127804c5	docker auth	Used by Docker clients to authenticate against the IDP	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
96258e9d-3637-4c8e-89c9-af73f3dbea46	browser-conditional-credential	d97d657d-c2a8-4c20-a3a8-4ca15a52738d
f826656a-1f4b-408d-8239-0222cfe0657d	review profile config	d97d657d-c2a8-4c20-a3a8-4ca15a52738d
19770a2b-2fec-47d4-a10b-641ff13aa2af	create unique user config	d97d657d-c2a8-4c20-a3a8-4ca15a52738d
86931da0-ef30-45cc-9f48-f3643120f047	first-broker-login-conditional-credential	d97d657d-c2a8-4c20-a3a8-4ca15a52738d
b9a011b7-49cd-4e41-9667-53a32b080574	browser-conditional-credential	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b
3a14d0e0-1b2e-4a21-b0ad-a1ce4ef04c48	review profile config	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b
d4cc328c-cbb1-4ee0-9b1d-7f94bf85e3a7	create unique user config	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b
64249d50-1771-401a-8e77-5eeea344882e	first-broker-login-conditional-credential	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
19770a2b-2fec-47d4-a10b-641ff13aa2af	false	require.password.update.after.registration
86931da0-ef30-45cc-9f48-f3643120f047	webauthn-passwordless	credentials
96258e9d-3637-4c8e-89c9-af73f3dbea46	webauthn-passwordless	credentials
f826656a-1f4b-408d-8239-0222cfe0657d	missing	update.profile.on.first.login
3a14d0e0-1b2e-4a21-b0ad-a1ce4ef04c48	missing	update.profile.on.first.login
64249d50-1771-401a-8e77-5eeea344882e	webauthn-passwordless	credentials
b9a011b7-49cd-4e41-9667-53a32b080574	webauthn-passwordless	credentials
d4cc328c-cbb1-4ee0-9b1d-7f94bf85e3a7	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: cirugia; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.cirugia (id, anestesia, estado, fecha_hora_inicio, prioridad, paciente_id, quirofano_id, tipo, servicio_id, nivel_urgencia) FROM stdin;
254	SEDACION	FINALIZADA	2026-02-04 13:30:00	MEDIA	12	1	URGENTE	2	\N
260		PROGRAMADA	2026-02-11 08:00:00		8	1		2	\N
259		CANCELADA	2026-02-10 10:00:00		1	1		1	\N
261	LOCAL	PROGRAMADA	2026-02-27 08:00:00	MEDIA	8	1	PROGRAMADA	3	\N
264	LOCAL	CANCELADA	2026-03-12 11:30:00	MEDIA	8	1	PROGRAMADA	8	\N
270	LOCAL	EN_CURSO	2026-03-12 12:30:00	MEDIA	10	3	PROGRAMADA	2	\N
271	GENERAL	PROGRAMADA	2026-03-17 12:00:00	ALTA	7	1	ELECTIVA	3	\N
279	GENERAL	FINALIZADA	2026-03-11 12:00:00	MEDIA	11	3	PROGRAMADA	10	\N
280	GENERAL	EN_CURSO	2026-03-11 12:00:00	MEDIA	11	3	PROGRAMADA	10	\N
287	LOCAL	EN_CURSO	2026-03-18 11:30:00	MEDIA	8	1	URGENTE	3	\N
293	LOCAL	PROGRAMADA	2026-04-25 13:00:00	MEDIA	14	2	URGENTE	4	\N
294	LOCAL	PROGRAMADA	2026-04-26 12:30:00	MEDIA	12	1	ELECTIVA	3	\N
255	LOCAL	FINALIZADA	2026-02-06 12:30:00	MEDIA	7	1	ELECTIVA	2	\N
258	REGIONAL	FINALIZADA	2026-02-10 08:00:00	BAJA	3	1		1	\N
297	GENERAL	CANCELADA	2026-04-29 08:00:00	BAJA	8	1	AMBULATORIA	2	\N
300	GENERAL	CANCELADA	2026-04-29 12:30:00	MEDIA	1	1	ELECTIVA	1	\N
303	REGIONAL	CANCELADA	2026-05-03 08:00:00	ALTA	10	1		2	\N
263	LOCAL	CANCELADA	2026-03-11 08:00:00	MEDIA	1	1	ELECTIVA	2	\N
268	LOCAL	CANCELADA	2026-03-16 15:00:00	BAJA	15	3	URGENTE	4	\N
290	GENERAL	CANCELADA	2026-04-25 08:00:00	MEDIA	1	1	PROGRAMADA	1	\N
304	LOCAL	CANCELADA	2026-04-29 08:00:00	ALTA	2	1		1	\N
307	LOCAL	PROGRAMADA	2026-05-03 08:00:00	ALTA	3	1		2	\N
309	REGIONAL	CANCELADA	2026-05-05 08:00:00	BAJA	1	1	ELECTIVA	1	\N
281	REGIONAL	FINALIZADA	2026-02-10 08:00:00	BAJA	3	1	URGENTE	1	\N
311	GENERAL	PROGRAMADA	2026-05-07 12:00:00	ALTA	7	1	ELECTIVA	2	\N
257		CANCELADA	2026-02-06 11:00:00		3	2		1	\N
262	REGIONAL	PROGRAMADA	2026-02-27 08:30:00	MEDIA	8	3	ELECTIVA	7	\N
265	GENERAL	PROGRAMADA	2026-03-11 12:00:00	MEDIA	11	3	PROGRAMADA	10	\N
267	REGIONAL	PROGRAMADA	2026-03-16 12:00:00	MEDIA	13	3	PROGRAMADA	3	\N
269	LOCAL	CANCELADA	2026-03-14 11:30:00	MEDIA	16	1		4	\N
272	REGIONAL	PROGRAMADA	2026-03-17 09:00:00	MEDIA	10	1	URGENTE	3	\N
275	LOCAL	PROGRAMADA	2026-03-13 15:30:00	ALTA	19	3	URGENTE	4	\N
276	REGIONAL	CANCELADA	2026-03-13 15:00:00	MEDIA	16	1		4	\N
277	LOCAL	EN_CURSO	2026-03-15 15:30:00	BAJA	16	1	URGENTE	4	\N
283	LOCAL	CANCELADA	2026-02-06 11:00:00	MEDIA	3	2	URGENTE	1	\N
285	REGIONAL	PROGRAMADA	2026-02-10 08:00:00	BAJA	3	1	ELECTIVA	1	\N
288	LOCAL	FINALIZADA	2026-03-14 11:30:00	MEDIA	11	3	URGENTE	3	\N
291	LOCAL	EN_CURSO	2026-04-25 10:00:00	MEDIA	10	1	URGENTE	1	\N
256	SEDACION	FINALIZADA	2026-02-06 08:30:00	MEDIA	8	2	PROGRAMADA	1	\N
298	GENERAL	CANCELADA	2026-04-29 08:00:00	BAJA	20	1	AMBULATORIA	2	\N
305		CANCELADA	2026-04-29 10:00:00		2	1		2	\N
308	LOCAL	CANCELADA	2026-04-29 08:00:00	ALTA	3	1		1	\N
310	LOCAL	CANCELADA	2026-05-05 10:00:00	MEDIA	1	1	ELECTIVA	1	\N
312	GENERAL	FINALIZADA	2026-05-09 08:00:00	ALTA	10	1	ELECTIVA	2	\N
253	REGIONAL	FINALIZADA	2026-02-06 08:30:00	MEDIA	7	1	AMBULATORIA	2	\N
252	REGIONAL	CANCELADA	2026-02-09 09:00:00	MEDIA	14	1	PROGRAMADA	4	\N
266	REGIONAL	PROGRAMADA	2026-03-15 12:00:00	MEDIA	25	1	PROGRAMADA	10	\N
274	GENERAL	PROGRAMADA	2026-03-13 12:00:00	MEDIA	12	1		4	\N
278	GENERAL	FINALIZADA	2026-03-16 09:00:00	MEDIA	10	3	URGENTE	3	\N
282	REGIONAL	CANCELADA	2026-02-06 11:00:00	BAJA	3	2	ELECTIVA	1	\N
284	LOCAL	EN_CURSO	2026-03-15 11:30:00	MEDIA	10	3	URGENTE	3	\N
273	GENERAL	CANCELADA	2026-03-12 09:00:00	ALTA	7	3		4	\N
289	REGIONAL	PROGRAMADA	2026-02-10 08:00:00	BAJA	3	1	URGENTE	1	\N
292	GENERAL	EN_CURSO	2026-04-25 08:00:00	MEDIA	13	2	ELECTIVA	5	\N
295	LOCAL	CANCELADA	2026-04-29 14:30:00	MEDIA	12	3	URGENTE	4	\N
302	GENERAL	CANCELADA	2026-04-30 08:00:00	ALTA	3	1	AMBULATORIA	2	\N
286	LOCAL	CANCELADA	2026-03-17 14:30:00	ALTA	1	3	URGENTE	3	\N
306	LOCAL	EN_CURSO	2026-04-29 10:30:00	ALTA	7	1		1	\N
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
7196ea6b-8216-4773-a2ab-de3c674db4c7	t	f	master-realm	0	f	\N	\N	t	\N	f	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
3853b62d-0671-4bb5-9980-a8724355460a	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
cc39bee7-2e22-4ec7-96e6-47f3b38f88ad	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
a18c5734-736b-4ca6-b5b7-8387d03e25ab	t	f	broker	0	f	\N	\N	t	\N	f	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
bf31eec8-25de-4851-8df5-e95fdbad8878	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
e86e970e-7194-47eb-9bcc-a636869d14b6	t	t	admin-cli	0	t	\N	\N	f	\N	f	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
6f7c43c3-7963-4bdd-9997-3869cfd54951	t	f	dacs-realm	0	f	\N	\N	t	\N	f	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	\N	0	f	f	dacs Realm	f	client-secret	\N	\N	\N	t	f	f	f
dad7d20e-96d4-47c9-a64a-8ed9c833b897	t	f	realm-management	0	f	\N	\N	t	\N	f	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
6178dd03-ea93-491b-9340-c44abcfe617c	t	f	account-console	0	t	\N	/realms/dacs/account/	f	\N	f	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
3aa1c395-bec1-4dc4-ade2-eb0f964f3897	t	f	broker	0	f	\N	\N	t	\N	f	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
8b815c6c-80ec-4263-aa9e-c2f015ffd4c7	t	t	security-admin-console	0	t	\N	/admin/dacs/console/	f	\N	f	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
ca473b61-7d9f-466c-9b48-7bd0d4759732	t	t	admin-cli	0	t	\N	\N	f	\N	f	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	t	t	dacs-fe	0	t	\N	http://localhost:4200	f	http://localhost:4200	f	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	openid-connect	-1	t	f	DACS FE	f	client-secret	http://localhost:4200		\N	t	f	f	f
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	t	f	account	0	t	\N	/realms/dacs/account/	f		f	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}		\N	t	f	f	f
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	t	t	dacs-app	0	t	\N	https://dacs2025.local/dacsapp/home	f	https://dacs2025.local/dacsapp	f	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	openid-connect	-1	t	f	DACS	f	client-secret	https://dacs2025.local/dacsapp		\N	t	f	f	f
02d538de-9d35-440d-a6cf-a6fe61f33904	t	t	dacs-bff	0	f	L9o1XhvkpPRVKh6ut7ncHGkAl0azC7tj	https://dacs2025.local/dacsapp	f	https://dacs2025.local/dacsapp	f	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	openid-connect	-1	t	f	DACS BFF	t	client-secret	https://dacs2025.local/dacsapp	DACS BFF	\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
3853b62d-0671-4bb5-9980-a8724355460a	post.logout.redirect.uris	+
cc39bee7-2e22-4ec7-96e6-47f3b38f88ad	post.logout.redirect.uris	+
cc39bee7-2e22-4ec7-96e6-47f3b38f88ad	pkce.code.challenge.method	S256
bf31eec8-25de-4851-8df5-e95fdbad8878	post.logout.redirect.uris	+
bf31eec8-25de-4851-8df5-e95fdbad8878	pkce.code.challenge.method	S256
bf31eec8-25de-4851-8df5-e95fdbad8878	client.use.lightweight.access.token.enabled	true
e86e970e-7194-47eb-9bcc-a636869d14b6	client.use.lightweight.access.token.enabled	true
6178dd03-ea93-491b-9340-c44abcfe617c	post.logout.redirect.uris	+
6178dd03-ea93-491b-9340-c44abcfe617c	pkce.code.challenge.method	S256
8b815c6c-80ec-4263-aa9e-c2f015ffd4c7	post.logout.redirect.uris	+
8b815c6c-80ec-4263-aa9e-c2f015ffd4c7	pkce.code.challenge.method	S256
8b815c6c-80ec-4263-aa9e-c2f015ffd4c7	client.use.lightweight.access.token.enabled	true
ca473b61-7d9f-466c-9b48-7bd0d4759732	client.use.lightweight.access.token.enabled	true
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	standard.token.exchange.enabled	false
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	oauth2.device.authorization.grant.enabled	false
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	oidc.ciba.grant.enabled	false
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	pkce.code.challenge.method	S256
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	dpop.bound.access.tokens	false
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	post.logout.redirect.uris	https://dacs2025.local/dacsapp/*
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	backchannel.logout.session.required	true
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	backchannel.logout.revoke.offline.tokens	false
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	realm_client	false
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	display.on.consent.screen	false
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	frontchannel.logout.session.required	true
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	standard.token.exchange.enabled	false
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	oauth2.device.authorization.grant.enabled	false
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	oidc.ciba.grant.enabled	false
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	pkce.code.challenge.method	S256
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	dpop.bound.access.tokens	false
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	post.logout.redirect.uris	http://localhost:4200/*
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	backchannel.logout.session.required	true
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	backchannel.logout.revoke.offline.tokens	false
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	realm_client	false
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	display.on.consent.screen	false
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	frontchannel.logout.session.required	true
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	login_theme	keycloak
02d538de-9d35-440d-a6cf-a6fe61f33904	client.secret.creation.time	1763061812
02d538de-9d35-440d-a6cf-a6fe61f33904	standard.token.exchange.enabled	false
02d538de-9d35-440d-a6cf-a6fe61f33904	oauth2.device.authorization.grant.enabled	false
02d538de-9d35-440d-a6cf-a6fe61f33904	oidc.ciba.grant.enabled	false
02d538de-9d35-440d-a6cf-a6fe61f33904	pkce.code.challenge.method	S256
02d538de-9d35-440d-a6cf-a6fe61f33904	dpop.bound.access.tokens	false
02d538de-9d35-440d-a6cf-a6fe61f33904	post.logout.redirect.uris	https://dacs2025.local/dacsapp
02d538de-9d35-440d-a6cf-a6fe61f33904	backchannel.logout.session.required	true
02d538de-9d35-440d-a6cf-a6fe61f33904	backchannel.logout.revoke.offline.tokens	false
02d538de-9d35-440d-a6cf-a6fe61f33904	realm_client	false
02d538de-9d35-440d-a6cf-a6fe61f33904	display.on.consent.screen	false
02d538de-9d35-440d-a6cf-a6fe61f33904	frontchannel.logout.session.required	true
02d538de-9d35-440d-a6cf-a6fe61f33904	logout.confirmation.enabled	false
02d538de-9d35-440d-a6cf-a6fe61f33904	use.jwks.url	false
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	logout.confirmation.enabled	false
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	realm_client	false
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	standard.token.exchange.enabled	false
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	oauth2.device.authorization.grant.enabled	false
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	oidc.ciba.grant.enabled	false
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	dpop.bound.access.tokens	false
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	display.on.consent.screen	false
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	backchannel.logout.session.required	false
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	backchannel.logout.revoke.offline.tokens	false
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	logout.confirmation.enabled	false
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	post.logout.redirect.uris	+
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
57a2e151-26f8-450e-b005-0602dbb8a225	offline_access	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	OpenID Connect built-in scope: offline_access	openid-connect
9f928ed9-bf85-4eab-b6af-ef3e3a1fcb6b	role_list	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	SAML role list	saml
6eaf9b37-dcac-4ec2-89b9-0d52ad20ae49	saml_organization	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	Organization Membership	saml
762e75d9-0f85-4428-9f61-dd29b70fbca7	profile	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	OpenID Connect built-in scope: profile	openid-connect
31343b91-30b1-4820-badb-3fdb3bd99344	email	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	OpenID Connect built-in scope: email	openid-connect
576c8bc9-0e41-41ad-ad3a-e4e08b1e136c	address	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	OpenID Connect built-in scope: address	openid-connect
3c2019e4-c7d8-4baa-8468-1fdfae651ed3	phone	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	OpenID Connect built-in scope: phone	openid-connect
9c785d74-50ff-459f-9516-adb26979d24d	roles	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	OpenID Connect scope for add user roles to the access token	openid-connect
5dd71a61-adff-44c0-8cac-6308d473a68c	web-origins	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	OpenID Connect scope for add allowed web origins to the access token	openid-connect
84040f67-5a1f-4a3d-ab25-9a5c40ba8cd1	microprofile-jwt	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	Microprofile - JWT built-in scope	openid-connect
f8762493-840b-42b4-8416-20d2e2e9546e	acr	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
1203ff0f-5a41-4afc-9dd0-82038219797a	basic	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	OpenID Connect scope for add all basic claims to the token	openid-connect
f50f4215-18b8-4354-95b8-1876d0ff3464	service_account	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	Specific scope for a client enabled for service accounts	openid-connect
94252ff3-4947-43fd-a72d-51f3b111c925	organization	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	Additional claims about the organization a subject belongs to	openid-connect
34982ee3-5e7d-4b38-aa4b-9007a7e9047d	offline_access	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	OpenID Connect built-in scope: offline_access	openid-connect
2d143538-2878-4812-be3b-3f75a9564ae1	role_list	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	SAML role list	saml
b9e06341-04a2-4151-86b3-2cf13abc8a72	saml_organization	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	Organization Membership	saml
eb8ffb5e-641e-42da-ab1a-f8948abf85aa	profile	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	OpenID Connect built-in scope: profile	openid-connect
73a899b2-50be-43ba-b233-4f9b0f856306	email	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	OpenID Connect built-in scope: email	openid-connect
88508b6c-f1a9-4677-bc83-cd819ffbd95a	address	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	OpenID Connect built-in scope: address	openid-connect
4b6c1f65-c316-41dc-816f-410ba75388f7	phone	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	OpenID Connect built-in scope: phone	openid-connect
6cd790ae-baff-47a2-a0e1-3c775ee20d3e	roles	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	OpenID Connect scope for add user roles to the access token	openid-connect
599c40ac-4f06-4952-b50a-5bce8d372b5e	web-origins	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	OpenID Connect scope for add allowed web origins to the access token	openid-connect
f80d7182-f104-4a13-9334-e5b9d8be1b6f	microprofile-jwt	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	Microprofile - JWT built-in scope	openid-connect
795a4fcb-21b3-4b2f-b8e7-e9964b1f9686	acr	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
21b289c4-86ab-46da-b930-5c0f30be7a34	basic	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	OpenID Connect scope for add all basic claims to the token	openid-connect
0cce9e54-0935-4ea2-affd-807266f1e4dd	service_account	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	Specific scope for a client enabled for service accounts	openid-connect
72e16833-952b-46a6-a583-a8c462a2cdac	organization	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	Additional claims about the organization a subject belongs to	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
57a2e151-26f8-450e-b005-0602dbb8a225	true	display.on.consent.screen
57a2e151-26f8-450e-b005-0602dbb8a225	${offlineAccessScopeConsentText}	consent.screen.text
9f928ed9-bf85-4eab-b6af-ef3e3a1fcb6b	true	display.on.consent.screen
9f928ed9-bf85-4eab-b6af-ef3e3a1fcb6b	${samlRoleListScopeConsentText}	consent.screen.text
6eaf9b37-dcac-4ec2-89b9-0d52ad20ae49	false	display.on.consent.screen
762e75d9-0f85-4428-9f61-dd29b70fbca7	true	display.on.consent.screen
762e75d9-0f85-4428-9f61-dd29b70fbca7	${profileScopeConsentText}	consent.screen.text
762e75d9-0f85-4428-9f61-dd29b70fbca7	true	include.in.token.scope
31343b91-30b1-4820-badb-3fdb3bd99344	true	display.on.consent.screen
31343b91-30b1-4820-badb-3fdb3bd99344	${emailScopeConsentText}	consent.screen.text
31343b91-30b1-4820-badb-3fdb3bd99344	true	include.in.token.scope
576c8bc9-0e41-41ad-ad3a-e4e08b1e136c	true	display.on.consent.screen
576c8bc9-0e41-41ad-ad3a-e4e08b1e136c	${addressScopeConsentText}	consent.screen.text
576c8bc9-0e41-41ad-ad3a-e4e08b1e136c	true	include.in.token.scope
3c2019e4-c7d8-4baa-8468-1fdfae651ed3	true	display.on.consent.screen
3c2019e4-c7d8-4baa-8468-1fdfae651ed3	${phoneScopeConsentText}	consent.screen.text
3c2019e4-c7d8-4baa-8468-1fdfae651ed3	true	include.in.token.scope
9c785d74-50ff-459f-9516-adb26979d24d	true	display.on.consent.screen
9c785d74-50ff-459f-9516-adb26979d24d	${rolesScopeConsentText}	consent.screen.text
9c785d74-50ff-459f-9516-adb26979d24d	false	include.in.token.scope
5dd71a61-adff-44c0-8cac-6308d473a68c	false	display.on.consent.screen
5dd71a61-adff-44c0-8cac-6308d473a68c		consent.screen.text
5dd71a61-adff-44c0-8cac-6308d473a68c	false	include.in.token.scope
84040f67-5a1f-4a3d-ab25-9a5c40ba8cd1	false	display.on.consent.screen
84040f67-5a1f-4a3d-ab25-9a5c40ba8cd1	true	include.in.token.scope
f8762493-840b-42b4-8416-20d2e2e9546e	false	display.on.consent.screen
f8762493-840b-42b4-8416-20d2e2e9546e	false	include.in.token.scope
1203ff0f-5a41-4afc-9dd0-82038219797a	false	display.on.consent.screen
1203ff0f-5a41-4afc-9dd0-82038219797a	false	include.in.token.scope
f50f4215-18b8-4354-95b8-1876d0ff3464	false	display.on.consent.screen
f50f4215-18b8-4354-95b8-1876d0ff3464	false	include.in.token.scope
94252ff3-4947-43fd-a72d-51f3b111c925	true	display.on.consent.screen
94252ff3-4947-43fd-a72d-51f3b111c925	${organizationScopeConsentText}	consent.screen.text
94252ff3-4947-43fd-a72d-51f3b111c925	true	include.in.token.scope
34982ee3-5e7d-4b38-aa4b-9007a7e9047d	true	display.on.consent.screen
34982ee3-5e7d-4b38-aa4b-9007a7e9047d	${offlineAccessScopeConsentText}	consent.screen.text
2d143538-2878-4812-be3b-3f75a9564ae1	true	display.on.consent.screen
2d143538-2878-4812-be3b-3f75a9564ae1	${samlRoleListScopeConsentText}	consent.screen.text
b9e06341-04a2-4151-86b3-2cf13abc8a72	false	display.on.consent.screen
eb8ffb5e-641e-42da-ab1a-f8948abf85aa	true	display.on.consent.screen
eb8ffb5e-641e-42da-ab1a-f8948abf85aa	${profileScopeConsentText}	consent.screen.text
eb8ffb5e-641e-42da-ab1a-f8948abf85aa	true	include.in.token.scope
73a899b2-50be-43ba-b233-4f9b0f856306	true	display.on.consent.screen
73a899b2-50be-43ba-b233-4f9b0f856306	${emailScopeConsentText}	consent.screen.text
73a899b2-50be-43ba-b233-4f9b0f856306	true	include.in.token.scope
88508b6c-f1a9-4677-bc83-cd819ffbd95a	true	display.on.consent.screen
88508b6c-f1a9-4677-bc83-cd819ffbd95a	${addressScopeConsentText}	consent.screen.text
88508b6c-f1a9-4677-bc83-cd819ffbd95a	true	include.in.token.scope
4b6c1f65-c316-41dc-816f-410ba75388f7	true	display.on.consent.screen
4b6c1f65-c316-41dc-816f-410ba75388f7	${phoneScopeConsentText}	consent.screen.text
4b6c1f65-c316-41dc-816f-410ba75388f7	true	include.in.token.scope
6cd790ae-baff-47a2-a0e1-3c775ee20d3e	true	display.on.consent.screen
6cd790ae-baff-47a2-a0e1-3c775ee20d3e	${rolesScopeConsentText}	consent.screen.text
6cd790ae-baff-47a2-a0e1-3c775ee20d3e	false	include.in.token.scope
599c40ac-4f06-4952-b50a-5bce8d372b5e	false	display.on.consent.screen
599c40ac-4f06-4952-b50a-5bce8d372b5e		consent.screen.text
599c40ac-4f06-4952-b50a-5bce8d372b5e	false	include.in.token.scope
f80d7182-f104-4a13-9334-e5b9d8be1b6f	false	display.on.consent.screen
f80d7182-f104-4a13-9334-e5b9d8be1b6f	true	include.in.token.scope
795a4fcb-21b3-4b2f-b8e7-e9964b1f9686	false	display.on.consent.screen
795a4fcb-21b3-4b2f-b8e7-e9964b1f9686	false	include.in.token.scope
21b289c4-86ab-46da-b930-5c0f30be7a34	false	display.on.consent.screen
21b289c4-86ab-46da-b930-5c0f30be7a34	false	include.in.token.scope
0cce9e54-0935-4ea2-affd-807266f1e4dd	false	display.on.consent.screen
0cce9e54-0935-4ea2-affd-807266f1e4dd	false	include.in.token.scope
72e16833-952b-46a6-a583-a8c462a2cdac	true	display.on.consent.screen
72e16833-952b-46a6-a583-a8c462a2cdac	${organizationScopeConsentText}	consent.screen.text
72e16833-952b-46a6-a583-a8c462a2cdac	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
3853b62d-0671-4bb5-9980-a8724355460a	9c785d74-50ff-459f-9516-adb26979d24d	t
3853b62d-0671-4bb5-9980-a8724355460a	5dd71a61-adff-44c0-8cac-6308d473a68c	t
3853b62d-0671-4bb5-9980-a8724355460a	f8762493-840b-42b4-8416-20d2e2e9546e	t
3853b62d-0671-4bb5-9980-a8724355460a	1203ff0f-5a41-4afc-9dd0-82038219797a	t
3853b62d-0671-4bb5-9980-a8724355460a	762e75d9-0f85-4428-9f61-dd29b70fbca7	t
3853b62d-0671-4bb5-9980-a8724355460a	31343b91-30b1-4820-badb-3fdb3bd99344	t
3853b62d-0671-4bb5-9980-a8724355460a	3c2019e4-c7d8-4baa-8468-1fdfae651ed3	f
3853b62d-0671-4bb5-9980-a8724355460a	84040f67-5a1f-4a3d-ab25-9a5c40ba8cd1	f
3853b62d-0671-4bb5-9980-a8724355460a	94252ff3-4947-43fd-a72d-51f3b111c925	f
3853b62d-0671-4bb5-9980-a8724355460a	57a2e151-26f8-450e-b005-0602dbb8a225	f
3853b62d-0671-4bb5-9980-a8724355460a	576c8bc9-0e41-41ad-ad3a-e4e08b1e136c	f
cc39bee7-2e22-4ec7-96e6-47f3b38f88ad	9c785d74-50ff-459f-9516-adb26979d24d	t
cc39bee7-2e22-4ec7-96e6-47f3b38f88ad	5dd71a61-adff-44c0-8cac-6308d473a68c	t
cc39bee7-2e22-4ec7-96e6-47f3b38f88ad	f8762493-840b-42b4-8416-20d2e2e9546e	t
cc39bee7-2e22-4ec7-96e6-47f3b38f88ad	1203ff0f-5a41-4afc-9dd0-82038219797a	t
cc39bee7-2e22-4ec7-96e6-47f3b38f88ad	762e75d9-0f85-4428-9f61-dd29b70fbca7	t
cc39bee7-2e22-4ec7-96e6-47f3b38f88ad	31343b91-30b1-4820-badb-3fdb3bd99344	t
cc39bee7-2e22-4ec7-96e6-47f3b38f88ad	3c2019e4-c7d8-4baa-8468-1fdfae651ed3	f
cc39bee7-2e22-4ec7-96e6-47f3b38f88ad	84040f67-5a1f-4a3d-ab25-9a5c40ba8cd1	f
cc39bee7-2e22-4ec7-96e6-47f3b38f88ad	94252ff3-4947-43fd-a72d-51f3b111c925	f
cc39bee7-2e22-4ec7-96e6-47f3b38f88ad	57a2e151-26f8-450e-b005-0602dbb8a225	f
cc39bee7-2e22-4ec7-96e6-47f3b38f88ad	576c8bc9-0e41-41ad-ad3a-e4e08b1e136c	f
e86e970e-7194-47eb-9bcc-a636869d14b6	9c785d74-50ff-459f-9516-adb26979d24d	t
e86e970e-7194-47eb-9bcc-a636869d14b6	5dd71a61-adff-44c0-8cac-6308d473a68c	t
e86e970e-7194-47eb-9bcc-a636869d14b6	f8762493-840b-42b4-8416-20d2e2e9546e	t
e86e970e-7194-47eb-9bcc-a636869d14b6	1203ff0f-5a41-4afc-9dd0-82038219797a	t
e86e970e-7194-47eb-9bcc-a636869d14b6	762e75d9-0f85-4428-9f61-dd29b70fbca7	t
e86e970e-7194-47eb-9bcc-a636869d14b6	31343b91-30b1-4820-badb-3fdb3bd99344	t
e86e970e-7194-47eb-9bcc-a636869d14b6	3c2019e4-c7d8-4baa-8468-1fdfae651ed3	f
e86e970e-7194-47eb-9bcc-a636869d14b6	84040f67-5a1f-4a3d-ab25-9a5c40ba8cd1	f
e86e970e-7194-47eb-9bcc-a636869d14b6	94252ff3-4947-43fd-a72d-51f3b111c925	f
e86e970e-7194-47eb-9bcc-a636869d14b6	57a2e151-26f8-450e-b005-0602dbb8a225	f
e86e970e-7194-47eb-9bcc-a636869d14b6	576c8bc9-0e41-41ad-ad3a-e4e08b1e136c	f
a18c5734-736b-4ca6-b5b7-8387d03e25ab	9c785d74-50ff-459f-9516-adb26979d24d	t
a18c5734-736b-4ca6-b5b7-8387d03e25ab	5dd71a61-adff-44c0-8cac-6308d473a68c	t
a18c5734-736b-4ca6-b5b7-8387d03e25ab	f8762493-840b-42b4-8416-20d2e2e9546e	t
a18c5734-736b-4ca6-b5b7-8387d03e25ab	1203ff0f-5a41-4afc-9dd0-82038219797a	t
a18c5734-736b-4ca6-b5b7-8387d03e25ab	762e75d9-0f85-4428-9f61-dd29b70fbca7	t
a18c5734-736b-4ca6-b5b7-8387d03e25ab	31343b91-30b1-4820-badb-3fdb3bd99344	t
a18c5734-736b-4ca6-b5b7-8387d03e25ab	3c2019e4-c7d8-4baa-8468-1fdfae651ed3	f
a18c5734-736b-4ca6-b5b7-8387d03e25ab	84040f67-5a1f-4a3d-ab25-9a5c40ba8cd1	f
a18c5734-736b-4ca6-b5b7-8387d03e25ab	94252ff3-4947-43fd-a72d-51f3b111c925	f
a18c5734-736b-4ca6-b5b7-8387d03e25ab	57a2e151-26f8-450e-b005-0602dbb8a225	f
a18c5734-736b-4ca6-b5b7-8387d03e25ab	576c8bc9-0e41-41ad-ad3a-e4e08b1e136c	f
7196ea6b-8216-4773-a2ab-de3c674db4c7	9c785d74-50ff-459f-9516-adb26979d24d	t
7196ea6b-8216-4773-a2ab-de3c674db4c7	5dd71a61-adff-44c0-8cac-6308d473a68c	t
7196ea6b-8216-4773-a2ab-de3c674db4c7	f8762493-840b-42b4-8416-20d2e2e9546e	t
7196ea6b-8216-4773-a2ab-de3c674db4c7	1203ff0f-5a41-4afc-9dd0-82038219797a	t
7196ea6b-8216-4773-a2ab-de3c674db4c7	762e75d9-0f85-4428-9f61-dd29b70fbca7	t
7196ea6b-8216-4773-a2ab-de3c674db4c7	31343b91-30b1-4820-badb-3fdb3bd99344	t
7196ea6b-8216-4773-a2ab-de3c674db4c7	3c2019e4-c7d8-4baa-8468-1fdfae651ed3	f
7196ea6b-8216-4773-a2ab-de3c674db4c7	84040f67-5a1f-4a3d-ab25-9a5c40ba8cd1	f
7196ea6b-8216-4773-a2ab-de3c674db4c7	94252ff3-4947-43fd-a72d-51f3b111c925	f
7196ea6b-8216-4773-a2ab-de3c674db4c7	57a2e151-26f8-450e-b005-0602dbb8a225	f
7196ea6b-8216-4773-a2ab-de3c674db4c7	576c8bc9-0e41-41ad-ad3a-e4e08b1e136c	f
bf31eec8-25de-4851-8df5-e95fdbad8878	9c785d74-50ff-459f-9516-adb26979d24d	t
bf31eec8-25de-4851-8df5-e95fdbad8878	5dd71a61-adff-44c0-8cac-6308d473a68c	t
bf31eec8-25de-4851-8df5-e95fdbad8878	f8762493-840b-42b4-8416-20d2e2e9546e	t
bf31eec8-25de-4851-8df5-e95fdbad8878	1203ff0f-5a41-4afc-9dd0-82038219797a	t
bf31eec8-25de-4851-8df5-e95fdbad8878	762e75d9-0f85-4428-9f61-dd29b70fbca7	t
bf31eec8-25de-4851-8df5-e95fdbad8878	31343b91-30b1-4820-badb-3fdb3bd99344	t
bf31eec8-25de-4851-8df5-e95fdbad8878	3c2019e4-c7d8-4baa-8468-1fdfae651ed3	f
bf31eec8-25de-4851-8df5-e95fdbad8878	84040f67-5a1f-4a3d-ab25-9a5c40ba8cd1	f
bf31eec8-25de-4851-8df5-e95fdbad8878	94252ff3-4947-43fd-a72d-51f3b111c925	f
bf31eec8-25de-4851-8df5-e95fdbad8878	57a2e151-26f8-450e-b005-0602dbb8a225	f
bf31eec8-25de-4851-8df5-e95fdbad8878	576c8bc9-0e41-41ad-ad3a-e4e08b1e136c	f
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	795a4fcb-21b3-4b2f-b8e7-e9964b1f9686	t
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	73a899b2-50be-43ba-b233-4f9b0f856306	t
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	6cd790ae-baff-47a2-a0e1-3c775ee20d3e	t
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	21b289c4-86ab-46da-b930-5c0f30be7a34	t
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	599c40ac-4f06-4952-b50a-5bce8d372b5e	t
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	eb8ffb5e-641e-42da-ab1a-f8948abf85aa	t
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	72e16833-952b-46a6-a583-a8c462a2cdac	f
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	34982ee3-5e7d-4b38-aa4b-9007a7e9047d	f
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	88508b6c-f1a9-4677-bc83-cd819ffbd95a	f
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	f80d7182-f104-4a13-9334-e5b9d8be1b6f	f
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	4b6c1f65-c316-41dc-816f-410ba75388f7	f
6178dd03-ea93-491b-9340-c44abcfe617c	795a4fcb-21b3-4b2f-b8e7-e9964b1f9686	t
6178dd03-ea93-491b-9340-c44abcfe617c	73a899b2-50be-43ba-b233-4f9b0f856306	t
6178dd03-ea93-491b-9340-c44abcfe617c	6cd790ae-baff-47a2-a0e1-3c775ee20d3e	t
6178dd03-ea93-491b-9340-c44abcfe617c	21b289c4-86ab-46da-b930-5c0f30be7a34	t
6178dd03-ea93-491b-9340-c44abcfe617c	599c40ac-4f06-4952-b50a-5bce8d372b5e	t
6178dd03-ea93-491b-9340-c44abcfe617c	eb8ffb5e-641e-42da-ab1a-f8948abf85aa	t
6178dd03-ea93-491b-9340-c44abcfe617c	72e16833-952b-46a6-a583-a8c462a2cdac	f
6178dd03-ea93-491b-9340-c44abcfe617c	34982ee3-5e7d-4b38-aa4b-9007a7e9047d	f
6178dd03-ea93-491b-9340-c44abcfe617c	88508b6c-f1a9-4677-bc83-cd819ffbd95a	f
6178dd03-ea93-491b-9340-c44abcfe617c	f80d7182-f104-4a13-9334-e5b9d8be1b6f	f
6178dd03-ea93-491b-9340-c44abcfe617c	4b6c1f65-c316-41dc-816f-410ba75388f7	f
ca473b61-7d9f-466c-9b48-7bd0d4759732	795a4fcb-21b3-4b2f-b8e7-e9964b1f9686	t
ca473b61-7d9f-466c-9b48-7bd0d4759732	73a899b2-50be-43ba-b233-4f9b0f856306	t
ca473b61-7d9f-466c-9b48-7bd0d4759732	6cd790ae-baff-47a2-a0e1-3c775ee20d3e	t
ca473b61-7d9f-466c-9b48-7bd0d4759732	21b289c4-86ab-46da-b930-5c0f30be7a34	t
ca473b61-7d9f-466c-9b48-7bd0d4759732	599c40ac-4f06-4952-b50a-5bce8d372b5e	t
ca473b61-7d9f-466c-9b48-7bd0d4759732	eb8ffb5e-641e-42da-ab1a-f8948abf85aa	t
ca473b61-7d9f-466c-9b48-7bd0d4759732	72e16833-952b-46a6-a583-a8c462a2cdac	f
ca473b61-7d9f-466c-9b48-7bd0d4759732	34982ee3-5e7d-4b38-aa4b-9007a7e9047d	f
ca473b61-7d9f-466c-9b48-7bd0d4759732	88508b6c-f1a9-4677-bc83-cd819ffbd95a	f
ca473b61-7d9f-466c-9b48-7bd0d4759732	f80d7182-f104-4a13-9334-e5b9d8be1b6f	f
ca473b61-7d9f-466c-9b48-7bd0d4759732	4b6c1f65-c316-41dc-816f-410ba75388f7	f
3aa1c395-bec1-4dc4-ade2-eb0f964f3897	795a4fcb-21b3-4b2f-b8e7-e9964b1f9686	t
3aa1c395-bec1-4dc4-ade2-eb0f964f3897	73a899b2-50be-43ba-b233-4f9b0f856306	t
3aa1c395-bec1-4dc4-ade2-eb0f964f3897	6cd790ae-baff-47a2-a0e1-3c775ee20d3e	t
3aa1c395-bec1-4dc4-ade2-eb0f964f3897	21b289c4-86ab-46da-b930-5c0f30be7a34	t
3aa1c395-bec1-4dc4-ade2-eb0f964f3897	599c40ac-4f06-4952-b50a-5bce8d372b5e	t
3aa1c395-bec1-4dc4-ade2-eb0f964f3897	eb8ffb5e-641e-42da-ab1a-f8948abf85aa	t
3aa1c395-bec1-4dc4-ade2-eb0f964f3897	72e16833-952b-46a6-a583-a8c462a2cdac	f
3aa1c395-bec1-4dc4-ade2-eb0f964f3897	34982ee3-5e7d-4b38-aa4b-9007a7e9047d	f
3aa1c395-bec1-4dc4-ade2-eb0f964f3897	88508b6c-f1a9-4677-bc83-cd819ffbd95a	f
3aa1c395-bec1-4dc4-ade2-eb0f964f3897	f80d7182-f104-4a13-9334-e5b9d8be1b6f	f
3aa1c395-bec1-4dc4-ade2-eb0f964f3897	4b6c1f65-c316-41dc-816f-410ba75388f7	f
dad7d20e-96d4-47c9-a64a-8ed9c833b897	795a4fcb-21b3-4b2f-b8e7-e9964b1f9686	t
dad7d20e-96d4-47c9-a64a-8ed9c833b897	73a899b2-50be-43ba-b233-4f9b0f856306	t
dad7d20e-96d4-47c9-a64a-8ed9c833b897	6cd790ae-baff-47a2-a0e1-3c775ee20d3e	t
dad7d20e-96d4-47c9-a64a-8ed9c833b897	21b289c4-86ab-46da-b930-5c0f30be7a34	t
dad7d20e-96d4-47c9-a64a-8ed9c833b897	599c40ac-4f06-4952-b50a-5bce8d372b5e	t
dad7d20e-96d4-47c9-a64a-8ed9c833b897	eb8ffb5e-641e-42da-ab1a-f8948abf85aa	t
dad7d20e-96d4-47c9-a64a-8ed9c833b897	72e16833-952b-46a6-a583-a8c462a2cdac	f
dad7d20e-96d4-47c9-a64a-8ed9c833b897	34982ee3-5e7d-4b38-aa4b-9007a7e9047d	f
dad7d20e-96d4-47c9-a64a-8ed9c833b897	88508b6c-f1a9-4677-bc83-cd819ffbd95a	f
dad7d20e-96d4-47c9-a64a-8ed9c833b897	f80d7182-f104-4a13-9334-e5b9d8be1b6f	f
dad7d20e-96d4-47c9-a64a-8ed9c833b897	4b6c1f65-c316-41dc-816f-410ba75388f7	f
8b815c6c-80ec-4263-aa9e-c2f015ffd4c7	795a4fcb-21b3-4b2f-b8e7-e9964b1f9686	t
8b815c6c-80ec-4263-aa9e-c2f015ffd4c7	73a899b2-50be-43ba-b233-4f9b0f856306	t
8b815c6c-80ec-4263-aa9e-c2f015ffd4c7	6cd790ae-baff-47a2-a0e1-3c775ee20d3e	t
8b815c6c-80ec-4263-aa9e-c2f015ffd4c7	21b289c4-86ab-46da-b930-5c0f30be7a34	t
8b815c6c-80ec-4263-aa9e-c2f015ffd4c7	599c40ac-4f06-4952-b50a-5bce8d372b5e	t
8b815c6c-80ec-4263-aa9e-c2f015ffd4c7	eb8ffb5e-641e-42da-ab1a-f8948abf85aa	t
8b815c6c-80ec-4263-aa9e-c2f015ffd4c7	72e16833-952b-46a6-a583-a8c462a2cdac	f
8b815c6c-80ec-4263-aa9e-c2f015ffd4c7	34982ee3-5e7d-4b38-aa4b-9007a7e9047d	f
8b815c6c-80ec-4263-aa9e-c2f015ffd4c7	88508b6c-f1a9-4677-bc83-cd819ffbd95a	f
8b815c6c-80ec-4263-aa9e-c2f015ffd4c7	f80d7182-f104-4a13-9334-e5b9d8be1b6f	f
8b815c6c-80ec-4263-aa9e-c2f015ffd4c7	4b6c1f65-c316-41dc-816f-410ba75388f7	f
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	795a4fcb-21b3-4b2f-b8e7-e9964b1f9686	t
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	73a899b2-50be-43ba-b233-4f9b0f856306	t
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	6cd790ae-baff-47a2-a0e1-3c775ee20d3e	t
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	21b289c4-86ab-46da-b930-5c0f30be7a34	t
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	599c40ac-4f06-4952-b50a-5bce8d372b5e	t
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	eb8ffb5e-641e-42da-ab1a-f8948abf85aa	t
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	72e16833-952b-46a6-a583-a8c462a2cdac	f
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	34982ee3-5e7d-4b38-aa4b-9007a7e9047d	f
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	88508b6c-f1a9-4677-bc83-cd819ffbd95a	f
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	f80d7182-f104-4a13-9334-e5b9d8be1b6f	f
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	4b6c1f65-c316-41dc-816f-410ba75388f7	f
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	795a4fcb-21b3-4b2f-b8e7-e9964b1f9686	t
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	73a899b2-50be-43ba-b233-4f9b0f856306	t
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	6cd790ae-baff-47a2-a0e1-3c775ee20d3e	t
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	21b289c4-86ab-46da-b930-5c0f30be7a34	t
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	599c40ac-4f06-4952-b50a-5bce8d372b5e	t
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	eb8ffb5e-641e-42da-ab1a-f8948abf85aa	t
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	72e16833-952b-46a6-a583-a8c462a2cdac	f
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	34982ee3-5e7d-4b38-aa4b-9007a7e9047d	f
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	88508b6c-f1a9-4677-bc83-cd819ffbd95a	f
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	f80d7182-f104-4a13-9334-e5b9d8be1b6f	f
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	4b6c1f65-c316-41dc-816f-410ba75388f7	f
02d538de-9d35-440d-a6cf-a6fe61f33904	795a4fcb-21b3-4b2f-b8e7-e9964b1f9686	t
02d538de-9d35-440d-a6cf-a6fe61f33904	73a899b2-50be-43ba-b233-4f9b0f856306	t
02d538de-9d35-440d-a6cf-a6fe61f33904	6cd790ae-baff-47a2-a0e1-3c775ee20d3e	t
02d538de-9d35-440d-a6cf-a6fe61f33904	21b289c4-86ab-46da-b930-5c0f30be7a34	t
02d538de-9d35-440d-a6cf-a6fe61f33904	599c40ac-4f06-4952-b50a-5bce8d372b5e	t
02d538de-9d35-440d-a6cf-a6fe61f33904	eb8ffb5e-641e-42da-ab1a-f8948abf85aa	t
02d538de-9d35-440d-a6cf-a6fe61f33904	72e16833-952b-46a6-a583-a8c462a2cdac	f
02d538de-9d35-440d-a6cf-a6fe61f33904	34982ee3-5e7d-4b38-aa4b-9007a7e9047d	f
02d538de-9d35-440d-a6cf-a6fe61f33904	88508b6c-f1a9-4677-bc83-cd819ffbd95a	f
02d538de-9d35-440d-a6cf-a6fe61f33904	f80d7182-f104-4a13-9334-e5b9d8be1b6f	f
02d538de-9d35-440d-a6cf-a6fe61f33904	4b6c1f65-c316-41dc-816f-410ba75388f7	f
02d538de-9d35-440d-a6cf-a6fe61f33904	0cce9e54-0935-4ea2-affd-807266f1e4dd	t
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
57a2e151-26f8-450e-b005-0602dbb8a225	5b47d572-3c44-4d32-8c3b-0967733e65b2
34982ee3-5e7d-4b38-aa4b-9007a7e9047d	0a073e89-ceed-4ec3-a0c2-a9f62ae9f48a
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
1e0ddc8d-2d6c-42d0-bb37-faa20aaf3641	Trusted Hosts	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	anonymous
45015099-919a-49dd-8c82-da6d6161bc01	Consent Required	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	anonymous
58a4aa21-bb83-4d16-936b-1b9e06fd23bb	Full Scope Disabled	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	anonymous
a6a06268-343e-4d66-996f-bf83b043fce7	Max Clients Limit	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	anonymous
a965efad-1727-4363-97c3-f1bb0a078456	Allowed Protocol Mapper Types	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	anonymous
2f322fbe-25c5-4a3e-b46c-eed02b025f46	Allowed Client Scopes	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	anonymous
17189e83-54a3-47ae-9c25-0503a6bb2ea0	Allowed Protocol Mapper Types	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	authenticated
1f0e135c-a8a3-4af6-8fe5-6587ef6c01c5	Allowed Client Scopes	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	authenticated
f6a95d27-5e55-414a-9ade-18cc4d5b636f	rsa-generated	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	rsa-generated	org.keycloak.keys.KeyProvider	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	\N
1683dbf5-580b-4eb2-821b-dbf351867803	rsa-enc-generated	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	rsa-enc-generated	org.keycloak.keys.KeyProvider	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	\N
bcf44aa4-c391-4f14-a75d-97238699a263	hmac-generated-hs512	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	hmac-generated	org.keycloak.keys.KeyProvider	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	\N
afbf34cb-0943-4551-8b02-d894434d248d	aes-generated	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	aes-generated	org.keycloak.keys.KeyProvider	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	\N
5dbed0bd-643f-4fc2-bfb2-801d3d548e69	\N	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	\N
78ad3db9-a83f-4444-a0f9-9a1482331b0c	rsa-generated	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	rsa-generated	org.keycloak.keys.KeyProvider	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	\N
1d6a9515-2d6d-4fcb-b283-d5d2dfe68fee	rsa-enc-generated	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	rsa-enc-generated	org.keycloak.keys.KeyProvider	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	\N
20f4cd88-f93e-43f8-b110-ea9f79367cad	hmac-generated-hs512	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	hmac-generated	org.keycloak.keys.KeyProvider	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	\N
2ba47049-827b-4fbc-9d6b-53b0fe425007	aes-generated	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	aes-generated	org.keycloak.keys.KeyProvider	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	\N
f4562d0b-7d3e-4139-86cd-f8cbfd199cb3	Trusted Hosts	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	anonymous
29d212df-c540-4625-a6d4-893240337856	Consent Required	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	anonymous
bf346a60-1c4e-4a40-a732-804a2f037732	Full Scope Disabled	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	anonymous
1a9ee61d-0bbf-4292-853a-d4ad63febf2f	Max Clients Limit	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	anonymous
2665adb3-2efd-40fd-bce4-cc1a428411da	Allowed Protocol Mapper Types	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	anonymous
a5f3f441-4474-471a-8352-2e5cd35abb15	Allowed Client Scopes	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	anonymous
c06c048e-9d01-4961-a4fb-57478ae9f3dd	Allowed Protocol Mapper Types	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	authenticated
21e222cb-f3a2-44cd-b881-386dbf6701ca	Allowed Client Scopes	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
cf0c3a61-2d79-402e-9875-b475671641ab	17189e83-54a3-47ae-9c25-0503a6bb2ea0	allowed-protocol-mapper-types	saml-user-attribute-mapper
6b60269b-1b3e-4197-bea2-4065622f21d9	17189e83-54a3-47ae-9c25-0503a6bb2ea0	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
ffe1c98f-a960-4cd9-919c-af7ff9b348c1	17189e83-54a3-47ae-9c25-0503a6bb2ea0	allowed-protocol-mapper-types	oidc-address-mapper
7f9adce0-c082-41ba-bf0f-1daa7af8bcff	17189e83-54a3-47ae-9c25-0503a6bb2ea0	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
f27a15eb-0e83-4635-b959-a0b1bbc0fa3e	17189e83-54a3-47ae-9c25-0503a6bb2ea0	allowed-protocol-mapper-types	saml-role-list-mapper
17bc56c1-e5ab-4aa7-b83b-994cefcbe26b	17189e83-54a3-47ae-9c25-0503a6bb2ea0	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
eeb2c78e-38da-48c2-9c1b-b72d9a8e6c0a	17189e83-54a3-47ae-9c25-0503a6bb2ea0	allowed-protocol-mapper-types	oidc-full-name-mapper
9798d709-021a-4341-8894-cbf66d94ea76	17189e83-54a3-47ae-9c25-0503a6bb2ea0	allowed-protocol-mapper-types	saml-user-property-mapper
f653abfb-abb1-4677-ad1f-43f12cbcb2b8	1e0ddc8d-2d6c-42d0-bb37-faa20aaf3641	client-uris-must-match	true
1690f438-befc-460e-a1d9-54f4b25cc5c3	1e0ddc8d-2d6c-42d0-bb37-faa20aaf3641	host-sending-registration-request-must-match	true
67faea03-dbc0-4c67-b861-3977c237dc8d	a6a06268-343e-4d66-996f-bf83b043fce7	max-clients	200
57cdbcb6-37ef-4e8a-8cc5-28304425d86f	2f322fbe-25c5-4a3e-b46c-eed02b025f46	allow-default-scopes	true
2705133f-cbcd-407a-8ce4-ad2b49fcc4e5	a965efad-1727-4363-97c3-f1bb0a078456	allowed-protocol-mapper-types	saml-user-attribute-mapper
b32d36bf-5097-4519-83e6-f67ee7f3734c	a965efad-1727-4363-97c3-f1bb0a078456	allowed-protocol-mapper-types	saml-user-property-mapper
0c6e9499-c008-4d46-8a96-8791952add8d	a965efad-1727-4363-97c3-f1bb0a078456	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
13a7d47a-50eb-476a-8752-98af6b4e0494	a965efad-1727-4363-97c3-f1bb0a078456	allowed-protocol-mapper-types	oidc-full-name-mapper
e63e76a8-5b01-4579-a0d5-8c834cf2a251	a965efad-1727-4363-97c3-f1bb0a078456	allowed-protocol-mapper-types	oidc-address-mapper
49c4d3c7-e82c-49fc-adfc-f1a81149b691	a965efad-1727-4363-97c3-f1bb0a078456	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
9f5d7488-c3e8-4b3b-ac68-2eba4598bcc0	a965efad-1727-4363-97c3-f1bb0a078456	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
cbb062a7-e6e4-40ba-b2b8-d749eef6814e	a965efad-1727-4363-97c3-f1bb0a078456	allowed-protocol-mapper-types	saml-role-list-mapper
1606762b-3951-4e41-95e9-9d9fa608ed83	1f0e135c-a8a3-4af6-8fe5-6587ef6c01c5	allow-default-scopes	true
a2c1e282-3c69-4d17-99be-6bda4599fa11	bcf44aa4-c391-4f14-a75d-97238699a263	kid	7f9c09a3-3190-49a1-9755-ea64cb460451
b4a0633c-5853-4430-aa3d-16df921f0f15	bcf44aa4-c391-4f14-a75d-97238699a263	algorithm	HS512
cc3e9d99-4428-42cb-8b64-55b2c14230db	bcf44aa4-c391-4f14-a75d-97238699a263	secret	bT7OHvtdebEPnJEaupVemTngJxjhJXHGx3n29D7son-_T-qMdBNspLkPCW_AnwzsmtLU3RuKNv2wPjB7KxBQ5-o7MI8UeBLO_pLOM_wbhWs3hb6EL3aYD0i_ao_EHHsncmvuDBlBo6Nk07MVmOUx7FXo83b1PtCY6ZKmvlTp3RY
2712ef74-fd49-422e-b0fd-97016c832fba	bcf44aa4-c391-4f14-a75d-97238699a263	priority	100
9d68f32c-2744-464c-bbfd-912d7ce06eb6	1683dbf5-580b-4eb2-821b-dbf351867803	priority	100
735921bc-f125-4e25-a8a4-ac2decc485f2	1683dbf5-580b-4eb2-821b-dbf351867803	algorithm	RSA-OAEP
a8b34f12-59df-4a70-b8cc-486e5837cbed	1683dbf5-580b-4eb2-821b-dbf351867803	privateKey	MIIEoQIBAAKCAQEAxCeQCMP2PscLoxI1ccjen0oCNr77QNyTNvul8f8/Vhdftl8s5L56oNmI7GObnSUaQBaKcqaN2RfWnTZk8fYXLvDeOK+muEivmSj+ufBsOqUzeZDOCSuzH2RPEwHugZS9xoVlSOsDOUX2bJ5hDaTVSIJ3K+YkSY1Pb7nKdVnyYHg8pIGzRjtdM6MtsxJCuM/cn/rBrScDBj00B4oMoXOn07gnsVTsoHmQ7XYHnXrf51Q9ujF8ibNrv4B2WIEY2uDB/j+QO/oz29kK7k1cwlKdz1cAy+UfaFfzoQEwKGofi02zQRlmYIcETR093R5w1zunQCTTKkRiHoroJGbaGc1YmQIDAQABAoH/XzPUdGyn11BEFaGAzvjvE+CXsnp+97wWt1jr8cgwtVgi3CDVaTAJ1IfALPsrS9n2I6TNDVhJAFTRlPwRgl4uYloFgP2/rTGaCHwdJaHK5avIj/f4B/tttI660j7dw4atlOype/qUVffe4lj8QeL+oXKw5F2OvyQWqeNCoDJHsQnPTt/C+KPalsuS6XgVgpOEKSgoQZ7oEdREvshO53n7W2gMwsfPEtPLyhXrpe3eZOe3NwRjSl0DsU9XyX9pCDEUgffx5XPjsq/fUN2qVMYq6WUkcsKY9gEBwiiIJ5lkwrO2NY3Jmk87QAEaKIY/nWQwsnQmebmV0i7XNU3pWHYhAoGBAPydDyE1cxJ6g8KJMKVjwfgiXqeY/l5UE9+ym51/H7RdhOTiZ4doDbb/umUnz+Sz+Etezz987HRhi7l2/oUNXOqteQd8taQlWGs4IaXQ54+AoeDVToTXIKzi8gP2AAF15JbERFpADGqYeLRynt9at8JrOdk6Lryx4XbB2brSNeQJAoGBAMbIviUvYBa992vEUembzntwYDYSjku1SA2cbIVp2p/YTC1YSnurhVwBjNgP/Vxm0a0WZaHjkUii0y8H9IVRruCw/0qzHdse6Ib7N5mxKBi91n6MKlcmYhhb2gkKe4f3VqAEyLEl8e2K8yKT9bdQ9Z2RJPsdJ4ya+4Y2eEWaRJQRAoGAZEGJMare4qSRCnIcRmeTIgGyA14rBhDkWlGuhRFg6dp71cMtR4Y6ezh/J4pnbeMnVfJo2k+gIIheRds+JFwrVlBGynvqMx1HPDZo1EBWxpNMq8i8guhGZZckagIF+o5pjJSUdCUbSGr+7M7Y0thUOesIaHg4+Fa4nsNMwGKRVNECgYBOL4zicVTY/RUBFTGmsbqwQI4HFptTWdUiTWE9xFnSPzAPMcfyBo+olY+BOCDOJD7aVpHY7/on2Ks5t2ZMvckL5XI0PmlC01BgLxU6ZTzBJoHkOls49gblT9NddPsLipRO0jLhwmv6o4loE0w1Mym4NOuXvWrd2eOOcYQy1C+fEQKBgQDK6uAJh5WQbIxiZ0nAY2bdx1s5RhxgtxnCTs2u7xJ4EPkl12UDS6DNH+cwAgAwyBveuKu92wihDjSSDRFYcu+ikB7sxfG+rDQGcy6JiwQEqjSk15F9DMW2xLlPsHqwwcL5exgnUrSRfp5pzFDN+vK8jXKUUasNvbbRFTcx89/DfQ==
cb8275df-f6cf-43d2-aa90-fc5f11b8203a	1683dbf5-580b-4eb2-821b-dbf351867803	certificate	MIICmzCCAYMCBgGaRkF05DANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUxMTAyMjAyNjI2WhcNMzUxMTAyMjAyODA2WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDEJ5AIw/Y+xwujEjVxyN6fSgI2vvtA3JM2+6Xx/z9WF1+2Xyzkvnqg2YjsY5udJRpAFopypo3ZF9adNmTx9hcu8N44r6a4SK+ZKP658Gw6pTN5kM4JK7MfZE8TAe6BlL3GhWVI6wM5RfZsnmENpNVIgncr5iRJjU9vucp1WfJgeDykgbNGO10zoy2zEkK4z9yf+sGtJwMGPTQHigyhc6fTuCexVOygeZDtdgedet/nVD26MXyJs2u/gHZYgRja4MH+P5A7+jPb2QruTVzCUp3PVwDL5R9oV/OhATAoah+LTbNBGWZghwRNHT3dHnDXO6dAJNMqRGIeiugkZtoZzViZAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAKn2rJXnD/5qcayVkugrDIw6JHzO9VIdb7nM6R4CVpYUC3AQHG5V/xWeFVzlm2Iv1kWuRvkgdpx6xe//lHdlEEqlVcg6Xn6rXOWOElEN3ghR2mu4IlhLt4jbABdu6UFjBO/vUkVluQva81nKDn7jQhDb9+JWs9nUvbn0QD0pnu9y35am/XtW7q/qJyeivafGdkg74MamwbjSeaPAzIPCUP1EDd3cl+3MjkOWys2CyEaSXjOe1jKvJmM9NgJahoPMjDa8cymnBPgt4bqmUmv/qbQoDeJTRA43LprHGmBUkOMzuLI+ar6SNHh5Brclizljjbhc146nTh/9ab+UV0hEJOE=
99ee9124-0b39-4027-8b08-2596745894e0	1683dbf5-580b-4eb2-821b-dbf351867803	keyUse	ENC
391a1bf0-05f6-47a2-8ebf-27f6c1433fc1	f6a95d27-5e55-414a-9ade-18cc4d5b636f	privateKey	MIIEowIBAAKCAQEA6zE2SJ1TFv+CunW2peETK3DsQasKMeq9mCBTW0ki5Acsnso6OAG8MRP9mkxInF00CUfu/rwno3VZ5ngFvbe5TZzMAg5P+lu8SnjQNFrG7PxZktk/dVwBlskL6yXjpowcmI01lmoNgwr3tgeBSF9ZjD3Ju63Qcc98Fp0dobpoHhlnxKGimnC6ozVfYOS7Y8IoxlbMfF1PGYoLjslwR6wMfHDmln/IJgB/7RltHAPbDVszjwidKErQKwV4EbTEs6j3r+wRb1g4gTBezFlCwi5cs4vCBygX9JonGFyjqGOTyEoow1eceCbW7N6qIfY6CvKpSQ8FG33m1IRRZhvYwrvfiwIDAQABAoIBAAGOohh3r6veg1HmBD/qIS/5INn7RH8kXpCmcruT77yENE9xf1v1T21Zwf7YefhMin2jrzqapTwrZJr3C+lZ2rM0+pyVGGFQuWTh8XuLs0eneS117WS5ZTQJ6FFi7ntsyfJFu3Da94dOMZlUumPAaGFQ2+4pRNWSSofnIbJoVO55xrSga9JrY+S0aLFhH/45JKak+0c2RTH7ByCdICXsoUbTbV53O119c/GKWgJPYgPrVTNWQy+lWkvLDjbBXkVSS5qdiZLojsuB94wA7Ny5oGqiOzxb70rpeWdw35osJsLzvSZwnTf7Lw/ekbtWQXhXGfU+GcmXN+87mK2ZkGlhxhUCgYEA+odQhIBN+Ha7YiTXI8o5Cr5oQHAcd41nKUavmMGVgsMtFbVvAUIoqaUJNWuUzf/iDT4KPBHm2UuF+z7k3R6eEcPp5qk2jIgL+N4qi5xPsh6JDPIN+Gci6n4NoU0Wxy0u64mv/tlW9PrfK2aZdx2PHZIcO6d6zCsK3aBZS6xSME0CgYEA8FQnPKgs/zxvdm1WTS0ShEHFUL/J3HrXI03n/IK2N/iL4xQ2+XyxEXK1AKM2QMKwZVKytIbFaX7v1RVmRT7avOpzOUsbY8Jp7gyVUkI9Tv3G91ZLHKkJqYQ3jx46iaLGqFr/O8/ZdffPPfnakIOeY/Mi3TbNiBFhpKAsuGKY+zcCgYBQBUqVl/nPo/UESyogt2Xy5ZCdDHI7SYIq7/YEf8jGpJrQ9UvIhh5A2YMQehVkmxfUDP3t4/XtcC8Saitl6XKpz/70+xV+W7IfQq8qOrpF9XTnGqWVszO23J5z6BCfe/Ihr6/0Ye1hgIQp87KPFnTxCAtWjo8tiY4F7kK3Zgo2fQKBgQCrZwl47GTzQJIqf35+mnfLVfE5Tx/UHNRVfJnI8RyuvJhgQymWNEVBMXNAWic2duRBz4Je2IPxYrQAYDvJhTOSaw/0u8l0E9NjERxqR43cSYjfHG+DqFeYzBCoBSIwyaQvrH6+lNX+mdf31rv4N7b+iAjEhvJ9ahAezpI2izOabwKBgHolhA9x2ApRXctdnEJ920jf9T+jQP2Bvb5CIRfu2IQl4MFCNdqbnkDsPFoj7soxyRisfIVglU/+dcbRQ6UITsx9ftWLuht1iobHRvIX07kEViB1Mf1g10gIA1s1cPRlk1e0109ETRo7ElUdVQVzDD4QR1/rRLUJiDh+VVufS2S5
2ee9ee55-bf9d-4a27-8ce2-51811db8e1f3	f6a95d27-5e55-414a-9ade-18cc4d5b636f	keyUse	SIG
769f68a2-6f2f-4f33-bc38-07923b27f98d	f6a95d27-5e55-414a-9ade-18cc4d5b636f	priority	100
d5d862cc-e99b-403f-8fce-51496ce9cd78	f6a95d27-5e55-414a-9ade-18cc4d5b636f	certificate	MIICmzCCAYMCBgGaRkF0DjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUxMTAyMjAyNjI2WhcNMzUxMTAyMjAyODA2WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDrMTZInVMW/4K6dbal4RMrcOxBqwox6r2YIFNbSSLkByyeyjo4AbwxE/2aTEicXTQJR+7+vCejdVnmeAW9t7lNnMwCDk/6W7xKeNA0Wsbs/FmS2T91XAGWyQvrJeOmjByYjTWWag2DCve2B4FIX1mMPcm7rdBxz3wWnR2humgeGWfEoaKacLqjNV9g5LtjwijGVsx8XU8ZiguOyXBHrAx8cOaWf8gmAH/tGW0cA9sNWzOPCJ0oStArBXgRtMSzqPev7BFvWDiBMF7MWULCLlyzi8IHKBf0micYXKOoY5PISijDV5x4Jtbs3qoh9joK8qlJDwUbfebUhFFmG9jCu9+LAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFSMfMS/bVbG5y6KiuTHY0t+AQwXcyoAtUJP9ebc/OvBnR//MDNyl/Ni6XYVUSgCDzO/zoDmNr/BULbSETvXnS3dQ7tPwjtgF1nbdb+aWZtqgI6zUrAVOdg+jefskKhpJYRWUPBq3wEuLsjc9WFUiit89dhiNS0MG9mFZUKmfWk4s+jZxY20RrTmUP1s2luHvLpbeBogfbmGH0kBMncn/huJABTkcaxA8Q2TGbPmudqih8KuIZOHi6ZNNt58clpyvbrAYfCXaSVa87cs3hYHYI5A4krVEW4oAt5gtWiGcoZcPe2s8NI7IJcCCgIgJKUQHjr9G+pfNG73xFpGZcLCICY=
1d7d4c3e-18fb-46e7-8121-007ba66904f2	afbf34cb-0943-4551-8b02-d894434d248d	priority	100
1d7f960a-dabd-4065-80f1-b71d37601d80	afbf34cb-0943-4551-8b02-d894434d248d	kid	c0995f66-d39c-4d1c-9ed2-6f590bbf45df
a9a86881-250e-4842-bf79-c7d51d7678a4	afbf34cb-0943-4551-8b02-d894434d248d	secret	LyB54-tC_B8eKRVOQFhWXQ
30d66642-413c-4602-b2ee-12de6c32b24f	5dbed0bd-643f-4fc2-bfb2-801d3d548e69	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
0d702119-0f2f-42c1-88df-1ed545b3f040	78ad3db9-a83f-4444-a0f9-9a1482331b0c	keyUse	SIG
db491dcd-95e0-4680-8d2e-001c5878d098	78ad3db9-a83f-4444-a0f9-9a1482331b0c	certificate	MIIClzCCAX8CBgGaRpLo6jANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDARkYWNzMB4XDTI1MTEwMjIxNTUyNFoXDTM1MTEwMjIxNTcwNFowDzENMAsGA1UEAwwEZGFjczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMA0li+3P8Cs4BjBJCBxluwrt+jl8N4N95IASI/ztOGMhLeZ1xmM8CY8uPm6iNp/ObjiTcJUttuGesRQpb/WMeM8Z/TxORX3G/mvZmKW+0yR8dK61A/bH/5bscjwWlCWAaiMJo1JCdIq76z/rDWTTaOTUj9qUTsTZz5xwgF8t/KjOW6Y7eUhb0RTZFg5OV9MYahY/9p5S1rrYswp+NLzmMQeGsbDRJTLydNIp/a8CRC8VHpCYU6jJG0WE/S1vm4Vw2jZydYmZNM1pozz8IbFtCfNvGyMUSmhOtMbv+EGel4zhCon7O7rb5idXRGfhKL+Ivet09cpTpidhqrGazKjGsUCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAEdNH6XOjuEUhxiqmtuYK8Z0UhNgXROLkVWd9sRqYQhcOazng2ISNAlfi0Py/idKKbPZk0lz5Bfe+00Zf3wFfTGUVZNzr7tWY18ykz3Dq2uLtqwJxAXCRNgnTptaQ6qQC6nvzzley2dxkMpok7Kcwxi4hC8Pip7OljTKPShc7ynZ7aAbgAOJ1Gx+QhzYvmo1jCsPrCxEqRZMCxiy6Bljx0XnhOec+qiCgSOLzERzuIqadeieV1HDVbyvQzl835J6C3IaF2Hwn74J+49sZYMPZBfDqmAaOLSsrRh/pEmJ+myrwV+QgKEMoC2MU8iD9BblPS8xKvBlp5Xbys0P1DnKiGw==
975a7c0d-baa7-474c-8057-f3db093e446f	78ad3db9-a83f-4444-a0f9-9a1482331b0c	priority	100
7faf7de6-5837-4cbc-95bc-5ab5a3edfe45	78ad3db9-a83f-4444-a0f9-9a1482331b0c	privateKey	MIIEogIBAAKCAQEAwDSWL7c/wKzgGMEkIHGW7Cu36OXw3g33kgBIj/O04YyEt5nXGYzwJjy4+bqI2n85uOJNwlS224Z6xFClv9Yx4zxn9PE5Ffcb+a9mYpb7TJHx0rrUD9sf/luxyPBaUJYBqIwmjUkJ0irvrP+sNZNNo5NSP2pROxNnPnHCAXy38qM5bpjt5SFvRFNkWDk5X0xhqFj/2nlLWutizCn40vOYxB4axsNElMvJ00in9rwJELxUekJhTqMkbRYT9LW+bhXDaNnJ1iZk0zWmjPPwhsW0J828bIxRKaE60xu/4QZ6XjOEKifs7utvmJ1dEZ+Eov4i963T1ylOmJ2GqsZrMqMaxQIDAQABAoIBAFnVGi7CCI9+nRykxMRPIrlOM54sPlgikgfQjxmMz4ktemgvhFvCRgmxDslVWBo7JVjWmH5PxskygNWZVeaj71wkAvh19/besFoSExnYNCrU+X/C51Nj2H+zDpR6VdPdUHgczPXy4Z6zh6LFOpEtwDdIJ0RRZhbk2jfSxliYmIbT2KVrMGv4eUq00H49f74NG8n17b9Ud3X/VXviT+YombDjpn9JTRTce6N8QdeDSIDihC/5DD4aIK+GqIpCT1P2kRMI0+pAb1+BcfYRjltChzC5YOvkQeRw0LRbYOw/Us6SkZbuPrs9xCLCEXdvYRfQzQAuFMJR2MzAxn+GqsFjuC8CgYEA4bdp+4T8tFoFUavR24emIm6vZI/bniXb40mnuwwc0Y5nu/XetwD83GTQvmqjXgQ64YwSYjihe8FG4rceWZxod/sokt8Acho7uTpQbatl4hTPEYKSSZmjz1o6DR+mvddNjJO4Rj5duSJz5GESgCf1ryQQ6olE/GuYGNLsLnLdT6sCgYEA2f4u6zp42zuf1I8GzmUWdFIuoULIcdFgQR0bUGf++ccu8HL6rDlAlWZ6tZocdDzeAnpW9UkLM3DY4e1HjEggh7HkSfdIgH6TBfpUz8lpEZyC86pTxrFRkWO6RuPbD9ur2+cfYfGTjCRp7rAEakV4Mjoxx2XhuIPNdbJmfDeFj08CgYBoEvPxHy6N0fwl3j2TJYa61aJVkedHkllDAZEvM7SOA0Vda07XvsLYtDtzsSPGk9i6aqWHWGlM8J9Ipfp+gxnASLQ6lExWUDY9f9/Z0W/WwJWBk1z0Rr07PHUL3A479mwxZ2NOMC9yz6n0IbYwFTy5Fr4eBlEiulGVEJwKBrh4pQKBgEaNoOvbCeCSxKEMBXzpdMIDEzp4Hd3QkSGh5QQ6FGkNEWEbJYx2HzP7bf22ujzYslYE+H38vRZSEK/WlxCNC5I/fg5+bUXBMZ5+rdJucoYTrMJmPyUQoMC4kUJ+XpkcVNwgSqTthf6Wjn6FE3i9sTA4a4IItGx+pBHSwp6zbZO7AoGAMG/axFroqjKCvVuv53UmxENYIruJ1GaGdu6YadzESo9/zk4GrA85U2r7Snittlwlh0wSqXOZSnaCu8E21wC/Qlw/8mloTpS2vc20mxzASNz/V9+hZpoLZ4GnLrgE35NObQASdvy0f/l4UDPBYIcdd7VSWXHW6D+mGpMz+EcdMjY=
ac2be183-32b6-435b-b3f4-0b903e2e8be5	2ba47049-827b-4fbc-9d6b-53b0fe425007	kid	83344554-7395-4f07-9466-6a47a20b7298
4cd8a9fe-b9d6-44ab-84af-1b3c24e77ea3	2ba47049-827b-4fbc-9d6b-53b0fe425007	priority	100
4011e6e9-f432-4aed-b1cf-fef6b131eb24	2ba47049-827b-4fbc-9d6b-53b0fe425007	secret	3Yco_7uCCyoO3qkjnzOzWA
3ea7dbd6-69fd-4c48-962b-0b11f0d1ed52	1d6a9515-2d6d-4fcb-b283-d5d2dfe68fee	algorithm	RSA-OAEP
2abc8574-065f-46e0-8e61-ff5af2604714	1d6a9515-2d6d-4fcb-b283-d5d2dfe68fee	priority	100
0f622ea5-7547-4745-843b-170904e91df6	1d6a9515-2d6d-4fcb-b283-d5d2dfe68fee	privateKey	MIIEowIBAAKCAQEAsgelq6GBn3SV4Q0Mg/n6wJ9xC/pKu6LvjEV+/j1x/AbHpmoteBcvr/GSAnc4dc5YbgDq6UAyRjh0UwsosuotDBJb/Eyb3JSuCdhD4gcvS+HiWewETMLYlzx8JMlqADzCQtbVxjDUM0HBiIgPZR/mg5nHuP/zgSqXFcScKuf8RM300zPndR0/pg83fLjLZloWtJB+Z2fgm/Pd+mNUBEjHZ/2wW2O5kwo3wSkkpPcnmLkNsRCyD0LXJ8N/5iTsR4VMctRsXv7HV/16YSLXTqr85/jnb1fs6rOBxqhVKzY9/wFh3wSaBdLwSF/6t0ws8Z8zsujkT5gXkL3dsblSsmKrCwIDAQABAoIBAAxHOPBU2hoNHt2GGl2Ryu70/OvZp8TRttnpD+cCuUIR/G81D6ZVwKOB5bmHNZzxjcMmC6ccyjrYkueiGeNfZ84kCAJApr4FGdmykVmQRRbjlDC/Qjt1c4QLfZGSu8PnbNhr260b2gHs+fPrulZ8AQuerZnloSQnGh0IuC9aj4xcVqws6lF7xaCdOLLx4opYVvLoKt1CutlCr0OzcJHcqLh+O9jUKM/Kwj+feGsgDmLT+EXk5Mro/GGi5lK5l8uIckFCF1Quy2HqpMBvYpHXT7lXT18m+IdqAo0iWRIi+iiqSxaGFJm6+xFuFo5oOZBHdujEQvgZ6FEuGC2pafkTg5UCgYEA84l09APNLdgY1ez7VnB5O3VmqGGzmZcxNmQGSyRgbWNJjShkfnpJJJY/IUsUhys3C1XsyZIUx4RYu0jZa4Lg14YfJcTSBSOinX1nw9UkhbbRaszyw5mfoNppyEVyzmOysDt+7QLDuywfpzeACmXsCkG26umYppDJ2SnNzF7tlQ8CgYEAuyP9zY6oXkRm5IAGGLNP9W2T4y73M2qlNPgQgDYx0vA+JtfapVMma96+5cfLJj+NzpLUPFMwfcmZHKP12m5St4OhQT102CPTjL9Wp+fRfabHa/TbuUIpnNuh4HxBMMUExadgGEjVVZvfFxD36ZWPG0T8Iypr0trPHsBX+VeaokUCgYEAo4FF5A4pUv4irn3MwNwCiMjpg2MVEalQgRPmpcxmcQqX9w2HauLu+IFnIRMnVRjOe+3UbACHsuxIJnVig6v7CLgjcVgTKSAjrVjksbYILz3um6W911TstzHsk2kNC0QkU+2d6cJRZvjYx4ubi1+iecBk7pKmyi2rVwGaCfwxxkECgYBgLQoV51gOQlci3czESvsv5eXYHt36dbd79nT8f12xy7gVXF/JEWewjmRLURfNi2IEpR8f9Zz5OG9Q8c67OHGYULTCA6SWJCtnrToKxq+6RMk+aTO3DRK3w4R5C0Kxnr9qGS/gqyXAfn/zqcvPJwbJ+/Uc2YNadQt3AWD1Cxm0hQKBgH+VfDvMyKWKJEESEPkZ4HUpRECH1p/niz8Max4fPcgUFxg/9sZzRzrhAQHJ+AvFzXhrZl4KApbeMqreZdps2b74033YFy0xAL9zXnr2aXp25aWj7aqNKJb01jT9jOQL/FKCSAB06pEwrlnJj048hqi4BUsEPOKLzwJ7aM0js+Pq
b4bbd11b-9549-45c6-88ad-8c7852c6889e	1d6a9515-2d6d-4fcb-b283-d5d2dfe68fee	keyUse	ENC
61c20035-123c-4417-bb96-e449705c9108	1d6a9515-2d6d-4fcb-b283-d5d2dfe68fee	certificate	MIIClzCCAX8CBgGaRpLp2zANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDARkYWNzMB4XDTI1MTEwMjIxNTUyNFoXDTM1MTEwMjIxNTcwNFowDzENMAsGA1UEAwwEZGFjczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALIHpauhgZ90leENDIP5+sCfcQv6Srui74xFfv49cfwGx6ZqLXgXL6/xkgJ3OHXOWG4A6ulAMkY4dFMLKLLqLQwSW/xMm9yUrgnYQ+IHL0vh4lnsBEzC2Jc8fCTJagA8wkLW1cYw1DNBwYiID2Uf5oOZx7j/84EqlxXEnCrn/ETN9NMz53UdP6YPN3y4y2ZaFrSQfmdn4Jvz3fpjVARIx2f9sFtjuZMKN8EpJKT3J5i5DbEQsg9C1yfDf+Yk7EeFTHLUbF7+x1f9emEi106q/Of4529X7OqzgcaoVSs2Pf8BYd8EmgXS8Ehf+rdMLPGfM7Lo5E+YF5C93bG5UrJiqwsCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAV8VHiHRiV+CIzMyMi7xXTtNXmvcxXi66X+11kaKLQ/QkDX4vPcvouyVfI+lDO/E3xDfPK1CRxcurfka1Vha+CA8UZE396EBTmRACOkNqibsldJ7ttmQJrsx9tBBZ0a0udZbi6LjFrvFguExzljr092RUfv9/DQQX9TC06Vv8yqLxY1VOfq6La5f/cQh5wtggJjfmt2Q5wTrcB46otM3RV4/7QuonveNSKAX2KBnzuKIAHSUnwbjaSHKZlPWnuiodD7q6sQ6RS1r7fK6LedG7iWBJGnjsbqEpTh6JWu/nzJmcNiQKiwvd6itbRwlYMFYvcTrLePtSdpKrzELg6c7R6Q==
b65c1560-e9bc-423a-ab16-9fe3df45504b	20f4cd88-f93e-43f8-b110-ea9f79367cad	secret	BR-rwpzHkgLou9gFG2Eqbbdiu6eSIvJOa568l_e-jX0F8_WM9sorrIIH37XRAyN2qzybr1TBa6undEBDOWiw8fMkxEhwocBb-fXnT8xXQxwUgc1XNP7EAbwTYEu7k-rq0eT4Fi2Ry5DAUvEJqL2sDcU4db1LbfD-zIQfB-YrMQg
db57a8ef-129a-4037-a0e8-6f6c9bce8816	20f4cd88-f93e-43f8-b110-ea9f79367cad	priority	100
711edb7d-d78f-41ea-8533-32e855e1608c	20f4cd88-f93e-43f8-b110-ea9f79367cad	algorithm	HS512
086e05a0-aeef-451d-a159-f22f95678909	20f4cd88-f93e-43f8-b110-ea9f79367cad	kid	97c0b01f-ccda-4041-8f74-51ccd1a07332
4df67409-94b3-400a-b436-2181cdd10aa3	f4562d0b-7d3e-4139-86cd-f8cbfd199cb3	client-uris-must-match	true
763cc1bd-ac3d-48f3-a1a2-f063e1a04cca	f4562d0b-7d3e-4139-86cd-f8cbfd199cb3	host-sending-registration-request-must-match	true
a36046cc-458c-4149-9100-048c066e6650	2665adb3-2efd-40fd-bce4-cc1a428411da	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
2ea8d4e0-c9af-416c-8414-0fc2f3950414	2665adb3-2efd-40fd-bce4-cc1a428411da	allowed-protocol-mapper-types	oidc-full-name-mapper
b5d0d074-200c-4a06-a61a-9c9551cea461	2665adb3-2efd-40fd-bce4-cc1a428411da	allowed-protocol-mapper-types	saml-user-attribute-mapper
aca52231-8dea-491f-991e-221dd28908a6	2665adb3-2efd-40fd-bce4-cc1a428411da	allowed-protocol-mapper-types	saml-user-property-mapper
5c5d582b-9b5a-4354-8be8-e0002febf97c	2665adb3-2efd-40fd-bce4-cc1a428411da	allowed-protocol-mapper-types	oidc-address-mapper
6388adc7-a065-4357-8dcf-327235ac37cd	2665adb3-2efd-40fd-bce4-cc1a428411da	allowed-protocol-mapper-types	saml-role-list-mapper
2ffcd0fc-cbc4-4c9f-a0ac-d6626224ca53	2665adb3-2efd-40fd-bce4-cc1a428411da	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
328f7dde-e36b-413d-8253-56568c2a207f	2665adb3-2efd-40fd-bce4-cc1a428411da	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
c51a46fc-8f34-4daa-81fb-f990c23a272d	1a9ee61d-0bbf-4292-853a-d4ad63febf2f	max-clients	200
9d6161bd-4020-4ba0-b1e5-13408de6b46d	a5f3f441-4474-471a-8352-2e5cd35abb15	allow-default-scopes	true
898fc650-63cb-4d70-b351-5e1a9d932b6c	c06c048e-9d01-4961-a4fb-57478ae9f3dd	allowed-protocol-mapper-types	saml-user-property-mapper
6c14a8ed-feb9-464d-b9e4-9e3c6c443a75	c06c048e-9d01-4961-a4fb-57478ae9f3dd	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
77a7034b-73fa-4a45-9be5-dc7415f5f5bf	c06c048e-9d01-4961-a4fb-57478ae9f3dd	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
ce6614aa-ff98-4f17-8e46-c128e998c0d9	c06c048e-9d01-4961-a4fb-57478ae9f3dd	allowed-protocol-mapper-types	oidc-address-mapper
1e5f2afa-1c70-4f7c-9236-31793d3d8a73	c06c048e-9d01-4961-a4fb-57478ae9f3dd	allowed-protocol-mapper-types	oidc-full-name-mapper
1e0ec950-e4cd-45e2-9d25-8c7c4cd96521	c06c048e-9d01-4961-a4fb-57478ae9f3dd	allowed-protocol-mapper-types	saml-role-list-mapper
95329a97-d13c-4469-80e1-f7efda8388ab	c06c048e-9d01-4961-a4fb-57478ae9f3dd	allowed-protocol-mapper-types	saml-user-attribute-mapper
5eaeb91e-c711-4e8a-b69e-6e42c54c1983	c06c048e-9d01-4961-a4fb-57478ae9f3dd	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
5a30e64a-c3f7-4b98-b135-84d30514b0a9	21e222cb-f3a2-44cd-b881-386dbf6701ca	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.composite_role (composite, child_role) FROM stdin;
401c85ca-5f45-4959-821a-8b74dd59c76b	8ec73f86-f34a-4cb9-be1e-ec1edbde03e1
401c85ca-5f45-4959-821a-8b74dd59c76b	47ba1f30-99d2-40d1-84ec-8dca108e0ab0
401c85ca-5f45-4959-821a-8b74dd59c76b	788ad063-a164-4e5b-b6ac-3e5b3837e5a3
401c85ca-5f45-4959-821a-8b74dd59c76b	8f314735-0068-4669-a559-51329b96d4f0
401c85ca-5f45-4959-821a-8b74dd59c76b	4b02999c-805c-4ff6-ade3-0e7d018dc1e6
401c85ca-5f45-4959-821a-8b74dd59c76b	ade6fffe-bc3b-4962-b069-75eac5726bea
401c85ca-5f45-4959-821a-8b74dd59c76b	a3e32c71-4e60-4f4b-b6e1-a2a9eaf1627b
401c85ca-5f45-4959-821a-8b74dd59c76b	5e525ac9-c985-481b-873d-32da4890e7d3
401c85ca-5f45-4959-821a-8b74dd59c76b	d263d0ae-aeb1-4104-9f70-1b35d871d931
401c85ca-5f45-4959-821a-8b74dd59c76b	ba627645-ed38-4aad-9e8c-a435169319df
401c85ca-5f45-4959-821a-8b74dd59c76b	dfda3ec0-f572-4c77-97dc-54703c3d0545
401c85ca-5f45-4959-821a-8b74dd59c76b	5ff8def1-0889-4b11-bc10-119e4abc1aa3
401c85ca-5f45-4959-821a-8b74dd59c76b	680b34ae-dd60-445f-ab65-6c623c100444
401c85ca-5f45-4959-821a-8b74dd59c76b	10ace31b-fb28-47e8-b61a-fa09d00fdfb7
401c85ca-5f45-4959-821a-8b74dd59c76b	73640819-3816-4e7f-a601-f1e90e1a9205
401c85ca-5f45-4959-821a-8b74dd59c76b	ae19c8ff-d907-4bdb-be82-77103774b552
401c85ca-5f45-4959-821a-8b74dd59c76b	97b998fe-a1c1-492b-9bf5-9dfbdcf3c9a8
401c85ca-5f45-4959-821a-8b74dd59c76b	47e07117-abf0-4ef2-b2cf-59d26019ceee
2439e07d-eecf-4e4f-9a13-24aac26dcd66	b4670921-e7f4-4520-9047-92491e45443f
4b02999c-805c-4ff6-ade3-0e7d018dc1e6	ae19c8ff-d907-4bdb-be82-77103774b552
8f314735-0068-4669-a559-51329b96d4f0	47e07117-abf0-4ef2-b2cf-59d26019ceee
8f314735-0068-4669-a559-51329b96d4f0	73640819-3816-4e7f-a601-f1e90e1a9205
2439e07d-eecf-4e4f-9a13-24aac26dcd66	f6207dad-e8d1-427c-a3d6-4b5e08c3a9a9
f6207dad-e8d1-427c-a3d6-4b5e08c3a9a9	261125fb-2fef-4c79-887a-bd88e63571a5
f0af8aa4-b999-43b5-a319-b55f0b41c26e	50dc5490-5b35-4326-8a92-e2cd3c62f7af
401c85ca-5f45-4959-821a-8b74dd59c76b	3e29ad58-5245-4f03-9c05-bea7d2e2a918
2439e07d-eecf-4e4f-9a13-24aac26dcd66	5b47d572-3c44-4d32-8c3b-0967733e65b2
2439e07d-eecf-4e4f-9a13-24aac26dcd66	470ae50d-ecf1-4768-a99b-7c66bce0356c
401c85ca-5f45-4959-821a-8b74dd59c76b	60b6184e-a77a-440a-8a6a-8c282360ac40
401c85ca-5f45-4959-821a-8b74dd59c76b	1f3e363a-1755-4702-99f0-2a520079b308
401c85ca-5f45-4959-821a-8b74dd59c76b	85b20729-3829-48c1-96a3-966c4322c56c
401c85ca-5f45-4959-821a-8b74dd59c76b	1826f980-e86d-466c-b969-c3b0f24eeb15
401c85ca-5f45-4959-821a-8b74dd59c76b	455a5ad7-5097-47e6-84c3-2b3b688991ef
401c85ca-5f45-4959-821a-8b74dd59c76b	019d18b4-1c1b-47b3-9806-bf8f37a07271
401c85ca-5f45-4959-821a-8b74dd59c76b	9c6e2ce9-007b-4f0d-91d9-a8c569988d76
401c85ca-5f45-4959-821a-8b74dd59c76b	264ba0e9-d8d1-45fb-88a6-692e9ed1b122
401c85ca-5f45-4959-821a-8b74dd59c76b	816d4f7b-b254-41ac-9e3c-6340b13b812b
401c85ca-5f45-4959-821a-8b74dd59c76b	79b52ec0-a906-4853-9cd6-54b40bac6721
401c85ca-5f45-4959-821a-8b74dd59c76b	892c4b9f-29a9-46c9-9390-36c7ed805b90
401c85ca-5f45-4959-821a-8b74dd59c76b	1db8949f-f629-43c7-b5ce-b94b89df7fa0
401c85ca-5f45-4959-821a-8b74dd59c76b	45575167-cc26-4105-8b54-6ca3a9048cea
401c85ca-5f45-4959-821a-8b74dd59c76b	730669d5-1bf7-45e3-8e33-2833f73ec657
401c85ca-5f45-4959-821a-8b74dd59c76b	4b0d0f0e-a1d2-4c50-a958-7747ef0fd610
401c85ca-5f45-4959-821a-8b74dd59c76b	3bb3d42a-6d0f-4d98-b268-fee66d4315a6
401c85ca-5f45-4959-821a-8b74dd59c76b	d035ed43-2e93-47c4-afb3-fd9a589eeb5d
1826f980-e86d-466c-b969-c3b0f24eeb15	4b0d0f0e-a1d2-4c50-a958-7747ef0fd610
85b20729-3829-48c1-96a3-966c4322c56c	730669d5-1bf7-45e3-8e33-2833f73ec657
85b20729-3829-48c1-96a3-966c4322c56c	d035ed43-2e93-47c4-afb3-fd9a589eeb5d
dfc4d070-2ffb-4953-8e99-4a8f12921e76	e133e3db-44fc-4065-b442-ff0b7e2d0a99
dfc4d070-2ffb-4953-8e99-4a8f12921e76	1ac5a204-fb46-4700-bc05-8ef62ebeb3e0
dfc4d070-2ffb-4953-8e99-4a8f12921e76	4f436c94-8df5-4e86-a3fa-d3b99ce04a8e
dfc4d070-2ffb-4953-8e99-4a8f12921e76	d9ebc80c-f637-4023-a1ec-c41ab77c8f2b
dfc4d070-2ffb-4953-8e99-4a8f12921e76	54c77e64-5e5a-4758-b7f9-ab97d73169ec
dfc4d070-2ffb-4953-8e99-4a8f12921e76	701f4fe1-71d3-4212-915a-e943feb141cf
dfc4d070-2ffb-4953-8e99-4a8f12921e76	6f828e14-b06a-4499-93fa-138826be0216
dfc4d070-2ffb-4953-8e99-4a8f12921e76	b296ed71-5f27-4b60-b299-6157d5ac954e
dfc4d070-2ffb-4953-8e99-4a8f12921e76	fe89dd59-55e8-4737-aaab-91940d46a6b8
dfc4d070-2ffb-4953-8e99-4a8f12921e76	13358d59-d354-49b2-8ade-fd54cb4d1300
dfc4d070-2ffb-4953-8e99-4a8f12921e76	710bbc58-b0bb-4970-b0bd-a2d82080c0a3
dfc4d070-2ffb-4953-8e99-4a8f12921e76	e1552b71-3b12-4ee1-a9dc-17080865b49c
dfc4d070-2ffb-4953-8e99-4a8f12921e76	9ca2e44e-22bb-4025-abef-0eb2b9f830f7
dfc4d070-2ffb-4953-8e99-4a8f12921e76	9f70bf0a-1320-4a34-94e5-e68761ab07dc
dfc4d070-2ffb-4953-8e99-4a8f12921e76	9dc0f021-1ff9-46a7-85e7-7657440445d2
dfc4d070-2ffb-4953-8e99-4a8f12921e76	762318a9-6758-4e23-9770-82547a6d591a
dfc4d070-2ffb-4953-8e99-4a8f12921e76	3b22eb73-f2f6-46bb-b021-230559b5a76f
4f436c94-8df5-4e86-a3fa-d3b99ce04a8e	9f70bf0a-1320-4a34-94e5-e68761ab07dc
4f436c94-8df5-4e86-a3fa-d3b99ce04a8e	3b22eb73-f2f6-46bb-b021-230559b5a76f
8fc1edbd-5d64-460f-97b4-3b4fdf427189	6a79eb89-79f3-4539-bba5-18e1d270fb04
d9ebc80c-f637-4023-a1ec-c41ab77c8f2b	9dc0f021-1ff9-46a7-85e7-7657440445d2
8fc1edbd-5d64-460f-97b4-3b4fdf427189	b40cd027-c121-42c3-8633-ba98f3ea193f
b40cd027-c121-42c3-8633-ba98f3ea193f	8e080b1d-1f7a-4785-927b-2bd5cf8d2aab
35c993fa-fa37-454a-aab9-1239de34be95	e3444dc3-9514-44a0-ad3e-ab815ee7f9b0
401c85ca-5f45-4959-821a-8b74dd59c76b	e9eab650-d2de-4875-99cc-1b0833c4502a
dfc4d070-2ffb-4953-8e99-4a8f12921e76	ff0627e9-0920-4d16-93d5-103765af78f9
8fc1edbd-5d64-460f-97b4-3b4fdf427189	0a073e89-ceed-4ec3-a0c2-a9f62ae9f48a
8fc1edbd-5d64-460f-97b4-3b4fdf427189	c9c931dd-4e62-45ba-b277-13c372237a1e
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority, version) FROM stdin;
5a2202e4-2ea7-4f13-9e49-3c99e93be37b	\N	password	b7e81ecc-cd17-4814-a70f-119927f0c946	1762119880682	\N	{"value":"/cKYLkXzDti5rQHCp4alqz4y1pk2TqWDoDerc4W+rAU=","salt":"dE2EV1ZR5gw2ns9LzmNRog==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
ccb32480-c7ab-4f75-9c0b-a4055e84acaf	\N	password	e1a4f949-24c1-40b5-b89c-ce98844bafef	1762286822363	My password	{"value":"1p8LRDYU14lGbKHTjS5PHnBMNy4FxJ2sps+ZthErtqE=","salt":"I2N6letoPV/vGSAlJhfBgw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	1
c54881c0-40dc-4eee-a96c-99d1d05fbd4c	\N	password	6e6ab2e8-79f1-4a3f-944a-0cca02dc3e76	1769455347861	My password	{"value":"r+ebbqSrlN78Ay6/QqLXRRzXSuKpMc9k/5TL8IOtTJo=","salt":"YRKOTGRStxqV0oryEV92NA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	4
727c1b20-05cd-4ed3-9357-62b91e7ac71b	\N	password	84326def-2e28-4f8c-b07f-a913fbc9d0e2	1769807734633	\N	{"value":"OBH7MUzdlylMs1erqkRU25ZxojyTMXXy39fMisb8Rl8=","salt":"vGqzlmEBP0VxSvwqDyOxaw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
362611a5-8101-4102-aa42-28d967e79e66	\N	password	36accbf1-584f-4847-83c2-b0a4325c5f5d	1769808969771	\N	{"value":"ou6K8iYKy45G/Sh5QeqgWwdVgY+Ui6FnWNfxRTVp8jI=","salt":"j9qL/eJjRNNx+gnp8u0Vow==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
9f0c247c-5d3b-41f6-94cc-d5ba98828e0e	\N	password	a9969c21-5336-441c-b6ad-665dc8cb959b	1769809154565	\N	{"value":"kwKwxadWotkBREmKf1kwomUxRzJb2wR01HrrbqMwpPI=","salt":"a6Dat6G7SrR80u9zqsfJPw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
34337867-fe3c-4f30-9483-fd456af47d4a	\N	password	b9ee02b5-f629-45cc-aa93-8e40270773be	1769809201899	\N	{"value":"HWzawwOcE8OVXwdrAqMjn0nSGMq9fe9a5MScxPnV/VE=","salt":"m+ZhiViAz4p9949mpvbU+A==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
f6060b1a-26d1-4337-9e95-9ff9ad12a064	\N	password	afa50bac-8979-47f8-989a-6a1dc43e97a3	1769810272273	\N	{"value":"SDjXo9fgAp7gnNtjd2Wh9ipE+DST+MGmBjQnFaFIt1E=","salt":"uUTXtSpBZrK2rOt51h0UEw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
2431cf40-8df3-4fac-ba8e-3eb40d06ad23	\N	password	ca8a9e8e-d979-447f-b175-36c9b70ae4db	1773265391633	\N	{"value":"ijaohvh5x6ldGijZjLWmwTyMYLYVapHpo0tYeKaXMQs=","salt":"UVPpiP4UfKNXTwydShbubA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	1
7b2d0748-856e-4db3-97fe-15767cf4cb8f	\N	password	5e5370b5-3550-4124-88b7-c4dcfc093612	1777152925571	\N	{"value":"iCF8QpaUsJINKzkbugWH55404u8WeGDanYtxAjQtML4=","salt":"lnvDEzyl4BIZpDscKwXQmA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
d7a56dab-b9a9-4bff-89f1-93ce57eb190b	\N	password	19f300ab-a7fb-4673-98a6-24c288ae9d74	1777154924187	\N	{"value":"u/oTxiTI3uBrGvBqvEaIMfoEQ4oHOsm8zGk9vYRg3Ek=","salt":"ScJRWEjNcCmCLfpe5GlcBQ==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
f1e74a2a-8627-487d-9ef0-9a870492ff5e	\N	password	99db6213-9f51-491a-9526-e7c5cc26f206	1777155310582	\N	{"value":"oZujL6y+iUhJUcFqxJxz+QTRyaZDzLbAgTeRfCGOOBY=","salt":"QWWGbMhwA2EuNU3RK8Ss0w==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-11-02 20:27:55.808995	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.33.0	\N	\N	2115270962
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-11-02 20:27:55.819883	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.33.0	\N	\N	2115270962
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-11-02 20:27:55.899266	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.33.0	\N	\N	2115270962
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-11-02 20:27:55.904539	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.33.0	\N	\N	2115270962
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-11-02 20:27:56.116664	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.33.0	\N	\N	2115270962
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-11-02 20:27:56.123576	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.33.0	\N	\N	2115270962
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-11-02 20:27:56.268735	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.33.0	\N	\N	2115270962
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-11-02 20:27:56.276119	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.33.0	\N	\N	2115270962
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-11-02 20:27:56.282659	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.33.0	\N	\N	2115270962
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-11-02 20:27:56.448833	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.33.0	\N	\N	2115270962
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-11-02 20:27:56.526484	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.33.0	\N	\N	2115270962
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-11-02 20:27:56.530621	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.33.0	\N	\N	2115270962
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-11-02 20:27:56.565024	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.33.0	\N	\N	2115270962
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-11-02 20:27:56.593015	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.33.0	\N	\N	2115270962
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-11-02 20:27:56.595598	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2115270962
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-11-02 20:27:56.598791	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.33.0	\N	\N	2115270962
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-11-02 20:27:56.601569	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.33.0	\N	\N	2115270962
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-11-02 20:27:56.690943	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.33.0	\N	\N	2115270962
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-11-02 20:27:56.78104	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.33.0	\N	\N	2115270962
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-11-02 20:27:56.786914	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.33.0	\N	\N	2115270962
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-11-02 20:28:00.940852	119	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.33.0	\N	\N	2115270962
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-11-02 20:27:56.789702	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.33.0	\N	\N	2115270962
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-11-02 20:27:56.792984	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.33.0	\N	\N	2115270962
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-11-02 20:27:56.84716	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.33.0	\N	\N	2115270962
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-11-02 20:27:56.852216	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.33.0	\N	\N	2115270962
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-11-02 20:27:56.853724	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.33.0	\N	\N	2115270962
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-11-02 20:27:57.113777	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.33.0	\N	\N	2115270962
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-11-02 20:27:57.296087	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.33.0	\N	\N	2115270962
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-11-02 20:27:57.304353	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.33.0	\N	\N	2115270962
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-11-02 20:27:57.430006	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.33.0	\N	\N	2115270962
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-11-02 20:27:57.454555	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.33.0	\N	\N	2115270962
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-11-02 20:27:57.479166	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.33.0	\N	\N	2115270962
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-11-02 20:27:57.484328	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.33.0	\N	\N	2115270962
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-11-02 20:27:57.489346	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2115270962
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-11-02 20:27:57.491135	34	MARK_RAN	9:f9753208029f582525ed12011a19d054	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.33.0	\N	\N	2115270962
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-11-02 20:27:57.525399	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.33.0	\N	\N	2115270962
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-11-02 20:27:57.531818	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.33.0	\N	\N	2115270962
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-11-02 20:27:57.538878	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	2115270962
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-11-02 20:27:57.543277	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.33.0	\N	\N	2115270962
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-11-02 20:27:57.546724	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.33.0	\N	\N	2115270962
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-11-02 20:27:57.548223	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.33.0	\N	\N	2115270962
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-11-02 20:27:57.550014	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.33.0	\N	\N	2115270962
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-11-02 20:27:57.554861	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.33.0	\N	\N	2115270962
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-11-02 20:27:58.788567	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.33.0	\N	\N	2115270962
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-11-02 20:27:58.79526	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.33.0	\N	\N	2115270962
26.5.0-org-id-charset-mysql	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-01-22 23:23:24.851433	174	MARK_RAN	9:3564cacb2892098d8d3ab5987e51f72a	customChange		\N	4.33.0	\N	\N	9124202530
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-11-02 20:27:58.800285	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.33.0	\N	\N	2115270962
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-11-02 20:27:58.805888	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.33.0	\N	\N	2115270962
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-11-02 20:27:58.807569	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.33.0	\N	\N	2115270962
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-11-02 20:27:58.939483	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.33.0	\N	\N	2115270962
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-11-02 20:27:58.947992	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.33.0	\N	\N	2115270962
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-11-02 20:27:59.031158	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.33.0	\N	\N	2115270962
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-11-02 20:27:59.314461	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.33.0	\N	\N	2115270962
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-11-02 20:27:59.320615	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2115270962
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-11-02 20:27:59.324254	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.33.0	\N	\N	2115270962
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-11-02 20:27:59.327478	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.33.0	\N	\N	2115270962
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-11-02 20:27:59.339292	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.33.0	\N	\N	2115270962
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-11-02 20:27:59.350981	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.33.0	\N	\N	2115270962
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-11-02 20:27:59.406639	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.33.0	\N	\N	2115270962
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-11-02 20:27:59.798667	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.33.0	\N	\N	2115270962
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-11-02 20:27:59.866732	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.33.0	\N	\N	2115270962
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-11-02 20:27:59.879483	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.33.0	\N	\N	2115270962
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-11-02 20:27:59.892034	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.33.0	\N	\N	2115270962
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-11-02 20:27:59.902135	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.33.0	\N	\N	2115270962
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-11-02 20:27:59.907151	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.33.0	\N	\N	2115270962
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-11-02 20:27:59.912669	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.33.0	\N	\N	2115270962
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-11-02 20:27:59.917038	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.33.0	\N	\N	2115270962
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-11-02 20:27:59.972914	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.33.0	\N	\N	2115270962
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-11-02 20:28:00.002479	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.33.0	\N	\N	2115270962
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-11-02 20:28:00.007739	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.33.0	\N	\N	2115270962
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-11-02 20:28:00.046571	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.33.0	\N	\N	2115270962
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-11-02 20:28:00.055067	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.33.0	\N	\N	2115270962
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-11-02 20:28:00.060572	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.33.0	\N	\N	2115270962
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-11-02 20:28:00.067729	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.33.0	\N	\N	2115270962
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-11-02 20:28:00.077136	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.33.0	\N	\N	2115270962
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-11-02 20:28:00.080463	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.33.0	\N	\N	2115270962
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-11-02 20:28:00.110275	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.33.0	\N	\N	2115270962
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-11-02 20:28:00.151788	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.33.0	\N	\N	2115270962
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-11-02 20:28:00.156735	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.33.0	\N	\N	2115270962
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-11-02 20:28:00.158721	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.33.0	\N	\N	2115270962
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-11-02 20:28:00.184017	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.33.0	\N	\N	2115270962
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-11-02 20:28:00.186554	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.33.0	\N	\N	2115270962
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-11-02 20:28:00.22176	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.33.0	\N	\N	2115270962
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-11-02 20:28:00.224492	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	2115270962
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-11-02 20:28:00.234632	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	2115270962
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-11-02 20:28:00.237403	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	2115270962
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-11-02 20:28:00.276014	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.33.0	\N	\N	2115270962
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-11-02 20:28:00.286878	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.33.0	\N	\N	2115270962
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-11-02 20:28:00.294455	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.33.0	\N	\N	2115270962
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-11-02 20:28:00.311055	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.33.0	\N	\N	2115270962
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-11-02 20:28:00.319847	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.33.0	\N	\N	2115270962
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-11-02 20:28:00.339332	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.33.0	\N	\N	2115270962
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-11-02 20:28:00.376789	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2115270962
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-11-02 20:28:00.384324	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.33.0	\N	\N	2115270962
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-11-02 20:28:00.3869	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.33.0	\N	\N	2115270962
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-11-02 20:28:00.401879	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.33.0	\N	\N	2115270962
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-11-02 20:28:00.404867	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.33.0	\N	\N	2115270962
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-11-02 20:28:00.413668	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.33.0	\N	\N	2115270962
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-11-02 20:28:00.5132	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2115270962
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-11-02 20:28:00.515881	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2115270962
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-11-02 20:28:00.569879	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2115270962
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-11-02 20:28:00.60667	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2115270962
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-11-02 20:28:00.609125	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2115270962
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-11-02 20:28:00.639546	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.33.0	\N	\N	2115270962
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-11-02 20:28:00.646779	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.33.0	\N	\N	2115270962
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-11-02 20:28:00.65598	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.33.0	\N	\N	2115270962
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-11-02 20:28:00.689961	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.33.0	\N	\N	2115270962
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-11-02 20:28:00.72008	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.33.0	\N	\N	2115270962
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2025-11-02 20:28:00.755114	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.33.0	\N	\N	2115270962
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-11-02 20:28:00.760004	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.33.0	\N	\N	2115270962
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-11-02 20:28:00.79226	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.33.0	\N	\N	2115270962
20.0.0-12964-supported-dbs-edb-migration	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-11-02 20:28:00.828716	110	EXECUTED	9:a6b18a8e38062df5793edbe064f4aecd	dropIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE; createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.33.0	\N	\N	2115270962
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-11-02 20:28:00.831553	111	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.33.0	\N	\N	2115270962
client-attributes-string-accomodation-fixed-pre-drop-index	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-11-02 20:28:00.837814	112	EXECUTED	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2115270962
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-11-02 20:28:00.844165	113	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2115270962
client-attributes-string-accomodation-fixed-post-create-index	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-11-02 20:28:00.845802	114	MARK_RAN	9:bd2bd0fc7768cf0845ac96a8786fa735	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2115270962
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2025-11-02 20:28:00.850305	115	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.33.0	\N	\N	2115270962
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-11-02 20:28:00.929791	116	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.33.0	\N	\N	2115270962
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-11-02 20:28:00.934261	117	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.33.0	\N	\N	2115270962
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-11-02 20:28:00.939076	118	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.33.0	\N	\N	2115270962
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-11-02 20:28:00.947364	120	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.33.0	\N	\N	2115270962
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-11-02 20:28:00.952161	121	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.33.0	\N	\N	2115270962
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-11-02 20:28:01.055668	122	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.33.0	\N	\N	2115270962
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-11-02 20:28:01.060294	123	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.33.0	\N	\N	2115270962
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-11-02 20:28:01.065603	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2115270962
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-11-02 20:28:01.092217	125	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2115270962
24.0.0-26618-edb-migration	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-11-02 20:28:01.12692	126	EXECUTED	9:2f684b29d414cd47efe3a3599f390741	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES; createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2115270962
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-11-02 20:28:01.131512	127	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.33.0	\N	\N	2115270962
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-11-02 20:28:01.1337	128	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2115270962
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-11-02 20:28:01.136123	129	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	2115270962
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-11-02 20:28:01.141818	130	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	2115270962
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-11-02 20:28:01.170291	131	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2115270962
25.0.0-28265-index-cleanup-uss-createdon	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-11-02 20:28:01.179269	132	EXECUTED	9:78ab4fc129ed5e8265dbcc3485fba92f	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2115270962
25.0.0-28265-index-cleanup-uss-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-11-02 20:28:01.189036	133	EXECUTED	9:de5f7c1f7e10994ed8b62e621d20eaab	dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2115270962
25.0.0-28265-index-cleanup-uss-by-usersess	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-11-02 20:28:01.197043	134	EXECUTED	9:6eee220d024e38e89c799417ec33667f	dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2115270962
25.0.0-28265-index-cleanup-css-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-11-02 20:28:01.205571	135	EXECUTED	9:5411d2fb2891d3e8d63ddb55dfa3c0c9	dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	2115270962
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-11-02 20:28:01.207492	136	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2115270962
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-11-02 20:28:01.231919	137	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	2115270962
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-11-02 20:28:01.269924	138	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.33.0	\N	\N	2115270962
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-11-02 20:28:01.286852	139	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.33.0	\N	\N	2115270962
unique-consentuser-edb-migration	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-11-02 20:28:01.296863	140	MARK_RAN	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.33.0	\N	\N	2115270962
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-11-02 20:28:01.299817	141	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.33.0	\N	\N	2115270962
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-11-02 20:28:01.376437	142	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.33.0	\N	\N	2115270962
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-11-02 20:28:01.392718	143	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.33.0	\N	\N	2115270962
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-11-02 20:28:01.402761	144	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.33.0	\N	\N	2115270962
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-11-02 20:28:01.437712	145	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.33.0	\N	\N	2115270962
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-11-02 20:28:01.444582	146	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.33.0	\N	\N	2115270962
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-11-02 20:28:01.454238	147	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.33.0	\N	\N	2115270962
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-11-02 20:28:01.487602	148	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.33.0	\N	\N	2115270962
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-11-02 20:28:01.557298	149	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.33.0	\N	\N	2115270962
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-11-02 20:28:01.570297	150	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	2115270962
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-11-02 20:28:01.603826	151	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.33.0	\N	\N	2115270962
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-11-02 20:28:01.608413	152	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.33.0	\N	\N	2115270962
29399-jdbc-ping-default	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-11-02 20:28:01.621037	153	EXECUTED	9:007dbe99d7203fca403b89d4edfdf21e	createTable tableName=JGROUPS_PING; addPrimaryKey constraintName=CONSTRAINT_JGROUPS_PING, tableName=JGROUPS_PING		\N	4.33.0	\N	\N	2115270962
26.1.0-34013	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-11-02 20:28:01.627384	154	EXECUTED	9:e6b686a15759aef99a6d758a5c4c6a26	addColumn tableName=ADMIN_EVENT_ENTITY		\N	4.33.0	\N	\N	2115270962
26.1.0-34380	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-11-02 20:28:01.634947	155	EXECUTED	9:ac8b9edb7c2b6c17a1c7a11fcf5ccf01	dropTable tableName=USERNAME_LOGIN_FAILURE		\N	4.33.0	\N	\N	2115270962
26.2.0-36750	keycloak	META-INF/jpa-changelog-26.2.0.xml	2025-11-02 20:28:01.647413	156	EXECUTED	9:b49ce951c22f7eb16480ff085640a33a	createTable tableName=SERVER_CONFIG		\N	4.33.0	\N	\N	2115270962
26.2.0-26106	keycloak	META-INF/jpa-changelog-26.2.0.xml	2025-11-02 20:28:01.651795	157	EXECUTED	9:b5877d5dab7d10ff3a9d209d7beb6680	addColumn tableName=CREDENTIAL		\N	4.33.0	\N	\N	2115270962
26.2.6-39866-duplicate	keycloak	META-INF/jpa-changelog-26.2.6.xml	2025-11-02 20:28:01.656301	158	EXECUTED	9:1dc67ccee24f30331db2cba4f372e40e	customChange		\N	4.33.0	\N	\N	2115270962
26.2.6-39866-uk	keycloak	META-INF/jpa-changelog-26.2.6.xml	2025-11-02 20:28:01.662976	159	EXECUTED	9:b70b76f47210cf0a5f4ef0e219eac7cd	addUniqueConstraint constraintName=UK_MIGRATION_VERSION, tableName=MIGRATION_MODEL		\N	4.33.0	\N	\N	2115270962
26.2.6-40088-duplicate	keycloak	META-INF/jpa-changelog-26.2.6.xml	2025-11-02 20:28:01.666733	160	EXECUTED	9:cc7e02ed69ab31979afb1982f9670e8f	customChange		\N	4.33.0	\N	\N	2115270962
26.2.6-40088-uk	keycloak	META-INF/jpa-changelog-26.2.6.xml	2025-11-02 20:28:01.678257	161	EXECUTED	9:5bb848128da7bc4595cc507383325241	addUniqueConstraint constraintName=UK_MIGRATION_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.33.0	\N	\N	2115270962
26.3.0-groups-description	keycloak	META-INF/jpa-changelog-26.3.0.xml	2025-11-02 20:28:01.693566	162	EXECUTED	9:e1a3c05574326fb5b246b73b9a4c4d49	addColumn tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	2115270962
26.4.0-40933-saml-encryption-attributes	keycloak	META-INF/jpa-changelog-26.4.0.xml	2025-11-02 20:28:01.697133	163	EXECUTED	9:7e9eaba362ca105efdda202303a4fe49	customChange		\N	4.33.0	\N	\N	2115270962
26.4.0-51321	keycloak	META-INF/jpa-changelog-26.4.0.xml	2025-11-02 20:28:01.728314	164	EXECUTED	9:34bab2bc56f75ffd7e347c580874e306	createIndex indexName=IDX_EVENT_ENTITY_USER_ID_TYPE, tableName=EVENT_ENTITY		\N	4.33.0	\N	\N	2115270962
40343-workflow-state-table	keycloak	META-INF/jpa-changelog-26.4.0.xml	2025-11-02 20:28:01.8005	165	EXECUTED	9:ed3ab4723ceed210e5b5e60ac4562106	createTable tableName=WORKFLOW_STATE; addPrimaryKey constraintName=PK_WORKFLOW_STATE, tableName=WORKFLOW_STATE; addUniqueConstraint constraintName=UQ_WORKFLOW_RESOURCE, tableName=WORKFLOW_STATE; createIndex indexName=IDX_WORKFLOW_STATE_STEP, table...		\N	4.33.0	\N	\N	2115270962
26.5.0-index-offline-css-by-client	keycloak	META-INF/jpa-changelog-26.5.0.xml	2025-12-22 21:28:10.678753	166	EXECUTED	9:383e981ce95d16e32af757b7998820f7	createIndex indexName=IDX_OFFLINE_CSS_BY_CLIENT, tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	6438887088
26.5.0-index-offline-css-by-client-storage-provider	keycloak	META-INF/jpa-changelog-26.5.0.xml	2025-12-22 21:28:10.73977	167	EXECUTED	9:f5bc200e6fa7d7e483854dee535ca425	createIndex indexName=IDX_OFFLINE_CSS_BY_CLIENT_STORAGE_PROVIDER, tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	6438887088
26.5.0-idp-config-allow-null	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-01-22 23:23:24.744317	168	EXECUTED	9:b667fb087874303b324c1af7fae4f606	dropDefaultValue columnName=TRUST_EMAIL, tableName=IDENTITY_PROVIDER; dropNotNullConstraint columnName=TRUST_EMAIL, tableName=IDENTITY_PROVIDER; dropNotNullConstraint columnName=STORE_TOKEN, tableName=IDENTITY_PROVIDER; dropDefaultValue columnName...		\N	4.33.0	\N	\N	9124202530
26.5.0-remove-workflow-provider-id-column	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-01-22 23:23:24.786933	169	EXECUTED	9:d8eeb324484d45e946d03b953e168b21	dropIndex indexName=IDX_WORKFLOW_STATE_PROVIDER, tableName=WORKFLOW_STATE; createIndex indexName=IDX_WORKFLOW_STATE_PROVIDER, tableName=WORKFLOW_STATE; dropColumn columnName=WORKFLOW_PROVIDER_ID, tableName=WORKFLOW_STATE		\N	4.33.0	\N	\N	9124202530
26.5.0-add-remember-me	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-01-22 23:23:24.790552	170	EXECUTED	9:a7273ea8b21bd2f674c9c49141999f05	addColumn tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	9124202530
26.5.0-add-sess-refresh-idx	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-01-22 23:23:24.818556	171	EXECUTED	9:ce49383d317ccbcd3434d1f21172b0b7	createIndex indexName=IDX_USER_SESSION_EXPIRATION_CREATED, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	9124202530
26.5.0-add-sess-create-idx	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-01-22 23:23:24.846163	172	EXECUTED	9:aaee09e23a4d8468fbc5c51b7b314c58	createIndex indexName=IDX_USER_SESSION_EXPIRATION_LAST_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	9124202530
26.5.0-drop-sess-refresh-idx	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-01-22 23:23:24.849999	173	EXECUTED	9:f0082210b6ccbbaf81287c27aa23753c	dropIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	9124202530
26.5.0-invitations-table-fixed	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-01-22 23:23:24.858035	175	EXECUTED	9:fb71495ac8fbe4671b661586e09421d9	createTable tableName=ORG_INVITATION		\N	4.33.0	\N	\N	9124202530
26.5.0-invitations-table-fixed-fk	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-01-22 23:23:24.93772	176	EXECUTED	9:9238c60ff7fd4cfe87ffba19709c0394	addForeignKeyConstraint baseTableName=ORG_INVITATION, constraintName=FK_ORG_INVITATION_ORG, referencedTableName=ORG; createIndex indexName=IDX_ORG_INVITATION_ORG_ID, tableName=ORG_INVITATION; createIndex indexName=IDX_ORG_INVITATION_EMAIL, tableNa...		\N	4.33.0	\N	\N	9124202530
26.6.0-45009-broker-link-user-id	keycloak	META-INF/jpa-changelog-26.6.0.xml	2026-01-22 23:23:24.961727	177	EXECUTED	9:05026bbbc8d2ead5afcbda2f5fdf3a2b	createIndex indexName=IDX_BROKER_LINK_USER_ID, tableName=BROKER_LINK		\N	4.33.0	\N	\N	9124202530
26.6.0-45009-broker-link-identity-provider	keycloak	META-INF/jpa-changelog-26.6.0.xml	2026-01-22 23:23:24.991642	178	EXECUTED	9:7d9a0253c9de7be754efef8bba4265bd	createIndex indexName=IDX_BROKER_LINK_IDENTITY_PROVIDER, tableName=BROKER_LINK		\N	4.33.0	\N	\N	9124202530
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
d97d657d-c2a8-4c20-a3a8-4ca15a52738d	57a2e151-26f8-450e-b005-0602dbb8a225	f
d97d657d-c2a8-4c20-a3a8-4ca15a52738d	9f928ed9-bf85-4eab-b6af-ef3e3a1fcb6b	t
d97d657d-c2a8-4c20-a3a8-4ca15a52738d	6eaf9b37-dcac-4ec2-89b9-0d52ad20ae49	t
d97d657d-c2a8-4c20-a3a8-4ca15a52738d	762e75d9-0f85-4428-9f61-dd29b70fbca7	t
d97d657d-c2a8-4c20-a3a8-4ca15a52738d	31343b91-30b1-4820-badb-3fdb3bd99344	t
d97d657d-c2a8-4c20-a3a8-4ca15a52738d	576c8bc9-0e41-41ad-ad3a-e4e08b1e136c	f
d97d657d-c2a8-4c20-a3a8-4ca15a52738d	3c2019e4-c7d8-4baa-8468-1fdfae651ed3	f
d97d657d-c2a8-4c20-a3a8-4ca15a52738d	9c785d74-50ff-459f-9516-adb26979d24d	t
d97d657d-c2a8-4c20-a3a8-4ca15a52738d	5dd71a61-adff-44c0-8cac-6308d473a68c	t
d97d657d-c2a8-4c20-a3a8-4ca15a52738d	84040f67-5a1f-4a3d-ab25-9a5c40ba8cd1	f
d97d657d-c2a8-4c20-a3a8-4ca15a52738d	f8762493-840b-42b4-8416-20d2e2e9546e	t
d97d657d-c2a8-4c20-a3a8-4ca15a52738d	1203ff0f-5a41-4afc-9dd0-82038219797a	t
d97d657d-c2a8-4c20-a3a8-4ca15a52738d	94252ff3-4947-43fd-a72d-51f3b111c925	f
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	34982ee3-5e7d-4b38-aa4b-9007a7e9047d	f
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	2d143538-2878-4812-be3b-3f75a9564ae1	t
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	b9e06341-04a2-4151-86b3-2cf13abc8a72	t
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	eb8ffb5e-641e-42da-ab1a-f8948abf85aa	t
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	73a899b2-50be-43ba-b233-4f9b0f856306	t
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	88508b6c-f1a9-4677-bc83-cd819ffbd95a	f
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	4b6c1f65-c316-41dc-816f-410ba75388f7	f
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	6cd790ae-baff-47a2-a0e1-3c775ee20d3e	t
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	599c40ac-4f06-4952-b50a-5bce8d372b5e	t
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	f80d7182-f104-4a13-9334-e5b9d8be1b6f	f
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	795a4fcb-21b3-4b2f-b8e7-e9964b1f9686	t
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	21b289c4-86ab-46da-b930-5c0f30be7a34	t
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	72e16833-952b-46a6-a583-a8c462a2cdac	f
\.


--
-- Data for Name: equipo_medico; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.equipo_medico (id, fecha_asignacion, rol, id_cirugia, id_personal, id_urgencia) FROM stdin;
75	2026-04-24 18:47:27.540486	Personal	256	38	\N
76	2026-04-24 18:47:27.541407	Personal	256	28	\N
84	2026-04-27 18:54:38.707893	Usuario	\N	31	1
85	2026-04-27 19:39:47.128253	Usuario	289	32	\N
89	2026-04-28 18:08:36.308786	Usuario	\N	33	2
90	2026-04-28 18:08:36.30959	Usuario	\N	30	2
91	2026-05-05 19:09:37.258766	Medico	281	29	\N
92	2026-05-05 19:09:37.275873	Personal	281	34	\N
93	2026-05-05 19:09:37.277538	Usuario	281	32	\N
94	2026-05-05 20:38:07.631445	Cirujano	\N	30	11
95	2026-05-05 20:41:20.691783	Cirujano	\N	30	13
96	2026-05-05 20:43:04.475744	Cirujano	\N	30	8
97	2026-05-05 20:55:18.265068	Cirujano	\N	30	10
98	2026-05-06 17:48:35.02195	Cirujano	312	30	\N
\.


--
-- Data for Name: equipo_medico_urgencia; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.equipo_medico_urgencia (id, fecha_asignacion, rol, id_personal, id_urgencia) FROM stdin;
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: intervencion; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.intervencion (id, observaciones, cirugia_id, tipo_intervencion_id, urgencia_id, id_urgencia) FROM stdin;
9	312312	258	2	\N	\N
10	ugikjl;kmml;	281	2	\N	\N
12	asasd	\N	2	\N	2
13	asfsd	281	2	\N	\N
14	aaa	\N	1	\N	11
15	a	312	2	\N	\N
\.


--
-- Data for Name: jgroups_ping; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.jgroups_ping (address, name, cluster_name, ip, coord) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type, description) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
2439e07d-eecf-4e4f-9a13-24aac26dcd66	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	f	${role_default-roles}	default-roles-master	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	\N	\N
401c85ca-5f45-4959-821a-8b74dd59c76b	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	f	${role_admin}	admin	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	\N	\N
8ec73f86-f34a-4cb9-be1e-ec1edbde03e1	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	f	${role_create-realm}	create-realm	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	\N	\N
47ba1f30-99d2-40d1-84ec-8dca108e0ab0	7196ea6b-8216-4773-a2ab-de3c674db4c7	t	${role_create-client}	create-client	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	7196ea6b-8216-4773-a2ab-de3c674db4c7	\N
788ad063-a164-4e5b-b6ac-3e5b3837e5a3	7196ea6b-8216-4773-a2ab-de3c674db4c7	t	${role_view-realm}	view-realm	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	7196ea6b-8216-4773-a2ab-de3c674db4c7	\N
8f314735-0068-4669-a559-51329b96d4f0	7196ea6b-8216-4773-a2ab-de3c674db4c7	t	${role_view-users}	view-users	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	7196ea6b-8216-4773-a2ab-de3c674db4c7	\N
4b02999c-805c-4ff6-ade3-0e7d018dc1e6	7196ea6b-8216-4773-a2ab-de3c674db4c7	t	${role_view-clients}	view-clients	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	7196ea6b-8216-4773-a2ab-de3c674db4c7	\N
ade6fffe-bc3b-4962-b069-75eac5726bea	7196ea6b-8216-4773-a2ab-de3c674db4c7	t	${role_view-events}	view-events	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	7196ea6b-8216-4773-a2ab-de3c674db4c7	\N
a3e32c71-4e60-4f4b-b6e1-a2a9eaf1627b	7196ea6b-8216-4773-a2ab-de3c674db4c7	t	${role_view-identity-providers}	view-identity-providers	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	7196ea6b-8216-4773-a2ab-de3c674db4c7	\N
5e525ac9-c985-481b-873d-32da4890e7d3	7196ea6b-8216-4773-a2ab-de3c674db4c7	t	${role_view-authorization}	view-authorization	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	7196ea6b-8216-4773-a2ab-de3c674db4c7	\N
d263d0ae-aeb1-4104-9f70-1b35d871d931	7196ea6b-8216-4773-a2ab-de3c674db4c7	t	${role_manage-realm}	manage-realm	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	7196ea6b-8216-4773-a2ab-de3c674db4c7	\N
ba627645-ed38-4aad-9e8c-a435169319df	7196ea6b-8216-4773-a2ab-de3c674db4c7	t	${role_manage-users}	manage-users	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	7196ea6b-8216-4773-a2ab-de3c674db4c7	\N
dfda3ec0-f572-4c77-97dc-54703c3d0545	7196ea6b-8216-4773-a2ab-de3c674db4c7	t	${role_manage-clients}	manage-clients	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	7196ea6b-8216-4773-a2ab-de3c674db4c7	\N
5ff8def1-0889-4b11-bc10-119e4abc1aa3	7196ea6b-8216-4773-a2ab-de3c674db4c7	t	${role_manage-events}	manage-events	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	7196ea6b-8216-4773-a2ab-de3c674db4c7	\N
680b34ae-dd60-445f-ab65-6c623c100444	7196ea6b-8216-4773-a2ab-de3c674db4c7	t	${role_manage-identity-providers}	manage-identity-providers	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	7196ea6b-8216-4773-a2ab-de3c674db4c7	\N
10ace31b-fb28-47e8-b61a-fa09d00fdfb7	7196ea6b-8216-4773-a2ab-de3c674db4c7	t	${role_manage-authorization}	manage-authorization	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	7196ea6b-8216-4773-a2ab-de3c674db4c7	\N
73640819-3816-4e7f-a601-f1e90e1a9205	7196ea6b-8216-4773-a2ab-de3c674db4c7	t	${role_query-users}	query-users	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	7196ea6b-8216-4773-a2ab-de3c674db4c7	\N
ae19c8ff-d907-4bdb-be82-77103774b552	7196ea6b-8216-4773-a2ab-de3c674db4c7	t	${role_query-clients}	query-clients	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	7196ea6b-8216-4773-a2ab-de3c674db4c7	\N
97b998fe-a1c1-492b-9bf5-9dfbdcf3c9a8	7196ea6b-8216-4773-a2ab-de3c674db4c7	t	${role_query-realms}	query-realms	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	7196ea6b-8216-4773-a2ab-de3c674db4c7	\N
47e07117-abf0-4ef2-b2cf-59d26019ceee	7196ea6b-8216-4773-a2ab-de3c674db4c7	t	${role_query-groups}	query-groups	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	7196ea6b-8216-4773-a2ab-de3c674db4c7	\N
b4670921-e7f4-4520-9047-92491e45443f	3853b62d-0671-4bb5-9980-a8724355460a	t	${role_view-profile}	view-profile	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	3853b62d-0671-4bb5-9980-a8724355460a	\N
f6207dad-e8d1-427c-a3d6-4b5e08c3a9a9	3853b62d-0671-4bb5-9980-a8724355460a	t	${role_manage-account}	manage-account	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	3853b62d-0671-4bb5-9980-a8724355460a	\N
261125fb-2fef-4c79-887a-bd88e63571a5	3853b62d-0671-4bb5-9980-a8724355460a	t	${role_manage-account-links}	manage-account-links	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	3853b62d-0671-4bb5-9980-a8724355460a	\N
45844197-5249-4586-98c1-16733305fd42	3853b62d-0671-4bb5-9980-a8724355460a	t	${role_view-applications}	view-applications	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	3853b62d-0671-4bb5-9980-a8724355460a	\N
50dc5490-5b35-4326-8a92-e2cd3c62f7af	3853b62d-0671-4bb5-9980-a8724355460a	t	${role_view-consent}	view-consent	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	3853b62d-0671-4bb5-9980-a8724355460a	\N
f0af8aa4-b999-43b5-a319-b55f0b41c26e	3853b62d-0671-4bb5-9980-a8724355460a	t	${role_manage-consent}	manage-consent	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	3853b62d-0671-4bb5-9980-a8724355460a	\N
1e6d2221-756b-4e8e-8fe6-3740bc698528	3853b62d-0671-4bb5-9980-a8724355460a	t	${role_view-groups}	view-groups	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	3853b62d-0671-4bb5-9980-a8724355460a	\N
f3cb4971-2be9-41ac-971e-f9ab6f28da89	3853b62d-0671-4bb5-9980-a8724355460a	t	${role_delete-account}	delete-account	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	3853b62d-0671-4bb5-9980-a8724355460a	\N
323ee233-adce-403b-b906-7acae4673f0f	a18c5734-736b-4ca6-b5b7-8387d03e25ab	t	${role_read-token}	read-token	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	a18c5734-736b-4ca6-b5b7-8387d03e25ab	\N
3e29ad58-5245-4f03-9c05-bea7d2e2a918	7196ea6b-8216-4773-a2ab-de3c674db4c7	t	${role_impersonation}	impersonation	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	7196ea6b-8216-4773-a2ab-de3c674db4c7	\N
5b47d572-3c44-4d32-8c3b-0967733e65b2	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	f	${role_offline-access}	offline_access	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	\N	\N
470ae50d-ecf1-4768-a99b-7c66bce0356c	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	f	${role_uma_authorization}	uma_authorization	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	\N	\N
8fc1edbd-5d64-460f-97b4-3b4fdf427189	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	f	${role_default-roles}	default-roles-dacs	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	\N	\N
60b6184e-a77a-440a-8a6a-8c282360ac40	6f7c43c3-7963-4bdd-9997-3869cfd54951	t	${role_create-client}	create-client	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	6f7c43c3-7963-4bdd-9997-3869cfd54951	\N
1f3e363a-1755-4702-99f0-2a520079b308	6f7c43c3-7963-4bdd-9997-3869cfd54951	t	${role_view-realm}	view-realm	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	6f7c43c3-7963-4bdd-9997-3869cfd54951	\N
85b20729-3829-48c1-96a3-966c4322c56c	6f7c43c3-7963-4bdd-9997-3869cfd54951	t	${role_view-users}	view-users	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	6f7c43c3-7963-4bdd-9997-3869cfd54951	\N
1826f980-e86d-466c-b969-c3b0f24eeb15	6f7c43c3-7963-4bdd-9997-3869cfd54951	t	${role_view-clients}	view-clients	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	6f7c43c3-7963-4bdd-9997-3869cfd54951	\N
455a5ad7-5097-47e6-84c3-2b3b688991ef	6f7c43c3-7963-4bdd-9997-3869cfd54951	t	${role_view-events}	view-events	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	6f7c43c3-7963-4bdd-9997-3869cfd54951	\N
019d18b4-1c1b-47b3-9806-bf8f37a07271	6f7c43c3-7963-4bdd-9997-3869cfd54951	t	${role_view-identity-providers}	view-identity-providers	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	6f7c43c3-7963-4bdd-9997-3869cfd54951	\N
9c6e2ce9-007b-4f0d-91d9-a8c569988d76	6f7c43c3-7963-4bdd-9997-3869cfd54951	t	${role_view-authorization}	view-authorization	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	6f7c43c3-7963-4bdd-9997-3869cfd54951	\N
264ba0e9-d8d1-45fb-88a6-692e9ed1b122	6f7c43c3-7963-4bdd-9997-3869cfd54951	t	${role_manage-realm}	manage-realm	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	6f7c43c3-7963-4bdd-9997-3869cfd54951	\N
816d4f7b-b254-41ac-9e3c-6340b13b812b	6f7c43c3-7963-4bdd-9997-3869cfd54951	t	${role_manage-users}	manage-users	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	6f7c43c3-7963-4bdd-9997-3869cfd54951	\N
79b52ec0-a906-4853-9cd6-54b40bac6721	6f7c43c3-7963-4bdd-9997-3869cfd54951	t	${role_manage-clients}	manage-clients	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	6f7c43c3-7963-4bdd-9997-3869cfd54951	\N
892c4b9f-29a9-46c9-9390-36c7ed805b90	6f7c43c3-7963-4bdd-9997-3869cfd54951	t	${role_manage-events}	manage-events	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	6f7c43c3-7963-4bdd-9997-3869cfd54951	\N
1db8949f-f629-43c7-b5ce-b94b89df7fa0	6f7c43c3-7963-4bdd-9997-3869cfd54951	t	${role_manage-identity-providers}	manage-identity-providers	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	6f7c43c3-7963-4bdd-9997-3869cfd54951	\N
45575167-cc26-4105-8b54-6ca3a9048cea	6f7c43c3-7963-4bdd-9997-3869cfd54951	t	${role_manage-authorization}	manage-authorization	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	6f7c43c3-7963-4bdd-9997-3869cfd54951	\N
730669d5-1bf7-45e3-8e33-2833f73ec657	6f7c43c3-7963-4bdd-9997-3869cfd54951	t	${role_query-users}	query-users	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	6f7c43c3-7963-4bdd-9997-3869cfd54951	\N
4b0d0f0e-a1d2-4c50-a958-7747ef0fd610	6f7c43c3-7963-4bdd-9997-3869cfd54951	t	${role_query-clients}	query-clients	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	6f7c43c3-7963-4bdd-9997-3869cfd54951	\N
3bb3d42a-6d0f-4d98-b268-fee66d4315a6	6f7c43c3-7963-4bdd-9997-3869cfd54951	t	${role_query-realms}	query-realms	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	6f7c43c3-7963-4bdd-9997-3869cfd54951	\N
d035ed43-2e93-47c4-afb3-fd9a589eeb5d	6f7c43c3-7963-4bdd-9997-3869cfd54951	t	${role_query-groups}	query-groups	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	6f7c43c3-7963-4bdd-9997-3869cfd54951	\N
dfc4d070-2ffb-4953-8e99-4a8f12921e76	dad7d20e-96d4-47c9-a64a-8ed9c833b897	t	${role_realm-admin}	realm-admin	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dad7d20e-96d4-47c9-a64a-8ed9c833b897	\N
e133e3db-44fc-4065-b442-ff0b7e2d0a99	dad7d20e-96d4-47c9-a64a-8ed9c833b897	t	${role_create-client}	create-client	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dad7d20e-96d4-47c9-a64a-8ed9c833b897	\N
1ac5a204-fb46-4700-bc05-8ef62ebeb3e0	dad7d20e-96d4-47c9-a64a-8ed9c833b897	t	${role_view-realm}	view-realm	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dad7d20e-96d4-47c9-a64a-8ed9c833b897	\N
4f436c94-8df5-4e86-a3fa-d3b99ce04a8e	dad7d20e-96d4-47c9-a64a-8ed9c833b897	t	${role_view-users}	view-users	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dad7d20e-96d4-47c9-a64a-8ed9c833b897	\N
d9ebc80c-f637-4023-a1ec-c41ab77c8f2b	dad7d20e-96d4-47c9-a64a-8ed9c833b897	t	${role_view-clients}	view-clients	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dad7d20e-96d4-47c9-a64a-8ed9c833b897	\N
54c77e64-5e5a-4758-b7f9-ab97d73169ec	dad7d20e-96d4-47c9-a64a-8ed9c833b897	t	${role_view-events}	view-events	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dad7d20e-96d4-47c9-a64a-8ed9c833b897	\N
701f4fe1-71d3-4212-915a-e943feb141cf	dad7d20e-96d4-47c9-a64a-8ed9c833b897	t	${role_view-identity-providers}	view-identity-providers	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dad7d20e-96d4-47c9-a64a-8ed9c833b897	\N
6f828e14-b06a-4499-93fa-138826be0216	dad7d20e-96d4-47c9-a64a-8ed9c833b897	t	${role_view-authorization}	view-authorization	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dad7d20e-96d4-47c9-a64a-8ed9c833b897	\N
b296ed71-5f27-4b60-b299-6157d5ac954e	dad7d20e-96d4-47c9-a64a-8ed9c833b897	t	${role_manage-realm}	manage-realm	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dad7d20e-96d4-47c9-a64a-8ed9c833b897	\N
fe89dd59-55e8-4737-aaab-91940d46a6b8	dad7d20e-96d4-47c9-a64a-8ed9c833b897	t	${role_manage-users}	manage-users	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dad7d20e-96d4-47c9-a64a-8ed9c833b897	\N
13358d59-d354-49b2-8ade-fd54cb4d1300	dad7d20e-96d4-47c9-a64a-8ed9c833b897	t	${role_manage-clients}	manage-clients	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dad7d20e-96d4-47c9-a64a-8ed9c833b897	\N
710bbc58-b0bb-4970-b0bd-a2d82080c0a3	dad7d20e-96d4-47c9-a64a-8ed9c833b897	t	${role_manage-events}	manage-events	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dad7d20e-96d4-47c9-a64a-8ed9c833b897	\N
e1552b71-3b12-4ee1-a9dc-17080865b49c	dad7d20e-96d4-47c9-a64a-8ed9c833b897	t	${role_manage-identity-providers}	manage-identity-providers	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dad7d20e-96d4-47c9-a64a-8ed9c833b897	\N
9ca2e44e-22bb-4025-abef-0eb2b9f830f7	dad7d20e-96d4-47c9-a64a-8ed9c833b897	t	${role_manage-authorization}	manage-authorization	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dad7d20e-96d4-47c9-a64a-8ed9c833b897	\N
9f70bf0a-1320-4a34-94e5-e68761ab07dc	dad7d20e-96d4-47c9-a64a-8ed9c833b897	t	${role_query-users}	query-users	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dad7d20e-96d4-47c9-a64a-8ed9c833b897	\N
9dc0f021-1ff9-46a7-85e7-7657440445d2	dad7d20e-96d4-47c9-a64a-8ed9c833b897	t	${role_query-clients}	query-clients	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dad7d20e-96d4-47c9-a64a-8ed9c833b897	\N
762318a9-6758-4e23-9770-82547a6d591a	dad7d20e-96d4-47c9-a64a-8ed9c833b897	t	${role_query-realms}	query-realms	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dad7d20e-96d4-47c9-a64a-8ed9c833b897	\N
3b22eb73-f2f6-46bb-b021-230559b5a76f	dad7d20e-96d4-47c9-a64a-8ed9c833b897	t	${role_query-groups}	query-groups	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dad7d20e-96d4-47c9-a64a-8ed9c833b897	\N
6a79eb89-79f3-4539-bba5-18e1d270fb04	dcd2b2aa-e336-4d3c-8e00-8f356feefd25	t	${role_view-profile}	view-profile	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dcd2b2aa-e336-4d3c-8e00-8f356feefd25	\N
b40cd027-c121-42c3-8633-ba98f3ea193f	dcd2b2aa-e336-4d3c-8e00-8f356feefd25	t	${role_manage-account}	manage-account	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dcd2b2aa-e336-4d3c-8e00-8f356feefd25	\N
8e080b1d-1f7a-4785-927b-2bd5cf8d2aab	dcd2b2aa-e336-4d3c-8e00-8f356feefd25	t	${role_manage-account-links}	manage-account-links	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dcd2b2aa-e336-4d3c-8e00-8f356feefd25	\N
fd30c54d-c4dc-4d4d-9687-360c3e3ab80f	dcd2b2aa-e336-4d3c-8e00-8f356feefd25	t	${role_view-applications}	view-applications	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dcd2b2aa-e336-4d3c-8e00-8f356feefd25	\N
e3444dc3-9514-44a0-ad3e-ab815ee7f9b0	dcd2b2aa-e336-4d3c-8e00-8f356feefd25	t	${role_view-consent}	view-consent	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dcd2b2aa-e336-4d3c-8e00-8f356feefd25	\N
35c993fa-fa37-454a-aab9-1239de34be95	dcd2b2aa-e336-4d3c-8e00-8f356feefd25	t	${role_manage-consent}	manage-consent	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dcd2b2aa-e336-4d3c-8e00-8f356feefd25	\N
78694c8f-28c7-49c2-98b1-fd20ca0b1d83	dcd2b2aa-e336-4d3c-8e00-8f356feefd25	t	${role_view-groups}	view-groups	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dcd2b2aa-e336-4d3c-8e00-8f356feefd25	\N
e9171871-4be4-4890-9040-5809df77c9bf	dcd2b2aa-e336-4d3c-8e00-8f356feefd25	t	${role_delete-account}	delete-account	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dcd2b2aa-e336-4d3c-8e00-8f356feefd25	\N
e9eab650-d2de-4875-99cc-1b0833c4502a	6f7c43c3-7963-4bdd-9997-3869cfd54951	t	${role_impersonation}	impersonation	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	6f7c43c3-7963-4bdd-9997-3869cfd54951	\N
ff0627e9-0920-4d16-93d5-103765af78f9	dad7d20e-96d4-47c9-a64a-8ed9c833b897	t	${role_impersonation}	impersonation	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	dad7d20e-96d4-47c9-a64a-8ed9c833b897	\N
31c74c99-8178-44a5-b12b-3053ead36ad1	3aa1c395-bec1-4dc4-ade2-eb0f964f3897	t	${role_read-token}	read-token	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	3aa1c395-bec1-4dc4-ade2-eb0f964f3897	\N
0a073e89-ceed-4ec3-a0c2-a9f62ae9f48a	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	f	${role_offline-access}	offline_access	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	\N	\N
c9c931dd-4e62-45ba-b277-13c372237a1e	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	f	${role_uma_authorization}	uma_authorization	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	\N	\N
f79eff34-0d28-4b9f-a69c-bab657e0198e	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	f	ROLE A 	ROLE-A	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	\N	\N
c4e0301e-7029-45cb-9ef7-18fd8f7a3027	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	f	ROLE B	ROLE-B	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	\N	\N
c32dc552-b9d4-4670-bc1a-6ddd8de174f4	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	f	Rol de personal medico.	personal_medico	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	\N	\N
160efc49-ade7-426e-9956-24f2c8f2f9a3	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	f	Rol de admin del sistema.	admin	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.migration_model (id, version, update_time) FROM stdin;
bxc3z	26.4.0	1762115285
hv0fv	26.4.2	1762118791
zj8mx	26.4.7	1766438893
3p3ey	26.5.1	1769124206
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
QW1l4peBzdmP00YIn7TsLGIo	0cd5aab5-658d-44b4-b3f0-a7b3592ba199	0	1778193634	{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/paciente","notes":{"clientId":"0cd5aab5-658d-44b4-b3f0-a7b3592ba199","iss":"http://localhost:8080/realms/dacs","startedAt":"1778188964","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"a2c9a993-3c38-4dbc-a3f1-fa9647e3144e","response_mode":"fragment","scope":"openid","userSessionStartedAt":"1778188964","redirect_uri":"http://localhost:4200/paciente","state":"608a6cc2-698f-4530-a1f9-a85640621a00","code_challenge":"3G_Agu6uSC7waJHUQ0fTC9bppLkpx60ggSq--dEsgFo","SSO_AUTH":"true"}}	local	local	21
QW1l4peBzdmP00YIn7TsLGIo	6178dd03-ea93-491b-9340-c44abcfe617c	0	1778192784	{"authMethod":"openid-connect","redirectUri":"http://localhost:8080/realms/dacs/account?referrer=dacs-fe&referrer_uri=http%3A%2F%2Flocalhost%3A4200%2Fhome","notes":{"clientId":"6178dd03-ea93-491b-9340-c44abcfe617c","iss":"http://localhost:8080/realms/dacs","startedAt":"1778192784","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"a2ddb11f-d581-4d6f-9607-1b16c52b107f","response_mode":"query","scope":"openid","SSO_AUTH":"true","userSessionStartedAt":"1778188964","redirect_uri":"http://localhost:8080/realms/dacs/account?referrer=dacs-fe&referrer_uri=http%3A%2F%2Flocalhost%3A4200%2Fhome","state":"48cc06ff-a175-4133-bc8d-9d504cb2a7da","code_challenge":"18Dt-6QqV3k3oDi-mlIRdAHEKovolI8DE4Qd8-x5fYE"}}	local	local	0
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version, remember_me) FROM stdin;
QW1l4peBzdmP00YIn7TsLGIo	6e6ab2e8-79f1-4a3f-944a-0cca02dc3e76	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	1778188964	0	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJMaW51eCIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xNTAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1778188964","authenticators-completed":"{\\"d83c3d61-5af3-47b3-9341-9046bb2e58cd\\":1778188964,\\"84d4c5fe-6877-45db-b785-707bcaaea1b0\\":1778192784}"},"state":"LOGGED_IN"}	1778193634	\N	23	f
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: org_invitation; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.org_invitation (id, organization_id, email, first_name, last_name, created_at, expires_at, invite_link) FROM stdin;
\.


--
-- Data for Name: paciente; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.paciente (id, altura, direccion, dni, nombre, peso, telefono, apellido, fecha_nacimiento, active) FROM stdin;
3	1111.0	Vigo, Andalucía	04500908-H	Ismael	111.0	902-741-919	Morales	1984-08-27	t
7	1111.0	Vigo, Andalucía	04500908-H	Ismael	1111.0	902-741-919	Morales	1984-08-27	t
8	111.0	Vigo, Andalucía	04500908-H	Ismael	1111.0	902-741-919	Morales	1984-08-27	t
10	12.0	Logroño, País Vasco	10111729-A	Fátima	12.0	977-827-945	López	1997-12-06	t
11	111.0	La Coruña, Comunidad Valenciana	59940130-H	Margarita	121.0	984-155-375	Hernández	1956-08-20	t
12	33.0	Burgos, País Vasco	41563182-I	Eugenia	33.0	973-546-127	Suarez	1978-04-04	t
14	44.0	Granada, Cataluña	02692004-H	Remedios	44.0	986-053-176	Lozano	1949-06-04	t
15	123.0	Mérida, Cantabria	18431005-I	Julia	123.0	913-895-635	Vicente	1954-06-09	t
16	123.0	Albacete, Melilla	39532871-G	Patricia	123.0	942-416-912	Blanco	1946-06-01	t
17	33.0	Murcia, Cantabria	79903777-T	Gregorio	33.0	924-490-406	Jiménez	1980-05-24	t
18	1.0	Lorca, Extremadura	81701237-E	Irene	1.0	956-728-633	Delgado	1982-05-02	t
19	2.0	Guadalajara, Navarra	15709493-I	Guillermo	2.0	927-305-855	Castillo	1967-03-03	t
20	123.0	Torrente, Cataluña	76951475-P	Rafael	123.0	970-880-710	Prieto	1971-12-19	t
21	12.0	San Sebastián, Castilla y León	36666688-N	Cesar	1213.0	910-161-073	Guerrero	1980-04-26	t
22	11.0	La Palma, Extremadura	81575808-J	Manuel	11.0	952-123-832	Santana	1990-02-24	t
23	112.0	La Palma, Andalucía	17775725-U	Ángeles	11.0	915-104-685	Flores	1975-03-23	t
24	177.0	Las Palmas de Gran Canaria, Castilla y León	44694859-X	Fátima	111.0	917-560-114	Gallardo	1992-08-30	t
25	166.0	Castellón de la Plana, Cataluña	45256666-J	Jesus	123.0	966-517-035	Rojas	1980-08-08	t
26	177.0	Las Palmas de Gran Canaria, Castilla la Mancha	44445067-Y	Francisca	111.0	911-779-582	Santos	1991-01-17	t
28	1111.0	Blankenhain, Bayern	39 060479 N 418	Friedrich-Wilhelm	1111.0	0185-0793435	Niermann	1979-04-06	t
29	1.75	Calle Falsa 123	12345678	Juan Pérez	80.0	3456789012	Perez	2000-01-01	t
30	1111.0	Vigo, Andalucía	04500908-H	Ismael	111.0	902-741-919	Morales	1984-08-27	t
1	1.75	Calle Falsa 123	12345678	Juan Pérez	80	3456789012	Perez	2000-01-01	f
2	1.75	Calle Falsa 123	12345678	Juan Pérez	70	1234-567890	Perez	2000-01-01	f
33	1.0	Lintrup, Nordjylland	12345678	Magnus	1.0	79217921	Poulsen	1974-08-08	f
31	166.0	Lasalle, Northwest Territories	281494658	Delphine	55.0	X40 I55-3354	Harris	1981-01-28	f
32	1.75	Calle Falsa 123	12345678	Juan Pérez	70.0	1234-567890	Perez	2000-01-01	t
13	11.0	Orense, La Rioja	79659500-R	Benito	21.0	931-278-450	Ortiz	1963-03-09	f
\.


--
-- Data for Name: personal; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.personal (id, especialidad, estado, legajo, nombre, rol, telefono, dni, apellido) FROM stdin;
31	Anestesista	Alta	54322111	Laura	Usuario	231122	5567123	Martinez
32	Traumatologo	Alta	14598237	Federico	Usuario	564321	3712349	Ibarra
33	Tecnico Laboratorio	Alta	28473916	Tomas	Usuario	554433	3334512	Godoy
34	Nutricionista	Alta	55671238	Cecilia	Personal	446787	3319874	Pardo
35	Farmaceutica	Alta	32435345	Natalia	Personal	529433	32112211	Sosa
36	Medico Clinico	Alta	66781234	Nicolas	Personal	546423	324411	Duarte
38	Neurologo	Alta	78123945	Gustavo	Personal	546642	23441124	Molina
28	Enfermero	Alta	124345422	Cristian	Personal	123321	4441112	Bidal
39	Cirujano Plastico	Alta	5325234	Ricardo	Personal	243546	342356	Pardo
40	Tecnico Radiologia	Alta	64363463	Paula	Personal	655422	214354	Silva
29	Director	Alta	2334412	Camila	personal_medico	+344112211	345553111	Perez
27	Medico	alta	12355645	Jose	personal_medico	+444425511	1234678	Gimenez
41	Administrativa	alta	34345436	Valeria	admin	+56226535	43541223	Campos
37	Gerente	alta	24545651	Mariana	admin	+23435311	32441123	Vera
43	Cardiologo	baja	235342543	Alonzo	personal_medico	+323432352	4355522	Martinez
30	Cirujano	alta	233212431	Alejo	personal_medico	+4224111111	42500000	Nandez
42	Fonoaudiologo	alta	4356346	Daniela	personal_medico	+3434343434	34235356	Rios
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
3baf2894-a8ad-4ce3-a3aa-892650f398a2	audience resolve	openid-connect	oidc-audience-resolve-mapper	cc39bee7-2e22-4ec7-96e6-47f3b38f88ad	\N
49c32d0a-1661-4382-b4ff-6f858be4847e	locale	openid-connect	oidc-usermodel-attribute-mapper	bf31eec8-25de-4851-8df5-e95fdbad8878	\N
12300760-93d9-4c74-99e7-9121687ebe41	role list	saml	saml-role-list-mapper	\N	9f928ed9-bf85-4eab-b6af-ef3e3a1fcb6b
d32ddc38-4448-4d8e-a13e-fbec56f5a635	organization	saml	saml-organization-membership-mapper	\N	6eaf9b37-dcac-4ec2-89b9-0d52ad20ae49
66e9d95a-8d63-41dc-a9cd-11b50b48b783	full name	openid-connect	oidc-full-name-mapper	\N	762e75d9-0f85-4428-9f61-dd29b70fbca7
df2bce65-2d60-4ed9-b3bd-bfeee0cbbf33	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	762e75d9-0f85-4428-9f61-dd29b70fbca7
fa18b365-21ef-4232-b0b5-373dbd2af7ee	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	762e75d9-0f85-4428-9f61-dd29b70fbca7
fde42da6-9cd6-4ebf-9e96-2b5c885ad3a8	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	762e75d9-0f85-4428-9f61-dd29b70fbca7
6064d330-3197-49d3-bd65-e2d11334f773	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	762e75d9-0f85-4428-9f61-dd29b70fbca7
9c89ffb9-0b4a-47a8-ba28-4e19cff81734	username	openid-connect	oidc-usermodel-attribute-mapper	\N	762e75d9-0f85-4428-9f61-dd29b70fbca7
a7b1b0cb-1973-45c8-a2c1-c89dd210016d	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	762e75d9-0f85-4428-9f61-dd29b70fbca7
6fa9e2fa-3720-4ac8-949d-b4b6b623e7f7	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	762e75d9-0f85-4428-9f61-dd29b70fbca7
5eced984-8ca5-43b9-ba17-6864dc6050c9	website	openid-connect	oidc-usermodel-attribute-mapper	\N	762e75d9-0f85-4428-9f61-dd29b70fbca7
a3bffb05-2c84-41b9-a09b-3c9fdb021825	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	762e75d9-0f85-4428-9f61-dd29b70fbca7
a36009e0-77be-4d97-b5c4-a322c28a991c	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	762e75d9-0f85-4428-9f61-dd29b70fbca7
c61df367-b6ad-45ba-8db0-db5319d74e9b	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	762e75d9-0f85-4428-9f61-dd29b70fbca7
b1215ad7-1020-4e6a-b228-914320a2b4fd	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	762e75d9-0f85-4428-9f61-dd29b70fbca7
3ff1e96f-d311-4f4a-80f9-0f4313569916	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	762e75d9-0f85-4428-9f61-dd29b70fbca7
47fffd12-a784-40de-b569-8d58b4ce808b	email	openid-connect	oidc-usermodel-attribute-mapper	\N	31343b91-30b1-4820-badb-3fdb3bd99344
242816c8-e51b-42bf-82c4-f019699d0f04	email verified	openid-connect	oidc-usermodel-property-mapper	\N	31343b91-30b1-4820-badb-3fdb3bd99344
897676e4-9374-4d7d-bcbd-6b36cfc49d12	address	openid-connect	oidc-address-mapper	\N	576c8bc9-0e41-41ad-ad3a-e4e08b1e136c
39951de6-6df1-4d16-bc86-41e274e6b5e8	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	3c2019e4-c7d8-4baa-8468-1fdfae651ed3
2fc03c35-5061-4f91-b7db-5fe7ce70a551	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	3c2019e4-c7d8-4baa-8468-1fdfae651ed3
69ec4751-2d63-4d93-bf68-7a3d41d3d087	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	9c785d74-50ff-459f-9516-adb26979d24d
fc021b29-7ce3-43ed-8ad0-bcb29684ff99	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	9c785d74-50ff-459f-9516-adb26979d24d
df5c29e2-e625-45bf-9946-9216cb60be91	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	9c785d74-50ff-459f-9516-adb26979d24d
4f58d6bf-033d-4103-bc1a-259704930674	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	5dd71a61-adff-44c0-8cac-6308d473a68c
510ec04b-1b90-4869-a078-2ed78326b155	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	84040f67-5a1f-4a3d-ab25-9a5c40ba8cd1
08e234cd-9ffc-4607-afb3-2c5b789b7629	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	84040f67-5a1f-4a3d-ab25-9a5c40ba8cd1
67f6c5a7-8133-475d-9a5a-d532eea188f6	acr loa level	openid-connect	oidc-acr-mapper	\N	f8762493-840b-42b4-8416-20d2e2e9546e
0e44bd44-2e76-40a5-8f19-9a24b0285e54	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	1203ff0f-5a41-4afc-9dd0-82038219797a
6a43ad3c-28ba-4b97-96c1-13076ccb7fe9	sub	openid-connect	oidc-sub-mapper	\N	1203ff0f-5a41-4afc-9dd0-82038219797a
c46eaa2e-8c19-40dd-8f61-c320e8acdeba	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	f50f4215-18b8-4354-95b8-1876d0ff3464
a0fcd7ff-9970-4f27-9e82-2d0bf4337b19	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	f50f4215-18b8-4354-95b8-1876d0ff3464
e19d2890-3659-43c8-b14d-ed51202a4a6c	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	f50f4215-18b8-4354-95b8-1876d0ff3464
a5aa0850-ca98-4f81-a077-3bc1a4fe4047	organization	openid-connect	oidc-organization-membership-mapper	\N	94252ff3-4947-43fd-a72d-51f3b111c925
d8f0a97e-e32f-4bf2-a472-88f096a6a50c	audience resolve	openid-connect	oidc-audience-resolve-mapper	6178dd03-ea93-491b-9340-c44abcfe617c	\N
26707b1d-562d-4f5f-83ab-c90c6c00fefb	role list	saml	saml-role-list-mapper	\N	2d143538-2878-4812-be3b-3f75a9564ae1
f806162a-c4f4-4462-9aa6-4d7eefe4e75d	organization	saml	saml-organization-membership-mapper	\N	b9e06341-04a2-4151-86b3-2cf13abc8a72
dfe8f14b-f0a1-4a68-9530-4d8f8cb3cd0a	full name	openid-connect	oidc-full-name-mapper	\N	eb8ffb5e-641e-42da-ab1a-f8948abf85aa
d73dc2da-8c3c-4f32-99f0-7baebf894b3b	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	eb8ffb5e-641e-42da-ab1a-f8948abf85aa
d83d12a8-a513-48ae-bd9c-c4988d47238a	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	eb8ffb5e-641e-42da-ab1a-f8948abf85aa
5bc8e2ed-81ac-4128-bf9a-d6bc94924fff	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	eb8ffb5e-641e-42da-ab1a-f8948abf85aa
e7475b79-6fce-4566-a37a-3c912359001b	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	eb8ffb5e-641e-42da-ab1a-f8948abf85aa
629dbd23-aba3-49bb-9b11-9adcb2d5b832	username	openid-connect	oidc-usermodel-attribute-mapper	\N	eb8ffb5e-641e-42da-ab1a-f8948abf85aa
0098274f-f589-4359-849a-4106aba7b350	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	eb8ffb5e-641e-42da-ab1a-f8948abf85aa
503bd916-98ea-4fe6-b9c6-d7bee2416354	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	eb8ffb5e-641e-42da-ab1a-f8948abf85aa
3942e7ed-6c76-4b34-b2bd-c358f822a62e	website	openid-connect	oidc-usermodel-attribute-mapper	\N	eb8ffb5e-641e-42da-ab1a-f8948abf85aa
8b2d28ab-375b-4d1e-aee8-34e493dda31c	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	eb8ffb5e-641e-42da-ab1a-f8948abf85aa
5bfb32e2-dcae-4716-bc1e-626c01ce1c1e	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	eb8ffb5e-641e-42da-ab1a-f8948abf85aa
0a550bf0-edab-4c44-aeb4-72db8bbb9de0	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	eb8ffb5e-641e-42da-ab1a-f8948abf85aa
f2d97136-ee5b-4f98-a5fb-3f3045d6e7f0	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	eb8ffb5e-641e-42da-ab1a-f8948abf85aa
867794b1-c9d5-4435-b5eb-e23e45512703	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	eb8ffb5e-641e-42da-ab1a-f8948abf85aa
5fd431e2-700b-40a7-9149-3a4689c2e3c6	email	openid-connect	oidc-usermodel-attribute-mapper	\N	73a899b2-50be-43ba-b233-4f9b0f856306
fb83d4f3-8aac-43c4-a052-ac78f0151549	email verified	openid-connect	oidc-usermodel-property-mapper	\N	73a899b2-50be-43ba-b233-4f9b0f856306
239993ba-0d1f-4413-b8c2-e38a0ff67289	address	openid-connect	oidc-address-mapper	\N	88508b6c-f1a9-4677-bc83-cd819ffbd95a
2082a5ac-3491-4eff-9815-dee65e0ccaec	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	4b6c1f65-c316-41dc-816f-410ba75388f7
c8de2f5d-4042-4c70-9967-efcf8d6f1580	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	4b6c1f65-c316-41dc-816f-410ba75388f7
1581e01b-42fc-4a7e-86ef-c23b3865fb56	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	6cd790ae-baff-47a2-a0e1-3c775ee20d3e
7305f977-cb59-473f-9bf8-204c557d9ab2	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	6cd790ae-baff-47a2-a0e1-3c775ee20d3e
1145fc5f-668c-4eb9-9a7f-14400f5fe7da	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	6cd790ae-baff-47a2-a0e1-3c775ee20d3e
82d019b3-3f05-4e0e-9a11-29da9af4de1d	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	599c40ac-4f06-4952-b50a-5bce8d372b5e
d8ebbb84-7e99-4c9f-88b1-22f953e7c899	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	f80d7182-f104-4a13-9334-e5b9d8be1b6f
526baca5-e47f-4a5a-b572-5596e9d0bd43	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	f80d7182-f104-4a13-9334-e5b9d8be1b6f
9c35e839-e557-4ee4-bd84-67f84409d569	acr loa level	openid-connect	oidc-acr-mapper	\N	795a4fcb-21b3-4b2f-b8e7-e9964b1f9686
5d9a5667-13f5-429a-8212-dabec7d1e727	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	21b289c4-86ab-46da-b930-5c0f30be7a34
dcb5a95e-be69-478f-9567-93aef3262365	sub	openid-connect	oidc-sub-mapper	\N	21b289c4-86ab-46da-b930-5c0f30be7a34
f19ec30c-1d67-4ccb-9852-4742882dad6e	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	0cce9e54-0935-4ea2-affd-807266f1e4dd
25254e48-25bb-4545-ab86-51356566109f	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	0cce9e54-0935-4ea2-affd-807266f1e4dd
69a9b550-c340-479c-a620-6a9184f9825f	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	0cce9e54-0935-4ea2-affd-807266f1e4dd
663b18e6-2670-4107-a870-3dace8b2d191	organization	openid-connect	oidc-organization-membership-mapper	\N	72e16833-952b-46a6-a583-a8c462a2cdac
aa8a8b59-ef98-413c-a0f0-755f598219c0	locale	openid-connect	oidc-usermodel-attribute-mapper	8b815c6c-80ec-4263-aa9e-c2f015ffd4c7	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
49c32d0a-1661-4382-b4ff-6f858be4847e	true	introspection.token.claim
49c32d0a-1661-4382-b4ff-6f858be4847e	true	userinfo.token.claim
49c32d0a-1661-4382-b4ff-6f858be4847e	locale	user.attribute
49c32d0a-1661-4382-b4ff-6f858be4847e	true	id.token.claim
49c32d0a-1661-4382-b4ff-6f858be4847e	true	access.token.claim
49c32d0a-1661-4382-b4ff-6f858be4847e	locale	claim.name
49c32d0a-1661-4382-b4ff-6f858be4847e	String	jsonType.label
12300760-93d9-4c74-99e7-9121687ebe41	false	single
12300760-93d9-4c74-99e7-9121687ebe41	Basic	attribute.nameformat
12300760-93d9-4c74-99e7-9121687ebe41	Role	attribute.name
3ff1e96f-d311-4f4a-80f9-0f4313569916	true	introspection.token.claim
3ff1e96f-d311-4f4a-80f9-0f4313569916	true	userinfo.token.claim
3ff1e96f-d311-4f4a-80f9-0f4313569916	updatedAt	user.attribute
3ff1e96f-d311-4f4a-80f9-0f4313569916	true	id.token.claim
3ff1e96f-d311-4f4a-80f9-0f4313569916	true	access.token.claim
3ff1e96f-d311-4f4a-80f9-0f4313569916	updated_at	claim.name
3ff1e96f-d311-4f4a-80f9-0f4313569916	long	jsonType.label
5eced984-8ca5-43b9-ba17-6864dc6050c9	true	introspection.token.claim
5eced984-8ca5-43b9-ba17-6864dc6050c9	true	userinfo.token.claim
5eced984-8ca5-43b9-ba17-6864dc6050c9	website	user.attribute
5eced984-8ca5-43b9-ba17-6864dc6050c9	true	id.token.claim
5eced984-8ca5-43b9-ba17-6864dc6050c9	true	access.token.claim
5eced984-8ca5-43b9-ba17-6864dc6050c9	website	claim.name
5eced984-8ca5-43b9-ba17-6864dc6050c9	String	jsonType.label
6064d330-3197-49d3-bd65-e2d11334f773	true	introspection.token.claim
6064d330-3197-49d3-bd65-e2d11334f773	true	userinfo.token.claim
6064d330-3197-49d3-bd65-e2d11334f773	nickname	user.attribute
6064d330-3197-49d3-bd65-e2d11334f773	true	id.token.claim
6064d330-3197-49d3-bd65-e2d11334f773	true	access.token.claim
6064d330-3197-49d3-bd65-e2d11334f773	nickname	claim.name
6064d330-3197-49d3-bd65-e2d11334f773	String	jsonType.label
66e9d95a-8d63-41dc-a9cd-11b50b48b783	true	introspection.token.claim
66e9d95a-8d63-41dc-a9cd-11b50b48b783	true	userinfo.token.claim
66e9d95a-8d63-41dc-a9cd-11b50b48b783	true	id.token.claim
66e9d95a-8d63-41dc-a9cd-11b50b48b783	true	access.token.claim
6fa9e2fa-3720-4ac8-949d-b4b6b623e7f7	true	introspection.token.claim
6fa9e2fa-3720-4ac8-949d-b4b6b623e7f7	true	userinfo.token.claim
6fa9e2fa-3720-4ac8-949d-b4b6b623e7f7	picture	user.attribute
6fa9e2fa-3720-4ac8-949d-b4b6b623e7f7	true	id.token.claim
6fa9e2fa-3720-4ac8-949d-b4b6b623e7f7	true	access.token.claim
6fa9e2fa-3720-4ac8-949d-b4b6b623e7f7	picture	claim.name
6fa9e2fa-3720-4ac8-949d-b4b6b623e7f7	String	jsonType.label
9c89ffb9-0b4a-47a8-ba28-4e19cff81734	true	introspection.token.claim
9c89ffb9-0b4a-47a8-ba28-4e19cff81734	true	userinfo.token.claim
9c89ffb9-0b4a-47a8-ba28-4e19cff81734	username	user.attribute
9c89ffb9-0b4a-47a8-ba28-4e19cff81734	true	id.token.claim
9c89ffb9-0b4a-47a8-ba28-4e19cff81734	true	access.token.claim
9c89ffb9-0b4a-47a8-ba28-4e19cff81734	preferred_username	claim.name
9c89ffb9-0b4a-47a8-ba28-4e19cff81734	String	jsonType.label
a36009e0-77be-4d97-b5c4-a322c28a991c	true	introspection.token.claim
a36009e0-77be-4d97-b5c4-a322c28a991c	true	userinfo.token.claim
a36009e0-77be-4d97-b5c4-a322c28a991c	birthdate	user.attribute
a36009e0-77be-4d97-b5c4-a322c28a991c	true	id.token.claim
a36009e0-77be-4d97-b5c4-a322c28a991c	true	access.token.claim
a36009e0-77be-4d97-b5c4-a322c28a991c	birthdate	claim.name
a36009e0-77be-4d97-b5c4-a322c28a991c	String	jsonType.label
a3bffb05-2c84-41b9-a09b-3c9fdb021825	true	introspection.token.claim
a3bffb05-2c84-41b9-a09b-3c9fdb021825	true	userinfo.token.claim
a3bffb05-2c84-41b9-a09b-3c9fdb021825	gender	user.attribute
a3bffb05-2c84-41b9-a09b-3c9fdb021825	true	id.token.claim
a3bffb05-2c84-41b9-a09b-3c9fdb021825	true	access.token.claim
a3bffb05-2c84-41b9-a09b-3c9fdb021825	gender	claim.name
a3bffb05-2c84-41b9-a09b-3c9fdb021825	String	jsonType.label
a7b1b0cb-1973-45c8-a2c1-c89dd210016d	true	introspection.token.claim
a7b1b0cb-1973-45c8-a2c1-c89dd210016d	true	userinfo.token.claim
a7b1b0cb-1973-45c8-a2c1-c89dd210016d	profile	user.attribute
a7b1b0cb-1973-45c8-a2c1-c89dd210016d	true	id.token.claim
a7b1b0cb-1973-45c8-a2c1-c89dd210016d	true	access.token.claim
a7b1b0cb-1973-45c8-a2c1-c89dd210016d	profile	claim.name
a7b1b0cb-1973-45c8-a2c1-c89dd210016d	String	jsonType.label
b1215ad7-1020-4e6a-b228-914320a2b4fd	true	introspection.token.claim
b1215ad7-1020-4e6a-b228-914320a2b4fd	true	userinfo.token.claim
b1215ad7-1020-4e6a-b228-914320a2b4fd	locale	user.attribute
b1215ad7-1020-4e6a-b228-914320a2b4fd	true	id.token.claim
b1215ad7-1020-4e6a-b228-914320a2b4fd	true	access.token.claim
b1215ad7-1020-4e6a-b228-914320a2b4fd	locale	claim.name
b1215ad7-1020-4e6a-b228-914320a2b4fd	String	jsonType.label
c61df367-b6ad-45ba-8db0-db5319d74e9b	true	introspection.token.claim
c61df367-b6ad-45ba-8db0-db5319d74e9b	true	userinfo.token.claim
c61df367-b6ad-45ba-8db0-db5319d74e9b	zoneinfo	user.attribute
c61df367-b6ad-45ba-8db0-db5319d74e9b	true	id.token.claim
c61df367-b6ad-45ba-8db0-db5319d74e9b	true	access.token.claim
c61df367-b6ad-45ba-8db0-db5319d74e9b	zoneinfo	claim.name
c61df367-b6ad-45ba-8db0-db5319d74e9b	String	jsonType.label
df2bce65-2d60-4ed9-b3bd-bfeee0cbbf33	true	introspection.token.claim
df2bce65-2d60-4ed9-b3bd-bfeee0cbbf33	true	userinfo.token.claim
df2bce65-2d60-4ed9-b3bd-bfeee0cbbf33	lastName	user.attribute
df2bce65-2d60-4ed9-b3bd-bfeee0cbbf33	true	id.token.claim
df2bce65-2d60-4ed9-b3bd-bfeee0cbbf33	true	access.token.claim
df2bce65-2d60-4ed9-b3bd-bfeee0cbbf33	family_name	claim.name
df2bce65-2d60-4ed9-b3bd-bfeee0cbbf33	String	jsonType.label
fa18b365-21ef-4232-b0b5-373dbd2af7ee	true	introspection.token.claim
fa18b365-21ef-4232-b0b5-373dbd2af7ee	true	userinfo.token.claim
fa18b365-21ef-4232-b0b5-373dbd2af7ee	firstName	user.attribute
fa18b365-21ef-4232-b0b5-373dbd2af7ee	true	id.token.claim
fa18b365-21ef-4232-b0b5-373dbd2af7ee	true	access.token.claim
fa18b365-21ef-4232-b0b5-373dbd2af7ee	given_name	claim.name
fa18b365-21ef-4232-b0b5-373dbd2af7ee	String	jsonType.label
fde42da6-9cd6-4ebf-9e96-2b5c885ad3a8	true	introspection.token.claim
fde42da6-9cd6-4ebf-9e96-2b5c885ad3a8	true	userinfo.token.claim
fde42da6-9cd6-4ebf-9e96-2b5c885ad3a8	middleName	user.attribute
fde42da6-9cd6-4ebf-9e96-2b5c885ad3a8	true	id.token.claim
fde42da6-9cd6-4ebf-9e96-2b5c885ad3a8	true	access.token.claim
fde42da6-9cd6-4ebf-9e96-2b5c885ad3a8	middle_name	claim.name
fde42da6-9cd6-4ebf-9e96-2b5c885ad3a8	String	jsonType.label
242816c8-e51b-42bf-82c4-f019699d0f04	true	introspection.token.claim
242816c8-e51b-42bf-82c4-f019699d0f04	true	userinfo.token.claim
242816c8-e51b-42bf-82c4-f019699d0f04	emailVerified	user.attribute
242816c8-e51b-42bf-82c4-f019699d0f04	true	id.token.claim
242816c8-e51b-42bf-82c4-f019699d0f04	true	access.token.claim
242816c8-e51b-42bf-82c4-f019699d0f04	email_verified	claim.name
242816c8-e51b-42bf-82c4-f019699d0f04	boolean	jsonType.label
47fffd12-a784-40de-b569-8d58b4ce808b	true	introspection.token.claim
47fffd12-a784-40de-b569-8d58b4ce808b	true	userinfo.token.claim
47fffd12-a784-40de-b569-8d58b4ce808b	email	user.attribute
47fffd12-a784-40de-b569-8d58b4ce808b	true	id.token.claim
47fffd12-a784-40de-b569-8d58b4ce808b	true	access.token.claim
47fffd12-a784-40de-b569-8d58b4ce808b	email	claim.name
47fffd12-a784-40de-b569-8d58b4ce808b	String	jsonType.label
897676e4-9374-4d7d-bcbd-6b36cfc49d12	formatted	user.attribute.formatted
897676e4-9374-4d7d-bcbd-6b36cfc49d12	country	user.attribute.country
897676e4-9374-4d7d-bcbd-6b36cfc49d12	true	introspection.token.claim
897676e4-9374-4d7d-bcbd-6b36cfc49d12	postal_code	user.attribute.postal_code
897676e4-9374-4d7d-bcbd-6b36cfc49d12	true	userinfo.token.claim
897676e4-9374-4d7d-bcbd-6b36cfc49d12	street	user.attribute.street
897676e4-9374-4d7d-bcbd-6b36cfc49d12	true	id.token.claim
897676e4-9374-4d7d-bcbd-6b36cfc49d12	region	user.attribute.region
897676e4-9374-4d7d-bcbd-6b36cfc49d12	true	access.token.claim
897676e4-9374-4d7d-bcbd-6b36cfc49d12	locality	user.attribute.locality
2fc03c35-5061-4f91-b7db-5fe7ce70a551	true	introspection.token.claim
2fc03c35-5061-4f91-b7db-5fe7ce70a551	true	userinfo.token.claim
2fc03c35-5061-4f91-b7db-5fe7ce70a551	phoneNumberVerified	user.attribute
2fc03c35-5061-4f91-b7db-5fe7ce70a551	true	id.token.claim
2fc03c35-5061-4f91-b7db-5fe7ce70a551	true	access.token.claim
2fc03c35-5061-4f91-b7db-5fe7ce70a551	phone_number_verified	claim.name
2fc03c35-5061-4f91-b7db-5fe7ce70a551	boolean	jsonType.label
39951de6-6df1-4d16-bc86-41e274e6b5e8	true	introspection.token.claim
39951de6-6df1-4d16-bc86-41e274e6b5e8	true	userinfo.token.claim
39951de6-6df1-4d16-bc86-41e274e6b5e8	phoneNumber	user.attribute
39951de6-6df1-4d16-bc86-41e274e6b5e8	true	id.token.claim
39951de6-6df1-4d16-bc86-41e274e6b5e8	true	access.token.claim
39951de6-6df1-4d16-bc86-41e274e6b5e8	phone_number	claim.name
39951de6-6df1-4d16-bc86-41e274e6b5e8	String	jsonType.label
69ec4751-2d63-4d93-bf68-7a3d41d3d087	true	introspection.token.claim
69ec4751-2d63-4d93-bf68-7a3d41d3d087	true	multivalued
69ec4751-2d63-4d93-bf68-7a3d41d3d087	foo	user.attribute
69ec4751-2d63-4d93-bf68-7a3d41d3d087	true	access.token.claim
69ec4751-2d63-4d93-bf68-7a3d41d3d087	realm_access.roles	claim.name
69ec4751-2d63-4d93-bf68-7a3d41d3d087	String	jsonType.label
df5c29e2-e625-45bf-9946-9216cb60be91	true	introspection.token.claim
df5c29e2-e625-45bf-9946-9216cb60be91	true	access.token.claim
fc021b29-7ce3-43ed-8ad0-bcb29684ff99	true	introspection.token.claim
fc021b29-7ce3-43ed-8ad0-bcb29684ff99	true	multivalued
fc021b29-7ce3-43ed-8ad0-bcb29684ff99	foo	user.attribute
fc021b29-7ce3-43ed-8ad0-bcb29684ff99	true	access.token.claim
fc021b29-7ce3-43ed-8ad0-bcb29684ff99	resource_access.${client_id}.roles	claim.name
fc021b29-7ce3-43ed-8ad0-bcb29684ff99	String	jsonType.label
4f58d6bf-033d-4103-bc1a-259704930674	true	introspection.token.claim
4f58d6bf-033d-4103-bc1a-259704930674	true	access.token.claim
08e234cd-9ffc-4607-afb3-2c5b789b7629	true	introspection.token.claim
08e234cd-9ffc-4607-afb3-2c5b789b7629	true	multivalued
08e234cd-9ffc-4607-afb3-2c5b789b7629	foo	user.attribute
08e234cd-9ffc-4607-afb3-2c5b789b7629	true	id.token.claim
08e234cd-9ffc-4607-afb3-2c5b789b7629	true	access.token.claim
08e234cd-9ffc-4607-afb3-2c5b789b7629	groups	claim.name
08e234cd-9ffc-4607-afb3-2c5b789b7629	String	jsonType.label
510ec04b-1b90-4869-a078-2ed78326b155	true	introspection.token.claim
510ec04b-1b90-4869-a078-2ed78326b155	true	userinfo.token.claim
510ec04b-1b90-4869-a078-2ed78326b155	username	user.attribute
510ec04b-1b90-4869-a078-2ed78326b155	true	id.token.claim
510ec04b-1b90-4869-a078-2ed78326b155	true	access.token.claim
510ec04b-1b90-4869-a078-2ed78326b155	upn	claim.name
510ec04b-1b90-4869-a078-2ed78326b155	String	jsonType.label
67f6c5a7-8133-475d-9a5a-d532eea188f6	true	introspection.token.claim
67f6c5a7-8133-475d-9a5a-d532eea188f6	true	id.token.claim
67f6c5a7-8133-475d-9a5a-d532eea188f6	true	access.token.claim
0e44bd44-2e76-40a5-8f19-9a24b0285e54	AUTH_TIME	user.session.note
0e44bd44-2e76-40a5-8f19-9a24b0285e54	true	introspection.token.claim
0e44bd44-2e76-40a5-8f19-9a24b0285e54	true	id.token.claim
0e44bd44-2e76-40a5-8f19-9a24b0285e54	true	access.token.claim
0e44bd44-2e76-40a5-8f19-9a24b0285e54	auth_time	claim.name
0e44bd44-2e76-40a5-8f19-9a24b0285e54	long	jsonType.label
6a43ad3c-28ba-4b97-96c1-13076ccb7fe9	true	introspection.token.claim
6a43ad3c-28ba-4b97-96c1-13076ccb7fe9	true	access.token.claim
a0fcd7ff-9970-4f27-9e82-2d0bf4337b19	clientHost	user.session.note
a0fcd7ff-9970-4f27-9e82-2d0bf4337b19	true	introspection.token.claim
a0fcd7ff-9970-4f27-9e82-2d0bf4337b19	true	id.token.claim
a0fcd7ff-9970-4f27-9e82-2d0bf4337b19	true	access.token.claim
a0fcd7ff-9970-4f27-9e82-2d0bf4337b19	clientHost	claim.name
a0fcd7ff-9970-4f27-9e82-2d0bf4337b19	String	jsonType.label
c46eaa2e-8c19-40dd-8f61-c320e8acdeba	client_id	user.session.note
c46eaa2e-8c19-40dd-8f61-c320e8acdeba	true	introspection.token.claim
c46eaa2e-8c19-40dd-8f61-c320e8acdeba	true	id.token.claim
c46eaa2e-8c19-40dd-8f61-c320e8acdeba	true	access.token.claim
c46eaa2e-8c19-40dd-8f61-c320e8acdeba	client_id	claim.name
c46eaa2e-8c19-40dd-8f61-c320e8acdeba	String	jsonType.label
e19d2890-3659-43c8-b14d-ed51202a4a6c	clientAddress	user.session.note
e19d2890-3659-43c8-b14d-ed51202a4a6c	true	introspection.token.claim
e19d2890-3659-43c8-b14d-ed51202a4a6c	true	id.token.claim
e19d2890-3659-43c8-b14d-ed51202a4a6c	true	access.token.claim
e19d2890-3659-43c8-b14d-ed51202a4a6c	clientAddress	claim.name
e19d2890-3659-43c8-b14d-ed51202a4a6c	String	jsonType.label
a5aa0850-ca98-4f81-a077-3bc1a4fe4047	true	introspection.token.claim
a5aa0850-ca98-4f81-a077-3bc1a4fe4047	true	multivalued
a5aa0850-ca98-4f81-a077-3bc1a4fe4047	true	id.token.claim
a5aa0850-ca98-4f81-a077-3bc1a4fe4047	true	access.token.claim
a5aa0850-ca98-4f81-a077-3bc1a4fe4047	organization	claim.name
a5aa0850-ca98-4f81-a077-3bc1a4fe4047	String	jsonType.label
26707b1d-562d-4f5f-83ab-c90c6c00fefb	false	single
26707b1d-562d-4f5f-83ab-c90c6c00fefb	Basic	attribute.nameformat
26707b1d-562d-4f5f-83ab-c90c6c00fefb	Role	attribute.name
0098274f-f589-4359-849a-4106aba7b350	true	introspection.token.claim
0098274f-f589-4359-849a-4106aba7b350	true	userinfo.token.claim
0098274f-f589-4359-849a-4106aba7b350	profile	user.attribute
0098274f-f589-4359-849a-4106aba7b350	true	id.token.claim
0098274f-f589-4359-849a-4106aba7b350	true	access.token.claim
0098274f-f589-4359-849a-4106aba7b350	profile	claim.name
0098274f-f589-4359-849a-4106aba7b350	String	jsonType.label
0a550bf0-edab-4c44-aeb4-72db8bbb9de0	true	introspection.token.claim
0a550bf0-edab-4c44-aeb4-72db8bbb9de0	true	userinfo.token.claim
0a550bf0-edab-4c44-aeb4-72db8bbb9de0	zoneinfo	user.attribute
0a550bf0-edab-4c44-aeb4-72db8bbb9de0	true	id.token.claim
0a550bf0-edab-4c44-aeb4-72db8bbb9de0	true	access.token.claim
0a550bf0-edab-4c44-aeb4-72db8bbb9de0	zoneinfo	claim.name
0a550bf0-edab-4c44-aeb4-72db8bbb9de0	String	jsonType.label
3942e7ed-6c76-4b34-b2bd-c358f822a62e	true	introspection.token.claim
3942e7ed-6c76-4b34-b2bd-c358f822a62e	true	userinfo.token.claim
3942e7ed-6c76-4b34-b2bd-c358f822a62e	website	user.attribute
3942e7ed-6c76-4b34-b2bd-c358f822a62e	true	id.token.claim
3942e7ed-6c76-4b34-b2bd-c358f822a62e	true	access.token.claim
3942e7ed-6c76-4b34-b2bd-c358f822a62e	website	claim.name
3942e7ed-6c76-4b34-b2bd-c358f822a62e	String	jsonType.label
503bd916-98ea-4fe6-b9c6-d7bee2416354	true	introspection.token.claim
503bd916-98ea-4fe6-b9c6-d7bee2416354	true	userinfo.token.claim
503bd916-98ea-4fe6-b9c6-d7bee2416354	picture	user.attribute
503bd916-98ea-4fe6-b9c6-d7bee2416354	true	id.token.claim
503bd916-98ea-4fe6-b9c6-d7bee2416354	true	access.token.claim
503bd916-98ea-4fe6-b9c6-d7bee2416354	picture	claim.name
503bd916-98ea-4fe6-b9c6-d7bee2416354	String	jsonType.label
5bc8e2ed-81ac-4128-bf9a-d6bc94924fff	true	introspection.token.claim
5bc8e2ed-81ac-4128-bf9a-d6bc94924fff	true	userinfo.token.claim
5bc8e2ed-81ac-4128-bf9a-d6bc94924fff	middleName	user.attribute
5bc8e2ed-81ac-4128-bf9a-d6bc94924fff	true	id.token.claim
5bc8e2ed-81ac-4128-bf9a-d6bc94924fff	true	access.token.claim
5bc8e2ed-81ac-4128-bf9a-d6bc94924fff	middle_name	claim.name
5bc8e2ed-81ac-4128-bf9a-d6bc94924fff	String	jsonType.label
5bfb32e2-dcae-4716-bc1e-626c01ce1c1e	true	introspection.token.claim
5bfb32e2-dcae-4716-bc1e-626c01ce1c1e	true	userinfo.token.claim
5bfb32e2-dcae-4716-bc1e-626c01ce1c1e	birthdate	user.attribute
5bfb32e2-dcae-4716-bc1e-626c01ce1c1e	true	id.token.claim
5bfb32e2-dcae-4716-bc1e-626c01ce1c1e	true	access.token.claim
5bfb32e2-dcae-4716-bc1e-626c01ce1c1e	birthdate	claim.name
5bfb32e2-dcae-4716-bc1e-626c01ce1c1e	String	jsonType.label
629dbd23-aba3-49bb-9b11-9adcb2d5b832	true	introspection.token.claim
629dbd23-aba3-49bb-9b11-9adcb2d5b832	true	userinfo.token.claim
629dbd23-aba3-49bb-9b11-9adcb2d5b832	username	user.attribute
629dbd23-aba3-49bb-9b11-9adcb2d5b832	true	id.token.claim
629dbd23-aba3-49bb-9b11-9adcb2d5b832	true	access.token.claim
629dbd23-aba3-49bb-9b11-9adcb2d5b832	preferred_username	claim.name
629dbd23-aba3-49bb-9b11-9adcb2d5b832	String	jsonType.label
867794b1-c9d5-4435-b5eb-e23e45512703	true	introspection.token.claim
867794b1-c9d5-4435-b5eb-e23e45512703	true	userinfo.token.claim
867794b1-c9d5-4435-b5eb-e23e45512703	updatedAt	user.attribute
867794b1-c9d5-4435-b5eb-e23e45512703	true	id.token.claim
867794b1-c9d5-4435-b5eb-e23e45512703	true	access.token.claim
867794b1-c9d5-4435-b5eb-e23e45512703	updated_at	claim.name
867794b1-c9d5-4435-b5eb-e23e45512703	long	jsonType.label
8b2d28ab-375b-4d1e-aee8-34e493dda31c	true	introspection.token.claim
8b2d28ab-375b-4d1e-aee8-34e493dda31c	true	userinfo.token.claim
8b2d28ab-375b-4d1e-aee8-34e493dda31c	gender	user.attribute
8b2d28ab-375b-4d1e-aee8-34e493dda31c	true	id.token.claim
8b2d28ab-375b-4d1e-aee8-34e493dda31c	true	access.token.claim
8b2d28ab-375b-4d1e-aee8-34e493dda31c	gender	claim.name
8b2d28ab-375b-4d1e-aee8-34e493dda31c	String	jsonType.label
d73dc2da-8c3c-4f32-99f0-7baebf894b3b	true	introspection.token.claim
d73dc2da-8c3c-4f32-99f0-7baebf894b3b	true	userinfo.token.claim
d73dc2da-8c3c-4f32-99f0-7baebf894b3b	lastName	user.attribute
d73dc2da-8c3c-4f32-99f0-7baebf894b3b	true	id.token.claim
d73dc2da-8c3c-4f32-99f0-7baebf894b3b	true	access.token.claim
d73dc2da-8c3c-4f32-99f0-7baebf894b3b	family_name	claim.name
d73dc2da-8c3c-4f32-99f0-7baebf894b3b	String	jsonType.label
d83d12a8-a513-48ae-bd9c-c4988d47238a	true	introspection.token.claim
d83d12a8-a513-48ae-bd9c-c4988d47238a	true	userinfo.token.claim
d83d12a8-a513-48ae-bd9c-c4988d47238a	firstName	user.attribute
d83d12a8-a513-48ae-bd9c-c4988d47238a	true	id.token.claim
d83d12a8-a513-48ae-bd9c-c4988d47238a	true	access.token.claim
d83d12a8-a513-48ae-bd9c-c4988d47238a	given_name	claim.name
d83d12a8-a513-48ae-bd9c-c4988d47238a	String	jsonType.label
dfe8f14b-f0a1-4a68-9530-4d8f8cb3cd0a	true	introspection.token.claim
dfe8f14b-f0a1-4a68-9530-4d8f8cb3cd0a	true	userinfo.token.claim
dfe8f14b-f0a1-4a68-9530-4d8f8cb3cd0a	true	id.token.claim
dfe8f14b-f0a1-4a68-9530-4d8f8cb3cd0a	true	access.token.claim
e7475b79-6fce-4566-a37a-3c912359001b	true	introspection.token.claim
e7475b79-6fce-4566-a37a-3c912359001b	true	userinfo.token.claim
e7475b79-6fce-4566-a37a-3c912359001b	nickname	user.attribute
e7475b79-6fce-4566-a37a-3c912359001b	true	id.token.claim
e7475b79-6fce-4566-a37a-3c912359001b	true	access.token.claim
e7475b79-6fce-4566-a37a-3c912359001b	nickname	claim.name
e7475b79-6fce-4566-a37a-3c912359001b	String	jsonType.label
f2d97136-ee5b-4f98-a5fb-3f3045d6e7f0	true	introspection.token.claim
f2d97136-ee5b-4f98-a5fb-3f3045d6e7f0	true	userinfo.token.claim
f2d97136-ee5b-4f98-a5fb-3f3045d6e7f0	locale	user.attribute
f2d97136-ee5b-4f98-a5fb-3f3045d6e7f0	true	id.token.claim
f2d97136-ee5b-4f98-a5fb-3f3045d6e7f0	true	access.token.claim
f2d97136-ee5b-4f98-a5fb-3f3045d6e7f0	locale	claim.name
f2d97136-ee5b-4f98-a5fb-3f3045d6e7f0	String	jsonType.label
5fd431e2-700b-40a7-9149-3a4689c2e3c6	true	introspection.token.claim
5fd431e2-700b-40a7-9149-3a4689c2e3c6	true	userinfo.token.claim
5fd431e2-700b-40a7-9149-3a4689c2e3c6	email	user.attribute
5fd431e2-700b-40a7-9149-3a4689c2e3c6	true	id.token.claim
5fd431e2-700b-40a7-9149-3a4689c2e3c6	true	access.token.claim
5fd431e2-700b-40a7-9149-3a4689c2e3c6	email	claim.name
5fd431e2-700b-40a7-9149-3a4689c2e3c6	String	jsonType.label
fb83d4f3-8aac-43c4-a052-ac78f0151549	true	introspection.token.claim
fb83d4f3-8aac-43c4-a052-ac78f0151549	true	userinfo.token.claim
fb83d4f3-8aac-43c4-a052-ac78f0151549	emailVerified	user.attribute
fb83d4f3-8aac-43c4-a052-ac78f0151549	true	id.token.claim
fb83d4f3-8aac-43c4-a052-ac78f0151549	true	access.token.claim
fb83d4f3-8aac-43c4-a052-ac78f0151549	email_verified	claim.name
fb83d4f3-8aac-43c4-a052-ac78f0151549	boolean	jsonType.label
239993ba-0d1f-4413-b8c2-e38a0ff67289	formatted	user.attribute.formatted
239993ba-0d1f-4413-b8c2-e38a0ff67289	country	user.attribute.country
239993ba-0d1f-4413-b8c2-e38a0ff67289	true	introspection.token.claim
239993ba-0d1f-4413-b8c2-e38a0ff67289	postal_code	user.attribute.postal_code
239993ba-0d1f-4413-b8c2-e38a0ff67289	true	userinfo.token.claim
239993ba-0d1f-4413-b8c2-e38a0ff67289	street	user.attribute.street
239993ba-0d1f-4413-b8c2-e38a0ff67289	true	id.token.claim
239993ba-0d1f-4413-b8c2-e38a0ff67289	region	user.attribute.region
239993ba-0d1f-4413-b8c2-e38a0ff67289	true	access.token.claim
239993ba-0d1f-4413-b8c2-e38a0ff67289	locality	user.attribute.locality
2082a5ac-3491-4eff-9815-dee65e0ccaec	true	introspection.token.claim
2082a5ac-3491-4eff-9815-dee65e0ccaec	true	userinfo.token.claim
2082a5ac-3491-4eff-9815-dee65e0ccaec	phoneNumber	user.attribute
2082a5ac-3491-4eff-9815-dee65e0ccaec	true	id.token.claim
2082a5ac-3491-4eff-9815-dee65e0ccaec	true	access.token.claim
2082a5ac-3491-4eff-9815-dee65e0ccaec	phone_number	claim.name
2082a5ac-3491-4eff-9815-dee65e0ccaec	String	jsonType.label
c8de2f5d-4042-4c70-9967-efcf8d6f1580	true	introspection.token.claim
c8de2f5d-4042-4c70-9967-efcf8d6f1580	true	userinfo.token.claim
c8de2f5d-4042-4c70-9967-efcf8d6f1580	phoneNumberVerified	user.attribute
c8de2f5d-4042-4c70-9967-efcf8d6f1580	true	id.token.claim
c8de2f5d-4042-4c70-9967-efcf8d6f1580	true	access.token.claim
c8de2f5d-4042-4c70-9967-efcf8d6f1580	phone_number_verified	claim.name
c8de2f5d-4042-4c70-9967-efcf8d6f1580	boolean	jsonType.label
1145fc5f-668c-4eb9-9a7f-14400f5fe7da	true	introspection.token.claim
1145fc5f-668c-4eb9-9a7f-14400f5fe7da	true	access.token.claim
1581e01b-42fc-4a7e-86ef-c23b3865fb56	true	introspection.token.claim
1581e01b-42fc-4a7e-86ef-c23b3865fb56	true	multivalued
1581e01b-42fc-4a7e-86ef-c23b3865fb56	foo	user.attribute
1581e01b-42fc-4a7e-86ef-c23b3865fb56	true	access.token.claim
1581e01b-42fc-4a7e-86ef-c23b3865fb56	realm_access.roles	claim.name
1581e01b-42fc-4a7e-86ef-c23b3865fb56	String	jsonType.label
7305f977-cb59-473f-9bf8-204c557d9ab2	true	introspection.token.claim
7305f977-cb59-473f-9bf8-204c557d9ab2	true	multivalued
7305f977-cb59-473f-9bf8-204c557d9ab2	foo	user.attribute
7305f977-cb59-473f-9bf8-204c557d9ab2	true	access.token.claim
7305f977-cb59-473f-9bf8-204c557d9ab2	resource_access.${client_id}.roles	claim.name
7305f977-cb59-473f-9bf8-204c557d9ab2	String	jsonType.label
82d019b3-3f05-4e0e-9a11-29da9af4de1d	true	introspection.token.claim
82d019b3-3f05-4e0e-9a11-29da9af4de1d	true	access.token.claim
526baca5-e47f-4a5a-b572-5596e9d0bd43	true	introspection.token.claim
526baca5-e47f-4a5a-b572-5596e9d0bd43	true	multivalued
526baca5-e47f-4a5a-b572-5596e9d0bd43	foo	user.attribute
526baca5-e47f-4a5a-b572-5596e9d0bd43	true	id.token.claim
526baca5-e47f-4a5a-b572-5596e9d0bd43	true	access.token.claim
526baca5-e47f-4a5a-b572-5596e9d0bd43	groups	claim.name
526baca5-e47f-4a5a-b572-5596e9d0bd43	String	jsonType.label
d8ebbb84-7e99-4c9f-88b1-22f953e7c899	true	introspection.token.claim
d8ebbb84-7e99-4c9f-88b1-22f953e7c899	true	userinfo.token.claim
d8ebbb84-7e99-4c9f-88b1-22f953e7c899	username	user.attribute
d8ebbb84-7e99-4c9f-88b1-22f953e7c899	true	id.token.claim
d8ebbb84-7e99-4c9f-88b1-22f953e7c899	true	access.token.claim
d8ebbb84-7e99-4c9f-88b1-22f953e7c899	upn	claim.name
d8ebbb84-7e99-4c9f-88b1-22f953e7c899	String	jsonType.label
9c35e839-e557-4ee4-bd84-67f84409d569	true	introspection.token.claim
9c35e839-e557-4ee4-bd84-67f84409d569	true	id.token.claim
9c35e839-e557-4ee4-bd84-67f84409d569	true	access.token.claim
5d9a5667-13f5-429a-8212-dabec7d1e727	AUTH_TIME	user.session.note
5d9a5667-13f5-429a-8212-dabec7d1e727	true	introspection.token.claim
5d9a5667-13f5-429a-8212-dabec7d1e727	true	id.token.claim
5d9a5667-13f5-429a-8212-dabec7d1e727	true	access.token.claim
5d9a5667-13f5-429a-8212-dabec7d1e727	auth_time	claim.name
5d9a5667-13f5-429a-8212-dabec7d1e727	long	jsonType.label
dcb5a95e-be69-478f-9567-93aef3262365	true	introspection.token.claim
dcb5a95e-be69-478f-9567-93aef3262365	true	access.token.claim
25254e48-25bb-4545-ab86-51356566109f	clientHost	user.session.note
25254e48-25bb-4545-ab86-51356566109f	true	introspection.token.claim
25254e48-25bb-4545-ab86-51356566109f	true	id.token.claim
25254e48-25bb-4545-ab86-51356566109f	true	access.token.claim
25254e48-25bb-4545-ab86-51356566109f	clientHost	claim.name
25254e48-25bb-4545-ab86-51356566109f	String	jsonType.label
69a9b550-c340-479c-a620-6a9184f9825f	clientAddress	user.session.note
69a9b550-c340-479c-a620-6a9184f9825f	true	introspection.token.claim
69a9b550-c340-479c-a620-6a9184f9825f	true	id.token.claim
69a9b550-c340-479c-a620-6a9184f9825f	true	access.token.claim
69a9b550-c340-479c-a620-6a9184f9825f	clientAddress	claim.name
69a9b550-c340-479c-a620-6a9184f9825f	String	jsonType.label
f19ec30c-1d67-4ccb-9852-4742882dad6e	client_id	user.session.note
f19ec30c-1d67-4ccb-9852-4742882dad6e	true	introspection.token.claim
f19ec30c-1d67-4ccb-9852-4742882dad6e	true	id.token.claim
f19ec30c-1d67-4ccb-9852-4742882dad6e	true	access.token.claim
f19ec30c-1d67-4ccb-9852-4742882dad6e	client_id	claim.name
f19ec30c-1d67-4ccb-9852-4742882dad6e	String	jsonType.label
663b18e6-2670-4107-a870-3dace8b2d191	true	introspection.token.claim
663b18e6-2670-4107-a870-3dace8b2d191	true	multivalued
663b18e6-2670-4107-a870-3dace8b2d191	true	id.token.claim
663b18e6-2670-4107-a870-3dace8b2d191	true	access.token.claim
663b18e6-2670-4107-a870-3dace8b2d191	organization	claim.name
663b18e6-2670-4107-a870-3dace8b2d191	String	jsonType.label
aa8a8b59-ef98-413c-a0f0-755f598219c0	true	introspection.token.claim
aa8a8b59-ef98-413c-a0f0-755f598219c0	true	userinfo.token.claim
aa8a8b59-ef98-413c-a0f0-755f598219c0	locale	user.attribute
aa8a8b59-ef98-413c-a0f0-755f598219c0	true	id.token.claim
aa8a8b59-ef98-413c-a0f0-755f598219c0	true	access.token.claim
aa8a8b59-ef98-413c-a0f0-755f598219c0	locale	claim.name
aa8a8b59-ef98-413c-a0f0-755f598219c0	String	jsonType.label
\.


--
-- Data for Name: quirofano; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.quirofano (id, estado, nombre, ubicacion) FROM stdin;
1	Disponible	Quirofano A	Secto A
2	Disponible	Quirofano A	Secto A
3	Disponible	Quirófano Central	Piso 2 - Sector A
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
d97d657d-c2a8-4c20-a3a8-4ca15a52738d	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	7196ea6b-8216-4773-a2ab-de3c674db4c7	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	81c64f59-c6e5-42a8-be0e-2a65a4386b14	ab247d35-2c31-412f-9823-62b2006de5f9	f4ee410d-e26e-4972-a1e3-999afe4a4257	438c4c42-dd11-4bfd-819f-1b2924ddef4e	f7b66a8f-1645-4e15-9729-a54ea1e7912f	2592000	f	900	t	f	f84cb0c3-373a-4f3a-9441-4ca79426d5e6	0	f	0	0	2439e07d-eecf-4e4f-9a13-24aac26dcd66
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	60	300	300	\N	\N	\N	t	f	0	\N	dacs	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	6f7c43c3-7963-4bdd-9997-3869cfd54951	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	5b71a30c-86a5-4aa7-9dcc-f585f9971709	993d1787-2eee-4541-a884-04e693df4cb8	6f3565d5-09bc-4034-8143-39ce036a58b0	4603d110-c8f0-4bdf-b6f8-493cc9fb4b1b	2f5574ef-a5d1-4feb-a5b3-b633f6fabb49	2592000	f	900	t	f	6ad1fe17-e8e3-423d-a4bf-0eed127804c5	0	f	0	0	8fc1edbd-5d64-460f-97b4-3b4fdf427189
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	
_browser_header.xContentTypeOptions	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	nosniff
_browser_header.referrerPolicy	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	no-referrer
_browser_header.xRobotsTag	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	none
_browser_header.xFrameOptions	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	SAMEORIGIN
_browser_header.contentSecurityPolicy	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	max-age=31536000; includeSubDomains
bruteForceProtected	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	false
permanentLockout	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	false
maxTemporaryLockouts	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	0
bruteForceStrategy	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	MULTIPLE
maxFailureWaitSeconds	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	900
minimumQuickLoginWaitSeconds	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	60
waitIncrementSeconds	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	60
quickLoginCheckMilliSeconds	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	1000
maxDeltaTimeSeconds	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	43200
failureFactor	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	30
realmReusableOtpCode	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	false
firstBrokerLoginFlowId	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	47156c63-0b6d-4f95-bdac-e5d8103ef8e6
displayName	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	Keycloak
displayNameHtml	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	RS256
offlineSessionMaxLifespanEnabled	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	false
offlineSessionMaxLifespan	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	5184000
_browser_header.contentSecurityPolicyReportOnly	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	
_browser_header.xContentTypeOptions	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	nosniff
_browser_header.referrerPolicy	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	no-referrer
_browser_header.xRobotsTag	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	none
_browser_header.xFrameOptions	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	SAMEORIGIN
_browser_header.contentSecurityPolicy	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	max-age=31536000; includeSubDomains
bruteForceProtected	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	false
permanentLockout	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	false
maxTemporaryLockouts	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	0
bruteForceStrategy	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	MULTIPLE
maxFailureWaitSeconds	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	900
minimumQuickLoginWaitSeconds	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	60
waitIncrementSeconds	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	60
quickLoginCheckMilliSeconds	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	1000
maxDeltaTimeSeconds	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	43200
failureFactor	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	30
realmReusableOtpCode	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	false
defaultSignatureAlgorithm	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	RS256
offlineSessionMaxLifespanEnabled	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	false
offlineSessionMaxLifespan	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	5184000
actionTokenGeneratedByAdminLifespan	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	43200
actionTokenGeneratedByUserLifespan	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	300
oauth2DeviceCodeLifespan	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	600
oauth2DevicePollingInterval	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	5
webAuthnPolicyRpEntityName	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	keycloak
webAuthnPolicySignatureAlgorithms	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	ES256,RS256
webAuthnPolicyRpId	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	
webAuthnPolicyAttestationConveyancePreference	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	not specified
webAuthnPolicyAuthenticatorAttachment	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	not specified
webAuthnPolicyRequireResidentKey	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	not specified
webAuthnPolicyUserVerificationRequirement	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	not specified
webAuthnPolicyCreateTimeout	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	0
webAuthnPolicyAvoidSameAuthenticatorRegister	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	false
webAuthnPolicyRpEntityNamePasswordless	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	ES256,RS256
webAuthnPolicyRpIdPasswordless	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	
webAuthnPolicyAttestationConveyancePreferencePasswordless	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	not specified
webAuthnPolicyRequireResidentKeyPasswordless	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	Yes
webAuthnPolicyUserVerificationRequirementPasswordless	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	required
webAuthnPolicyCreateTimeoutPasswordless	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	false
cibaBackchannelTokenDeliveryMode	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	poll
cibaExpiresIn	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	120
cibaInterval	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	5
cibaAuthRequestedUserHint	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	login_hint
parRequestUriLifespan	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	60
firstBrokerLoginFlowId	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	bd9914c4-fb6f-4f58-8e33-8ed038f99173
organizationsEnabled	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	false
adminPermissionsEnabled	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	false
verifiableCredentialsEnabled	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	false
clientSessionIdleTimeout	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	0
clientSessionMaxLifespan	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	0
clientOfflineSessionIdleTimeout	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	0
clientOfflineSessionMaxLifespan	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	0
client-policies.profiles	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	{"profiles":[]}
client-policies.policies	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	{"policies":[]}
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
d97d657d-c2a8-4c20-a3a8-4ca15a52738d	jboss-logging
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	d97d657d-c2a8-4c20-a3a8-4ca15a52738d
password	password	t	t	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b		allowutf8
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	ADMIN DACS 2025	replyToDisplayName
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	true	debug
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	true	starttls
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	true	auth
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b		envelopeFrom
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	true	ssl
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	admin	password
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	465	port
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	carottalucas2@gmail.com	replyTo
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	smtp.gmail.com	host
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	carottalucas2@gmail.com	from
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	ADMIN DACS 2025	fromDisplayName
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	basic	authType
d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	admin	user
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.redirect_uris (client_id, value) FROM stdin;
3853b62d-0671-4bb5-9980-a8724355460a	/realms/master/account/*
cc39bee7-2e22-4ec7-96e6-47f3b38f88ad	/realms/master/account/*
bf31eec8-25de-4851-8df5-e95fdbad8878	/admin/master/console/*
6178dd03-ea93-491b-9340-c44abcfe617c	/realms/dacs/account/*
8b815c6c-80ec-4263-aa9e-c2f015ffd4c7	/admin/dacs/console/*
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	https://dacs2025.local/dacsapp/*
02d538de-9d35-440d-a6cf-a6fe61f33904	https://dacs2025.local/dacsapp/*
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	http://localhost:4200/*
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	/realms/dacs/account/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
d535e55c-2389-41da-aebf-d364df5ffead	VERIFY_EMAIL	Verify Email	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	t	f	VERIFY_EMAIL	50
71102d0b-28d4-47b9-8121-41a5fc848718	UPDATE_PROFILE	Update Profile	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	t	f	UPDATE_PROFILE	40
6dacdd8a-ec97-40f8-97e6-afbdca6908fa	CONFIGURE_TOTP	Configure OTP	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	t	f	CONFIGURE_TOTP	10
29dd93d8-88b8-456b-b378-8a9fa90cf4c1	UPDATE_PASSWORD	Update Password	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	t	f	UPDATE_PASSWORD	30
5d0dfbc8-553f-43e6-b51d-563e968ee65e	TERMS_AND_CONDITIONS	Terms and Conditions	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	f	f	TERMS_AND_CONDITIONS	20
e22a7882-0706-4812-b54f-7da33f31dc89	delete_account	Delete Account	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	f	f	delete_account	60
875f2dcf-06bb-46ba-a3d4-bc27f3ec57b3	delete_credential	Delete Credential	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	t	f	delete_credential	110
53b0b99b-f8d0-45ca-b49b-8cffb4722398	update_user_locale	Update User Locale	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	t	f	update_user_locale	1000
7ee6c247-94d5-4cbb-864d-d53185af34ee	UPDATE_EMAIL	Update Email	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	f	f	UPDATE_EMAIL	70
3d206f8d-e78b-461d-8382-ded3de34d357	CONFIGURE_RECOVERY_AUTHN_CODES	Recovery Authentication Codes	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	t	f	CONFIGURE_RECOVERY_AUTHN_CODES	130
c1d9eb6f-d45c-426d-b4bf-a0c832f48d4d	webauthn-register	Webauthn Register	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	t	f	webauthn-register	80
d15ee0f2-f62c-4abe-a285-045f99f848db	webauthn-register-passwordless	Webauthn Register Passwordless	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	t	f	webauthn-register-passwordless	90
9c29496b-7ede-4ed7-b2f4-f44078533d17	VERIFY_PROFILE	Verify Profile	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	t	f	VERIFY_PROFILE	100
3d4e343b-8daa-422b-90a9-7e5a7aed0255	idp_link	Linking Identity Provider	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	t	f	idp_link	120
d574c1ec-7c00-43c9-b167-81f0a68ab6fe	VERIFY_EMAIL	Verify Email	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	t	f	VERIFY_EMAIL	50
63439129-baa7-4a96-815b-27bd882a577e	UPDATE_PROFILE	Update Profile	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	t	f	UPDATE_PROFILE	40
31790f24-e4f0-48d4-b3ba-fd638e54a865	CONFIGURE_TOTP	Configure OTP	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	t	f	CONFIGURE_TOTP	10
43a61640-a15b-438f-b6a8-ea09f901fc8a	UPDATE_PASSWORD	Update Password	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	t	f	UPDATE_PASSWORD	30
d835745e-81bc-4371-87e1-d6c100a15756	TERMS_AND_CONDITIONS	Terms and Conditions	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	f	f	TERMS_AND_CONDITIONS	20
66f9d1ff-d2b3-42c2-9e53-2649611894d6	delete_account	Delete Account	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	f	f	delete_account	60
f8089f76-ccd3-407b-8d7f-a0734cee264a	delete_credential	Delete Credential	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	t	f	delete_credential	110
3a17aac4-d00b-44e0-967d-385a33cc0f4a	update_user_locale	Update User Locale	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	t	f	update_user_locale	1000
4a0b83eb-0fe0-445f-98e5-59d99f16600d	UPDATE_EMAIL	Update Email	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	f	f	UPDATE_EMAIL	70
b85a5ca3-4de2-421a-bdb8-88961472bc4b	CONFIGURE_RECOVERY_AUTHN_CODES	Recovery Authentication Codes	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	t	f	CONFIGURE_RECOVERY_AUTHN_CODES	130
76448820-8c78-464e-a672-d8dbc0766122	webauthn-register	Webauthn Register	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	t	f	webauthn-register	80
ab239446-ba79-444b-ba30-0d3b09422344	webauthn-register-passwordless	Webauthn Register Passwordless	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	t	f	webauthn-register-passwordless	90
30df100c-4461-4dd9-8a2c-cdca760fc04d	VERIFY_PROFILE	Verify Profile	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	t	f	VERIFY_PROFILE	100
11da8b52-9576-4ae5-9224-4d23e06b9496	idp_link	Linking Identity Provider	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	t	f	idp_link	120
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
cc39bee7-2e22-4ec7-96e6-47f3b38f88ad	1e6d2221-756b-4e8e-8fe6-3740bc698528
cc39bee7-2e22-4ec7-96e6-47f3b38f88ad	f6207dad-e8d1-427c-a3d6-4b5e08c3a9a9
6178dd03-ea93-491b-9340-c44abcfe617c	78694c8f-28c7-49c2-98b1-fd20ca0b1d83
6178dd03-ea93-491b-9340-c44abcfe617c	b40cd027-c121-42c3-8633-ba98f3ea193f
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: server_config; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.server_config (server_config_key, value, version) FROM stdin;
crt_jgroups	{"prvKey":"MIIEowIBAAKCAQEApvITjQac/0t7kpfb6LUngPceLxKKZrBhy/pKL3Uf+6Mbl6KMIymoczazjJOVi9NmgCN5CL6U4ucupeYJB/YsfubZYvsCiFpEcOOQbNSFq6Fy9sYsNfL3CjgRHCDoA1DYbyk4HVxMqyEbMLsQ2c3z5N3Q1T8IzPyFh2nuum9FSkr/JB5AlVU8ouH7TjX0J7vcbdEuk7M0IQOhKQZFdpCcBZgrzb7DJnjAJGU7f0GGZc4dRAIZKfJ+MghduQcjrpHeDIXCNDQnPI4XwBlUog/UplGb7UU/a4tJZx+W4LhzOwmvHJWEfgh6oMgl1ACAtCqfq+NOudXQEr7cQCH3rPODfQIDAQABAoIBAAog1Z7Qr+WtJqoWHHlZxDPGykYA0fS47rX5UVbfvDkABESG0AmyFU4oG2yD56a8BJPxkv480buSWvolopahEMICL14Z7GVpVI2kwLZZjmKDQP5Ht5buTp6IGEGknW7WEMttrMHbP6uCLqweLT+JhypzaqAFWvtUtqUogBs/dOy01v+Fq5tfFJFpsycJ6o35gqjS6JsOg0rsJlJ2oiNhQPQbwXyKjRbgPJuiQXzwb3Ay/wU17fTcE68Ol6/3Ok/84UACA1hCdVSvhHRAl3nDL82HuABdKhjOQiHBY2lbqnK50ayOh/TP0m+mrV11yi7GAoXv1RtNbsy1eHvbpw+7BOECgYEA0cgPhn43o4uswPoXgrLokTt4WZ+cwnySLXIXz/ctDRahBoJN/DQ+VZrzor8fSL2sKdILR0vaxZTks3LazUiI5sjb0hDWn0j/K0+GnA33LbjyQwr3EsA8SgEe3l0L+/lD+TXeEzN/NLC9chTZi6aBFpXGOxjXmQRm6MmBXaj2kncCgYEAy7oEvR0fqYqzIY6DTGB5oI0o1h1aBu0bWgyh7eYwSQ0Ncw3igdUKSdZD8F4kiNGyvdzIxddD++OPZl//YMA6VbnsrxclBrgCvt56RY/N3PcwogWDleDa6cOFy+k0uEMK9ug/pqU02MW7kf/Zt3a6czLOlkKRZUa6g5pq2B+rQqsCgYBNxUU8Lv6het6IjC67HWhqrwlm8G1FDLmEb4+0YYYqHAGGUDhpD1Usl01LQF9wsCBrQJs9yzlHlnNSs3m6MPHP3RbhQazPUFiIzeqxX9wK702g3SfLo8i2BsRS21veBgLVGMtDgwvdlMgmyuP7ibbBkLT0o7kJ2T/tfQagmksO8QKBgQDADc7l0QzGMcEJA2Z3nANM/YXfw6/ZE7FTRNFqijQ+yZVCP3am2oVmch19/eIHMViFcBu9ll+6mB3Zbuo69TyJEEs2DGWVXecItIckCJsTkdxBAV24706wTOhXALP4eQtfFDbdDKUzLcTTsBQ4xi6i5uSl9n9GsFSoN+w9bi1vHQKBgCXx4GytnOWQNMQLEmk6v6FrBZmk9SS+rDSLT1BPewOUMkR2yfAYIFnAVDI4vMKs46IrK0Zm+g86LBlJ+/2JNqLEWh+V73+qx9lCo6TEs80FrL8FhX+DPHkCf5qJqN/oir8yOt/5Vq4xeeZa7h0ZuNM51BC1/xquBrFTQWc/t1gP","pubKey":"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApvITjQac/0t7kpfb6LUngPceLxKKZrBhy/pKL3Uf+6Mbl6KMIymoczazjJOVi9NmgCN5CL6U4ucupeYJB/YsfubZYvsCiFpEcOOQbNSFq6Fy9sYsNfL3CjgRHCDoA1DYbyk4HVxMqyEbMLsQ2c3z5N3Q1T8IzPyFh2nuum9FSkr/JB5AlVU8ouH7TjX0J7vcbdEuk7M0IQOhKQZFdpCcBZgrzb7DJnjAJGU7f0GGZc4dRAIZKfJ+MghduQcjrpHeDIXCNDQnPI4XwBlUog/UplGb7UU/a4tJZx+W4LhzOwmvHJWEfgh6oMgl1ACAtCqfq+NOudXQEr7cQCH3rPODfQIDAQAB","crt":"MIICnTCCAYUCBgGaRkFsUTANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdqZ3JvdXBzMB4XDTI1MTEwMjIwMjYyNFoXDTI2MDEwMTIwMjgwM1owEjEQMA4GA1UEAwwHamdyb3VwczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKbyE40GnP9Le5KX2+i1J4D3Hi8SimawYcv6Si91H/ujG5eijCMpqHM2s4yTlYvTZoAjeQi+lOLnLqXmCQf2LH7m2WL7AohaRHDjkGzUhauhcvbGLDXy9wo4ERwg6ANQ2G8pOB1cTKshGzC7ENnN8+Td0NU/CMz8hYdp7rpvRUpK/yQeQJVVPKLh+0419Ce73G3RLpOzNCEDoSkGRXaQnAWYK82+wyZ4wCRlO39BhmXOHUQCGSnyfjIIXbkHI66R3gyFwjQ0JzyOF8AZVKIP1KZRm+1FP2uLSWcfluC4czsJrxyVhH4IeqDIJdQAgLQqn6vjTrnV0BK+3EAh96zzg30CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAnPS8FOYzJ/sYP27KhW2EV07US8YxryqnIsvHUWvPvevai6eoAHPAgsBH0sSv3iMR+5i6HFWVe7Lv8BM2ahnNSDDJaC1sc6fRJl58nnd7wwvL9gryjjBWqyGdQ5CkADHYM8zSnUwQMdxaiqLz9eLTcIeqTiP1kz6375GyhxXMB6VimWN4a/A+xBdmrAnG83nYB/ZMeKzVGh0AT4E/u4Dr9jZiiENDJ4wD8HFyYFRW1AyTBZZ3gx0Af4rITeCHpBkmLNRo1DoHx3dOLwCOQlIoFfEwBNeYMUPwLoLi3qFiHYV9VN6lNvaO0aJZYyssB4mL7xAvIUFYoL86K7C3ghgntQ==","alias":"a4021a9e-73d3-4c82-ba9b-fe7a808941c1","generatedMillis":1762115284120}	0
JGROUPS_ADDRESS_SEQUENCE	10	10
\.


--
-- Data for Name: servicio; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.servicio (id, nombre, duracion_minutos) FROM stdin;
1	Cirugía General	120
2	Cirugía Cardiovascular	240
3	Cirugía Plástica	180
4	Cirugía Pediátrica	150
5	Neurocirugía	300
6	Anestesiología	60
7	Instrumentación Quirúrgica	90
8	Esterilización de Material	45
9	Recuperación Postquirúrgica	60
10	Traumatología y Ortopedia	180
\.


--
-- Data for Name: tipo_intervencion; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.tipo_intervencion (id, descripcion, nombre) FROM stdin;
1	Procedimientos quirúrgicos generales	Cirugía General
2	Intervenciones del corazón y sistema cardiovascular	Cirugía Cardíaca
3	Intervenciones del sistema musculoesquelético	Cirugía Ortopédica
4	Intervenciones del sistema nervioso	Neurocirugía
5	Procedimientos reconstructivos y estéticos	Cirugía Plástica
6	Intervenciones del tórax y pulmones	Cirugía Torácica
7	Intervenciones del sistema vascular	Cirugía Vascular
8	Intervenciones del sistema urinario	Cirugía Urológica
9	Intervenciones oculares	Cirugía Oftalmológica
10	Procedimientos mínimamente invasivos	Cirugía Laparoscópica
\.


--
-- Data for Name: turno; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.turno (id, estado, fecha_hora_inicio, cirugia_id, quirofano_id, urgencia_id) FROM stdin;
13512	DISPONIBLE	2026-05-24 09:30:00	\N	3	\N
13513	DISPONIBLE	2026-05-24 10:00:00	\N	1	\N
13514	DISPONIBLE	2026-05-24 10:00:00	\N	2	\N
11701	DISPONIBLE	2026-04-24 08:00:00	\N	1	\N
11702	DISPONIBLE	2026-04-24 08:00:00	\N	2	\N
11703	DISPONIBLE	2026-04-24 08:00:00	\N	3	\N
11704	DISPONIBLE	2026-04-24 08:30:00	\N	1	\N
11705	DISPONIBLE	2026-04-24 08:30:00	\N	2	\N
11706	DISPONIBLE	2026-04-24 08:30:00	\N	3	\N
11707	DISPONIBLE	2026-04-24 09:00:00	\N	1	\N
11708	DISPONIBLE	2026-04-24 09:00:00	\N	2	\N
11709	DISPONIBLE	2026-04-24 09:00:00	\N	3	\N
11710	DISPONIBLE	2026-04-24 09:30:00	\N	1	\N
11711	DISPONIBLE	2026-04-24 09:30:00	\N	2	\N
13515	DISPONIBLE	2026-05-24 10:00:00	\N	3	\N
13516	DISPONIBLE	2026-05-24 10:30:00	\N	1	\N
13517	DISPONIBLE	2026-05-24 10:30:00	\N	2	\N
13518	DISPONIBLE	2026-05-24 10:30:00	\N	3	\N
13519	DISPONIBLE	2026-05-24 11:00:00	\N	1	\N
13520	DISPONIBLE	2026-05-24 11:00:00	\N	2	\N
13521	DISPONIBLE	2026-05-24 11:00:00	\N	3	\N
13522	DISPONIBLE	2026-05-24 11:30:00	\N	1	\N
13523	DISPONIBLE	2026-05-24 11:30:00	\N	2	\N
13524	DISPONIBLE	2026-05-24 11:30:00	\N	3	\N
13525	DISPONIBLE	2026-05-24 12:00:00	\N	1	\N
13526	DISPONIBLE	2026-05-24 12:00:00	\N	2	\N
13527	DISPONIBLE	2026-05-24 12:00:00	\N	3	\N
13528	DISPONIBLE	2026-05-24 12:30:00	\N	1	\N
13529	DISPONIBLE	2026-05-24 12:30:00	\N	2	\N
13530	DISPONIBLE	2026-05-24 12:30:00	\N	3	\N
13531	DISPONIBLE	2026-05-24 13:00:00	\N	1	\N
13532	DISPONIBLE	2026-05-24 13:00:00	\N	2	\N
13533	DISPONIBLE	2026-05-24 13:00:00	\N	3	\N
13534	DISPONIBLE	2026-05-24 13:30:00	\N	1	\N
13535	DISPONIBLE	2026-05-24 13:30:00	\N	2	\N
13536	DISPONIBLE	2026-05-24 13:30:00	\N	3	\N
13537	DISPONIBLE	2026-05-24 14:00:00	\N	1	\N
13538	DISPONIBLE	2026-05-24 14:00:00	\N	2	\N
13539	DISPONIBLE	2026-05-24 14:00:00	\N	3	\N
13540	DISPONIBLE	2026-05-24 14:30:00	\N	1	\N
13541	DISPONIBLE	2026-05-24 14:30:00	\N	2	\N
13542	DISPONIBLE	2026-05-24 14:30:00	\N	3	\N
13543	DISPONIBLE	2026-05-24 15:00:00	\N	1	\N
13544	DISPONIBLE	2026-05-24 15:00:00	\N	2	\N
13545	DISPONIBLE	2026-05-24 15:00:00	\N	3	\N
13546	DISPONIBLE	2026-05-24 15:30:00	\N	1	\N
13547	DISPONIBLE	2026-05-24 15:30:00	\N	2	\N
13548	DISPONIBLE	2026-05-24 15:30:00	\N	3	\N
13549	DISPONIBLE	2026-05-24 16:00:00	\N	1	\N
13550	DISPONIBLE	2026-05-24 16:00:00	\N	2	\N
13551	DISPONIBLE	2026-05-24 16:00:00	\N	3	\N
13552	DISPONIBLE	2026-05-24 16:30:00	\N	1	\N
13553	DISPONIBLE	2026-05-24 16:30:00	\N	2	\N
13554	DISPONIBLE	2026-05-24 16:30:00	\N	3	\N
13555	DISPONIBLE	2026-05-24 17:00:00	\N	1	\N
13556	DISPONIBLE	2026-05-24 17:00:00	\N	2	\N
13557	DISPONIBLE	2026-05-24 17:00:00	\N	3	\N
13558	DISPONIBLE	2026-05-24 17:30:00	\N	1	\N
13559	DISPONIBLE	2026-05-24 17:30:00	\N	2	\N
13560	DISPONIBLE	2026-05-24 17:30:00	\N	3	\N
11789	ASIGNADO	2026-04-25 12:30:00	292	2	\N
12042	DISPONIBLE	2026-04-29 14:30:00	\N	3	\N
12045	DISPONIBLE	2026-04-29 15:00:00	\N	3	\N
12048	DISPONIBLE	2026-04-29 15:30:00	\N	3	\N
12051	DISPONIBLE	2026-04-29 16:00:00	\N	3	\N
12054	DISPONIBLE	2026-04-29 16:30:00	\N	3	\N
12016	ASIGNADO	2026-04-29 10:30:00	306	1	\N
12019	ASIGNADO	2026-04-29 11:00:00	306	1	\N
12022	ASIGNADO	2026-04-29 11:30:00	306	1	\N
12013	DISPONIBLE	2026-04-29 10:00:00	\N	1	\N
12361	DISPONIBLE	2026-05-05 08:00:00	\N	1	\N
12364	ASIGNADO_URGENCIA	2026-05-05 08:30:00	\N	1	13
12367	ASIGNADO_URGENCIA	2026-05-05 09:00:00	\N	1	13
12370	ASIGNADO_URGENCIA	2026-05-05 09:30:00	\N	1	13
12430	ASIGNADO_URGENCIA	2026-05-06 09:30:00	\N	1	14
12433	ASIGNADO_URGENCIA	2026-05-06 10:00:00	\N	1	14
12436	ASIGNADO_URGENCIA	2026-05-06 10:30:00	\N	1	14
12439	ASIGNADO_URGENCIA	2026-05-06 11:00:00	\N	1	14
12442	ASIGNADO_URGENCIA	2026-05-06 11:30:00	\N	1	14
12490	ASIGNADO_URGENCIA	2026-05-07 09:30:00	\N	1	15
12493	ASIGNADO_URGENCIA	2026-05-07 10:00:00	\N	1	15
12496	ASIGNADO_URGENCIA	2026-05-07 10:30:00	\N	1	15
12499	ASIGNADO_URGENCIA	2026-05-07 11:00:00	\N	1	15
12502	ASIGNADO_URGENCIA	2026-05-07 11:30:00	\N	1	15
11848	ASIGNADO	2026-04-26 12:30:00	294	1	\N
11851	ASIGNADO	2026-04-26 13:00:00	294	1	\N
11854	ASIGNADO	2026-04-26 13:30:00	294	1	\N
11712	DISPONIBLE	2026-04-24 09:30:00	\N	3	\N
11713	DISPONIBLE	2026-04-24 10:00:00	\N	1	\N
11714	DISPONIBLE	2026-04-24 10:00:00	\N	2	\N
11715	DISPONIBLE	2026-04-24 10:00:00	\N	3	\N
11716	DISPONIBLE	2026-04-24 10:30:00	\N	1	\N
11717	DISPONIBLE	2026-04-24 10:30:00	\N	2	\N
11718	DISPONIBLE	2026-04-24 10:30:00	\N	3	\N
11719	DISPONIBLE	2026-04-24 11:00:00	\N	1	\N
11720	DISPONIBLE	2026-04-24 11:00:00	\N	2	\N
11857	ASIGNADO	2026-04-26 14:00:00	294	1	\N
11860	ASIGNADO	2026-04-26 14:30:00	294	1	\N
11863	ASIGNADO	2026-04-26 15:00:00	294	1	\N
12037	DISPONIBLE	2026-04-29 14:00:00	\N	1	\N
12028	DISPONIBLE	2026-04-29 12:30:00	\N	1	\N
12031	DISPONIBLE	2026-04-29 13:00:00	\N	1	\N
12034	DISPONIBLE	2026-04-29 13:30:00	\N	1	\N
12382	ASIGNADO_URGENCIA	2026-05-05 11:30:00	\N	1	13
12526	ASIGNADO	2026-05-07 15:30:00	311	1	\N
11721	DISPONIBLE	2026-04-24 11:00:00	\N	3	\N
12076	ASIGNADO_URGENCIA	2026-04-30 10:30:00	\N	1	11
12079	ASIGNADO_URGENCIA	2026-04-30 11:00:00	\N	1	11
12082	ASIGNADO_URGENCIA	2026-04-30 11:30:00	\N	1	11
12070	ASIGNADO_URGENCIA	2026-04-30 09:30:00	\N	1	11
12073	ASIGNADO_URGENCIA	2026-04-30 10:00:00	\N	1	11
12379	ASIGNADO_URGENCIA	2026-05-05 11:00:00	\N	1	13
12601	ASIGNADO	2026-05-09 08:00:00	312	1	\N
12604	ASIGNADO	2026-05-09 08:30:00	312	1	\N
12607	ASIGNADO	2026-05-09 09:00:00	312	1	\N
12610	ASIGNADO	2026-05-09 09:30:00	312	1	\N
12613	ASIGNADO	2026-05-09 10:00:00	312	1	\N
12616	ASIGNADO	2026-05-09 10:30:00	312	1	\N
12619	ASIGNADO	2026-05-09 11:00:00	312	1	\N
12622	ASIGNADO	2026-05-09 11:30:00	312	1	\N
12241	ASIGNADO	2026-05-03 08:00:00	307	1	\N
12244	ASIGNADO	2026-05-03 08:30:00	307	1	\N
12247	ASIGNADO	2026-05-03 09:00:00	307	1	\N
12250	ASIGNADO	2026-05-03 09:30:00	307	1	\N
12253	ASIGNADO	2026-05-03 10:00:00	307	1	\N
12256	ASIGNADO	2026-05-03 10:30:00	307	1	\N
12259	ASIGNADO	2026-05-03 11:00:00	307	1	\N
12262	ASIGNADO	2026-05-03 11:30:00	307	1	\N
11773	ASIGNADO	2026-04-25 10:00:00	291	1	\N
11776	ASIGNADO	2026-04-25 10:30:00	291	1	\N
11779	ASIGNADO	2026-04-25 11:00:00	291	1	\N
11782	ASIGNADO	2026-04-25 11:30:00	291	1	\N
11762	ASIGNADO	2026-04-25 08:00:00	292	2	\N
11765	ASIGNADO	2026-04-25 08:30:00	292	2	\N
11768	ASIGNADO	2026-04-25 09:00:00	292	2	\N
11771	ASIGNADO	2026-04-25 09:30:00	292	2	\N
11722	DISPONIBLE	2026-04-24 11:30:00	\N	1	\N
11723	DISPONIBLE	2026-04-24 11:30:00	\N	2	\N
11724	DISPONIBLE	2026-04-24 11:30:00	\N	3	\N
11725	DISPONIBLE	2026-04-24 12:00:00	\N	1	\N
11726	DISPONIBLE	2026-04-24 12:00:00	\N	2	\N
11727	DISPONIBLE	2026-04-24 12:00:00	\N	3	\N
11728	DISPONIBLE	2026-04-24 12:30:00	\N	1	\N
11729	DISPONIBLE	2026-04-24 12:30:00	\N	2	\N
11730	DISPONIBLE	2026-04-24 12:30:00	\N	3	\N
11731	DISPONIBLE	2026-04-24 13:00:00	\N	1	\N
11732	DISPONIBLE	2026-04-24 13:00:00	\N	2	\N
11733	DISPONIBLE	2026-04-24 13:00:00	\N	3	\N
11734	DISPONIBLE	2026-04-24 13:30:00	\N	1	\N
11735	DISPONIBLE	2026-04-24 13:30:00	\N	2	\N
11736	DISPONIBLE	2026-04-24 13:30:00	\N	3	\N
11737	DISPONIBLE	2026-04-24 14:00:00	\N	1	\N
11738	DISPONIBLE	2026-04-24 14:00:00	\N	2	\N
11739	DISPONIBLE	2026-04-24 14:00:00	\N	3	\N
11740	DISPONIBLE	2026-04-24 14:30:00	\N	1	\N
11741	DISPONIBLE	2026-04-24 14:30:00	\N	2	\N
11742	DISPONIBLE	2026-04-24 14:30:00	\N	3	\N
11743	DISPONIBLE	2026-04-24 15:00:00	\N	1	\N
11744	DISPONIBLE	2026-04-24 15:00:00	\N	2	\N
11745	DISPONIBLE	2026-04-24 15:00:00	\N	3	\N
11746	DISPONIBLE	2026-04-24 15:30:00	\N	1	\N
11747	DISPONIBLE	2026-04-24 15:30:00	\N	2	\N
11748	DISPONIBLE	2026-04-24 15:30:00	\N	3	\N
11749	DISPONIBLE	2026-04-24 16:00:00	\N	1	\N
11750	DISPONIBLE	2026-04-24 16:00:00	\N	2	\N
11751	DISPONIBLE	2026-04-24 16:00:00	\N	3	\N
11752	DISPONIBLE	2026-04-24 16:30:00	\N	1	\N
11753	DISPONIBLE	2026-04-24 16:30:00	\N	2	\N
11754	DISPONIBLE	2026-04-24 16:30:00	\N	3	\N
11755	DISPONIBLE	2026-04-24 17:00:00	\N	1	\N
11756	DISPONIBLE	2026-04-24 17:00:00	\N	2	\N
11757	DISPONIBLE	2026-04-24 17:00:00	\N	3	\N
11758	DISPONIBLE	2026-04-24 17:30:00	\N	1	\N
11759	DISPONIBLE	2026-04-24 17:30:00	\N	2	\N
11760	DISPONIBLE	2026-04-24 17:30:00	\N	3	\N
11763	DISPONIBLE	2026-04-25 08:00:00	\N	3	\N
11766	DISPONIBLE	2026-04-25 08:30:00	\N	3	\N
11769	DISPONIBLE	2026-04-25 09:00:00	\N	3	\N
11772	DISPONIBLE	2026-04-25 09:30:00	\N	3	\N
11775	DISPONIBLE	2026-04-25 10:00:00	\N	3	\N
11778	DISPONIBLE	2026-04-25 10:30:00	\N	3	\N
11781	DISPONIBLE	2026-04-25 11:00:00	\N	3	\N
11784	DISPONIBLE	2026-04-25 11:30:00	\N	3	\N
11785	DISPONIBLE	2026-04-25 12:00:00	\N	1	\N
11787	DISPONIBLE	2026-04-25 12:00:00	\N	3	\N
11788	DISPONIBLE	2026-04-25 12:30:00	\N	1	\N
11790	DISPONIBLE	2026-04-25 12:30:00	\N	3	\N
11791	DISPONIBLE	2026-04-25 13:00:00	\N	1	\N
11793	DISPONIBLE	2026-04-25 13:00:00	\N	3	\N
11794	DISPONIBLE	2026-04-25 13:30:00	\N	1	\N
11796	DISPONIBLE	2026-04-25 13:30:00	\N	3	\N
11797	DISPONIBLE	2026-04-25 14:00:00	\N	1	\N
11799	DISPONIBLE	2026-04-25 14:00:00	\N	3	\N
11800	DISPONIBLE	2026-04-25 14:30:00	\N	1	\N
11802	DISPONIBLE	2026-04-25 14:30:00	\N	3	\N
11803	DISPONIBLE	2026-04-25 15:00:00	\N	1	\N
11805	DISPONIBLE	2026-04-25 15:00:00	\N	3	\N
11806	DISPONIBLE	2026-04-25 15:30:00	\N	1	\N
11807	DISPONIBLE	2026-04-25 15:30:00	\N	2	\N
11808	DISPONIBLE	2026-04-25 15:30:00	\N	3	\N
11809	DISPONIBLE	2026-04-25 16:00:00	\N	1	\N
11810	DISPONIBLE	2026-04-25 16:00:00	\N	2	\N
11811	DISPONIBLE	2026-04-25 16:00:00	\N	3	\N
11812	DISPONIBLE	2026-04-25 16:30:00	\N	1	\N
11813	DISPONIBLE	2026-04-25 16:30:00	\N	2	\N
11814	DISPONIBLE	2026-04-25 16:30:00	\N	3	\N
11815	DISPONIBLE	2026-04-25 17:00:00	\N	1	\N
11816	DISPONIBLE	2026-04-25 17:00:00	\N	2	\N
11817	DISPONIBLE	2026-04-25 17:00:00	\N	3	\N
11818	DISPONIBLE	2026-04-25 17:30:00	\N	1	\N
11819	DISPONIBLE	2026-04-25 17:30:00	\N	2	\N
11820	DISPONIBLE	2026-04-25 17:30:00	\N	3	\N
11821	DISPONIBLE	2026-04-26 08:00:00	\N	1	\N
11822	DISPONIBLE	2026-04-26 08:00:00	\N	2	\N
11823	DISPONIBLE	2026-04-26 08:00:00	\N	3	\N
11824	DISPONIBLE	2026-04-26 08:30:00	\N	1	\N
11825	DISPONIBLE	2026-04-26 08:30:00	\N	2	\N
11826	DISPONIBLE	2026-04-26 08:30:00	\N	3	\N
11827	DISPONIBLE	2026-04-26 09:00:00	\N	1	\N
11828	DISPONIBLE	2026-04-26 09:00:00	\N	2	\N
11774	ASIGNADO	2026-04-25 10:00:00	292	2	\N
11777	ASIGNADO	2026-04-25 10:30:00	292	2	\N
11780	ASIGNADO	2026-04-25 11:00:00	292	2	\N
11783	ASIGNADO	2026-04-25 11:30:00	292	2	\N
11786	ASIGNADO	2026-04-25 12:00:00	292	2	\N
11792	ASIGNADO	2026-04-25 13:00:00	293	2	\N
11795	ASIGNADO	2026-04-25 13:30:00	293	2	\N
11798	ASIGNADO	2026-04-25 14:00:00	293	2	\N
11801	ASIGNADO	2026-04-25 14:30:00	293	2	\N
11804	ASIGNADO	2026-04-25 15:00:00	293	2	\N
11761	DISPONIBLE	2026-04-25 08:00:00	\N	1	\N
11764	DISPONIBLE	2026-04-25 08:30:00	\N	1	\N
11767	DISPONIBLE	2026-04-25 09:00:00	\N	1	\N
11770	DISPONIBLE	2026-04-25 09:30:00	\N	1	\N
11829	DISPONIBLE	2026-04-26 09:00:00	\N	3	\N
11830	DISPONIBLE	2026-04-26 09:30:00	\N	1	\N
11831	DISPONIBLE	2026-04-26 09:30:00	\N	2	\N
11832	DISPONIBLE	2026-04-26 09:30:00	\N	3	\N
11833	DISPONIBLE	2026-04-26 10:00:00	\N	1	\N
11834	DISPONIBLE	2026-04-26 10:00:00	\N	2	\N
11835	DISPONIBLE	2026-04-26 10:00:00	\N	3	\N
11836	DISPONIBLE	2026-04-26 10:30:00	\N	1	\N
11837	DISPONIBLE	2026-04-26 10:30:00	\N	2	\N
11838	DISPONIBLE	2026-04-26 10:30:00	\N	3	\N
11839	DISPONIBLE	2026-04-26 11:00:00	\N	1	\N
11840	DISPONIBLE	2026-04-26 11:00:00	\N	2	\N
11841	DISPONIBLE	2026-04-26 11:00:00	\N	3	\N
11842	DISPONIBLE	2026-04-26 11:30:00	\N	1	\N
11843	DISPONIBLE	2026-04-26 11:30:00	\N	2	\N
11844	DISPONIBLE	2026-04-26 11:30:00	\N	3	\N
11845	DISPONIBLE	2026-04-26 12:00:00	\N	1	\N
11846	DISPONIBLE	2026-04-26 12:00:00	\N	2	\N
11847	DISPONIBLE	2026-04-26 12:00:00	\N	3	\N
11849	DISPONIBLE	2026-04-26 12:30:00	\N	2	\N
11850	DISPONIBLE	2026-04-26 12:30:00	\N	3	\N
11852	DISPONIBLE	2026-04-26 13:00:00	\N	2	\N
11853	DISPONIBLE	2026-04-26 13:00:00	\N	3	\N
11855	DISPONIBLE	2026-04-26 13:30:00	\N	2	\N
11856	DISPONIBLE	2026-04-26 13:30:00	\N	3	\N
11858	DISPONIBLE	2026-04-26 14:00:00	\N	2	\N
11859	DISPONIBLE	2026-04-26 14:00:00	\N	3	\N
11861	DISPONIBLE	2026-04-26 14:30:00	\N	2	\N
11862	DISPONIBLE	2026-04-26 14:30:00	\N	3	\N
11864	DISPONIBLE	2026-04-26 15:00:00	\N	2	\N
11865	DISPONIBLE	2026-04-26 15:00:00	\N	3	\N
11866	DISPONIBLE	2026-04-26 15:30:00	\N	1	\N
11867	DISPONIBLE	2026-04-26 15:30:00	\N	2	\N
11868	DISPONIBLE	2026-04-26 15:30:00	\N	3	\N
11869	DISPONIBLE	2026-04-26 16:00:00	\N	1	\N
11870	DISPONIBLE	2026-04-26 16:00:00	\N	2	\N
11871	DISPONIBLE	2026-04-26 16:00:00	\N	3	\N
11872	DISPONIBLE	2026-04-26 16:30:00	\N	1	\N
11873	DISPONIBLE	2026-04-26 16:30:00	\N	2	\N
11874	DISPONIBLE	2026-04-26 16:30:00	\N	3	\N
11875	DISPONIBLE	2026-04-26 17:00:00	\N	1	\N
11876	DISPONIBLE	2026-04-26 17:00:00	\N	2	\N
11877	DISPONIBLE	2026-04-26 17:00:00	\N	3	\N
11878	DISPONIBLE	2026-04-26 17:30:00	\N	1	\N
11879	DISPONIBLE	2026-04-26 17:30:00	\N	2	\N
11880	DISPONIBLE	2026-04-26 17:30:00	\N	3	\N
11881	DISPONIBLE	2026-04-27 08:00:00	\N	1	\N
11882	DISPONIBLE	2026-04-27 08:00:00	\N	2	\N
11883	DISPONIBLE	2026-04-27 08:00:00	\N	3	\N
11884	DISPONIBLE	2026-04-27 08:30:00	\N	1	\N
11885	DISPONIBLE	2026-04-27 08:30:00	\N	2	\N
11886	DISPONIBLE	2026-04-27 08:30:00	\N	3	\N
11887	DISPONIBLE	2026-04-27 09:00:00	\N	1	\N
11888	DISPONIBLE	2026-04-27 09:00:00	\N	2	\N
11889	DISPONIBLE	2026-04-27 09:00:00	\N	3	\N
11890	DISPONIBLE	2026-04-27 09:30:00	\N	1	\N
11891	DISPONIBLE	2026-04-27 09:30:00	\N	2	\N
11892	DISPONIBLE	2026-04-27 09:30:00	\N	3	\N
11893	DISPONIBLE	2026-04-27 10:00:00	\N	1	\N
11894	DISPONIBLE	2026-04-27 10:00:00	\N	2	\N
11895	DISPONIBLE	2026-04-27 10:00:00	\N	3	\N
11896	DISPONIBLE	2026-04-27 10:30:00	\N	1	\N
11897	DISPONIBLE	2026-04-27 10:30:00	\N	2	\N
11898	DISPONIBLE	2026-04-27 10:30:00	\N	3	\N
11899	DISPONIBLE	2026-04-27 11:00:00	\N	1	\N
11900	DISPONIBLE	2026-04-27 11:00:00	\N	2	\N
11901	DISPONIBLE	2026-04-27 11:00:00	\N	3	\N
11902	DISPONIBLE	2026-04-27 11:30:00	\N	1	\N
11903	DISPONIBLE	2026-04-27 11:30:00	\N	2	\N
11904	DISPONIBLE	2026-04-27 11:30:00	\N	3	\N
11905	DISPONIBLE	2026-04-27 12:00:00	\N	1	\N
11906	DISPONIBLE	2026-04-27 12:00:00	\N	2	\N
11907	DISPONIBLE	2026-04-27 12:00:00	\N	3	\N
11908	DISPONIBLE	2026-04-27 12:30:00	\N	1	\N
11909	DISPONIBLE	2026-04-27 12:30:00	\N	2	\N
11910	DISPONIBLE	2026-04-27 12:30:00	\N	3	\N
11911	DISPONIBLE	2026-04-27 13:00:00	\N	1	\N
11912	DISPONIBLE	2026-04-27 13:00:00	\N	2	\N
11913	DISPONIBLE	2026-04-27 13:00:00	\N	3	\N
11914	DISPONIBLE	2026-04-27 13:30:00	\N	1	\N
11915	DISPONIBLE	2026-04-27 13:30:00	\N	2	\N
11916	DISPONIBLE	2026-04-27 13:30:00	\N	3	\N
11917	DISPONIBLE	2026-04-27 14:00:00	\N	1	\N
11918	DISPONIBLE	2026-04-27 14:00:00	\N	2	\N
11919	DISPONIBLE	2026-04-27 14:00:00	\N	3	\N
11920	DISPONIBLE	2026-04-27 14:30:00	\N	1	\N
11921	DISPONIBLE	2026-04-27 14:30:00	\N	2	\N
11922	DISPONIBLE	2026-04-27 14:30:00	\N	3	\N
11923	DISPONIBLE	2026-04-27 15:00:00	\N	1	\N
11924	DISPONIBLE	2026-04-27 15:00:00	\N	2	\N
11925	DISPONIBLE	2026-04-27 15:00:00	\N	3	\N
11926	DISPONIBLE	2026-04-27 15:30:00	\N	1	\N
11927	DISPONIBLE	2026-04-27 15:30:00	\N	2	\N
11928	DISPONIBLE	2026-04-27 15:30:00	\N	3	\N
11929	DISPONIBLE	2026-04-27 16:00:00	\N	1	\N
11930	DISPONIBLE	2026-04-27 16:00:00	\N	2	\N
11931	DISPONIBLE	2026-04-27 16:00:00	\N	3	\N
11932	DISPONIBLE	2026-04-27 16:30:00	\N	1	\N
11933	DISPONIBLE	2026-04-27 16:30:00	\N	2	\N
11934	DISPONIBLE	2026-04-27 16:30:00	\N	3	\N
11935	DISPONIBLE	2026-04-27 17:00:00	\N	1	\N
11936	DISPONIBLE	2026-04-27 17:00:00	\N	2	\N
11937	DISPONIBLE	2026-04-27 17:00:00	\N	3	\N
11938	DISPONIBLE	2026-04-27 17:30:00	\N	1	\N
11939	DISPONIBLE	2026-04-27 17:30:00	\N	2	\N
11940	DISPONIBLE	2026-04-27 17:30:00	\N	3	\N
11941	DISPONIBLE	2026-04-28 08:00:00	\N	1	\N
11942	DISPONIBLE	2026-04-28 08:00:00	\N	2	\N
11943	DISPONIBLE	2026-04-28 08:00:00	\N	3	\N
11944	DISPONIBLE	2026-04-28 08:30:00	\N	1	\N
11945	DISPONIBLE	2026-04-28 08:30:00	\N	2	\N
11946	DISPONIBLE	2026-04-28 08:30:00	\N	3	\N
11947	DISPONIBLE	2026-04-28 09:00:00	\N	1	\N
11948	DISPONIBLE	2026-04-28 09:00:00	\N	2	\N
11949	DISPONIBLE	2026-04-28 09:00:00	\N	3	\N
11950	DISPONIBLE	2026-04-28 09:30:00	\N	1	\N
11951	DISPONIBLE	2026-04-28 09:30:00	\N	2	\N
11952	DISPONIBLE	2026-04-28 09:30:00	\N	3	\N
11953	DISPONIBLE	2026-04-28 10:00:00	\N	1	\N
11954	DISPONIBLE	2026-04-28 10:00:00	\N	2	\N
11955	DISPONIBLE	2026-04-28 10:00:00	\N	3	\N
11956	DISPONIBLE	2026-04-28 10:30:00	\N	1	\N
11957	DISPONIBLE	2026-04-28 10:30:00	\N	2	\N
11958	DISPONIBLE	2026-04-28 10:30:00	\N	3	\N
11959	DISPONIBLE	2026-04-28 11:00:00	\N	1	\N
11960	DISPONIBLE	2026-04-28 11:00:00	\N	2	\N
11961	DISPONIBLE	2026-04-28 11:00:00	\N	3	\N
11962	DISPONIBLE	2026-04-28 11:30:00	\N	1	\N
11963	DISPONIBLE	2026-04-28 11:30:00	\N	2	\N
11964	DISPONIBLE	2026-04-28 11:30:00	\N	3	\N
11965	DISPONIBLE	2026-04-28 12:00:00	\N	1	\N
11966	DISPONIBLE	2026-04-28 12:00:00	\N	2	\N
11967	DISPONIBLE	2026-04-28 12:00:00	\N	3	\N
11968	DISPONIBLE	2026-04-28 12:30:00	\N	1	\N
11969	DISPONIBLE	2026-04-28 12:30:00	\N	2	\N
11970	DISPONIBLE	2026-04-28 12:30:00	\N	3	\N
11971	DISPONIBLE	2026-04-28 13:00:00	\N	1	\N
11972	DISPONIBLE	2026-04-28 13:00:00	\N	2	\N
11973	DISPONIBLE	2026-04-28 13:00:00	\N	3	\N
11974	DISPONIBLE	2026-04-28 13:30:00	\N	1	\N
11975	DISPONIBLE	2026-04-28 13:30:00	\N	2	\N
11976	DISPONIBLE	2026-04-28 13:30:00	\N	3	\N
11977	DISPONIBLE	2026-04-28 14:00:00	\N	1	\N
11978	DISPONIBLE	2026-04-28 14:00:00	\N	2	\N
11979	DISPONIBLE	2026-04-28 14:00:00	\N	3	\N
11980	DISPONIBLE	2026-04-28 14:30:00	\N	1	\N
11981	DISPONIBLE	2026-04-28 14:30:00	\N	2	\N
11982	DISPONIBLE	2026-04-28 14:30:00	\N	3	\N
11983	DISPONIBLE	2026-04-28 15:00:00	\N	1	\N
11984	DISPONIBLE	2026-04-28 15:00:00	\N	2	\N
11985	DISPONIBLE	2026-04-28 15:00:00	\N	3	\N
11986	DISPONIBLE	2026-04-28 15:30:00	\N	1	\N
11987	DISPONIBLE	2026-04-28 15:30:00	\N	2	\N
11988	DISPONIBLE	2026-04-28 15:30:00	\N	3	\N
11989	DISPONIBLE	2026-04-28 16:00:00	\N	1	\N
11990	DISPONIBLE	2026-04-28 16:00:00	\N	2	\N
11991	DISPONIBLE	2026-04-28 16:00:00	\N	3	\N
11992	DISPONIBLE	2026-04-28 16:30:00	\N	1	\N
11993	DISPONIBLE	2026-04-28 16:30:00	\N	2	\N
11994	DISPONIBLE	2026-04-28 16:30:00	\N	3	\N
11995	DISPONIBLE	2026-04-28 17:00:00	\N	1	\N
11996	DISPONIBLE	2026-04-28 17:00:00	\N	2	\N
11997	DISPONIBLE	2026-04-28 17:00:00	\N	3	\N
11998	DISPONIBLE	2026-04-28 17:30:00	\N	1	\N
11999	DISPONIBLE	2026-04-28 17:30:00	\N	2	\N
12000	DISPONIBLE	2026-04-28 17:30:00	\N	3	\N
12002	DISPONIBLE	2026-04-29 08:00:00	\N	2	\N
12003	DISPONIBLE	2026-04-29 08:00:00	\N	3	\N
12005	DISPONIBLE	2026-04-29 08:30:00	\N	2	\N
12006	DISPONIBLE	2026-04-29 08:30:00	\N	3	\N
12008	DISPONIBLE	2026-04-29 09:00:00	\N	2	\N
12009	DISPONIBLE	2026-04-29 09:00:00	\N	3	\N
12011	DISPONIBLE	2026-04-29 09:30:00	\N	2	\N
12012	DISPONIBLE	2026-04-29 09:30:00	\N	3	\N
12014	DISPONIBLE	2026-04-29 10:00:00	\N	2	\N
12015	DISPONIBLE	2026-04-29 10:00:00	\N	3	\N
12017	DISPONIBLE	2026-04-29 10:30:00	\N	2	\N
12018	DISPONIBLE	2026-04-29 10:30:00	\N	3	\N
12020	DISPONIBLE	2026-04-29 11:00:00	\N	2	\N
12021	DISPONIBLE	2026-04-29 11:00:00	\N	3	\N
12023	DISPONIBLE	2026-04-29 11:30:00	\N	2	\N
12024	DISPONIBLE	2026-04-29 11:30:00	\N	3	\N
12026	DISPONIBLE	2026-04-29 12:00:00	\N	2	\N
12027	DISPONIBLE	2026-04-29 12:00:00	\N	3	\N
12029	DISPONIBLE	2026-04-29 12:30:00	\N	2	\N
12030	DISPONIBLE	2026-04-29 12:30:00	\N	3	\N
12032	DISPONIBLE	2026-04-29 13:00:00	\N	2	\N
12033	DISPONIBLE	2026-04-29 13:00:00	\N	3	\N
12035	DISPONIBLE	2026-04-29 13:30:00	\N	2	\N
12036	DISPONIBLE	2026-04-29 13:30:00	\N	3	\N
12038	DISPONIBLE	2026-04-29 14:00:00	\N	2	\N
12039	DISPONIBLE	2026-04-29 14:00:00	\N	3	\N
12041	DISPONIBLE	2026-04-29 14:30:00	\N	2	\N
12044	DISPONIBLE	2026-04-29 15:00:00	\N	2	\N
12047	DISPONIBLE	2026-04-29 15:30:00	\N	2	\N
12050	DISPONIBLE	2026-04-29 16:00:00	\N	2	\N
12053	DISPONIBLE	2026-04-29 16:30:00	\N	2	\N
12055	DISPONIBLE	2026-04-29 17:00:00	\N	1	\N
12056	DISPONIBLE	2026-04-29 17:00:00	\N	2	\N
12057	DISPONIBLE	2026-04-29 17:00:00	\N	3	\N
12058	DISPONIBLE	2026-04-29 17:30:00	\N	1	\N
12059	DISPONIBLE	2026-04-29 17:30:00	\N	2	\N
12060	DISPONIBLE	2026-04-29 17:30:00	\N	3	\N
12062	DISPONIBLE	2026-04-30 08:00:00	\N	2	\N
12063	DISPONIBLE	2026-04-30 08:00:00	\N	3	\N
12065	DISPONIBLE	2026-04-30 08:30:00	\N	2	\N
12066	DISPONIBLE	2026-04-30 08:30:00	\N	3	\N
12068	DISPONIBLE	2026-04-30 09:00:00	\N	2	\N
12064	ASIGNADO_URGENCIA	2026-04-30 08:30:00	\N	1	11
12025	ASIGNADO	2026-04-29 12:00:00	306	1	\N
12067	ASIGNADO_URGENCIA	2026-04-30 09:00:00	\N	1	11
12061	ASIGNADO_URGENCIA	2026-04-30 08:00:00	\N	1	11
12040	DISPONIBLE	2026-04-29 14:30:00	\N	1	\N
12043	DISPONIBLE	2026-04-29 15:00:00	\N	1	\N
12046	DISPONIBLE	2026-04-29 15:30:00	\N	1	\N
12049	DISPONIBLE	2026-04-29 16:00:00	\N	1	\N
12004	DISPONIBLE	2026-04-29 08:30:00	\N	1	\N
12007	DISPONIBLE	2026-04-29 09:00:00	\N	1	\N
12010	DISPONIBLE	2026-04-29 09:30:00	\N	1	\N
12001	DISPONIBLE	2026-04-29 08:00:00	\N	1	\N
12052	DISPONIBLE	2026-04-29 16:30:00	\N	1	\N
12069	DISPONIBLE	2026-04-30 09:00:00	\N	3	\N
12071	DISPONIBLE	2026-04-30 09:30:00	\N	2	\N
12072	DISPONIBLE	2026-04-30 09:30:00	\N	3	\N
12074	DISPONIBLE	2026-04-30 10:00:00	\N	2	\N
12075	DISPONIBLE	2026-04-30 10:00:00	\N	3	\N
12077	DISPONIBLE	2026-04-30 10:30:00	\N	2	\N
12078	DISPONIBLE	2026-04-30 10:30:00	\N	3	\N
12080	DISPONIBLE	2026-04-30 11:00:00	\N	2	\N
12081	DISPONIBLE	2026-04-30 11:00:00	\N	3	\N
12083	DISPONIBLE	2026-04-30 11:30:00	\N	2	\N
12084	DISPONIBLE	2026-04-30 11:30:00	\N	3	\N
12085	DISPONIBLE	2026-04-30 12:00:00	\N	1	\N
12086	DISPONIBLE	2026-04-30 12:00:00	\N	2	\N
12087	DISPONIBLE	2026-04-30 12:00:00	\N	3	\N
12088	DISPONIBLE	2026-04-30 12:30:00	\N	1	\N
12089	DISPONIBLE	2026-04-30 12:30:00	\N	2	\N
12090	DISPONIBLE	2026-04-30 12:30:00	\N	3	\N
12091	DISPONIBLE	2026-04-30 13:00:00	\N	1	\N
12092	DISPONIBLE	2026-04-30 13:00:00	\N	2	\N
12093	DISPONIBLE	2026-04-30 13:00:00	\N	3	\N
12094	DISPONIBLE	2026-04-30 13:30:00	\N	1	\N
12095	DISPONIBLE	2026-04-30 13:30:00	\N	2	\N
12096	DISPONIBLE	2026-04-30 13:30:00	\N	3	\N
12097	DISPONIBLE	2026-04-30 14:00:00	\N	1	\N
12098	DISPONIBLE	2026-04-30 14:00:00	\N	2	\N
12099	DISPONIBLE	2026-04-30 14:00:00	\N	3	\N
12100	DISPONIBLE	2026-04-30 14:30:00	\N	1	\N
12101	DISPONIBLE	2026-04-30 14:30:00	\N	2	\N
12102	DISPONIBLE	2026-04-30 14:30:00	\N	3	\N
12103	DISPONIBLE	2026-04-30 15:00:00	\N	1	\N
12104	DISPONIBLE	2026-04-30 15:00:00	\N	2	\N
12105	DISPONIBLE	2026-04-30 15:00:00	\N	3	\N
12106	DISPONIBLE	2026-04-30 15:30:00	\N	1	\N
12107	DISPONIBLE	2026-04-30 15:30:00	\N	2	\N
12108	DISPONIBLE	2026-04-30 15:30:00	\N	3	\N
12109	DISPONIBLE	2026-04-30 16:00:00	\N	1	\N
12110	DISPONIBLE	2026-04-30 16:00:00	\N	2	\N
12111	DISPONIBLE	2026-04-30 16:00:00	\N	3	\N
12112	DISPONIBLE	2026-04-30 16:30:00	\N	1	\N
12113	DISPONIBLE	2026-04-30 16:30:00	\N	2	\N
12114	DISPONIBLE	2026-04-30 16:30:00	\N	3	\N
12115	DISPONIBLE	2026-04-30 17:00:00	\N	1	\N
12116	DISPONIBLE	2026-04-30 17:00:00	\N	2	\N
12117	DISPONIBLE	2026-04-30 17:00:00	\N	3	\N
12118	DISPONIBLE	2026-04-30 17:30:00	\N	1	\N
12119	DISPONIBLE	2026-04-30 17:30:00	\N	2	\N
12120	DISPONIBLE	2026-04-30 17:30:00	\N	3	\N
12121	DISPONIBLE	2026-05-01 08:00:00	\N	1	\N
12122	DISPONIBLE	2026-05-01 08:00:00	\N	2	\N
12123	DISPONIBLE	2026-05-01 08:00:00	\N	3	\N
12124	DISPONIBLE	2026-05-01 08:30:00	\N	1	\N
12125	DISPONIBLE	2026-05-01 08:30:00	\N	2	\N
12126	DISPONIBLE	2026-05-01 08:30:00	\N	3	\N
12127	DISPONIBLE	2026-05-01 09:00:00	\N	1	\N
12128	DISPONIBLE	2026-05-01 09:00:00	\N	2	\N
12129	DISPONIBLE	2026-05-01 09:00:00	\N	3	\N
12130	DISPONIBLE	2026-05-01 09:30:00	\N	1	\N
12131	DISPONIBLE	2026-05-01 09:30:00	\N	2	\N
12132	DISPONIBLE	2026-05-01 09:30:00	\N	3	\N
12133	DISPONIBLE	2026-05-01 10:00:00	\N	1	\N
12134	DISPONIBLE	2026-05-01 10:00:00	\N	2	\N
12135	DISPONIBLE	2026-05-01 10:00:00	\N	3	\N
12136	DISPONIBLE	2026-05-01 10:30:00	\N	1	\N
12137	DISPONIBLE	2026-05-01 10:30:00	\N	2	\N
12138	DISPONIBLE	2026-05-01 10:30:00	\N	3	\N
12139	DISPONIBLE	2026-05-01 11:00:00	\N	1	\N
12140	DISPONIBLE	2026-05-01 11:00:00	\N	2	\N
12141	DISPONIBLE	2026-05-01 11:00:00	\N	3	\N
12142	DISPONIBLE	2026-05-01 11:30:00	\N	1	\N
12143	DISPONIBLE	2026-05-01 11:30:00	\N	2	\N
12144	DISPONIBLE	2026-05-01 11:30:00	\N	3	\N
12145	DISPONIBLE	2026-05-01 12:00:00	\N	1	\N
12146	DISPONIBLE	2026-05-01 12:00:00	\N	2	\N
12147	DISPONIBLE	2026-05-01 12:00:00	\N	3	\N
12148	DISPONIBLE	2026-05-01 12:30:00	\N	1	\N
12149	DISPONIBLE	2026-05-01 12:30:00	\N	2	\N
12150	DISPONIBLE	2026-05-01 12:30:00	\N	3	\N
12151	DISPONIBLE	2026-05-01 13:00:00	\N	1	\N
12152	DISPONIBLE	2026-05-01 13:00:00	\N	2	\N
12153	DISPONIBLE	2026-05-01 13:00:00	\N	3	\N
12154	DISPONIBLE	2026-05-01 13:30:00	\N	1	\N
12155	DISPONIBLE	2026-05-01 13:30:00	\N	2	\N
12156	DISPONIBLE	2026-05-01 13:30:00	\N	3	\N
12157	DISPONIBLE	2026-05-01 14:00:00	\N	1	\N
12158	DISPONIBLE	2026-05-01 14:00:00	\N	2	\N
12159	DISPONIBLE	2026-05-01 14:00:00	\N	3	\N
12160	DISPONIBLE	2026-05-01 14:30:00	\N	1	\N
12161	DISPONIBLE	2026-05-01 14:30:00	\N	2	\N
12162	DISPONIBLE	2026-05-01 14:30:00	\N	3	\N
12163	DISPONIBLE	2026-05-01 15:00:00	\N	1	\N
12164	DISPONIBLE	2026-05-01 15:00:00	\N	2	\N
12165	DISPONIBLE	2026-05-01 15:00:00	\N	3	\N
12166	DISPONIBLE	2026-05-01 15:30:00	\N	1	\N
12167	DISPONIBLE	2026-05-01 15:30:00	\N	2	\N
12168	DISPONIBLE	2026-05-01 15:30:00	\N	3	\N
12169	DISPONIBLE	2026-05-01 16:00:00	\N	1	\N
12170	DISPONIBLE	2026-05-01 16:00:00	\N	2	\N
12171	DISPONIBLE	2026-05-01 16:00:00	\N	3	\N
12172	DISPONIBLE	2026-05-01 16:30:00	\N	1	\N
12173	DISPONIBLE	2026-05-01 16:30:00	\N	2	\N
12174	DISPONIBLE	2026-05-01 16:30:00	\N	3	\N
12175	DISPONIBLE	2026-05-01 17:00:00	\N	1	\N
12176	DISPONIBLE	2026-05-01 17:00:00	\N	2	\N
12177	DISPONIBLE	2026-05-01 17:00:00	\N	3	\N
12178	DISPONIBLE	2026-05-01 17:30:00	\N	1	\N
12179	DISPONIBLE	2026-05-01 17:30:00	\N	2	\N
12180	DISPONIBLE	2026-05-01 17:30:00	\N	3	\N
12181	DISPONIBLE	2026-05-02 08:00:00	\N	1	\N
12182	DISPONIBLE	2026-05-02 08:00:00	\N	2	\N
12183	DISPONIBLE	2026-05-02 08:00:00	\N	3	\N
12184	DISPONIBLE	2026-05-02 08:30:00	\N	1	\N
12185	DISPONIBLE	2026-05-02 08:30:00	\N	2	\N
12186	DISPONIBLE	2026-05-02 08:30:00	\N	3	\N
12187	DISPONIBLE	2026-05-02 09:00:00	\N	1	\N
12188	DISPONIBLE	2026-05-02 09:00:00	\N	2	\N
12189	DISPONIBLE	2026-05-02 09:00:00	\N	3	\N
12190	DISPONIBLE	2026-05-02 09:30:00	\N	1	\N
12191	DISPONIBLE	2026-05-02 09:30:00	\N	2	\N
12192	DISPONIBLE	2026-05-02 09:30:00	\N	3	\N
12193	DISPONIBLE	2026-05-02 10:00:00	\N	1	\N
12194	DISPONIBLE	2026-05-02 10:00:00	\N	2	\N
12195	DISPONIBLE	2026-05-02 10:00:00	\N	3	\N
12196	DISPONIBLE	2026-05-02 10:30:00	\N	1	\N
12197	DISPONIBLE	2026-05-02 10:30:00	\N	2	\N
12198	DISPONIBLE	2026-05-02 10:30:00	\N	3	\N
12199	DISPONIBLE	2026-05-02 11:00:00	\N	1	\N
12200	DISPONIBLE	2026-05-02 11:00:00	\N	2	\N
12201	DISPONIBLE	2026-05-02 11:00:00	\N	3	\N
12202	DISPONIBLE	2026-05-02 11:30:00	\N	1	\N
12203	DISPONIBLE	2026-05-02 11:30:00	\N	2	\N
12204	DISPONIBLE	2026-05-02 11:30:00	\N	3	\N
12205	DISPONIBLE	2026-05-02 12:00:00	\N	1	\N
12206	DISPONIBLE	2026-05-02 12:00:00	\N	2	\N
12207	DISPONIBLE	2026-05-02 12:00:00	\N	3	\N
12208	DISPONIBLE	2026-05-02 12:30:00	\N	1	\N
12209	DISPONIBLE	2026-05-02 12:30:00	\N	2	\N
12210	DISPONIBLE	2026-05-02 12:30:00	\N	3	\N
12211	DISPONIBLE	2026-05-02 13:00:00	\N	1	\N
12212	DISPONIBLE	2026-05-02 13:00:00	\N	2	\N
12213	DISPONIBLE	2026-05-02 13:00:00	\N	3	\N
12214	DISPONIBLE	2026-05-02 13:30:00	\N	1	\N
12215	DISPONIBLE	2026-05-02 13:30:00	\N	2	\N
12216	DISPONIBLE	2026-05-02 13:30:00	\N	3	\N
12217	DISPONIBLE	2026-05-02 14:00:00	\N	1	\N
12218	DISPONIBLE	2026-05-02 14:00:00	\N	2	\N
12219	DISPONIBLE	2026-05-02 14:00:00	\N	3	\N
12220	DISPONIBLE	2026-05-02 14:30:00	\N	1	\N
12221	DISPONIBLE	2026-05-02 14:30:00	\N	2	\N
12222	DISPONIBLE	2026-05-02 14:30:00	\N	3	\N
12223	DISPONIBLE	2026-05-02 15:00:00	\N	1	\N
12224	DISPONIBLE	2026-05-02 15:00:00	\N	2	\N
12225	DISPONIBLE	2026-05-02 15:00:00	\N	3	\N
12226	DISPONIBLE	2026-05-02 15:30:00	\N	1	\N
12227	DISPONIBLE	2026-05-02 15:30:00	\N	2	\N
12228	DISPONIBLE	2026-05-02 15:30:00	\N	3	\N
12229	DISPONIBLE	2026-05-02 16:00:00	\N	1	\N
12230	DISPONIBLE	2026-05-02 16:00:00	\N	2	\N
12231	DISPONIBLE	2026-05-02 16:00:00	\N	3	\N
12232	DISPONIBLE	2026-05-02 16:30:00	\N	1	\N
12233	DISPONIBLE	2026-05-02 16:30:00	\N	2	\N
12234	DISPONIBLE	2026-05-02 16:30:00	\N	3	\N
12235	DISPONIBLE	2026-05-02 17:00:00	\N	1	\N
12236	DISPONIBLE	2026-05-02 17:00:00	\N	2	\N
12237	DISPONIBLE	2026-05-02 17:00:00	\N	3	\N
12238	DISPONIBLE	2026-05-02 17:30:00	\N	1	\N
12239	DISPONIBLE	2026-05-02 17:30:00	\N	2	\N
12240	DISPONIBLE	2026-05-02 17:30:00	\N	3	\N
12242	DISPONIBLE	2026-05-03 08:00:00	\N	2	\N
12243	DISPONIBLE	2026-05-03 08:00:00	\N	3	\N
12245	DISPONIBLE	2026-05-03 08:30:00	\N	2	\N
12246	DISPONIBLE	2026-05-03 08:30:00	\N	3	\N
12248	DISPONIBLE	2026-05-03 09:00:00	\N	2	\N
12249	DISPONIBLE	2026-05-03 09:00:00	\N	3	\N
12251	DISPONIBLE	2026-05-03 09:30:00	\N	2	\N
12252	DISPONIBLE	2026-05-03 09:30:00	\N	3	\N
12254	DISPONIBLE	2026-05-03 10:00:00	\N	2	\N
12255	DISPONIBLE	2026-05-03 10:00:00	\N	3	\N
12257	DISPONIBLE	2026-05-03 10:30:00	\N	2	\N
12258	DISPONIBLE	2026-05-03 10:30:00	\N	3	\N
12260	DISPONIBLE	2026-05-03 11:00:00	\N	2	\N
12261	DISPONIBLE	2026-05-03 11:00:00	\N	3	\N
12263	DISPONIBLE	2026-05-03 11:30:00	\N	2	\N
12264	DISPONIBLE	2026-05-03 11:30:00	\N	3	\N
12265	DISPONIBLE	2026-05-03 12:00:00	\N	1	\N
12266	DISPONIBLE	2026-05-03 12:00:00	\N	2	\N
12267	DISPONIBLE	2026-05-03 12:00:00	\N	3	\N
12268	DISPONIBLE	2026-05-03 12:30:00	\N	1	\N
12269	DISPONIBLE	2026-05-03 12:30:00	\N	2	\N
12270	DISPONIBLE	2026-05-03 12:30:00	\N	3	\N
12271	DISPONIBLE	2026-05-03 13:00:00	\N	1	\N
12272	DISPONIBLE	2026-05-03 13:00:00	\N	2	\N
12273	DISPONIBLE	2026-05-03 13:00:00	\N	3	\N
12274	DISPONIBLE	2026-05-03 13:30:00	\N	1	\N
12275	DISPONIBLE	2026-05-03 13:30:00	\N	2	\N
12276	DISPONIBLE	2026-05-03 13:30:00	\N	3	\N
12277	DISPONIBLE	2026-05-03 14:00:00	\N	1	\N
12278	DISPONIBLE	2026-05-03 14:00:00	\N	2	\N
12279	DISPONIBLE	2026-05-03 14:00:00	\N	3	\N
12280	DISPONIBLE	2026-05-03 14:30:00	\N	1	\N
12281	DISPONIBLE	2026-05-03 14:30:00	\N	2	\N
12282	DISPONIBLE	2026-05-03 14:30:00	\N	3	\N
12283	DISPONIBLE	2026-05-03 15:00:00	\N	1	\N
12284	DISPONIBLE	2026-05-03 15:00:00	\N	2	\N
12285	DISPONIBLE	2026-05-03 15:00:00	\N	3	\N
12286	DISPONIBLE	2026-05-03 15:30:00	\N	1	\N
12287	DISPONIBLE	2026-05-03 15:30:00	\N	2	\N
12288	DISPONIBLE	2026-05-03 15:30:00	\N	3	\N
12289	DISPONIBLE	2026-05-03 16:00:00	\N	1	\N
12290	DISPONIBLE	2026-05-03 16:00:00	\N	2	\N
12291	DISPONIBLE	2026-05-03 16:00:00	\N	3	\N
12292	DISPONIBLE	2026-05-03 16:30:00	\N	1	\N
12293	DISPONIBLE	2026-05-03 16:30:00	\N	2	\N
12294	DISPONIBLE	2026-05-03 16:30:00	\N	3	\N
12295	DISPONIBLE	2026-05-03 17:00:00	\N	1	\N
12296	DISPONIBLE	2026-05-03 17:00:00	\N	2	\N
12297	DISPONIBLE	2026-05-03 17:00:00	\N	3	\N
12298	DISPONIBLE	2026-05-03 17:30:00	\N	1	\N
12299	DISPONIBLE	2026-05-03 17:30:00	\N	2	\N
12300	DISPONIBLE	2026-05-03 17:30:00	\N	3	\N
12301	DISPONIBLE	2026-05-04 08:00:00	\N	1	\N
12302	DISPONIBLE	2026-05-04 08:00:00	\N	2	\N
12303	DISPONIBLE	2026-05-04 08:00:00	\N	3	\N
12304	DISPONIBLE	2026-05-04 08:30:00	\N	1	\N
12305	DISPONIBLE	2026-05-04 08:30:00	\N	2	\N
12306	DISPONIBLE	2026-05-04 08:30:00	\N	3	\N
12307	DISPONIBLE	2026-05-04 09:00:00	\N	1	\N
12308	DISPONIBLE	2026-05-04 09:00:00	\N	2	\N
12309	DISPONIBLE	2026-05-04 09:00:00	\N	3	\N
12310	DISPONIBLE	2026-05-04 09:30:00	\N	1	\N
12311	DISPONIBLE	2026-05-04 09:30:00	\N	2	\N
12312	DISPONIBLE	2026-05-04 09:30:00	\N	3	\N
12313	DISPONIBLE	2026-05-04 10:00:00	\N	1	\N
12314	DISPONIBLE	2026-05-04 10:00:00	\N	2	\N
12315	DISPONIBLE	2026-05-04 10:00:00	\N	3	\N
12316	DISPONIBLE	2026-05-04 10:30:00	\N	1	\N
12317	DISPONIBLE	2026-05-04 10:30:00	\N	2	\N
12318	DISPONIBLE	2026-05-04 10:30:00	\N	3	\N
12319	DISPONIBLE	2026-05-04 11:00:00	\N	1	\N
12320	DISPONIBLE	2026-05-04 11:00:00	\N	2	\N
12321	DISPONIBLE	2026-05-04 11:00:00	\N	3	\N
12322	DISPONIBLE	2026-05-04 11:30:00	\N	1	\N
12323	DISPONIBLE	2026-05-04 11:30:00	\N	2	\N
12324	DISPONIBLE	2026-05-04 11:30:00	\N	3	\N
12325	DISPONIBLE	2026-05-04 12:00:00	\N	1	\N
12326	DISPONIBLE	2026-05-04 12:00:00	\N	2	\N
12327	DISPONIBLE	2026-05-04 12:00:00	\N	3	\N
12328	DISPONIBLE	2026-05-04 12:30:00	\N	1	\N
12329	DISPONIBLE	2026-05-04 12:30:00	\N	2	\N
12330	DISPONIBLE	2026-05-04 12:30:00	\N	3	\N
12331	DISPONIBLE	2026-05-04 13:00:00	\N	1	\N
12332	DISPONIBLE	2026-05-04 13:00:00	\N	2	\N
12333	DISPONIBLE	2026-05-04 13:00:00	\N	3	\N
12334	DISPONIBLE	2026-05-04 13:30:00	\N	1	\N
12335	DISPONIBLE	2026-05-04 13:30:00	\N	2	\N
12336	DISPONIBLE	2026-05-04 13:30:00	\N	3	\N
12337	DISPONIBLE	2026-05-04 14:00:00	\N	1	\N
12338	DISPONIBLE	2026-05-04 14:00:00	\N	2	\N
12339	DISPONIBLE	2026-05-04 14:00:00	\N	3	\N
12340	DISPONIBLE	2026-05-04 14:30:00	\N	1	\N
12341	DISPONIBLE	2026-05-04 14:30:00	\N	2	\N
12342	DISPONIBLE	2026-05-04 14:30:00	\N	3	\N
12343	DISPONIBLE	2026-05-04 15:00:00	\N	1	\N
12344	DISPONIBLE	2026-05-04 15:00:00	\N	2	\N
12345	DISPONIBLE	2026-05-04 15:00:00	\N	3	\N
12346	DISPONIBLE	2026-05-04 15:30:00	\N	1	\N
12347	DISPONIBLE	2026-05-04 15:30:00	\N	2	\N
12348	DISPONIBLE	2026-05-04 15:30:00	\N	3	\N
12349	DISPONIBLE	2026-05-04 16:00:00	\N	1	\N
12350	DISPONIBLE	2026-05-04 16:00:00	\N	2	\N
12351	DISPONIBLE	2026-05-04 16:00:00	\N	3	\N
12352	DISPONIBLE	2026-05-04 16:30:00	\N	1	\N
12353	DISPONIBLE	2026-05-04 16:30:00	\N	2	\N
12354	DISPONIBLE	2026-05-04 16:30:00	\N	3	\N
12355	DISPONIBLE	2026-05-04 17:00:00	\N	1	\N
12356	DISPONIBLE	2026-05-04 17:00:00	\N	2	\N
12357	DISPONIBLE	2026-05-04 17:00:00	\N	3	\N
12358	DISPONIBLE	2026-05-04 17:30:00	\N	1	\N
12359	DISPONIBLE	2026-05-04 17:30:00	\N	2	\N
12360	DISPONIBLE	2026-05-04 17:30:00	\N	3	\N
12362	DISPONIBLE	2026-05-05 08:00:00	\N	2	\N
12363	DISPONIBLE	2026-05-05 08:00:00	\N	3	\N
12365	DISPONIBLE	2026-05-05 08:30:00	\N	2	\N
12366	DISPONIBLE	2026-05-05 08:30:00	\N	3	\N
12368	DISPONIBLE	2026-05-05 09:00:00	\N	2	\N
12369	DISPONIBLE	2026-05-05 09:00:00	\N	3	\N
12371	DISPONIBLE	2026-05-05 09:30:00	\N	2	\N
12372	DISPONIBLE	2026-05-05 09:30:00	\N	3	\N
12374	DISPONIBLE	2026-05-05 10:00:00	\N	2	\N
12375	DISPONIBLE	2026-05-05 10:00:00	\N	3	\N
12377	DISPONIBLE	2026-05-05 10:30:00	\N	2	\N
12378	DISPONIBLE	2026-05-05 10:30:00	\N	3	\N
12380	DISPONIBLE	2026-05-05 11:00:00	\N	2	\N
12381	DISPONIBLE	2026-05-05 11:00:00	\N	3	\N
12383	DISPONIBLE	2026-05-05 11:30:00	\N	2	\N
12384	DISPONIBLE	2026-05-05 11:30:00	\N	3	\N
12386	DISPONIBLE	2026-05-05 12:00:00	\N	2	\N
12387	DISPONIBLE	2026-05-05 12:00:00	\N	3	\N
12388	DISPONIBLE	2026-05-05 12:30:00	\N	1	\N
12389	DISPONIBLE	2026-05-05 12:30:00	\N	2	\N
12390	DISPONIBLE	2026-05-05 12:30:00	\N	3	\N
12391	DISPONIBLE	2026-05-05 13:00:00	\N	1	\N
12392	DISPONIBLE	2026-05-05 13:00:00	\N	2	\N
12393	DISPONIBLE	2026-05-05 13:00:00	\N	3	\N
12394	DISPONIBLE	2026-05-05 13:30:00	\N	1	\N
12395	DISPONIBLE	2026-05-05 13:30:00	\N	2	\N
12396	DISPONIBLE	2026-05-05 13:30:00	\N	3	\N
12397	DISPONIBLE	2026-05-05 14:00:00	\N	1	\N
12398	DISPONIBLE	2026-05-05 14:00:00	\N	2	\N
12399	DISPONIBLE	2026-05-05 14:00:00	\N	3	\N
12400	DISPONIBLE	2026-05-05 14:30:00	\N	1	\N
12401	DISPONIBLE	2026-05-05 14:30:00	\N	2	\N
12402	DISPONIBLE	2026-05-05 14:30:00	\N	3	\N
12403	DISPONIBLE	2026-05-05 15:00:00	\N	1	\N
12404	DISPONIBLE	2026-05-05 15:00:00	\N	2	\N
12405	DISPONIBLE	2026-05-05 15:00:00	\N	3	\N
12406	DISPONIBLE	2026-05-05 15:30:00	\N	1	\N
12407	DISPONIBLE	2026-05-05 15:30:00	\N	2	\N
12408	DISPONIBLE	2026-05-05 15:30:00	\N	3	\N
12409	DISPONIBLE	2026-05-05 16:00:00	\N	1	\N
12410	DISPONIBLE	2026-05-05 16:00:00	\N	2	\N
12411	DISPONIBLE	2026-05-05 16:00:00	\N	3	\N
12412	DISPONIBLE	2026-05-05 16:30:00	\N	1	\N
12413	DISPONIBLE	2026-05-05 16:30:00	\N	2	\N
12414	DISPONIBLE	2026-05-05 16:30:00	\N	3	\N
12415	DISPONIBLE	2026-05-05 17:00:00	\N	1	\N
12416	DISPONIBLE	2026-05-05 17:00:00	\N	2	\N
12417	DISPONIBLE	2026-05-05 17:00:00	\N	3	\N
12418	DISPONIBLE	2026-05-05 17:30:00	\N	1	\N
12419	DISPONIBLE	2026-05-05 17:30:00	\N	2	\N
12420	DISPONIBLE	2026-05-05 17:30:00	\N	3	\N
12422	DISPONIBLE	2026-05-06 08:00:00	\N	2	\N
12423	DISPONIBLE	2026-05-06 08:00:00	\N	3	\N
12425	DISPONIBLE	2026-05-06 08:30:00	\N	2	\N
12426	DISPONIBLE	2026-05-06 08:30:00	\N	3	\N
12428	DISPONIBLE	2026-05-06 09:00:00	\N	2	\N
12421	ASIGNADO_URGENCIA	2026-05-06 08:00:00	\N	1	14
12424	ASIGNADO_URGENCIA	2026-05-06 08:30:00	\N	1	14
12427	ASIGNADO_URGENCIA	2026-05-06 09:00:00	\N	1	14
12385	ASIGNADO_URGENCIA	2026-05-05 12:00:00	\N	1	13
12373	ASIGNADO_URGENCIA	2026-05-05 10:00:00	\N	1	13
12376	ASIGNADO_URGENCIA	2026-05-05 10:30:00	\N	1	13
12429	DISPONIBLE	2026-05-06 09:00:00	\N	3	\N
12431	DISPONIBLE	2026-05-06 09:30:00	\N	2	\N
12432	DISPONIBLE	2026-05-06 09:30:00	\N	3	\N
12434	DISPONIBLE	2026-05-06 10:00:00	\N	2	\N
12435	DISPONIBLE	2026-05-06 10:00:00	\N	3	\N
12437	DISPONIBLE	2026-05-06 10:30:00	\N	2	\N
12438	DISPONIBLE	2026-05-06 10:30:00	\N	3	\N
12440	DISPONIBLE	2026-05-06 11:00:00	\N	2	\N
12441	DISPONIBLE	2026-05-06 11:00:00	\N	3	\N
12443	DISPONIBLE	2026-05-06 11:30:00	\N	2	\N
12444	DISPONIBLE	2026-05-06 11:30:00	\N	3	\N
12445	DISPONIBLE	2026-05-06 12:00:00	\N	1	\N
12446	DISPONIBLE	2026-05-06 12:00:00	\N	2	\N
12447	DISPONIBLE	2026-05-06 12:00:00	\N	3	\N
12448	DISPONIBLE	2026-05-06 12:30:00	\N	1	\N
12449	DISPONIBLE	2026-05-06 12:30:00	\N	2	\N
12450	DISPONIBLE	2026-05-06 12:30:00	\N	3	\N
12451	DISPONIBLE	2026-05-06 13:00:00	\N	1	\N
12452	DISPONIBLE	2026-05-06 13:00:00	\N	2	\N
12453	DISPONIBLE	2026-05-06 13:00:00	\N	3	\N
12454	DISPONIBLE	2026-05-06 13:30:00	\N	1	\N
12455	DISPONIBLE	2026-05-06 13:30:00	\N	2	\N
12456	DISPONIBLE	2026-05-06 13:30:00	\N	3	\N
12457	DISPONIBLE	2026-05-06 14:00:00	\N	1	\N
12458	DISPONIBLE	2026-05-06 14:00:00	\N	2	\N
12459	DISPONIBLE	2026-05-06 14:00:00	\N	3	\N
12460	DISPONIBLE	2026-05-06 14:30:00	\N	1	\N
12461	DISPONIBLE	2026-05-06 14:30:00	\N	2	\N
12462	DISPONIBLE	2026-05-06 14:30:00	\N	3	\N
12463	DISPONIBLE	2026-05-06 15:00:00	\N	1	\N
12464	DISPONIBLE	2026-05-06 15:00:00	\N	2	\N
12465	DISPONIBLE	2026-05-06 15:00:00	\N	3	\N
12466	DISPONIBLE	2026-05-06 15:30:00	\N	1	\N
12467	DISPONIBLE	2026-05-06 15:30:00	\N	2	\N
12468	DISPONIBLE	2026-05-06 15:30:00	\N	3	\N
12469	DISPONIBLE	2026-05-06 16:00:00	\N	1	\N
12470	DISPONIBLE	2026-05-06 16:00:00	\N	2	\N
12471	DISPONIBLE	2026-05-06 16:00:00	\N	3	\N
12472	DISPONIBLE	2026-05-06 16:30:00	\N	1	\N
12473	DISPONIBLE	2026-05-06 16:30:00	\N	2	\N
12474	DISPONIBLE	2026-05-06 16:30:00	\N	3	\N
12475	DISPONIBLE	2026-05-06 17:00:00	\N	1	\N
12476	DISPONIBLE	2026-05-06 17:00:00	\N	2	\N
12477	DISPONIBLE	2026-05-06 17:00:00	\N	3	\N
12478	DISPONIBLE	2026-05-06 17:30:00	\N	1	\N
12479	DISPONIBLE	2026-05-06 17:30:00	\N	2	\N
12480	DISPONIBLE	2026-05-06 17:30:00	\N	3	\N
12482	DISPONIBLE	2026-05-07 08:00:00	\N	2	\N
12483	DISPONIBLE	2026-05-07 08:00:00	\N	3	\N
12485	DISPONIBLE	2026-05-07 08:30:00	\N	2	\N
12486	DISPONIBLE	2026-05-07 08:30:00	\N	3	\N
12488	DISPONIBLE	2026-05-07 09:00:00	\N	2	\N
12489	DISPONIBLE	2026-05-07 09:00:00	\N	3	\N
12491	DISPONIBLE	2026-05-07 09:30:00	\N	2	\N
12492	DISPONIBLE	2026-05-07 09:30:00	\N	3	\N
12494	DISPONIBLE	2026-05-07 10:00:00	\N	2	\N
12495	DISPONIBLE	2026-05-07 10:00:00	\N	3	\N
12497	DISPONIBLE	2026-05-07 10:30:00	\N	2	\N
12498	DISPONIBLE	2026-05-07 10:30:00	\N	3	\N
12500	DISPONIBLE	2026-05-07 11:00:00	\N	2	\N
12501	DISPONIBLE	2026-05-07 11:00:00	\N	3	\N
12503	DISPONIBLE	2026-05-07 11:30:00	\N	2	\N
12504	DISPONIBLE	2026-05-07 11:30:00	\N	3	\N
12506	DISPONIBLE	2026-05-07 12:00:00	\N	2	\N
12507	DISPONIBLE	2026-05-07 12:00:00	\N	3	\N
12509	DISPONIBLE	2026-05-07 12:30:00	\N	2	\N
12510	DISPONIBLE	2026-05-07 12:30:00	\N	3	\N
12512	DISPONIBLE	2026-05-07 13:00:00	\N	2	\N
12513	DISPONIBLE	2026-05-07 13:00:00	\N	3	\N
12515	DISPONIBLE	2026-05-07 13:30:00	\N	2	\N
12516	DISPONIBLE	2026-05-07 13:30:00	\N	3	\N
12518	DISPONIBLE	2026-05-07 14:00:00	\N	2	\N
12519	DISPONIBLE	2026-05-07 14:00:00	\N	3	\N
12521	DISPONIBLE	2026-05-07 14:30:00	\N	2	\N
12522	DISPONIBLE	2026-05-07 14:30:00	\N	3	\N
12524	DISPONIBLE	2026-05-07 15:00:00	\N	2	\N
12525	DISPONIBLE	2026-05-07 15:00:00	\N	3	\N
12527	DISPONIBLE	2026-05-07 15:30:00	\N	2	\N
12528	DISPONIBLE	2026-05-07 15:30:00	\N	3	\N
12529	DISPONIBLE	2026-05-07 16:00:00	\N	1	\N
12530	DISPONIBLE	2026-05-07 16:00:00	\N	2	\N
12531	DISPONIBLE	2026-05-07 16:00:00	\N	3	\N
12532	DISPONIBLE	2026-05-07 16:30:00	\N	1	\N
12533	DISPONIBLE	2026-05-07 16:30:00	\N	2	\N
12534	DISPONIBLE	2026-05-07 16:30:00	\N	3	\N
12535	DISPONIBLE	2026-05-07 17:00:00	\N	1	\N
12536	DISPONIBLE	2026-05-07 17:00:00	\N	2	\N
12537	DISPONIBLE	2026-05-07 17:00:00	\N	3	\N
12538	DISPONIBLE	2026-05-07 17:30:00	\N	1	\N
12539	DISPONIBLE	2026-05-07 17:30:00	\N	2	\N
12540	DISPONIBLE	2026-05-07 17:30:00	\N	3	\N
12541	DISPONIBLE	2026-05-08 08:00:00	\N	1	\N
12542	DISPONIBLE	2026-05-08 08:00:00	\N	2	\N
12543	DISPONIBLE	2026-05-08 08:00:00	\N	3	\N
12544	DISPONIBLE	2026-05-08 08:30:00	\N	1	\N
12545	DISPONIBLE	2026-05-08 08:30:00	\N	2	\N
12546	DISPONIBLE	2026-05-08 08:30:00	\N	3	\N
12547	DISPONIBLE	2026-05-08 09:00:00	\N	1	\N
12548	DISPONIBLE	2026-05-08 09:00:00	\N	2	\N
12481	ASIGNADO_URGENCIA	2026-05-07 08:00:00	\N	1	15
12484	ASIGNADO_URGENCIA	2026-05-07 08:30:00	\N	1	15
12487	ASIGNADO_URGENCIA	2026-05-07 09:00:00	\N	1	15
12505	ASIGNADO	2026-05-07 12:00:00	311	1	\N
12508	ASIGNADO	2026-05-07 12:30:00	311	1	\N
12511	ASIGNADO	2026-05-07 13:00:00	311	1	\N
12514	ASIGNADO	2026-05-07 13:30:00	311	1	\N
12517	ASIGNADO	2026-05-07 14:00:00	311	1	\N
12520	ASIGNADO	2026-05-07 14:30:00	311	1	\N
12523	ASIGNADO	2026-05-07 15:00:00	311	1	\N
12549	DISPONIBLE	2026-05-08 09:00:00	\N	3	\N
12550	DISPONIBLE	2026-05-08 09:30:00	\N	1	\N
12551	DISPONIBLE	2026-05-08 09:30:00	\N	2	\N
12552	DISPONIBLE	2026-05-08 09:30:00	\N	3	\N
12553	DISPONIBLE	2026-05-08 10:00:00	\N	1	\N
12554	DISPONIBLE	2026-05-08 10:00:00	\N	2	\N
12555	DISPONIBLE	2026-05-08 10:00:00	\N	3	\N
12556	DISPONIBLE	2026-05-08 10:30:00	\N	1	\N
12557	DISPONIBLE	2026-05-08 10:30:00	\N	2	\N
12558	DISPONIBLE	2026-05-08 10:30:00	\N	3	\N
12559	DISPONIBLE	2026-05-08 11:00:00	\N	1	\N
12560	DISPONIBLE	2026-05-08 11:00:00	\N	2	\N
12561	DISPONIBLE	2026-05-08 11:00:00	\N	3	\N
12562	DISPONIBLE	2026-05-08 11:30:00	\N	1	\N
12563	DISPONIBLE	2026-05-08 11:30:00	\N	2	\N
12564	DISPONIBLE	2026-05-08 11:30:00	\N	3	\N
12565	DISPONIBLE	2026-05-08 12:00:00	\N	1	\N
12566	DISPONIBLE	2026-05-08 12:00:00	\N	2	\N
12567	DISPONIBLE	2026-05-08 12:00:00	\N	3	\N
12568	DISPONIBLE	2026-05-08 12:30:00	\N	1	\N
12569	DISPONIBLE	2026-05-08 12:30:00	\N	2	\N
12570	DISPONIBLE	2026-05-08 12:30:00	\N	3	\N
12571	DISPONIBLE	2026-05-08 13:00:00	\N	1	\N
12572	DISPONIBLE	2026-05-08 13:00:00	\N	2	\N
12573	DISPONIBLE	2026-05-08 13:00:00	\N	3	\N
12574	DISPONIBLE	2026-05-08 13:30:00	\N	1	\N
12575	DISPONIBLE	2026-05-08 13:30:00	\N	2	\N
12576	DISPONIBLE	2026-05-08 13:30:00	\N	3	\N
12577	DISPONIBLE	2026-05-08 14:00:00	\N	1	\N
12578	DISPONIBLE	2026-05-08 14:00:00	\N	2	\N
12579	DISPONIBLE	2026-05-08 14:00:00	\N	3	\N
12580	DISPONIBLE	2026-05-08 14:30:00	\N	1	\N
12581	DISPONIBLE	2026-05-08 14:30:00	\N	2	\N
12582	DISPONIBLE	2026-05-08 14:30:00	\N	3	\N
12583	DISPONIBLE	2026-05-08 15:00:00	\N	1	\N
12584	DISPONIBLE	2026-05-08 15:00:00	\N	2	\N
12585	DISPONIBLE	2026-05-08 15:00:00	\N	3	\N
12586	DISPONIBLE	2026-05-08 15:30:00	\N	1	\N
12587	DISPONIBLE	2026-05-08 15:30:00	\N	2	\N
12588	DISPONIBLE	2026-05-08 15:30:00	\N	3	\N
12589	DISPONIBLE	2026-05-08 16:00:00	\N	1	\N
12590	DISPONIBLE	2026-05-08 16:00:00	\N	2	\N
12591	DISPONIBLE	2026-05-08 16:00:00	\N	3	\N
12592	DISPONIBLE	2026-05-08 16:30:00	\N	1	\N
12593	DISPONIBLE	2026-05-08 16:30:00	\N	2	\N
12594	DISPONIBLE	2026-05-08 16:30:00	\N	3	\N
12595	DISPONIBLE	2026-05-08 17:00:00	\N	1	\N
12596	DISPONIBLE	2026-05-08 17:00:00	\N	2	\N
12597	DISPONIBLE	2026-05-08 17:00:00	\N	3	\N
12598	DISPONIBLE	2026-05-08 17:30:00	\N	1	\N
12599	DISPONIBLE	2026-05-08 17:30:00	\N	2	\N
12600	DISPONIBLE	2026-05-08 17:30:00	\N	3	\N
12602	DISPONIBLE	2026-05-09 08:00:00	\N	2	\N
12603	DISPONIBLE	2026-05-09 08:00:00	\N	3	\N
12605	DISPONIBLE	2026-05-09 08:30:00	\N	2	\N
12606	DISPONIBLE	2026-05-09 08:30:00	\N	3	\N
12608	DISPONIBLE	2026-05-09 09:00:00	\N	2	\N
12609	DISPONIBLE	2026-05-09 09:00:00	\N	3	\N
12611	DISPONIBLE	2026-05-09 09:30:00	\N	2	\N
12612	DISPONIBLE	2026-05-09 09:30:00	\N	3	\N
12614	DISPONIBLE	2026-05-09 10:00:00	\N	2	\N
12615	DISPONIBLE	2026-05-09 10:00:00	\N	3	\N
12617	DISPONIBLE	2026-05-09 10:30:00	\N	2	\N
12618	DISPONIBLE	2026-05-09 10:30:00	\N	3	\N
12620	DISPONIBLE	2026-05-09 11:00:00	\N	2	\N
12621	DISPONIBLE	2026-05-09 11:00:00	\N	3	\N
12623	DISPONIBLE	2026-05-09 11:30:00	\N	2	\N
12624	DISPONIBLE	2026-05-09 11:30:00	\N	3	\N
12625	DISPONIBLE	2026-05-09 12:00:00	\N	1	\N
12626	DISPONIBLE	2026-05-09 12:00:00	\N	2	\N
12627	DISPONIBLE	2026-05-09 12:00:00	\N	3	\N
12628	DISPONIBLE	2026-05-09 12:30:00	\N	1	\N
12629	DISPONIBLE	2026-05-09 12:30:00	\N	2	\N
12630	DISPONIBLE	2026-05-09 12:30:00	\N	3	\N
12631	DISPONIBLE	2026-05-09 13:00:00	\N	1	\N
12632	DISPONIBLE	2026-05-09 13:00:00	\N	2	\N
12633	DISPONIBLE	2026-05-09 13:00:00	\N	3	\N
12634	DISPONIBLE	2026-05-09 13:30:00	\N	1	\N
12635	DISPONIBLE	2026-05-09 13:30:00	\N	2	\N
12636	DISPONIBLE	2026-05-09 13:30:00	\N	3	\N
12637	DISPONIBLE	2026-05-09 14:00:00	\N	1	\N
12638	DISPONIBLE	2026-05-09 14:00:00	\N	2	\N
12639	DISPONIBLE	2026-05-09 14:00:00	\N	3	\N
12640	DISPONIBLE	2026-05-09 14:30:00	\N	1	\N
12641	DISPONIBLE	2026-05-09 14:30:00	\N	2	\N
12642	DISPONIBLE	2026-05-09 14:30:00	\N	3	\N
12643	DISPONIBLE	2026-05-09 15:00:00	\N	1	\N
12644	DISPONIBLE	2026-05-09 15:00:00	\N	2	\N
12645	DISPONIBLE	2026-05-09 15:00:00	\N	3	\N
12646	DISPONIBLE	2026-05-09 15:30:00	\N	1	\N
12647	DISPONIBLE	2026-05-09 15:30:00	\N	2	\N
12648	DISPONIBLE	2026-05-09 15:30:00	\N	3	\N
12649	DISPONIBLE	2026-05-09 16:00:00	\N	1	\N
12650	DISPONIBLE	2026-05-09 16:00:00	\N	2	\N
12651	DISPONIBLE	2026-05-09 16:00:00	\N	3	\N
12652	DISPONIBLE	2026-05-09 16:30:00	\N	1	\N
12653	DISPONIBLE	2026-05-09 16:30:00	\N	2	\N
12654	DISPONIBLE	2026-05-09 16:30:00	\N	3	\N
12655	DISPONIBLE	2026-05-09 17:00:00	\N	1	\N
12656	DISPONIBLE	2026-05-09 17:00:00	\N	2	\N
12657	DISPONIBLE	2026-05-09 17:00:00	\N	3	\N
12658	DISPONIBLE	2026-05-09 17:30:00	\N	1	\N
12659	DISPONIBLE	2026-05-09 17:30:00	\N	2	\N
12660	DISPONIBLE	2026-05-09 17:30:00	\N	3	\N
12661	DISPONIBLE	2026-05-10 08:00:00	\N	1	\N
12662	DISPONIBLE	2026-05-10 08:00:00	\N	2	\N
12663	DISPONIBLE	2026-05-10 08:00:00	\N	3	\N
12664	DISPONIBLE	2026-05-10 08:30:00	\N	1	\N
12665	DISPONIBLE	2026-05-10 08:30:00	\N	2	\N
12666	DISPONIBLE	2026-05-10 08:30:00	\N	3	\N
12667	DISPONIBLE	2026-05-10 09:00:00	\N	1	\N
12668	DISPONIBLE	2026-05-10 09:00:00	\N	2	\N
12669	DISPONIBLE	2026-05-10 09:00:00	\N	3	\N
12670	DISPONIBLE	2026-05-10 09:30:00	\N	1	\N
12671	DISPONIBLE	2026-05-10 09:30:00	\N	2	\N
12672	DISPONIBLE	2026-05-10 09:30:00	\N	3	\N
12673	DISPONIBLE	2026-05-10 10:00:00	\N	1	\N
12674	DISPONIBLE	2026-05-10 10:00:00	\N	2	\N
12675	DISPONIBLE	2026-05-10 10:00:00	\N	3	\N
12676	DISPONIBLE	2026-05-10 10:30:00	\N	1	\N
12677	DISPONIBLE	2026-05-10 10:30:00	\N	2	\N
12678	DISPONIBLE	2026-05-10 10:30:00	\N	3	\N
12679	DISPONIBLE	2026-05-10 11:00:00	\N	1	\N
12680	DISPONIBLE	2026-05-10 11:00:00	\N	2	\N
12681	DISPONIBLE	2026-05-10 11:00:00	\N	3	\N
12682	DISPONIBLE	2026-05-10 11:30:00	\N	1	\N
12683	DISPONIBLE	2026-05-10 11:30:00	\N	2	\N
12684	DISPONIBLE	2026-05-10 11:30:00	\N	3	\N
12685	DISPONIBLE	2026-05-10 12:00:00	\N	1	\N
12686	DISPONIBLE	2026-05-10 12:00:00	\N	2	\N
12687	DISPONIBLE	2026-05-10 12:00:00	\N	3	\N
12688	DISPONIBLE	2026-05-10 12:30:00	\N	1	\N
12689	DISPONIBLE	2026-05-10 12:30:00	\N	2	\N
12690	DISPONIBLE	2026-05-10 12:30:00	\N	3	\N
12691	DISPONIBLE	2026-05-10 13:00:00	\N	1	\N
12692	DISPONIBLE	2026-05-10 13:00:00	\N	2	\N
12693	DISPONIBLE	2026-05-10 13:00:00	\N	3	\N
12694	DISPONIBLE	2026-05-10 13:30:00	\N	1	\N
12695	DISPONIBLE	2026-05-10 13:30:00	\N	2	\N
12696	DISPONIBLE	2026-05-10 13:30:00	\N	3	\N
12697	DISPONIBLE	2026-05-10 14:00:00	\N	1	\N
12698	DISPONIBLE	2026-05-10 14:00:00	\N	2	\N
12699	DISPONIBLE	2026-05-10 14:00:00	\N	3	\N
12700	DISPONIBLE	2026-05-10 14:30:00	\N	1	\N
12701	DISPONIBLE	2026-05-10 14:30:00	\N	2	\N
12702	DISPONIBLE	2026-05-10 14:30:00	\N	3	\N
12703	DISPONIBLE	2026-05-10 15:00:00	\N	1	\N
12704	DISPONIBLE	2026-05-10 15:00:00	\N	2	\N
12705	DISPONIBLE	2026-05-10 15:00:00	\N	3	\N
12706	DISPONIBLE	2026-05-10 15:30:00	\N	1	\N
12707	DISPONIBLE	2026-05-10 15:30:00	\N	2	\N
12708	DISPONIBLE	2026-05-10 15:30:00	\N	3	\N
12709	DISPONIBLE	2026-05-10 16:00:00	\N	1	\N
12710	DISPONIBLE	2026-05-10 16:00:00	\N	2	\N
12711	DISPONIBLE	2026-05-10 16:00:00	\N	3	\N
12712	DISPONIBLE	2026-05-10 16:30:00	\N	1	\N
12713	DISPONIBLE	2026-05-10 16:30:00	\N	2	\N
12714	DISPONIBLE	2026-05-10 16:30:00	\N	3	\N
12715	DISPONIBLE	2026-05-10 17:00:00	\N	1	\N
12716	DISPONIBLE	2026-05-10 17:00:00	\N	2	\N
12717	DISPONIBLE	2026-05-10 17:00:00	\N	3	\N
12718	DISPONIBLE	2026-05-10 17:30:00	\N	1	\N
12719	DISPONIBLE	2026-05-10 17:30:00	\N	2	\N
12720	DISPONIBLE	2026-05-10 17:30:00	\N	3	\N
12721	DISPONIBLE	2026-05-11 08:00:00	\N	1	\N
12722	DISPONIBLE	2026-05-11 08:00:00	\N	2	\N
12723	DISPONIBLE	2026-05-11 08:00:00	\N	3	\N
12724	DISPONIBLE	2026-05-11 08:30:00	\N	1	\N
12725	DISPONIBLE	2026-05-11 08:30:00	\N	2	\N
12726	DISPONIBLE	2026-05-11 08:30:00	\N	3	\N
12727	DISPONIBLE	2026-05-11 09:00:00	\N	1	\N
12728	DISPONIBLE	2026-05-11 09:00:00	\N	2	\N
12729	DISPONIBLE	2026-05-11 09:00:00	\N	3	\N
12730	DISPONIBLE	2026-05-11 09:30:00	\N	1	\N
12731	DISPONIBLE	2026-05-11 09:30:00	\N	2	\N
12732	DISPONIBLE	2026-05-11 09:30:00	\N	3	\N
12733	DISPONIBLE	2026-05-11 10:00:00	\N	1	\N
12734	DISPONIBLE	2026-05-11 10:00:00	\N	2	\N
12735	DISPONIBLE	2026-05-11 10:00:00	\N	3	\N
12736	DISPONIBLE	2026-05-11 10:30:00	\N	1	\N
12737	DISPONIBLE	2026-05-11 10:30:00	\N	2	\N
12738	DISPONIBLE	2026-05-11 10:30:00	\N	3	\N
12739	DISPONIBLE	2026-05-11 11:00:00	\N	1	\N
12740	DISPONIBLE	2026-05-11 11:00:00	\N	2	\N
12741	DISPONIBLE	2026-05-11 11:00:00	\N	3	\N
12742	DISPONIBLE	2026-05-11 11:30:00	\N	1	\N
12743	DISPONIBLE	2026-05-11 11:30:00	\N	2	\N
12744	DISPONIBLE	2026-05-11 11:30:00	\N	3	\N
12745	DISPONIBLE	2026-05-11 12:00:00	\N	1	\N
12746	DISPONIBLE	2026-05-11 12:00:00	\N	2	\N
12747	DISPONIBLE	2026-05-11 12:00:00	\N	3	\N
12748	DISPONIBLE	2026-05-11 12:30:00	\N	1	\N
12749	DISPONIBLE	2026-05-11 12:30:00	\N	2	\N
12750	DISPONIBLE	2026-05-11 12:30:00	\N	3	\N
12751	DISPONIBLE	2026-05-11 13:00:00	\N	1	\N
12752	DISPONIBLE	2026-05-11 13:00:00	\N	2	\N
12753	DISPONIBLE	2026-05-11 13:00:00	\N	3	\N
12754	DISPONIBLE	2026-05-11 13:30:00	\N	1	\N
12755	DISPONIBLE	2026-05-11 13:30:00	\N	2	\N
12756	DISPONIBLE	2026-05-11 13:30:00	\N	3	\N
12757	DISPONIBLE	2026-05-11 14:00:00	\N	1	\N
12758	DISPONIBLE	2026-05-11 14:00:00	\N	2	\N
12759	DISPONIBLE	2026-05-11 14:00:00	\N	3	\N
12760	DISPONIBLE	2026-05-11 14:30:00	\N	1	\N
12761	DISPONIBLE	2026-05-11 14:30:00	\N	2	\N
12762	DISPONIBLE	2026-05-11 14:30:00	\N	3	\N
12763	DISPONIBLE	2026-05-11 15:00:00	\N	1	\N
12764	DISPONIBLE	2026-05-11 15:00:00	\N	2	\N
12765	DISPONIBLE	2026-05-11 15:00:00	\N	3	\N
12766	DISPONIBLE	2026-05-11 15:30:00	\N	1	\N
12767	DISPONIBLE	2026-05-11 15:30:00	\N	2	\N
12768	DISPONIBLE	2026-05-11 15:30:00	\N	3	\N
12769	DISPONIBLE	2026-05-11 16:00:00	\N	1	\N
12770	DISPONIBLE	2026-05-11 16:00:00	\N	2	\N
12771	DISPONIBLE	2026-05-11 16:00:00	\N	3	\N
12772	DISPONIBLE	2026-05-11 16:30:00	\N	1	\N
12773	DISPONIBLE	2026-05-11 16:30:00	\N	2	\N
12774	DISPONIBLE	2026-05-11 16:30:00	\N	3	\N
12775	DISPONIBLE	2026-05-11 17:00:00	\N	1	\N
12776	DISPONIBLE	2026-05-11 17:00:00	\N	2	\N
12777	DISPONIBLE	2026-05-11 17:00:00	\N	3	\N
12778	DISPONIBLE	2026-05-11 17:30:00	\N	1	\N
12779	DISPONIBLE	2026-05-11 17:30:00	\N	2	\N
12780	DISPONIBLE	2026-05-11 17:30:00	\N	3	\N
12781	DISPONIBLE	2026-05-12 08:00:00	\N	1	\N
12782	DISPONIBLE	2026-05-12 08:00:00	\N	2	\N
12783	DISPONIBLE	2026-05-12 08:00:00	\N	3	\N
12784	DISPONIBLE	2026-05-12 08:30:00	\N	1	\N
12785	DISPONIBLE	2026-05-12 08:30:00	\N	2	\N
12786	DISPONIBLE	2026-05-12 08:30:00	\N	3	\N
12787	DISPONIBLE	2026-05-12 09:00:00	\N	1	\N
12788	DISPONIBLE	2026-05-12 09:00:00	\N	2	\N
12789	DISPONIBLE	2026-05-12 09:00:00	\N	3	\N
12790	DISPONIBLE	2026-05-12 09:30:00	\N	1	\N
12791	DISPONIBLE	2026-05-12 09:30:00	\N	2	\N
12792	DISPONIBLE	2026-05-12 09:30:00	\N	3	\N
12793	DISPONIBLE	2026-05-12 10:00:00	\N	1	\N
12794	DISPONIBLE	2026-05-12 10:00:00	\N	2	\N
12795	DISPONIBLE	2026-05-12 10:00:00	\N	3	\N
12796	DISPONIBLE	2026-05-12 10:30:00	\N	1	\N
12797	DISPONIBLE	2026-05-12 10:30:00	\N	2	\N
12798	DISPONIBLE	2026-05-12 10:30:00	\N	3	\N
12799	DISPONIBLE	2026-05-12 11:00:00	\N	1	\N
12800	DISPONIBLE	2026-05-12 11:00:00	\N	2	\N
12801	DISPONIBLE	2026-05-12 11:00:00	\N	3	\N
12802	DISPONIBLE	2026-05-12 11:30:00	\N	1	\N
12803	DISPONIBLE	2026-05-12 11:30:00	\N	2	\N
12804	DISPONIBLE	2026-05-12 11:30:00	\N	3	\N
12805	DISPONIBLE	2026-05-12 12:00:00	\N	1	\N
12806	DISPONIBLE	2026-05-12 12:00:00	\N	2	\N
12807	DISPONIBLE	2026-05-12 12:00:00	\N	3	\N
12808	DISPONIBLE	2026-05-12 12:30:00	\N	1	\N
12809	DISPONIBLE	2026-05-12 12:30:00	\N	2	\N
12810	DISPONIBLE	2026-05-12 12:30:00	\N	3	\N
12811	DISPONIBLE	2026-05-12 13:00:00	\N	1	\N
12812	DISPONIBLE	2026-05-12 13:00:00	\N	2	\N
12813	DISPONIBLE	2026-05-12 13:00:00	\N	3	\N
12814	DISPONIBLE	2026-05-12 13:30:00	\N	1	\N
12815	DISPONIBLE	2026-05-12 13:30:00	\N	2	\N
12816	DISPONIBLE	2026-05-12 13:30:00	\N	3	\N
12817	DISPONIBLE	2026-05-12 14:00:00	\N	1	\N
12818	DISPONIBLE	2026-05-12 14:00:00	\N	2	\N
12819	DISPONIBLE	2026-05-12 14:00:00	\N	3	\N
12820	DISPONIBLE	2026-05-12 14:30:00	\N	1	\N
12821	DISPONIBLE	2026-05-12 14:30:00	\N	2	\N
12822	DISPONIBLE	2026-05-12 14:30:00	\N	3	\N
12823	DISPONIBLE	2026-05-12 15:00:00	\N	1	\N
12824	DISPONIBLE	2026-05-12 15:00:00	\N	2	\N
12825	DISPONIBLE	2026-05-12 15:00:00	\N	3	\N
12826	DISPONIBLE	2026-05-12 15:30:00	\N	1	\N
12827	DISPONIBLE	2026-05-12 15:30:00	\N	2	\N
12828	DISPONIBLE	2026-05-12 15:30:00	\N	3	\N
12829	DISPONIBLE	2026-05-12 16:00:00	\N	1	\N
12830	DISPONIBLE	2026-05-12 16:00:00	\N	2	\N
12831	DISPONIBLE	2026-05-12 16:00:00	\N	3	\N
12832	DISPONIBLE	2026-05-12 16:30:00	\N	1	\N
12833	DISPONIBLE	2026-05-12 16:30:00	\N	2	\N
12834	DISPONIBLE	2026-05-12 16:30:00	\N	3	\N
12835	DISPONIBLE	2026-05-12 17:00:00	\N	1	\N
12836	DISPONIBLE	2026-05-12 17:00:00	\N	2	\N
12837	DISPONIBLE	2026-05-12 17:00:00	\N	3	\N
12838	DISPONIBLE	2026-05-12 17:30:00	\N	1	\N
12839	DISPONIBLE	2026-05-12 17:30:00	\N	2	\N
12840	DISPONIBLE	2026-05-12 17:30:00	\N	3	\N
12841	DISPONIBLE	2026-05-13 08:00:00	\N	1	\N
12842	DISPONIBLE	2026-05-13 08:00:00	\N	2	\N
12843	DISPONIBLE	2026-05-13 08:00:00	\N	3	\N
12844	DISPONIBLE	2026-05-13 08:30:00	\N	1	\N
12845	DISPONIBLE	2026-05-13 08:30:00	\N	2	\N
12846	DISPONIBLE	2026-05-13 08:30:00	\N	3	\N
12847	DISPONIBLE	2026-05-13 09:00:00	\N	1	\N
12848	DISPONIBLE	2026-05-13 09:00:00	\N	2	\N
12849	DISPONIBLE	2026-05-13 09:00:00	\N	3	\N
12850	DISPONIBLE	2026-05-13 09:30:00	\N	1	\N
12851	DISPONIBLE	2026-05-13 09:30:00	\N	2	\N
12852	DISPONIBLE	2026-05-13 09:30:00	\N	3	\N
12853	DISPONIBLE	2026-05-13 10:00:00	\N	1	\N
12854	DISPONIBLE	2026-05-13 10:00:00	\N	2	\N
12855	DISPONIBLE	2026-05-13 10:00:00	\N	3	\N
12856	DISPONIBLE	2026-05-13 10:30:00	\N	1	\N
12857	DISPONIBLE	2026-05-13 10:30:00	\N	2	\N
12858	DISPONIBLE	2026-05-13 10:30:00	\N	3	\N
12859	DISPONIBLE	2026-05-13 11:00:00	\N	1	\N
12860	DISPONIBLE	2026-05-13 11:00:00	\N	2	\N
12861	DISPONIBLE	2026-05-13 11:00:00	\N	3	\N
12862	DISPONIBLE	2026-05-13 11:30:00	\N	1	\N
12863	DISPONIBLE	2026-05-13 11:30:00	\N	2	\N
12864	DISPONIBLE	2026-05-13 11:30:00	\N	3	\N
12865	DISPONIBLE	2026-05-13 12:00:00	\N	1	\N
12866	DISPONIBLE	2026-05-13 12:00:00	\N	2	\N
12867	DISPONIBLE	2026-05-13 12:00:00	\N	3	\N
12868	DISPONIBLE	2026-05-13 12:30:00	\N	1	\N
12869	DISPONIBLE	2026-05-13 12:30:00	\N	2	\N
12870	DISPONIBLE	2026-05-13 12:30:00	\N	3	\N
12871	DISPONIBLE	2026-05-13 13:00:00	\N	1	\N
12872	DISPONIBLE	2026-05-13 13:00:00	\N	2	\N
12873	DISPONIBLE	2026-05-13 13:00:00	\N	3	\N
12874	DISPONIBLE	2026-05-13 13:30:00	\N	1	\N
12875	DISPONIBLE	2026-05-13 13:30:00	\N	2	\N
12876	DISPONIBLE	2026-05-13 13:30:00	\N	3	\N
12877	DISPONIBLE	2026-05-13 14:00:00	\N	1	\N
12878	DISPONIBLE	2026-05-13 14:00:00	\N	2	\N
12879	DISPONIBLE	2026-05-13 14:00:00	\N	3	\N
12880	DISPONIBLE	2026-05-13 14:30:00	\N	1	\N
12881	DISPONIBLE	2026-05-13 14:30:00	\N	2	\N
12882	DISPONIBLE	2026-05-13 14:30:00	\N	3	\N
12883	DISPONIBLE	2026-05-13 15:00:00	\N	1	\N
12884	DISPONIBLE	2026-05-13 15:00:00	\N	2	\N
12885	DISPONIBLE	2026-05-13 15:00:00	\N	3	\N
12886	DISPONIBLE	2026-05-13 15:30:00	\N	1	\N
12887	DISPONIBLE	2026-05-13 15:30:00	\N	2	\N
12888	DISPONIBLE	2026-05-13 15:30:00	\N	3	\N
12889	DISPONIBLE	2026-05-13 16:00:00	\N	1	\N
12890	DISPONIBLE	2026-05-13 16:00:00	\N	2	\N
12891	DISPONIBLE	2026-05-13 16:00:00	\N	3	\N
12892	DISPONIBLE	2026-05-13 16:30:00	\N	1	\N
12893	DISPONIBLE	2026-05-13 16:30:00	\N	2	\N
12894	DISPONIBLE	2026-05-13 16:30:00	\N	3	\N
12895	DISPONIBLE	2026-05-13 17:00:00	\N	1	\N
12896	DISPONIBLE	2026-05-13 17:00:00	\N	2	\N
12897	DISPONIBLE	2026-05-13 17:00:00	\N	3	\N
12898	DISPONIBLE	2026-05-13 17:30:00	\N	1	\N
12899	DISPONIBLE	2026-05-13 17:30:00	\N	2	\N
12900	DISPONIBLE	2026-05-13 17:30:00	\N	3	\N
12901	DISPONIBLE	2026-05-14 08:00:00	\N	1	\N
12902	DISPONIBLE	2026-05-14 08:00:00	\N	2	\N
12903	DISPONIBLE	2026-05-14 08:00:00	\N	3	\N
12904	DISPONIBLE	2026-05-14 08:30:00	\N	1	\N
12905	DISPONIBLE	2026-05-14 08:30:00	\N	2	\N
12906	DISPONIBLE	2026-05-14 08:30:00	\N	3	\N
12907	DISPONIBLE	2026-05-14 09:00:00	\N	1	\N
12908	DISPONIBLE	2026-05-14 09:00:00	\N	2	\N
12909	DISPONIBLE	2026-05-14 09:00:00	\N	3	\N
12910	DISPONIBLE	2026-05-14 09:30:00	\N	1	\N
12911	DISPONIBLE	2026-05-14 09:30:00	\N	2	\N
12912	DISPONIBLE	2026-05-14 09:30:00	\N	3	\N
12913	DISPONIBLE	2026-05-14 10:00:00	\N	1	\N
12914	DISPONIBLE	2026-05-14 10:00:00	\N	2	\N
12915	DISPONIBLE	2026-05-14 10:00:00	\N	3	\N
12916	DISPONIBLE	2026-05-14 10:30:00	\N	1	\N
12917	DISPONIBLE	2026-05-14 10:30:00	\N	2	\N
12918	DISPONIBLE	2026-05-14 10:30:00	\N	3	\N
12919	DISPONIBLE	2026-05-14 11:00:00	\N	1	\N
12920	DISPONIBLE	2026-05-14 11:00:00	\N	2	\N
12921	DISPONIBLE	2026-05-14 11:00:00	\N	3	\N
12922	DISPONIBLE	2026-05-14 11:30:00	\N	1	\N
12923	DISPONIBLE	2026-05-14 11:30:00	\N	2	\N
12924	DISPONIBLE	2026-05-14 11:30:00	\N	3	\N
12925	DISPONIBLE	2026-05-14 12:00:00	\N	1	\N
12926	DISPONIBLE	2026-05-14 12:00:00	\N	2	\N
12927	DISPONIBLE	2026-05-14 12:00:00	\N	3	\N
12928	DISPONIBLE	2026-05-14 12:30:00	\N	1	\N
12929	DISPONIBLE	2026-05-14 12:30:00	\N	2	\N
12930	DISPONIBLE	2026-05-14 12:30:00	\N	3	\N
12931	DISPONIBLE	2026-05-14 13:00:00	\N	1	\N
12932	DISPONIBLE	2026-05-14 13:00:00	\N	2	\N
12933	DISPONIBLE	2026-05-14 13:00:00	\N	3	\N
12934	DISPONIBLE	2026-05-14 13:30:00	\N	1	\N
12935	DISPONIBLE	2026-05-14 13:30:00	\N	2	\N
12936	DISPONIBLE	2026-05-14 13:30:00	\N	3	\N
12937	DISPONIBLE	2026-05-14 14:00:00	\N	1	\N
12938	DISPONIBLE	2026-05-14 14:00:00	\N	2	\N
12939	DISPONIBLE	2026-05-14 14:00:00	\N	3	\N
12940	DISPONIBLE	2026-05-14 14:30:00	\N	1	\N
12941	DISPONIBLE	2026-05-14 14:30:00	\N	2	\N
12942	DISPONIBLE	2026-05-14 14:30:00	\N	3	\N
12943	DISPONIBLE	2026-05-14 15:00:00	\N	1	\N
12944	DISPONIBLE	2026-05-14 15:00:00	\N	2	\N
12945	DISPONIBLE	2026-05-14 15:00:00	\N	3	\N
12946	DISPONIBLE	2026-05-14 15:30:00	\N	1	\N
12947	DISPONIBLE	2026-05-14 15:30:00	\N	2	\N
12948	DISPONIBLE	2026-05-14 15:30:00	\N	3	\N
12949	DISPONIBLE	2026-05-14 16:00:00	\N	1	\N
12950	DISPONIBLE	2026-05-14 16:00:00	\N	2	\N
12951	DISPONIBLE	2026-05-14 16:00:00	\N	3	\N
12952	DISPONIBLE	2026-05-14 16:30:00	\N	1	\N
12953	DISPONIBLE	2026-05-14 16:30:00	\N	2	\N
12954	DISPONIBLE	2026-05-14 16:30:00	\N	3	\N
12955	DISPONIBLE	2026-05-14 17:00:00	\N	1	\N
12956	DISPONIBLE	2026-05-14 17:00:00	\N	2	\N
12957	DISPONIBLE	2026-05-14 17:00:00	\N	3	\N
12958	DISPONIBLE	2026-05-14 17:30:00	\N	1	\N
12959	DISPONIBLE	2026-05-14 17:30:00	\N	2	\N
12960	DISPONIBLE	2026-05-14 17:30:00	\N	3	\N
12961	DISPONIBLE	2026-05-15 08:00:00	\N	1	\N
12962	DISPONIBLE	2026-05-15 08:00:00	\N	2	\N
12963	DISPONIBLE	2026-05-15 08:00:00	\N	3	\N
12964	DISPONIBLE	2026-05-15 08:30:00	\N	1	\N
12965	DISPONIBLE	2026-05-15 08:30:00	\N	2	\N
12966	DISPONIBLE	2026-05-15 08:30:00	\N	3	\N
12967	DISPONIBLE	2026-05-15 09:00:00	\N	1	\N
12968	DISPONIBLE	2026-05-15 09:00:00	\N	2	\N
12969	DISPONIBLE	2026-05-15 09:00:00	\N	3	\N
12970	DISPONIBLE	2026-05-15 09:30:00	\N	1	\N
12971	DISPONIBLE	2026-05-15 09:30:00	\N	2	\N
12972	DISPONIBLE	2026-05-15 09:30:00	\N	3	\N
12973	DISPONIBLE	2026-05-15 10:00:00	\N	1	\N
12974	DISPONIBLE	2026-05-15 10:00:00	\N	2	\N
12975	DISPONIBLE	2026-05-15 10:00:00	\N	3	\N
12976	DISPONIBLE	2026-05-15 10:30:00	\N	1	\N
12977	DISPONIBLE	2026-05-15 10:30:00	\N	2	\N
12978	DISPONIBLE	2026-05-15 10:30:00	\N	3	\N
12979	DISPONIBLE	2026-05-15 11:00:00	\N	1	\N
12980	DISPONIBLE	2026-05-15 11:00:00	\N	2	\N
12981	DISPONIBLE	2026-05-15 11:00:00	\N	3	\N
12982	DISPONIBLE	2026-05-15 11:30:00	\N	1	\N
12983	DISPONIBLE	2026-05-15 11:30:00	\N	2	\N
12984	DISPONIBLE	2026-05-15 11:30:00	\N	3	\N
12985	DISPONIBLE	2026-05-15 12:00:00	\N	1	\N
12986	DISPONIBLE	2026-05-15 12:00:00	\N	2	\N
12987	DISPONIBLE	2026-05-15 12:00:00	\N	3	\N
12988	DISPONIBLE	2026-05-15 12:30:00	\N	1	\N
12989	DISPONIBLE	2026-05-15 12:30:00	\N	2	\N
12990	DISPONIBLE	2026-05-15 12:30:00	\N	3	\N
12991	DISPONIBLE	2026-05-15 13:00:00	\N	1	\N
12992	DISPONIBLE	2026-05-15 13:00:00	\N	2	\N
12993	DISPONIBLE	2026-05-15 13:00:00	\N	3	\N
12994	DISPONIBLE	2026-05-15 13:30:00	\N	1	\N
12995	DISPONIBLE	2026-05-15 13:30:00	\N	2	\N
12996	DISPONIBLE	2026-05-15 13:30:00	\N	3	\N
12997	DISPONIBLE	2026-05-15 14:00:00	\N	1	\N
12998	DISPONIBLE	2026-05-15 14:00:00	\N	2	\N
12999	DISPONIBLE	2026-05-15 14:00:00	\N	3	\N
13000	DISPONIBLE	2026-05-15 14:30:00	\N	1	\N
13001	DISPONIBLE	2026-05-15 14:30:00	\N	2	\N
13002	DISPONIBLE	2026-05-15 14:30:00	\N	3	\N
13003	DISPONIBLE	2026-05-15 15:00:00	\N	1	\N
13004	DISPONIBLE	2026-05-15 15:00:00	\N	2	\N
13005	DISPONIBLE	2026-05-15 15:00:00	\N	3	\N
13006	DISPONIBLE	2026-05-15 15:30:00	\N	1	\N
13007	DISPONIBLE	2026-05-15 15:30:00	\N	2	\N
13008	DISPONIBLE	2026-05-15 15:30:00	\N	3	\N
13009	DISPONIBLE	2026-05-15 16:00:00	\N	1	\N
13010	DISPONIBLE	2026-05-15 16:00:00	\N	2	\N
13011	DISPONIBLE	2026-05-15 16:00:00	\N	3	\N
13012	DISPONIBLE	2026-05-15 16:30:00	\N	1	\N
13013	DISPONIBLE	2026-05-15 16:30:00	\N	2	\N
13014	DISPONIBLE	2026-05-15 16:30:00	\N	3	\N
13015	DISPONIBLE	2026-05-15 17:00:00	\N	1	\N
13016	DISPONIBLE	2026-05-15 17:00:00	\N	2	\N
13017	DISPONIBLE	2026-05-15 17:00:00	\N	3	\N
13018	DISPONIBLE	2026-05-15 17:30:00	\N	1	\N
13019	DISPONIBLE	2026-05-15 17:30:00	\N	2	\N
13020	DISPONIBLE	2026-05-15 17:30:00	\N	3	\N
13021	DISPONIBLE	2026-05-16 08:00:00	\N	1	\N
13022	DISPONIBLE	2026-05-16 08:00:00	\N	2	\N
13023	DISPONIBLE	2026-05-16 08:00:00	\N	3	\N
13024	DISPONIBLE	2026-05-16 08:30:00	\N	1	\N
13025	DISPONIBLE	2026-05-16 08:30:00	\N	2	\N
13026	DISPONIBLE	2026-05-16 08:30:00	\N	3	\N
13027	DISPONIBLE	2026-05-16 09:00:00	\N	1	\N
13028	DISPONIBLE	2026-05-16 09:00:00	\N	2	\N
13029	DISPONIBLE	2026-05-16 09:00:00	\N	3	\N
13030	DISPONIBLE	2026-05-16 09:30:00	\N	1	\N
13031	DISPONIBLE	2026-05-16 09:30:00	\N	2	\N
13032	DISPONIBLE	2026-05-16 09:30:00	\N	3	\N
13033	DISPONIBLE	2026-05-16 10:00:00	\N	1	\N
13034	DISPONIBLE	2026-05-16 10:00:00	\N	2	\N
13035	DISPONIBLE	2026-05-16 10:00:00	\N	3	\N
13036	DISPONIBLE	2026-05-16 10:30:00	\N	1	\N
13037	DISPONIBLE	2026-05-16 10:30:00	\N	2	\N
13038	DISPONIBLE	2026-05-16 10:30:00	\N	3	\N
13039	DISPONIBLE	2026-05-16 11:00:00	\N	1	\N
13040	DISPONIBLE	2026-05-16 11:00:00	\N	2	\N
13041	DISPONIBLE	2026-05-16 11:00:00	\N	3	\N
13042	DISPONIBLE	2026-05-16 11:30:00	\N	1	\N
13043	DISPONIBLE	2026-05-16 11:30:00	\N	2	\N
13044	DISPONIBLE	2026-05-16 11:30:00	\N	3	\N
13045	DISPONIBLE	2026-05-16 12:00:00	\N	1	\N
13046	DISPONIBLE	2026-05-16 12:00:00	\N	2	\N
13047	DISPONIBLE	2026-05-16 12:00:00	\N	3	\N
13048	DISPONIBLE	2026-05-16 12:30:00	\N	1	\N
13049	DISPONIBLE	2026-05-16 12:30:00	\N	2	\N
13050	DISPONIBLE	2026-05-16 12:30:00	\N	3	\N
13051	DISPONIBLE	2026-05-16 13:00:00	\N	1	\N
13052	DISPONIBLE	2026-05-16 13:00:00	\N	2	\N
13053	DISPONIBLE	2026-05-16 13:00:00	\N	3	\N
13054	DISPONIBLE	2026-05-16 13:30:00	\N	1	\N
13055	DISPONIBLE	2026-05-16 13:30:00	\N	2	\N
13056	DISPONIBLE	2026-05-16 13:30:00	\N	3	\N
13057	DISPONIBLE	2026-05-16 14:00:00	\N	1	\N
13058	DISPONIBLE	2026-05-16 14:00:00	\N	2	\N
13059	DISPONIBLE	2026-05-16 14:00:00	\N	3	\N
13060	DISPONIBLE	2026-05-16 14:30:00	\N	1	\N
13061	DISPONIBLE	2026-05-16 14:30:00	\N	2	\N
13062	DISPONIBLE	2026-05-16 14:30:00	\N	3	\N
13063	DISPONIBLE	2026-05-16 15:00:00	\N	1	\N
13064	DISPONIBLE	2026-05-16 15:00:00	\N	2	\N
13065	DISPONIBLE	2026-05-16 15:00:00	\N	3	\N
13066	DISPONIBLE	2026-05-16 15:30:00	\N	1	\N
13067	DISPONIBLE	2026-05-16 15:30:00	\N	2	\N
13068	DISPONIBLE	2026-05-16 15:30:00	\N	3	\N
13069	DISPONIBLE	2026-05-16 16:00:00	\N	1	\N
13070	DISPONIBLE	2026-05-16 16:00:00	\N	2	\N
13071	DISPONIBLE	2026-05-16 16:00:00	\N	3	\N
13072	DISPONIBLE	2026-05-16 16:30:00	\N	1	\N
13073	DISPONIBLE	2026-05-16 16:30:00	\N	2	\N
13074	DISPONIBLE	2026-05-16 16:30:00	\N	3	\N
13075	DISPONIBLE	2026-05-16 17:00:00	\N	1	\N
13076	DISPONIBLE	2026-05-16 17:00:00	\N	2	\N
13077	DISPONIBLE	2026-05-16 17:00:00	\N	3	\N
13078	DISPONIBLE	2026-05-16 17:30:00	\N	1	\N
13079	DISPONIBLE	2026-05-16 17:30:00	\N	2	\N
13080	DISPONIBLE	2026-05-16 17:30:00	\N	3	\N
13081	DISPONIBLE	2026-05-17 08:00:00	\N	1	\N
13082	DISPONIBLE	2026-05-17 08:00:00	\N	2	\N
13083	DISPONIBLE	2026-05-17 08:00:00	\N	3	\N
13084	DISPONIBLE	2026-05-17 08:30:00	\N	1	\N
13085	DISPONIBLE	2026-05-17 08:30:00	\N	2	\N
13086	DISPONIBLE	2026-05-17 08:30:00	\N	3	\N
13087	DISPONIBLE	2026-05-17 09:00:00	\N	1	\N
13088	DISPONIBLE	2026-05-17 09:00:00	\N	2	\N
13089	DISPONIBLE	2026-05-17 09:00:00	\N	3	\N
13090	DISPONIBLE	2026-05-17 09:30:00	\N	1	\N
13091	DISPONIBLE	2026-05-17 09:30:00	\N	2	\N
13092	DISPONIBLE	2026-05-17 09:30:00	\N	3	\N
13093	DISPONIBLE	2026-05-17 10:00:00	\N	1	\N
13094	DISPONIBLE	2026-05-17 10:00:00	\N	2	\N
13095	DISPONIBLE	2026-05-17 10:00:00	\N	3	\N
13096	DISPONIBLE	2026-05-17 10:30:00	\N	1	\N
13097	DISPONIBLE	2026-05-17 10:30:00	\N	2	\N
13098	DISPONIBLE	2026-05-17 10:30:00	\N	3	\N
13099	DISPONIBLE	2026-05-17 11:00:00	\N	1	\N
13100	DISPONIBLE	2026-05-17 11:00:00	\N	2	\N
13101	DISPONIBLE	2026-05-17 11:00:00	\N	3	\N
13102	DISPONIBLE	2026-05-17 11:30:00	\N	1	\N
13103	DISPONIBLE	2026-05-17 11:30:00	\N	2	\N
13104	DISPONIBLE	2026-05-17 11:30:00	\N	3	\N
13105	DISPONIBLE	2026-05-17 12:00:00	\N	1	\N
13106	DISPONIBLE	2026-05-17 12:00:00	\N	2	\N
13107	DISPONIBLE	2026-05-17 12:00:00	\N	3	\N
13108	DISPONIBLE	2026-05-17 12:30:00	\N	1	\N
13109	DISPONIBLE	2026-05-17 12:30:00	\N	2	\N
13110	DISPONIBLE	2026-05-17 12:30:00	\N	3	\N
13111	DISPONIBLE	2026-05-17 13:00:00	\N	1	\N
13112	DISPONIBLE	2026-05-17 13:00:00	\N	2	\N
13113	DISPONIBLE	2026-05-17 13:00:00	\N	3	\N
13114	DISPONIBLE	2026-05-17 13:30:00	\N	1	\N
13115	DISPONIBLE	2026-05-17 13:30:00	\N	2	\N
13116	DISPONIBLE	2026-05-17 13:30:00	\N	3	\N
13117	DISPONIBLE	2026-05-17 14:00:00	\N	1	\N
13118	DISPONIBLE	2026-05-17 14:00:00	\N	2	\N
13119	DISPONIBLE	2026-05-17 14:00:00	\N	3	\N
13120	DISPONIBLE	2026-05-17 14:30:00	\N	1	\N
13121	DISPONIBLE	2026-05-17 14:30:00	\N	2	\N
13122	DISPONIBLE	2026-05-17 14:30:00	\N	3	\N
13123	DISPONIBLE	2026-05-17 15:00:00	\N	1	\N
13124	DISPONIBLE	2026-05-17 15:00:00	\N	2	\N
13125	DISPONIBLE	2026-05-17 15:00:00	\N	3	\N
13126	DISPONIBLE	2026-05-17 15:30:00	\N	1	\N
13127	DISPONIBLE	2026-05-17 15:30:00	\N	2	\N
13128	DISPONIBLE	2026-05-17 15:30:00	\N	3	\N
13129	DISPONIBLE	2026-05-17 16:00:00	\N	1	\N
13130	DISPONIBLE	2026-05-17 16:00:00	\N	2	\N
13131	DISPONIBLE	2026-05-17 16:00:00	\N	3	\N
13132	DISPONIBLE	2026-05-17 16:30:00	\N	1	\N
13133	DISPONIBLE	2026-05-17 16:30:00	\N	2	\N
13134	DISPONIBLE	2026-05-17 16:30:00	\N	3	\N
13135	DISPONIBLE	2026-05-17 17:00:00	\N	1	\N
13136	DISPONIBLE	2026-05-17 17:00:00	\N	2	\N
13137	DISPONIBLE	2026-05-17 17:00:00	\N	3	\N
13138	DISPONIBLE	2026-05-17 17:30:00	\N	1	\N
13139	DISPONIBLE	2026-05-17 17:30:00	\N	2	\N
13140	DISPONIBLE	2026-05-17 17:30:00	\N	3	\N
13141	DISPONIBLE	2026-05-18 08:00:00	\N	1	\N
13142	DISPONIBLE	2026-05-18 08:00:00	\N	2	\N
13143	DISPONIBLE	2026-05-18 08:00:00	\N	3	\N
13144	DISPONIBLE	2026-05-18 08:30:00	\N	1	\N
13145	DISPONIBLE	2026-05-18 08:30:00	\N	2	\N
13146	DISPONIBLE	2026-05-18 08:30:00	\N	3	\N
13147	DISPONIBLE	2026-05-18 09:00:00	\N	1	\N
13148	DISPONIBLE	2026-05-18 09:00:00	\N	2	\N
13149	DISPONIBLE	2026-05-18 09:00:00	\N	3	\N
13150	DISPONIBLE	2026-05-18 09:30:00	\N	1	\N
13151	DISPONIBLE	2026-05-18 09:30:00	\N	2	\N
13152	DISPONIBLE	2026-05-18 09:30:00	\N	3	\N
13153	DISPONIBLE	2026-05-18 10:00:00	\N	1	\N
13154	DISPONIBLE	2026-05-18 10:00:00	\N	2	\N
13155	DISPONIBLE	2026-05-18 10:00:00	\N	3	\N
13156	DISPONIBLE	2026-05-18 10:30:00	\N	1	\N
13157	DISPONIBLE	2026-05-18 10:30:00	\N	2	\N
13158	DISPONIBLE	2026-05-18 10:30:00	\N	3	\N
13159	DISPONIBLE	2026-05-18 11:00:00	\N	1	\N
13160	DISPONIBLE	2026-05-18 11:00:00	\N	2	\N
13161	DISPONIBLE	2026-05-18 11:00:00	\N	3	\N
13162	DISPONIBLE	2026-05-18 11:30:00	\N	1	\N
13163	DISPONIBLE	2026-05-18 11:30:00	\N	2	\N
13164	DISPONIBLE	2026-05-18 11:30:00	\N	3	\N
13165	DISPONIBLE	2026-05-18 12:00:00	\N	1	\N
13166	DISPONIBLE	2026-05-18 12:00:00	\N	2	\N
13167	DISPONIBLE	2026-05-18 12:00:00	\N	3	\N
13168	DISPONIBLE	2026-05-18 12:30:00	\N	1	\N
13169	DISPONIBLE	2026-05-18 12:30:00	\N	2	\N
13170	DISPONIBLE	2026-05-18 12:30:00	\N	3	\N
13171	DISPONIBLE	2026-05-18 13:00:00	\N	1	\N
13172	DISPONIBLE	2026-05-18 13:00:00	\N	2	\N
13173	DISPONIBLE	2026-05-18 13:00:00	\N	3	\N
13174	DISPONIBLE	2026-05-18 13:30:00	\N	1	\N
13175	DISPONIBLE	2026-05-18 13:30:00	\N	2	\N
13176	DISPONIBLE	2026-05-18 13:30:00	\N	3	\N
13177	DISPONIBLE	2026-05-18 14:00:00	\N	1	\N
13178	DISPONIBLE	2026-05-18 14:00:00	\N	2	\N
13179	DISPONIBLE	2026-05-18 14:00:00	\N	3	\N
13180	DISPONIBLE	2026-05-18 14:30:00	\N	1	\N
13181	DISPONIBLE	2026-05-18 14:30:00	\N	2	\N
13182	DISPONIBLE	2026-05-18 14:30:00	\N	3	\N
13183	DISPONIBLE	2026-05-18 15:00:00	\N	1	\N
13184	DISPONIBLE	2026-05-18 15:00:00	\N	2	\N
13185	DISPONIBLE	2026-05-18 15:00:00	\N	3	\N
13186	DISPONIBLE	2026-05-18 15:30:00	\N	1	\N
13187	DISPONIBLE	2026-05-18 15:30:00	\N	2	\N
13188	DISPONIBLE	2026-05-18 15:30:00	\N	3	\N
13189	DISPONIBLE	2026-05-18 16:00:00	\N	1	\N
13190	DISPONIBLE	2026-05-18 16:00:00	\N	2	\N
13191	DISPONIBLE	2026-05-18 16:00:00	\N	3	\N
13192	DISPONIBLE	2026-05-18 16:30:00	\N	1	\N
13193	DISPONIBLE	2026-05-18 16:30:00	\N	2	\N
13194	DISPONIBLE	2026-05-18 16:30:00	\N	3	\N
13195	DISPONIBLE	2026-05-18 17:00:00	\N	1	\N
13196	DISPONIBLE	2026-05-18 17:00:00	\N	2	\N
13197	DISPONIBLE	2026-05-18 17:00:00	\N	3	\N
13198	DISPONIBLE	2026-05-18 17:30:00	\N	1	\N
13199	DISPONIBLE	2026-05-18 17:30:00	\N	2	\N
13200	DISPONIBLE	2026-05-18 17:30:00	\N	3	\N
13201	DISPONIBLE	2026-05-19 08:00:00	\N	1	\N
13202	DISPONIBLE	2026-05-19 08:00:00	\N	2	\N
13203	DISPONIBLE	2026-05-19 08:00:00	\N	3	\N
13204	DISPONIBLE	2026-05-19 08:30:00	\N	1	\N
13205	DISPONIBLE	2026-05-19 08:30:00	\N	2	\N
13206	DISPONIBLE	2026-05-19 08:30:00	\N	3	\N
13207	DISPONIBLE	2026-05-19 09:00:00	\N	1	\N
13208	DISPONIBLE	2026-05-19 09:00:00	\N	2	\N
13209	DISPONIBLE	2026-05-19 09:00:00	\N	3	\N
13210	DISPONIBLE	2026-05-19 09:30:00	\N	1	\N
13211	DISPONIBLE	2026-05-19 09:30:00	\N	2	\N
13212	DISPONIBLE	2026-05-19 09:30:00	\N	3	\N
13213	DISPONIBLE	2026-05-19 10:00:00	\N	1	\N
13214	DISPONIBLE	2026-05-19 10:00:00	\N	2	\N
13215	DISPONIBLE	2026-05-19 10:00:00	\N	3	\N
13216	DISPONIBLE	2026-05-19 10:30:00	\N	1	\N
13217	DISPONIBLE	2026-05-19 10:30:00	\N	2	\N
13218	DISPONIBLE	2026-05-19 10:30:00	\N	3	\N
13219	DISPONIBLE	2026-05-19 11:00:00	\N	1	\N
13220	DISPONIBLE	2026-05-19 11:00:00	\N	2	\N
13221	DISPONIBLE	2026-05-19 11:00:00	\N	3	\N
13222	DISPONIBLE	2026-05-19 11:30:00	\N	1	\N
13223	DISPONIBLE	2026-05-19 11:30:00	\N	2	\N
13224	DISPONIBLE	2026-05-19 11:30:00	\N	3	\N
13225	DISPONIBLE	2026-05-19 12:00:00	\N	1	\N
13226	DISPONIBLE	2026-05-19 12:00:00	\N	2	\N
13227	DISPONIBLE	2026-05-19 12:00:00	\N	3	\N
13228	DISPONIBLE	2026-05-19 12:30:00	\N	1	\N
13229	DISPONIBLE	2026-05-19 12:30:00	\N	2	\N
13230	DISPONIBLE	2026-05-19 12:30:00	\N	3	\N
13231	DISPONIBLE	2026-05-19 13:00:00	\N	1	\N
13232	DISPONIBLE	2026-05-19 13:00:00	\N	2	\N
13233	DISPONIBLE	2026-05-19 13:00:00	\N	3	\N
13234	DISPONIBLE	2026-05-19 13:30:00	\N	1	\N
13235	DISPONIBLE	2026-05-19 13:30:00	\N	2	\N
13236	DISPONIBLE	2026-05-19 13:30:00	\N	3	\N
13237	DISPONIBLE	2026-05-19 14:00:00	\N	1	\N
13238	DISPONIBLE	2026-05-19 14:00:00	\N	2	\N
13239	DISPONIBLE	2026-05-19 14:00:00	\N	3	\N
13240	DISPONIBLE	2026-05-19 14:30:00	\N	1	\N
13241	DISPONIBLE	2026-05-19 14:30:00	\N	2	\N
13242	DISPONIBLE	2026-05-19 14:30:00	\N	3	\N
13243	DISPONIBLE	2026-05-19 15:00:00	\N	1	\N
13244	DISPONIBLE	2026-05-19 15:00:00	\N	2	\N
13245	DISPONIBLE	2026-05-19 15:00:00	\N	3	\N
13246	DISPONIBLE	2026-05-19 15:30:00	\N	1	\N
13247	DISPONIBLE	2026-05-19 15:30:00	\N	2	\N
13248	DISPONIBLE	2026-05-19 15:30:00	\N	3	\N
13249	DISPONIBLE	2026-05-19 16:00:00	\N	1	\N
13250	DISPONIBLE	2026-05-19 16:00:00	\N	2	\N
13251	DISPONIBLE	2026-05-19 16:00:00	\N	3	\N
13252	DISPONIBLE	2026-05-19 16:30:00	\N	1	\N
13253	DISPONIBLE	2026-05-19 16:30:00	\N	2	\N
13254	DISPONIBLE	2026-05-19 16:30:00	\N	3	\N
13255	DISPONIBLE	2026-05-19 17:00:00	\N	1	\N
13256	DISPONIBLE	2026-05-19 17:00:00	\N	2	\N
13257	DISPONIBLE	2026-05-19 17:00:00	\N	3	\N
13258	DISPONIBLE	2026-05-19 17:30:00	\N	1	\N
13259	DISPONIBLE	2026-05-19 17:30:00	\N	2	\N
13260	DISPONIBLE	2026-05-19 17:30:00	\N	3	\N
13261	DISPONIBLE	2026-05-20 08:00:00	\N	1	\N
13262	DISPONIBLE	2026-05-20 08:00:00	\N	2	\N
13263	DISPONIBLE	2026-05-20 08:00:00	\N	3	\N
13264	DISPONIBLE	2026-05-20 08:30:00	\N	1	\N
13265	DISPONIBLE	2026-05-20 08:30:00	\N	2	\N
13266	DISPONIBLE	2026-05-20 08:30:00	\N	3	\N
13267	DISPONIBLE	2026-05-20 09:00:00	\N	1	\N
13268	DISPONIBLE	2026-05-20 09:00:00	\N	2	\N
13269	DISPONIBLE	2026-05-20 09:00:00	\N	3	\N
13270	DISPONIBLE	2026-05-20 09:30:00	\N	1	\N
13271	DISPONIBLE	2026-05-20 09:30:00	\N	2	\N
13272	DISPONIBLE	2026-05-20 09:30:00	\N	3	\N
13273	DISPONIBLE	2026-05-20 10:00:00	\N	1	\N
13274	DISPONIBLE	2026-05-20 10:00:00	\N	2	\N
13275	DISPONIBLE	2026-05-20 10:00:00	\N	3	\N
13276	DISPONIBLE	2026-05-20 10:30:00	\N	1	\N
13277	DISPONIBLE	2026-05-20 10:30:00	\N	2	\N
13278	DISPONIBLE	2026-05-20 10:30:00	\N	3	\N
13279	DISPONIBLE	2026-05-20 11:00:00	\N	1	\N
13280	DISPONIBLE	2026-05-20 11:00:00	\N	2	\N
13281	DISPONIBLE	2026-05-20 11:00:00	\N	3	\N
13282	DISPONIBLE	2026-05-20 11:30:00	\N	1	\N
13283	DISPONIBLE	2026-05-20 11:30:00	\N	2	\N
13284	DISPONIBLE	2026-05-20 11:30:00	\N	3	\N
13285	DISPONIBLE	2026-05-20 12:00:00	\N	1	\N
13286	DISPONIBLE	2026-05-20 12:00:00	\N	2	\N
13287	DISPONIBLE	2026-05-20 12:00:00	\N	3	\N
13288	DISPONIBLE	2026-05-20 12:30:00	\N	1	\N
13289	DISPONIBLE	2026-05-20 12:30:00	\N	2	\N
13290	DISPONIBLE	2026-05-20 12:30:00	\N	3	\N
13291	DISPONIBLE	2026-05-20 13:00:00	\N	1	\N
13292	DISPONIBLE	2026-05-20 13:00:00	\N	2	\N
13293	DISPONIBLE	2026-05-20 13:00:00	\N	3	\N
13294	DISPONIBLE	2026-05-20 13:30:00	\N	1	\N
13295	DISPONIBLE	2026-05-20 13:30:00	\N	2	\N
13296	DISPONIBLE	2026-05-20 13:30:00	\N	3	\N
13297	DISPONIBLE	2026-05-20 14:00:00	\N	1	\N
13298	DISPONIBLE	2026-05-20 14:00:00	\N	2	\N
13299	DISPONIBLE	2026-05-20 14:00:00	\N	3	\N
13300	DISPONIBLE	2026-05-20 14:30:00	\N	1	\N
13301	DISPONIBLE	2026-05-20 14:30:00	\N	2	\N
13302	DISPONIBLE	2026-05-20 14:30:00	\N	3	\N
13303	DISPONIBLE	2026-05-20 15:00:00	\N	1	\N
13304	DISPONIBLE	2026-05-20 15:00:00	\N	2	\N
13305	DISPONIBLE	2026-05-20 15:00:00	\N	3	\N
13306	DISPONIBLE	2026-05-20 15:30:00	\N	1	\N
13307	DISPONIBLE	2026-05-20 15:30:00	\N	2	\N
13308	DISPONIBLE	2026-05-20 15:30:00	\N	3	\N
13309	DISPONIBLE	2026-05-20 16:00:00	\N	1	\N
13310	DISPONIBLE	2026-05-20 16:00:00	\N	2	\N
13311	DISPONIBLE	2026-05-20 16:00:00	\N	3	\N
13312	DISPONIBLE	2026-05-20 16:30:00	\N	1	\N
13313	DISPONIBLE	2026-05-20 16:30:00	\N	2	\N
13314	DISPONIBLE	2026-05-20 16:30:00	\N	3	\N
13315	DISPONIBLE	2026-05-20 17:00:00	\N	1	\N
13316	DISPONIBLE	2026-05-20 17:00:00	\N	2	\N
13317	DISPONIBLE	2026-05-20 17:00:00	\N	3	\N
13318	DISPONIBLE	2026-05-20 17:30:00	\N	1	\N
13319	DISPONIBLE	2026-05-20 17:30:00	\N	2	\N
13320	DISPONIBLE	2026-05-20 17:30:00	\N	3	\N
13321	DISPONIBLE	2026-05-21 08:00:00	\N	1	\N
13322	DISPONIBLE	2026-05-21 08:00:00	\N	2	\N
13323	DISPONIBLE	2026-05-21 08:00:00	\N	3	\N
13324	DISPONIBLE	2026-05-21 08:30:00	\N	1	\N
13325	DISPONIBLE	2026-05-21 08:30:00	\N	2	\N
13326	DISPONIBLE	2026-05-21 08:30:00	\N	3	\N
13327	DISPONIBLE	2026-05-21 09:00:00	\N	1	\N
13328	DISPONIBLE	2026-05-21 09:00:00	\N	2	\N
13329	DISPONIBLE	2026-05-21 09:00:00	\N	3	\N
13330	DISPONIBLE	2026-05-21 09:30:00	\N	1	\N
13331	DISPONIBLE	2026-05-21 09:30:00	\N	2	\N
13332	DISPONIBLE	2026-05-21 09:30:00	\N	3	\N
13333	DISPONIBLE	2026-05-21 10:00:00	\N	1	\N
13334	DISPONIBLE	2026-05-21 10:00:00	\N	2	\N
13335	DISPONIBLE	2026-05-21 10:00:00	\N	3	\N
13336	DISPONIBLE	2026-05-21 10:30:00	\N	1	\N
13337	DISPONIBLE	2026-05-21 10:30:00	\N	2	\N
13338	DISPONIBLE	2026-05-21 10:30:00	\N	3	\N
13339	DISPONIBLE	2026-05-21 11:00:00	\N	1	\N
13340	DISPONIBLE	2026-05-21 11:00:00	\N	2	\N
13341	DISPONIBLE	2026-05-21 11:00:00	\N	3	\N
13342	DISPONIBLE	2026-05-21 11:30:00	\N	1	\N
13343	DISPONIBLE	2026-05-21 11:30:00	\N	2	\N
13344	DISPONIBLE	2026-05-21 11:30:00	\N	3	\N
13345	DISPONIBLE	2026-05-21 12:00:00	\N	1	\N
13346	DISPONIBLE	2026-05-21 12:00:00	\N	2	\N
13347	DISPONIBLE	2026-05-21 12:00:00	\N	3	\N
13348	DISPONIBLE	2026-05-21 12:30:00	\N	1	\N
13349	DISPONIBLE	2026-05-21 12:30:00	\N	2	\N
13350	DISPONIBLE	2026-05-21 12:30:00	\N	3	\N
13351	DISPONIBLE	2026-05-21 13:00:00	\N	1	\N
13352	DISPONIBLE	2026-05-21 13:00:00	\N	2	\N
13353	DISPONIBLE	2026-05-21 13:00:00	\N	3	\N
13354	DISPONIBLE	2026-05-21 13:30:00	\N	1	\N
13355	DISPONIBLE	2026-05-21 13:30:00	\N	2	\N
13356	DISPONIBLE	2026-05-21 13:30:00	\N	3	\N
13357	DISPONIBLE	2026-05-21 14:00:00	\N	1	\N
13358	DISPONIBLE	2026-05-21 14:00:00	\N	2	\N
13359	DISPONIBLE	2026-05-21 14:00:00	\N	3	\N
13360	DISPONIBLE	2026-05-21 14:30:00	\N	1	\N
13361	DISPONIBLE	2026-05-21 14:30:00	\N	2	\N
13362	DISPONIBLE	2026-05-21 14:30:00	\N	3	\N
13363	DISPONIBLE	2026-05-21 15:00:00	\N	1	\N
13364	DISPONIBLE	2026-05-21 15:00:00	\N	2	\N
13365	DISPONIBLE	2026-05-21 15:00:00	\N	3	\N
13366	DISPONIBLE	2026-05-21 15:30:00	\N	1	\N
13367	DISPONIBLE	2026-05-21 15:30:00	\N	2	\N
13368	DISPONIBLE	2026-05-21 15:30:00	\N	3	\N
13369	DISPONIBLE	2026-05-21 16:00:00	\N	1	\N
13370	DISPONIBLE	2026-05-21 16:00:00	\N	2	\N
13371	DISPONIBLE	2026-05-21 16:00:00	\N	3	\N
13372	DISPONIBLE	2026-05-21 16:30:00	\N	1	\N
13373	DISPONIBLE	2026-05-21 16:30:00	\N	2	\N
13374	DISPONIBLE	2026-05-21 16:30:00	\N	3	\N
13375	DISPONIBLE	2026-05-21 17:00:00	\N	1	\N
13376	DISPONIBLE	2026-05-21 17:00:00	\N	2	\N
13377	DISPONIBLE	2026-05-21 17:00:00	\N	3	\N
13378	DISPONIBLE	2026-05-21 17:30:00	\N	1	\N
13379	DISPONIBLE	2026-05-21 17:30:00	\N	2	\N
13380	DISPONIBLE	2026-05-21 17:30:00	\N	3	\N
13381	DISPONIBLE	2026-05-22 08:00:00	\N	1	\N
13382	DISPONIBLE	2026-05-22 08:00:00	\N	2	\N
13383	DISPONIBLE	2026-05-22 08:00:00	\N	3	\N
13384	DISPONIBLE	2026-05-22 08:30:00	\N	1	\N
13385	DISPONIBLE	2026-05-22 08:30:00	\N	2	\N
13386	DISPONIBLE	2026-05-22 08:30:00	\N	3	\N
13387	DISPONIBLE	2026-05-22 09:00:00	\N	1	\N
13388	DISPONIBLE	2026-05-22 09:00:00	\N	2	\N
13389	DISPONIBLE	2026-05-22 09:00:00	\N	3	\N
13390	DISPONIBLE	2026-05-22 09:30:00	\N	1	\N
13391	DISPONIBLE	2026-05-22 09:30:00	\N	2	\N
13392	DISPONIBLE	2026-05-22 09:30:00	\N	3	\N
13393	DISPONIBLE	2026-05-22 10:00:00	\N	1	\N
13394	DISPONIBLE	2026-05-22 10:00:00	\N	2	\N
13395	DISPONIBLE	2026-05-22 10:00:00	\N	3	\N
13396	DISPONIBLE	2026-05-22 10:30:00	\N	1	\N
13397	DISPONIBLE	2026-05-22 10:30:00	\N	2	\N
13398	DISPONIBLE	2026-05-22 10:30:00	\N	3	\N
13399	DISPONIBLE	2026-05-22 11:00:00	\N	1	\N
13400	DISPONIBLE	2026-05-22 11:00:00	\N	2	\N
13401	DISPONIBLE	2026-05-22 11:00:00	\N	3	\N
13402	DISPONIBLE	2026-05-22 11:30:00	\N	1	\N
13403	DISPONIBLE	2026-05-22 11:30:00	\N	2	\N
13404	DISPONIBLE	2026-05-22 11:30:00	\N	3	\N
13405	DISPONIBLE	2026-05-22 12:00:00	\N	1	\N
13406	DISPONIBLE	2026-05-22 12:00:00	\N	2	\N
13407	DISPONIBLE	2026-05-22 12:00:00	\N	3	\N
13408	DISPONIBLE	2026-05-22 12:30:00	\N	1	\N
13409	DISPONIBLE	2026-05-22 12:30:00	\N	2	\N
13410	DISPONIBLE	2026-05-22 12:30:00	\N	3	\N
13411	DISPONIBLE	2026-05-22 13:00:00	\N	1	\N
13412	DISPONIBLE	2026-05-22 13:00:00	\N	2	\N
13413	DISPONIBLE	2026-05-22 13:00:00	\N	3	\N
13414	DISPONIBLE	2026-05-22 13:30:00	\N	1	\N
13415	DISPONIBLE	2026-05-22 13:30:00	\N	2	\N
13416	DISPONIBLE	2026-05-22 13:30:00	\N	3	\N
13417	DISPONIBLE	2026-05-22 14:00:00	\N	1	\N
13418	DISPONIBLE	2026-05-22 14:00:00	\N	2	\N
13419	DISPONIBLE	2026-05-22 14:00:00	\N	3	\N
13420	DISPONIBLE	2026-05-22 14:30:00	\N	1	\N
13421	DISPONIBLE	2026-05-22 14:30:00	\N	2	\N
13422	DISPONIBLE	2026-05-22 14:30:00	\N	3	\N
13423	DISPONIBLE	2026-05-22 15:00:00	\N	1	\N
13424	DISPONIBLE	2026-05-22 15:00:00	\N	2	\N
13425	DISPONIBLE	2026-05-22 15:00:00	\N	3	\N
13426	DISPONIBLE	2026-05-22 15:30:00	\N	1	\N
13427	DISPONIBLE	2026-05-22 15:30:00	\N	2	\N
13428	DISPONIBLE	2026-05-22 15:30:00	\N	3	\N
13429	DISPONIBLE	2026-05-22 16:00:00	\N	1	\N
13430	DISPONIBLE	2026-05-22 16:00:00	\N	2	\N
13431	DISPONIBLE	2026-05-22 16:00:00	\N	3	\N
13432	DISPONIBLE	2026-05-22 16:30:00	\N	1	\N
13433	DISPONIBLE	2026-05-22 16:30:00	\N	2	\N
13434	DISPONIBLE	2026-05-22 16:30:00	\N	3	\N
13435	DISPONIBLE	2026-05-22 17:00:00	\N	1	\N
13436	DISPONIBLE	2026-05-22 17:00:00	\N	2	\N
13437	DISPONIBLE	2026-05-22 17:00:00	\N	3	\N
13438	DISPONIBLE	2026-05-22 17:30:00	\N	1	\N
13439	DISPONIBLE	2026-05-22 17:30:00	\N	2	\N
13440	DISPONIBLE	2026-05-22 17:30:00	\N	3	\N
13441	DISPONIBLE	2026-05-23 08:00:00	\N	1	\N
13442	DISPONIBLE	2026-05-23 08:00:00	\N	2	\N
13443	DISPONIBLE	2026-05-23 08:00:00	\N	3	\N
13444	DISPONIBLE	2026-05-23 08:30:00	\N	1	\N
13445	DISPONIBLE	2026-05-23 08:30:00	\N	2	\N
13446	DISPONIBLE	2026-05-23 08:30:00	\N	3	\N
13447	DISPONIBLE	2026-05-23 09:00:00	\N	1	\N
13448	DISPONIBLE	2026-05-23 09:00:00	\N	2	\N
13449	DISPONIBLE	2026-05-23 09:00:00	\N	3	\N
13450	DISPONIBLE	2026-05-23 09:30:00	\N	1	\N
13451	DISPONIBLE	2026-05-23 09:30:00	\N	2	\N
13452	DISPONIBLE	2026-05-23 09:30:00	\N	3	\N
13453	DISPONIBLE	2026-05-23 10:00:00	\N	1	\N
13454	DISPONIBLE	2026-05-23 10:00:00	\N	2	\N
13455	DISPONIBLE	2026-05-23 10:00:00	\N	3	\N
13456	DISPONIBLE	2026-05-23 10:30:00	\N	1	\N
13457	DISPONIBLE	2026-05-23 10:30:00	\N	2	\N
13458	DISPONIBLE	2026-05-23 10:30:00	\N	3	\N
13459	DISPONIBLE	2026-05-23 11:00:00	\N	1	\N
13460	DISPONIBLE	2026-05-23 11:00:00	\N	2	\N
13461	DISPONIBLE	2026-05-23 11:00:00	\N	3	\N
13462	DISPONIBLE	2026-05-23 11:30:00	\N	1	\N
13463	DISPONIBLE	2026-05-23 11:30:00	\N	2	\N
13464	DISPONIBLE	2026-05-23 11:30:00	\N	3	\N
13465	DISPONIBLE	2026-05-23 12:00:00	\N	1	\N
13466	DISPONIBLE	2026-05-23 12:00:00	\N	2	\N
13467	DISPONIBLE	2026-05-23 12:00:00	\N	3	\N
13468	DISPONIBLE	2026-05-23 12:30:00	\N	1	\N
13469	DISPONIBLE	2026-05-23 12:30:00	\N	2	\N
13470	DISPONIBLE	2026-05-23 12:30:00	\N	3	\N
13471	DISPONIBLE	2026-05-23 13:00:00	\N	1	\N
13472	DISPONIBLE	2026-05-23 13:00:00	\N	2	\N
13473	DISPONIBLE	2026-05-23 13:00:00	\N	3	\N
13474	DISPONIBLE	2026-05-23 13:30:00	\N	1	\N
13475	DISPONIBLE	2026-05-23 13:30:00	\N	2	\N
13476	DISPONIBLE	2026-05-23 13:30:00	\N	3	\N
13477	DISPONIBLE	2026-05-23 14:00:00	\N	1	\N
13478	DISPONIBLE	2026-05-23 14:00:00	\N	2	\N
13479	DISPONIBLE	2026-05-23 14:00:00	\N	3	\N
13480	DISPONIBLE	2026-05-23 14:30:00	\N	1	\N
13481	DISPONIBLE	2026-05-23 14:30:00	\N	2	\N
13482	DISPONIBLE	2026-05-23 14:30:00	\N	3	\N
13483	DISPONIBLE	2026-05-23 15:00:00	\N	1	\N
13484	DISPONIBLE	2026-05-23 15:00:00	\N	2	\N
13485	DISPONIBLE	2026-05-23 15:00:00	\N	3	\N
13486	DISPONIBLE	2026-05-23 15:30:00	\N	1	\N
13487	DISPONIBLE	2026-05-23 15:30:00	\N	2	\N
13488	DISPONIBLE	2026-05-23 15:30:00	\N	3	\N
13489	DISPONIBLE	2026-05-23 16:00:00	\N	1	\N
13490	DISPONIBLE	2026-05-23 16:00:00	\N	2	\N
13491	DISPONIBLE	2026-05-23 16:00:00	\N	3	\N
13492	DISPONIBLE	2026-05-23 16:30:00	\N	1	\N
13493	DISPONIBLE	2026-05-23 16:30:00	\N	2	\N
13494	DISPONIBLE	2026-05-23 16:30:00	\N	3	\N
13495	DISPONIBLE	2026-05-23 17:00:00	\N	1	\N
13496	DISPONIBLE	2026-05-23 17:00:00	\N	2	\N
13497	DISPONIBLE	2026-05-23 17:00:00	\N	3	\N
13498	DISPONIBLE	2026-05-23 17:30:00	\N	1	\N
13499	DISPONIBLE	2026-05-23 17:30:00	\N	2	\N
13500	DISPONIBLE	2026-05-23 17:30:00	\N	3	\N
13501	DISPONIBLE	2026-05-24 08:00:00	\N	1	\N
13502	DISPONIBLE	2026-05-24 08:00:00	\N	2	\N
13503	DISPONIBLE	2026-05-24 08:00:00	\N	3	\N
13504	DISPONIBLE	2026-05-24 08:30:00	\N	1	\N
13505	DISPONIBLE	2026-05-24 08:30:00	\N	2	\N
13506	DISPONIBLE	2026-05-24 08:30:00	\N	3	\N
13507	DISPONIBLE	2026-05-24 09:00:00	\N	1	\N
13508	DISPONIBLE	2026-05-24 09:00:00	\N	2	\N
13509	DISPONIBLE	2026-05-24 09:00:00	\N	3	\N
13510	DISPONIBLE	2026-05-24 09:30:00	\N	1	\N
13511	DISPONIBLE	2026-05-24 09:30:00	\N	2	\N
\.


--
-- Data for Name: urgencia; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.urgencia (id, anestesia, estado, fecha_hora_inicio, nivel_urgencia, prioridad, tipo, paciente_id, quirofano_id, servicio_id) FROM stdin;
2	GENERAL	FINALIZADA	2026-04-02 07:07:00	1	CRITICA	TRAUMATICA	11	2	1
7	LOCAL	CANCELADA	2026-04-29 08:30:00	2	\N	TRAUMATICA	10	1	2
8	GENERAL	CANCELADA	2026-04-29 13:00:00	1	\N	TRAUMATICA	7	1	2
5	LOCAL	CANCELADA	2026-04-29 14:30:00	3	ALTA	CARDIOVASCULAR	14	3	2
9	LOCAL	CANCELADA	2026-04-30 08:30:00	1	\N	GENERAL	3	1	1
1	SEDACION	CANCELADA	2026-05-01 06:06:00	2	ALTA	OTRA	11	2	2
10	LOCAL	CANCELADA	2026-04-29 08:30:00	1	\N	TRAUMATICA	1	1	1
12	GENERAL	CANCELADA	2026-04-29 08:30:00	1	\N	CARDIOVASCULAR	3	1	1
14	LOCAL	PROGRAMADA	2026-05-06 08:00:00	1	\N	CARDIOVASCULAR	2	1	2
11	LOCAL	FINALIZADA	2026-04-30 08:00:00	1	\N	NEUROLOGICA	7	1	2
15	LOCAL	PROGRAMADA	2026-05-07 08:00:00	3	\N	CARDIOVASCULAR	8	1	2
13	LOCAL	PROGRAMADA	2026-05-05 08:30:00	3	\N	TRAUMATICA	1	1	2
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
is_temporary_admin	true	b7e81ecc-cd17-4814-a70f-119927f0c946	1b40af33-ba0f-4e16-911c-c7cf0a13a85b	\N	\N	\N
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
e1a4f949-24c1-40b5-b89c-ce98844bafef	carottalucas2@gmail.com	carottalucas2@gmail.com	t	t	\N	Lucas	Carotta	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	lucascrtt	1762286589342	\N	0
99db6213-9f51-491a-9526-e7c5cc26f206	camilaperez@gmail.com	camilaperez@gmail.com	t	f	\N	Camila	Perez	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	2334412	1777155310568	\N	0
b7e81ecc-cd17-4814-a70f-119927f0c946	\N	822f6449-c26e-4c4d-92ab-94f30eab8ca7	t	t	\N	\N	\N	d97d657d-c2a8-4c20-a3a8-4ca15a52738d	admin	1762119880588	\N	0
b78b947a-1bd1-4cae-a613-32e4fd556a4b	\N	93224404-03b8-4fb4-a6ad-663dc765fa57	f	t	\N	\N	\N	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	service-account-dacs-bff	1769799645191	02d538de-9d35-440d-a6cf-a6fe61f33904	0
84326def-2e28-4f8c-b07f-a913fbc9d0e2	juanperez@gmail.com	juanperez@gmail.com	t	t	\N	Juan	Perez	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	juanperez	1769807734618	\N	0
b9ee02b5-f629-45cc-aa93-8e40270773be	medico@gmail.com	medico@gmail.com	t	t	\N	Medico	Medico	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	medico	1769809201886	\N	0
afa50bac-8979-47f8-989a-6a1dc43e97a3	sdasdads@gmail.com	sdasdads@gmail.com	f	t	\N	21	12	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	sadsad	1769810272260	\N	0
36accbf1-584f-4847-83c2-b0a4325c5f5d	ddd@gmail.com	ddd@gmail.com	f	t	\N	dd	dd	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	ddd	1769808969758	\N	0
a9969c21-5336-441c-b6ad-665dc8cb959b	aa@gmail.com	aa@gmail.com	t	f	\N	aaa	aa	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	aaa	1769809154543	\N	0
ca8a9e8e-d979-447f-b175-36c9b70ae4db	asd@gmail.com	asd@gmail.com	t	t	\N	Carlos	Martinez	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	asd	1769808859693	\N	0
6e6ab2e8-79f1-4a3f-944a-0cca02dc3e76	admin@admin.com	admin@admin.com	t	t	\N	admin	a	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	admin	1762286372093	\N	0
5e5370b5-3550-4124-88b7-c4dcfc093612	medico2@gmail.com	medico2@gmail.com	t	t	\N	Medico2	2	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	medico2	1777152925530	\N	0
19f300ab-a7fb-4673-98a6-24c288ae9d74	jperez@gmail.com	jperez@gmail.com	t	t	\N	j	perez	d3a4fe4c-75d3-4e66-a6b1-9fce68701b4b	jperez	1777154924161	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
84326def-2e28-4f8c-b07f-a913fbc9d0e2	UPDATE_PASSWORD
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
2439e07d-eecf-4e4f-9a13-24aac26dcd66	b7e81ecc-cd17-4814-a70f-119927f0c946
401c85ca-5f45-4959-821a-8b74dd59c76b	b7e81ecc-cd17-4814-a70f-119927f0c946
8fc1edbd-5d64-460f-97b4-3b4fdf427189	e1a4f949-24c1-40b5-b89c-ce98844bafef
8fc1edbd-5d64-460f-97b4-3b4fdf427189	b78b947a-1bd1-4cae-a613-32e4fd556a4b
dfc4d070-2ffb-4953-8e99-4a8f12921e76	b78b947a-1bd1-4cae-a613-32e4fd556a4b
e133e3db-44fc-4065-b442-ff0b7e2d0a99	b78b947a-1bd1-4cae-a613-32e4fd556a4b
6a79eb89-79f3-4539-bba5-18e1d270fb04	b78b947a-1bd1-4cae-a613-32e4fd556a4b
31c74c99-8178-44a5-b12b-3053ead36ad1	b78b947a-1bd1-4cae-a613-32e4fd556a4b
78694c8f-28c7-49c2-98b1-fd20ca0b1d83	b78b947a-1bd1-4cae-a613-32e4fd556a4b
e3444dc3-9514-44a0-ad3e-ab815ee7f9b0	b78b947a-1bd1-4cae-a613-32e4fd556a4b
fd30c54d-c4dc-4d4d-9687-360c3e3ab80f	b78b947a-1bd1-4cae-a613-32e4fd556a4b
35c993fa-fa37-454a-aab9-1239de34be95	b78b947a-1bd1-4cae-a613-32e4fd556a4b
8e080b1d-1f7a-4785-927b-2bd5cf8d2aab	b78b947a-1bd1-4cae-a613-32e4fd556a4b
b40cd027-c121-42c3-8633-ba98f3ea193f	b78b947a-1bd1-4cae-a613-32e4fd556a4b
e9171871-4be4-4890-9040-5809df77c9bf	b78b947a-1bd1-4cae-a613-32e4fd556a4b
8fc1edbd-5d64-460f-97b4-3b4fdf427189	84326def-2e28-4f8c-b07f-a913fbc9d0e2
8fc1edbd-5d64-460f-97b4-3b4fdf427189	a9969c21-5336-441c-b6ad-665dc8cb959b
160efc49-ade7-426e-9956-24f2c8f2f9a3	a9969c21-5336-441c-b6ad-665dc8cb959b
8fc1edbd-5d64-460f-97b4-3b4fdf427189	b9ee02b5-f629-45cc-aa93-8e40270773be
c32dc552-b9d4-4670-bc1a-6ddd8de174f4	b9ee02b5-f629-45cc-aa93-8e40270773be
8fc1edbd-5d64-460f-97b4-3b4fdf427189	afa50bac-8979-47f8-989a-6a1dc43e97a3
160efc49-ade7-426e-9956-24f2c8f2f9a3	afa50bac-8979-47f8-989a-6a1dc43e97a3
c32dc552-b9d4-4670-bc1a-6ddd8de174f4	36accbf1-584f-4847-83c2-b0a4325c5f5d
fd30c54d-c4dc-4d4d-9687-360c3e3ab80f	6e6ab2e8-79f1-4a3f-944a-0cca02dc3e76
e3444dc3-9514-44a0-ad3e-ab815ee7f9b0	6e6ab2e8-79f1-4a3f-944a-0cca02dc3e76
b40cd027-c121-42c3-8633-ba98f3ea193f	6e6ab2e8-79f1-4a3f-944a-0cca02dc3e76
6a79eb89-79f3-4539-bba5-18e1d270fb04	6e6ab2e8-79f1-4a3f-944a-0cca02dc3e76
78694c8f-28c7-49c2-98b1-fd20ca0b1d83	6e6ab2e8-79f1-4a3f-944a-0cca02dc3e76
c32dc552-b9d4-4670-bc1a-6ddd8de174f4	ca8a9e8e-d979-447f-b175-36c9b70ae4db
160efc49-ade7-426e-9956-24f2c8f2f9a3	6e6ab2e8-79f1-4a3f-944a-0cca02dc3e76
8fc1edbd-5d64-460f-97b4-3b4fdf427189	5e5370b5-3550-4124-88b7-c4dcfc093612
c32dc552-b9d4-4670-bc1a-6ddd8de174f4	5e5370b5-3550-4124-88b7-c4dcfc093612
8fc1edbd-5d64-460f-97b4-3b4fdf427189	19f300ab-a7fb-4673-98a6-24c288ae9d74
c32dc552-b9d4-4670-bc1a-6ddd8de174f4	19f300ab-a7fb-4673-98a6-24c288ae9d74
8fc1edbd-5d64-460f-97b4-3b4fdf427189	99db6213-9f51-491a-9526-e7c5cc26f206
c32dc552-b9d4-4670-bc1a-6ddd8de174f4	99db6213-9f51-491a-9526-e7c5cc26f206
\.


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.usuario (id, email, enabled, keycloak_id, username, id_personal) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.web_origins (client_id, value) FROM stdin;
bf31eec8-25de-4851-8df5-e95fdbad8878	+
8b815c6c-80ec-4263-aa9e-c2f015ffd4c7	+
42fdffbf-8dfa-4e1b-97dd-6a69d91e0beb	*
02d538de-9d35-440d-a6cf-a6fe61f33904	*
0cd5aab5-658d-44b4-b3f0-a7b3592ba199	*
dcd2b2aa-e336-4d3c-8e00-8f356feefd25	
\.


--
-- Data for Name: workflow_state; Type: TABLE DATA; Schema: public; Owner: dacs_user
--

COPY public.workflow_state (execution_id, resource_id, workflow_id, resource_type, scheduled_step_id, scheduled_step_timestamp) FROM stdin;
\.


--
-- Name: alumno_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dacs_user
--

SELECT pg_catalog.setval('public.alumno_id_seq', 2, true);


--
-- Name: cirugia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dacs_user
--

SELECT pg_catalog.setval('public.cirugia_id_seq', 312, true);


--
-- Name: equipo_medico_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dacs_user
--

SELECT pg_catalog.setval('public.equipo_medico_id_seq', 98, true);


--
-- Name: equipo_medico_urgencia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dacs_user
--

SELECT pg_catalog.setval('public.equipo_medico_urgencia_id_seq', 1, false);


--
-- Name: intervencion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dacs_user
--

SELECT pg_catalog.setval('public.intervencion_id_seq', 15, true);


--
-- Name: paciente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dacs_user
--

SELECT pg_catalog.setval('public.paciente_id_seq', 33, true);


--
-- Name: personal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dacs_user
--

SELECT pg_catalog.setval('public.personal_id_seq', 43, true);


--
-- Name: quirofano_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dacs_user
--

SELECT pg_catalog.setval('public.quirofano_id_seq', 3, true);


--
-- Name: servicio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dacs_user
--

SELECT pg_catalog.setval('public.servicio_id_seq', 10, true);


--
-- Name: tipo_intervencion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dacs_user
--

SELECT pg_catalog.setval('public.tipo_intervencion_id_seq', 1, false);


--
-- Name: turno_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dacs_user
--

SELECT pg_catalog.setval('public.turno_id_seq', 13560, true);


--
-- Name: urgencia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dacs_user
--

SELECT pg_catalog.setval('public.urgencia_id_seq', 15, true);


--
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dacs_user
--

SELECT pg_catalog.setval('public.usuario_id_seq', 1, false);


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: server_config SERVER_CONFIG_pkey; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.server_config
    ADD CONSTRAINT "SERVER_CONFIG_pkey" PRIMARY KEY (server_config_key);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: alumno alumno_pkey; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.alumno
    ADD CONSTRAINT alumno_pkey PRIMARY KEY (id);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: cirugia cirugia_pkey; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.cirugia
    ADD CONSTRAINT cirugia_pkey PRIMARY KEY (id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: jgroups_ping constraint_jgroups_ping; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.jgroups_ping
    ADD CONSTRAINT constraint_jgroups_ping PRIMARY KEY (address);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: org_invitation constraint_org_invitation; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.org_invitation
    ADD CONSTRAINT constraint_org_invitation PRIMARY KEY (id);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: equipo_medico equipo_medico_pkey; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.equipo_medico
    ADD CONSTRAINT equipo_medico_pkey PRIMARY KEY (id);


--
-- Name: equipo_medico_urgencia equipo_medico_urgencia_pkey; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.equipo_medico_urgencia
    ADD CONSTRAINT equipo_medico_urgencia_pkey PRIMARY KEY (id);


--
-- Name: intervencion intervencion_pkey; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.intervencion
    ADD CONSTRAINT intervencion_pkey PRIMARY KEY (id);


--
-- Name: paciente paciente_pkey; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.paciente
    ADD CONSTRAINT paciente_pkey PRIMARY KEY (id);


--
-- Name: personal personal_pkey; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.personal
    ADD CONSTRAINT personal_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: workflow_state pk_workflow_state; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.workflow_state
    ADD CONSTRAINT pk_workflow_state PRIMARY KEY (execution_id);


--
-- Name: quirofano quirofano_pkey; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.quirofano
    ADD CONSTRAINT quirofano_pkey PRIMARY KEY (id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: servicio servicio_pkey; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.servicio
    ADD CONSTRAINT servicio_pkey PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: tipo_intervencion tipo_intervencion_pkey; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.tipo_intervencion
    ADD CONSTRAINT tipo_intervencion_pkey PRIMARY KEY (id);


--
-- Name: turno turno_pkey; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.turno
    ADD CONSTRAINT turno_pkey PRIMARY KEY (id);


--
-- Name: usuario uk5171l57faosmj8myawaucatdw; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT uk5171l57faosmj8myawaucatdw UNIQUE (email);


--
-- Name: usuario uk863n1y3x0jalatoir4325ehal; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT uk863n1y3x0jalatoir4325ehal UNIQUE (username);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: migration_model uk_migration_update_time; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT uk_migration_update_time UNIQUE (update_time);


--
-- Name: migration_model uk_migration_version; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT uk_migration_version UNIQUE (version);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org_invitation uk_org_invitation_email; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.org_invitation
    ADD CONSTRAINT uk_org_invitation_email UNIQUE (organization_id, email);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: usuario ukdtu5miqkopl05jk553wbijc2s; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT ukdtu5miqkopl05jk553wbijc2s UNIQUE (keycloak_id);


--
-- Name: usuario ukkx92u9qcgnkarscsdi35phpqm; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT ukkx92u9qcgnkarscsdi35phpqm UNIQUE (id_personal);


--
-- Name: workflow_state uq_workflow_resource; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.workflow_state
    ADD CONSTRAINT uq_workflow_resource UNIQUE (workflow_id, resource_id);


--
-- Name: urgencia urgencia_pkey; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.urgencia
    ADD CONSTRAINT urgencia_pkey PRIMARY KEY (id);


--
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_broker_link_identity_provider; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_broker_link_identity_provider ON public.broker_link USING btree (realm_id, identity_provider, broker_user_id);


--
-- Name: idx_broker_link_user_id; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_broker_link_user_id ON public.broker_link USING btree (user_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_entity_user_id_type; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_event_entity_user_id_type ON public.event_entity USING btree (user_id, type, event_time);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_by_client; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_offline_css_by_client ON public.offline_client_session USING btree (client_id, offline_flag) WHERE ((client_id)::text <> 'external'::text);


--
-- Name: idx_offline_css_by_client_storage_provider; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_offline_css_by_client_storage_provider ON public.offline_client_session USING btree (client_storage_provider, external_client_id, offline_flag) WHERE ((client_storage_provider)::text <> 'internal'::text);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_org_invitation_email; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_org_invitation_email ON public.org_invitation USING btree (email);


--
-- Name: idx_org_invitation_expires; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_org_invitation_expires ON public.org_invitation USING btree (expires_at);


--
-- Name: idx_org_invitation_org_id; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_org_invitation_org_id ON public.org_invitation USING btree (organization_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_user_session_expiration_created; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_user_session_expiration_created ON public.offline_user_session USING btree (realm_id, offline_flag, remember_me, created_on, user_session_id, user_id);


--
-- Name: idx_user_session_expiration_last_refresh; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_user_session_expiration_last_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, remember_me, last_session_refresh, user_session_id, user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: idx_workflow_state_provider; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_workflow_state_provider ON public.workflow_state USING btree (resource_id);


--
-- Name: idx_workflow_state_step; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX idx_workflow_state_step ON public.workflow_state USING btree (workflow_id, scheduled_step_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: dacs_user
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: urgencia fk3nbva93no7pn80xx2l1hpbepa; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.urgencia
    ADD CONSTRAINT fk3nbva93no7pn80xx2l1hpbepa FOREIGN KEY (quirofano_id) REFERENCES public.quirofano(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: usuario fk60h977p2elgwkxcnjsp6vfu59; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk60h977p2elgwkxcnjsp6vfu59 FOREIGN KEY (id_personal) REFERENCES public.personal(id);


--
-- Name: equipo_medico_urgencia fk6u1vspcw9x1wcq34qsojjiwx3; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.equipo_medico_urgencia
    ADD CONSTRAINT fk6u1vspcw9x1wcq34qsojjiwx3 FOREIGN KEY (id_urgencia) REFERENCES public.urgencia(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: org_invitation fk_org_invitation_org; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.org_invitation
    ADD CONSTRAINT fk_org_invitation_org FOREIGN KEY (organization_id) REFERENCES public.org(id) ON DELETE CASCADE;


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: intervencion fka5uqjj2ou4l7gdcvhy9w5uxl9; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.intervencion
    ADD CONSTRAINT fka5uqjj2ou4l7gdcvhy9w5uxl9 FOREIGN KEY (tipo_intervencion_id) REFERENCES public.tipo_intervencion(id);


--
-- Name: equipo_medico fkcbo28yv3ydncp1fq9lrd8oxr7; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.equipo_medico
    ADD CONSTRAINT fkcbo28yv3ydncp1fq9lrd8oxr7 FOREIGN KEY (id_urgencia) REFERENCES public.urgencia(id);


--
-- Name: urgencia fkcp88oivr8swviu7odn2q73as9; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.urgencia
    ADD CONSTRAINT fkcp88oivr8swviu7odn2q73as9 FOREIGN KEY (paciente_id) REFERENCES public.paciente(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- Name: cirugia fkdyuownd1m58u53ygks1od0mc8; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.cirugia
    ADD CONSTRAINT fkdyuownd1m58u53ygks1od0mc8 FOREIGN KEY (quirofano_id) REFERENCES public.quirofano(id);


--
-- Name: turno fkfss20kip7p1tv5ia1iafsfm1; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.turno
    ADD CONSTRAINT fkfss20kip7p1tv5ia1iafsfm1 FOREIGN KEY (cirugia_id) REFERENCES public.cirugia(id);


--
-- Name: turno fkfxf26iwpw86f7mu9qdmstywos; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.turno
    ADD CONSTRAINT fkfxf26iwpw86f7mu9qdmstywos FOREIGN KEY (quirofano_id) REFERENCES public.quirofano(id);


--
-- Name: equipo_medico_urgencia fki8vf7f8feo0m1aewyhjp5mqyj; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.equipo_medico_urgencia
    ADD CONSTRAINT fki8vf7f8feo0m1aewyhjp5mqyj FOREIGN KEY (id_personal) REFERENCES public.personal(id);


--
-- Name: cirugia fkifskbsv0cx6b5grra6vfyrp55; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.cirugia
    ADD CONSTRAINT fkifskbsv0cx6b5grra6vfyrp55 FOREIGN KEY (servicio_id) REFERENCES public.servicio(id);


--
-- Name: turno fkiyf4ggcsy2p3rovj752ef8svu; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.turno
    ADD CONSTRAINT fkiyf4ggcsy2p3rovj752ef8svu FOREIGN KEY (urgencia_id) REFERENCES public.urgencia(id);


--
-- Name: equipo_medico fkje8xwctprvxoex2epux0d12ty; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.equipo_medico
    ADD CONSTRAINT fkje8xwctprvxoex2epux0d12ty FOREIGN KEY (id_personal) REFERENCES public.personal(id);


--
-- Name: intervencion fkjyrw0rcwmkt5dml76m9b101xe; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.intervencion
    ADD CONSTRAINT fkjyrw0rcwmkt5dml76m9b101xe FOREIGN KEY (cirugia_id) REFERENCES public.cirugia(id);


--
-- Name: intervencion fkkwu962yatope10bgm05hwy6oo; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.intervencion
    ADD CONSTRAINT fkkwu962yatope10bgm05hwy6oo FOREIGN KEY (id_urgencia) REFERENCES public.urgencia(id);


--
-- Name: urgencia fklw2mvi2go57o7m4sx2hod2v8x; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.urgencia
    ADD CONSTRAINT fklw2mvi2go57o7m4sx2hod2v8x FOREIGN KEY (servicio_id) REFERENCES public.servicio(id);


--
-- Name: equipo_medico fkmpxrrx0udrje450u081m314en; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.equipo_medico
    ADD CONSTRAINT fkmpxrrx0udrje450u081m314en FOREIGN KEY (id_cirugia) REFERENCES public.cirugia(id);


--
-- Name: cirugia fkne37m8i599qj4kfsd8ahea6pg; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.cirugia
    ADD CONSTRAINT fkne37m8i599qj4kfsd8ahea6pg FOREIGN KEY (paciente_id) REFERENCES public.paciente(id);


--
-- Name: intervencion fkom0f3gqxy056im7a4lw4o7tyg; Type: FK CONSTRAINT; Schema: public; Owner: dacs_user
--

ALTER TABLE ONLY public.intervencion
    ADD CONSTRAINT fkom0f3gqxy056im7a4lw4o7tyg FOREIGN KEY (urgencia_id) REFERENCES public.urgencia(id);


--
-- PostgreSQL database dump complete
--

\unrestrict edDjcX7xLY8aC8GTdG6Zb6IkWvXFL9mcMz8yz4JhawUeJZAF8p9oeRKnKPeeaY9

