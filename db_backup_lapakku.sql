--
-- PostgreSQL database dump
--

\restrict 5bZTavnoQQtzW2GQn4xJitJXRoEhc2jwaai4NZXkM0AgQ7hH33iFHVBQ7RscVMh

-- Dumped from database version 17.9 (Homebrew)
-- Dumped by pg_dump version 17.9 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.wishlists DROP CONSTRAINT wishlists_variant_id_foreign;
ALTER TABLE ONLY public.wishlists DROP CONSTRAINT wishlists_user_id_foreign;
ALTER TABLE ONLY public.wishlists DROP CONSTRAINT wishlists_product_id_foreign;
ALTER TABLE ONLY public.wallets DROP CONSTRAINT wallets_user_id_foreign;
ALTER TABLE ONLY public.wallet_transactions DROP CONSTRAINT wallet_transactions_wallet_id_foreign;
ALTER TABLE ONLY public.voucher_usages DROP CONSTRAINT voucher_usages_voucher_id_foreign;
ALTER TABLE ONLY public.voucher_usages DROP CONSTRAINT voucher_usages_user_id_foreign;
ALTER TABLE ONLY public.voucher_usages DROP CONSTRAINT voucher_usages_order_id_foreign;
ALTER TABLE ONLY public.user_addresses DROP CONSTRAINT user_addresses_user_id_foreign;
ALTER TABLE ONLY public.stock_ledger DROP CONSTRAINT stock_ledger_variant_id_foreign;
ALTER TABLE ONLY public.stock_ledger DROP CONSTRAINT stock_ledger_actor_id_foreign;
ALTER TABLE ONLY public.shipments DROP CONSTRAINT shipments_order_id_foreign;
ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_user_id_foreign;
ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_product_id_foreign;
ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_order_item_id_foreign;
ALTER TABLE ONLY public.refunds DROP CONSTRAINT refunds_requested_by_foreign;
ALTER TABLE ONLY public.refunds DROP CONSTRAINT refunds_payment_id_foreign;
ALTER TABLE ONLY public.refunds DROP CONSTRAINT refunds_order_id_foreign;
ALTER TABLE ONLY public.referrals DROP CONSTRAINT referrals_referrer_id_foreign;
ALTER TABLE ONLY public.referrals DROP CONSTRAINT referrals_referee_id_foreign;
ALTER TABLE ONLY public.products DROP CONSTRAINT products_category_id_foreign;
ALTER TABLE ONLY public.product_variants DROP CONSTRAINT product_variants_product_id_foreign;
ALTER TABLE ONLY public.product_variant_attributes DROP CONSTRAINT product_variant_attributes_variant_id_foreign;
ALTER TABLE ONLY public.product_variant_attributes DROP CONSTRAINT product_variant_attributes_attribute_value_id_foreign;
ALTER TABLE ONLY public.product_images DROP CONSTRAINT product_images_variant_id_foreign;
ALTER TABLE ONLY public.product_images DROP CONSTRAINT product_images_product_id_foreign;
ALTER TABLE ONLY public.product_attribute_values DROP CONSTRAINT product_attribute_values_attribute_id_foreign;
ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_order_id_foreign;
ALTER TABLE ONLY public.password_resets DROP CONSTRAINT password_resets_user_id_foreign;
ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_voucher_id_foreign;
ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_user_id_foreign;
ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_variant_id_foreign;
ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_order_id_foreign;
ALTER TABLE ONLY public.oauth_providers DROP CONSTRAINT oauth_providers_user_id_foreign;
ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_user_id_foreign;
ALTER TABLE ONLY public.loyalty_points DROP CONSTRAINT loyalty_points_user_id_foreign;
ALTER TABLE ONLY public.flash_sale_items DROP CONSTRAINT flash_sale_items_variant_id_foreign;
ALTER TABLE ONLY public.flash_sale_items DROP CONSTRAINT flash_sale_items_flash_sale_id_foreign;
ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_parent_id_foreign;
ALTER TABLE ONLY public.carts DROP CONSTRAINT carts_user_id_foreign;
ALTER TABLE ONLY public.cart_items DROP CONSTRAINT cart_items_variant_id_foreign;
ALTER TABLE ONLY public.cart_items DROP CONSTRAINT cart_items_cart_id_foreign;
ALTER TABLE ONLY public.audit_logs DROP CONSTRAINT audit_logs_user_id_foreign;
DROP INDEX public.wishlists_user_id_index;
DROP INDEX public.wallet_transactions_wallet_id_index;
DROP INDEX public.wallet_transactions_reference_type_reference_id_index;
DROP INDEX public.vouchers_is_active_starts_at_expires_at_index;
DROP INDEX public.vouchers_code_index;
DROP INDEX public.voucher_usages_voucher_id_user_id_index;
DROP INDEX public.user_addresses_user_id_is_default_index;
DROP INDEX public.user_addresses_user_id_index;
DROP INDEX public.stock_ledger_variant_id_index;
DROP INDEX public.stock_ledger_reference_type_reference_id_index;
DROP INDEX public.stock_ledger_created_at_index;
DROP INDEX public.shipments_tracking_number_index;
DROP INDEX public.shipments_order_id_index;
DROP INDEX public.settings_group_index;
DROP INDEX public.sessions_user_id_index;
DROP INDEX public.sessions_last_activity_index;
DROP INDEX public.reviews_user_id_index;
DROP INDEX public.reviews_product_id_status_index;
DROP INDEX public.refunds_status_index;
DROP INDEX public.refunds_order_id_index;
DROP INDEX public.referrals_referrer_id_index;
DROP INDEX public.products_status_is_featured_index;
DROP INDEX public.products_status_index;
DROP INDEX public.products_slug_index;
DROP INDEX public.products_is_featured_index;
DROP INDEX public.products_category_id_index;
DROP INDEX public.product_variants_stock_index;
DROP INDEX public.product_variants_sku_index;
DROP INDEX public.product_variants_product_id_is_active_index;
DROP INDEX public.product_variants_product_id_index;
DROP INDEX public.product_images_product_id_is_primary_index;
DROP INDEX public.product_images_product_id_index;
DROP INDEX public.product_attribute_values_attribute_id_index;
DROP INDEX public.personal_access_tokens_tokenable_type_tokenable_id_index;
DROP INDEX public.personal_access_tokens_expires_at_index;
DROP INDEX public.payments_status_index;
DROP INDEX public.payments_order_id_index;
DROP INDEX public.payments_gateway_transaction_id_index;
DROP INDEX public.password_resets_user_id_index;
DROP INDEX public.password_resets_token_index;
DROP INDEX public.orders_user_id_index;
DROP INDEX public.orders_status_index;
DROP INDEX public.orders_order_number_index;
DROP INDEX public.orders_created_at_index;
DROP INDEX public.order_items_variant_id_index;
DROP INDEX public.order_items_order_id_index;
DROP INDEX public.oauth_providers_user_id_index;
DROP INDEX public.notifications_user_id_read_at_index;
DROP INDEX public.notifications_created_at_index;
DROP INDEX public.loyalty_points_user_id_index;
DROP INDEX public.loyalty_points_reference_type_reference_id_index;
DROP INDEX public.jobs_queue_index;
DROP INDEX public.flash_sales_is_active_starts_at_ends_at_index;
DROP INDEX public.categories_slug_index;
DROP INDEX public.categories_parent_id_index;
DROP INDEX public.categories_is_active_index;
DROP INDEX public.carts_user_id_index;
DROP INDEX public.carts_session_id_index;
DROP INDEX public.cart_items_cart_id_index;
DROP INDEX public.cache_locks_expiration_index;
DROP INDEX public.cache_expiration_index;
DROP INDEX public.audit_logs_user_id_index;
DROP INDEX public.audit_logs_created_at_index;
DROP INDEX public.audit_logs_auditable_type_auditable_id_index;
ALTER TABLE ONLY public.wishlists DROP CONSTRAINT wishlists_user_id_product_id_unique;
ALTER TABLE ONLY public.wishlists DROP CONSTRAINT wishlists_pkey;
ALTER TABLE ONLY public.wallets DROP CONSTRAINT wallets_user_id_unique;
ALTER TABLE ONLY public.wallets DROP CONSTRAINT wallets_pkey;
ALTER TABLE ONLY public.wallet_transactions DROP CONSTRAINT wallet_transactions_pkey;
ALTER TABLE ONLY public.vouchers DROP CONSTRAINT vouchers_pkey;
ALTER TABLE ONLY public.vouchers DROP CONSTRAINT vouchers_code_unique;
ALTER TABLE ONLY public.voucher_usages DROP CONSTRAINT voucher_usages_pkey;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_phone_unique;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_unique;
ALTER TABLE ONLY public.user_addresses DROP CONSTRAINT user_addresses_pkey;
ALTER TABLE ONLY public.stock_ledger DROP CONSTRAINT stock_ledger_pkey;
ALTER TABLE ONLY public.site_settings DROP CONSTRAINT site_settings_pkey;
ALTER TABLE ONLY public.site_settings DROP CONSTRAINT site_settings_key_unique;
ALTER TABLE ONLY public.shipments DROP CONSTRAINT shipments_pkey;
ALTER TABLE ONLY public.settings DROP CONSTRAINT settings_pkey;
ALTER TABLE ONLY public.settings DROP CONSTRAINT settings_key_unique;
ALTER TABLE ONLY public.sessions DROP CONSTRAINT sessions_pkey;
ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_pkey;
ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_order_item_id_unique;
ALTER TABLE ONLY public.refunds DROP CONSTRAINT refunds_pkey;
ALTER TABLE ONLY public.referrals DROP CONSTRAINT referrals_referee_id_unique;
ALTER TABLE ONLY public.referrals DROP CONSTRAINT referrals_pkey;
ALTER TABLE ONLY public.products DROP CONSTRAINT products_slug_unique;
ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
ALTER TABLE ONLY public.product_variants DROP CONSTRAINT product_variants_sku_unique;
ALTER TABLE ONLY public.product_variants DROP CONSTRAINT product_variants_pkey;
ALTER TABLE ONLY public.product_variants DROP CONSTRAINT product_variants_barcode_unique;
ALTER TABLE ONLY public.product_variant_attributes DROP CONSTRAINT product_variant_attributes_pkey;
ALTER TABLE ONLY public.product_images DROP CONSTRAINT product_images_pkey;
ALTER TABLE ONLY public.product_attributes DROP CONSTRAINT product_attributes_pkey;
ALTER TABLE ONLY public.product_attributes DROP CONSTRAINT product_attributes_name_unique;
ALTER TABLE ONLY public.product_attribute_values DROP CONSTRAINT product_attribute_values_pkey;
ALTER TABLE ONLY public.product_attribute_values DROP CONSTRAINT product_attribute_values_attribute_id_value_unique;
ALTER TABLE ONLY public.personal_access_tokens DROP CONSTRAINT personal_access_tokens_token_unique;
ALTER TABLE ONLY public.personal_access_tokens DROP CONSTRAINT personal_access_tokens_pkey;
ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_pkey;
ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_gateway_transaction_id_unique;
ALTER TABLE ONLY public.password_resets DROP CONSTRAINT password_resets_token_unique;
ALTER TABLE ONLY public.password_resets DROP CONSTRAINT password_resets_pkey;
ALTER TABLE ONLY public.password_reset_tokens DROP CONSTRAINT password_reset_tokens_pkey;
ALTER TABLE ONLY public.pages DROP CONSTRAINT pages_slug_unique;
ALTER TABLE ONLY public.pages DROP CONSTRAINT pages_pkey;
ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_order_number_unique;
ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_pkey;
ALTER TABLE ONLY public.oauth_providers DROP CONSTRAINT oauth_providers_provider_provider_id_unique;
ALTER TABLE ONLY public.oauth_providers DROP CONSTRAINT oauth_providers_pkey;
ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_pkey;
ALTER TABLE ONLY public.migrations DROP CONSTRAINT migrations_pkey;
ALTER TABLE ONLY public.loyalty_points DROP CONSTRAINT loyalty_points_pkey;
ALTER TABLE ONLY public.jobs DROP CONSTRAINT jobs_pkey;
ALTER TABLE ONLY public.job_batches DROP CONSTRAINT job_batches_pkey;
ALTER TABLE ONLY public.flash_sales DROP CONSTRAINT flash_sales_pkey;
ALTER TABLE ONLY public.flash_sale_items DROP CONSTRAINT flash_sale_items_pkey;
ALTER TABLE ONLY public.flash_sale_items DROP CONSTRAINT flash_sale_items_flash_sale_id_variant_id_unique;
ALTER TABLE ONLY public.failed_jobs DROP CONSTRAINT failed_jobs_uuid_unique;
ALTER TABLE ONLY public.failed_jobs DROP CONSTRAINT failed_jobs_pkey;
ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_slug_unique;
ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
ALTER TABLE ONLY public.carts DROP CONSTRAINT carts_pkey;
ALTER TABLE ONLY public.cart_items DROP CONSTRAINT cart_items_pkey;
ALTER TABLE ONLY public.cart_items DROP CONSTRAINT cart_items_cart_id_variant_id_unique;
ALTER TABLE ONLY public.cache DROP CONSTRAINT cache_pkey;
ALTER TABLE ONLY public.cache_locks DROP CONSTRAINT cache_locks_pkey;
ALTER TABLE ONLY public.banners DROP CONSTRAINT banners_pkey;
ALTER TABLE ONLY public.audit_logs DROP CONSTRAINT audit_logs_pkey;
ALTER TABLE public.site_settings ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.personal_access_tokens ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.migrations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.jobs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.failed_jobs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.banners ALTER COLUMN id DROP DEFAULT;
DROP TABLE public.wishlists;
DROP TABLE public.wallets;
DROP TABLE public.wallet_transactions;
DROP TABLE public.vouchers;
DROP TABLE public.voucher_usages;
DROP TABLE public.users;
DROP TABLE public.user_addresses;
DROP TABLE public.stock_ledger;
DROP SEQUENCE public.site_settings_id_seq;
DROP TABLE public.site_settings;
DROP TABLE public.shipments;
DROP TABLE public.settings;
DROP TABLE public.sessions;
DROP TABLE public.reviews;
DROP TABLE public.refunds;
DROP TABLE public.referrals;
DROP TABLE public.products;
DROP TABLE public.product_variants;
DROP TABLE public.product_variant_attributes;
DROP TABLE public.product_images;
DROP TABLE public.product_attributes;
DROP TABLE public.product_attribute_values;
DROP SEQUENCE public.personal_access_tokens_id_seq;
DROP TABLE public.personal_access_tokens;
DROP TABLE public.payments;
DROP TABLE public.password_resets;
DROP TABLE public.password_reset_tokens;
DROP TABLE public.pages;
DROP TABLE public.orders;
DROP TABLE public.order_items;
DROP TABLE public.oauth_providers;
DROP TABLE public.notifications;
DROP SEQUENCE public.migrations_id_seq;
DROP TABLE public.migrations;
DROP TABLE public.loyalty_points;
DROP SEQUENCE public.jobs_id_seq;
DROP TABLE public.jobs;
DROP TABLE public.job_batches;
DROP TABLE public.flash_sales;
DROP TABLE public.flash_sale_items;
DROP SEQUENCE public.failed_jobs_id_seq;
DROP TABLE public.failed_jobs;
DROP TABLE public.categories;
DROP TABLE public.carts;
DROP TABLE public.cart_items;
DROP TABLE public.cache_locks;
DROP TABLE public.cache;
DROP SEQUENCE public.banners_id_seq;
DROP TABLE public.banners;
DROP TABLE public.audit_logs;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audit_logs (
    id uuid NOT NULL,
    user_id uuid,
    event character varying(50) NOT NULL,
    auditable_type character varying(60) NOT NULL,
    auditable_id uuid NOT NULL,
    old_values json,
    new_values json,
    ip_address character varying(45),
    user_agent character varying(500),
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: banners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.banners (
    id bigint NOT NULL,
    image character varying(255) NOT NULL,
    link_url character varying(255),
    sort_order integer DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: banners_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.banners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: banners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.banners_id_seq OWNED BY public.banners.id;


--
-- Name: cache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration bigint NOT NULL
);


--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration bigint NOT NULL
);


--
-- Name: cart_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart_items (
    id uuid NOT NULL,
    cart_id uuid NOT NULL,
    variant_id uuid NOT NULL,
    quantity integer NOT NULL,
    price_snapshot bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: carts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.carts (
    id uuid NOT NULL,
    user_id uuid,
    session_id character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id uuid NOT NULL,
    parent_id uuid,
    name character varying(100) NOT NULL,
    slug character varying(120) NOT NULL,
    description text,
    image_url character varying(500),
    sort_order integer DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    icon_name character varying(100)
);


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: flash_sale_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.flash_sale_items (
    id uuid NOT NULL,
    flash_sale_id uuid NOT NULL,
    variant_id uuid NOT NULL,
    sale_price bigint NOT NULL,
    stock_quota integer NOT NULL,
    sold_count integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: flash_sales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.flash_sales (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    banner_url character varying(500),
    starts_at timestamp(0) without time zone NOT NULL,
    ends_at timestamp(0) without time zone NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: loyalty_points; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.loyalty_points (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    points integer NOT NULL,
    type character varying(255) NOT NULL,
    reference_type character varying(50),
    reference_id uuid,
    description character varying(255),
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT loyalty_points_type_check CHECK (((type)::text = ANY ((ARRAY['earn'::character varying, 'redeem'::character varying, 'expire'::character varying, 'adjustment'::character varying])::text[])))
);


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    type character varying(60) NOT NULL,
    title character varying(150) NOT NULL,
    body text,
    data json,
    channel character varying(20) DEFAULT 'in_app'::character varying NOT NULL,
    read_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: oauth_providers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth_providers (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    provider character varying(30) NOT NULL,
    provider_id character varying(255) NOT NULL,
    access_token text,
    refresh_token text,
    token_expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_items (
    id uuid NOT NULL,
    order_id uuid NOT NULL,
    variant_id uuid,
    product_name character varying(255) NOT NULL,
    variant_name character varying(255),
    sku character varying(100) NOT NULL,
    product_image_url character varying(500),
    quantity integer NOT NULL,
    unit_price bigint NOT NULL,
    subtotal bigint NOT NULL,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    id uuid NOT NULL,
    user_id uuid,
    order_number character varying(30) NOT NULL,
    status character varying(255) DEFAULT 'pending_payment'::character varying NOT NULL,
    subtotal bigint NOT NULL,
    shipping_cost bigint DEFAULT '0'::bigint NOT NULL,
    discount_amount bigint DEFAULT '0'::bigint NOT NULL,
    tax_amount bigint DEFAULT '0'::bigint NOT NULL,
    grand_total bigint NOT NULL,
    recipient_name character varying(100) NOT NULL,
    recipient_phone character varying(20) NOT NULL,
    shipping_address text NOT NULL,
    province character varying(80) NOT NULL,
    city character varying(80) NOT NULL,
    postal_code character varying(10) NOT NULL,
    courier_code character varying(20) NOT NULL,
    courier_service character varying(30) NOT NULL,
    courier_etd character varying(30),
    tracking_number character varying(50),
    notes text,
    voucher_id uuid,
    paid_at timestamp(0) without time zone,
    shipped_at timestamp(0) without time zone,
    delivered_at timestamp(0) without time zone,
    completed_at timestamp(0) without time zone,
    cancelled_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT orders_status_check CHECK (((status)::text = ANY ((ARRAY['pending_payment'::character varying, 'paid'::character varying, 'processing'::character varying, 'shipped'::character varying, 'delivered'::character varying, 'completed'::character varying, 'cancelled'::character varying, 'refunded'::character varying])::text[])))
);


--
-- Name: pages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pages (
    id uuid NOT NULL,
    title character varying(150) NOT NULL,
    slug character varying(180) NOT NULL,
    content text NOT NULL,
    meta_title character varying(160),
    meta_description character varying(320),
    is_published boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


--
-- Name: password_resets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.password_resets (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token character varying(100) NOT NULL,
    expires_at timestamp(0) without time zone NOT NULL,
    used boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payments (
    id uuid NOT NULL,
    order_id uuid NOT NULL,
    gateway character varying(30) NOT NULL,
    gateway_transaction_id character varying(100),
    payment_method character varying(50),
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    amount bigint NOT NULL,
    gateway_response json,
    payment_url character varying(500),
    paid_at timestamp(0) without time zone,
    expired_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT payments_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'paid'::character varying, 'failed'::character varying, 'expired'::character varying, 'refunded'::character varying])::text[])))
);


--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id uuid NOT NULL,
    name text NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: product_attribute_values; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_attribute_values (
    id uuid NOT NULL,
    attribute_id uuid NOT NULL,
    value character varying(100) NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL
);


--
-- Name: product_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_attributes (
    id uuid NOT NULL,
    name character varying(50) NOT NULL,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: product_images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_images (
    id uuid NOT NULL,
    product_id uuid NOT NULL,
    variant_id uuid,
    url character varying(500) NOT NULL,
    alt_text character varying(255),
    sort_order integer DEFAULT 0 NOT NULL,
    is_primary boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: product_variant_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_variant_attributes (
    variant_id uuid NOT NULL,
    attribute_value_id uuid NOT NULL
);


--
-- Name: product_variants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_variants (
    id uuid NOT NULL,
    product_id uuid NOT NULL,
    sku character varying(100) NOT NULL,
    barcode character varying(100),
    price bigint NOT NULL,
    compare_price bigint,
    stock integer DEFAULT 0 NOT NULL,
    low_stock_threshold integer DEFAULT 5 NOT NULL,
    weight_gram numeric(10,2) NOT NULL,
    length_cm numeric(8,2),
    width_cm numeric(8,2),
    height_cm numeric(8,2),
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id uuid NOT NULL,
    category_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(280) NOT NULL,
    description text,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    is_featured boolean DEFAULT false NOT NULL,
    total_sold integer DEFAULT 0 NOT NULL,
    average_rating numeric(3,2) DEFAULT '0'::numeric NOT NULL,
    review_count integer DEFAULT 0 NOT NULL,
    meta_title character varying(160),
    meta_description character varying(320),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT products_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'draft'::character varying, 'archived'::character varying])::text[])))
);


--
-- Name: referrals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.referrals (
    id uuid NOT NULL,
    referrer_id uuid NOT NULL,
    referee_id uuid NOT NULL,
    code character varying(20) NOT NULL,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    referrer_reward bigint,
    referee_reward bigint,
    rewarded_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT referrals_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'rewarded'::character varying, 'expired'::character varying])::text[])))
);


--
-- Name: refunds; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.refunds (
    id uuid NOT NULL,
    order_id uuid NOT NULL,
    payment_id uuid NOT NULL,
    requested_by uuid NOT NULL,
    amount bigint NOT NULL,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    reason character varying(255) NOT NULL,
    description text,
    evidence_urls json,
    admin_notes text,
    gateway_refund_id character varying(100),
    processed_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT refunds_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'approved'::character varying, 'processing'::character varying, 'completed'::character varying, 'rejected'::character varying])::text[])))
);


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviews (
    id uuid NOT NULL,
    order_item_id uuid NOT NULL,
    user_id uuid NOT NULL,
    product_id uuid NOT NULL,
    rating smallint NOT NULL,
    title character varying(150),
    body text,
    image_urls json,
    is_anonymous boolean DEFAULT false NOT NULL,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    admin_reply text,
    replied_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT reviews_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'approved'::character varying, 'rejected'::character varying])::text[])))
);


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id uuid,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


--
-- Name: settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.settings (
    id uuid NOT NULL,
    key character varying(100) NOT NULL,
    value text,
    type character varying(20) DEFAULT 'string'::character varying NOT NULL,
    "group" character varying(50) DEFAULT 'general'::character varying NOT NULL,
    label character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: shipments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipments (
    id uuid NOT NULL,
    order_id uuid NOT NULL,
    courier_code character varying(20) NOT NULL,
    courier_service character varying(30) NOT NULL,
    tracking_number character varying(50) NOT NULL,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    tracking_history json,
    shipper_name character varying(100) NOT NULL,
    shipper_address text NOT NULL,
    picked_up_at timestamp(0) without time zone,
    delivered_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT shipments_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'picked_up'::character varying, 'in_transit'::character varying, 'out_for_delivery'::character varying, 'delivered'::character varying, 'failed'::character varying])::text[])))
);


--
-- Name: site_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.site_settings (
    id bigint NOT NULL,
    key character varying(255) NOT NULL,
    value text,
    is_encrypted boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: site_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.site_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: site_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.site_settings_id_seq OWNED BY public.site_settings.id;


--
-- Name: stock_ledger; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stock_ledger (
    id uuid NOT NULL,
    variant_id uuid NOT NULL,
    quantity_change integer NOT NULL,
    stock_after integer NOT NULL,
    reason character varying(100) NOT NULL,
    reference_type character varying(50),
    reference_id uuid,
    actor_id uuid,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: user_addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_addresses (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    label character varying(50) NOT NULL,
    recipient_name character varying(100) NOT NULL,
    phone character varying(20) NOT NULL,
    address_line text NOT NULL,
    province character varying(80) NOT NULL,
    city character varying(80) NOT NULL,
    district character varying(80) NOT NULL,
    village character varying(80) NOT NULL,
    postal_code character varying(10) NOT NULL,
    latitude numeric(10,7),
    longitude numeric(10,7),
    is_default boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    phone character varying(20),
    avatar_url character varying(500),
    role character varying(255) DEFAULT 'customer'::character varying NOT NULL,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    last_login_at timestamp(0) without time zone,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['customer'::character varying, 'admin'::character varying, 'super_admin'::character varying])::text[]))),
    CONSTRAINT users_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'suspended'::character varying, 'deleted'::character varying])::text[])))
);


--
-- Name: voucher_usages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.voucher_usages (
    id uuid NOT NULL,
    voucher_id uuid NOT NULL,
    user_id uuid NOT NULL,
    order_id uuid NOT NULL,
    discount_applied bigint NOT NULL,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: vouchers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vouchers (
    id uuid NOT NULL,
    code character varying(30) NOT NULL,
    name character varying(100) NOT NULL,
    type character varying(255) DEFAULT 'public'::character varying NOT NULL,
    discount_type character varying(255) NOT NULL,
    discount_value bigint NOT NULL,
    min_purchase bigint DEFAULT '0'::bigint NOT NULL,
    max_discount bigint,
    is_free_shipping boolean DEFAULT false NOT NULL,
    usage_limit integer,
    usage_count integer DEFAULT 0 NOT NULL,
    usage_limit_per_user integer,
    applies_to_all boolean DEFAULT true NOT NULL,
    starts_at timestamp(0) without time zone NOT NULL,
    expires_at timestamp(0) without time zone,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT vouchers_discount_type_check CHECK (((discount_type)::text = ANY ((ARRAY['percentage'::character varying, 'fixed'::character varying])::text[]))),
    CONSTRAINT vouchers_type_check CHECK (((type)::text = ANY ((ARRAY['public'::character varying, 'private'::character varying])::text[])))
);


--
-- Name: wallet_transactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wallet_transactions (
    id uuid NOT NULL,
    wallet_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    amount bigint NOT NULL,
    balance_after bigint NOT NULL,
    description character varying(255) NOT NULL,
    reference_type character varying(50),
    reference_id uuid,
    status character varying(255) DEFAULT 'completed'::character varying NOT NULL,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT wallet_transactions_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'completed'::character varying, 'failed'::character varying])::text[]))),
    CONSTRAINT wallet_transactions_type_check CHECK (((type)::text = ANY ((ARRAY['credit'::character varying, 'debit'::character varying])::text[])))
);


--
-- Name: wallets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wallets (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    balance bigint DEFAULT '0'::bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: wishlists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wishlists (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    product_id uuid NOT NULL,
    variant_id uuid,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone
);


--
-- Name: banners id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.banners ALTER COLUMN id SET DEFAULT nextval('public.banners_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: site_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_settings ALTER COLUMN id SET DEFAULT nextval('public.site_settings_id_seq'::regclass);


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.audit_logs (id, user_id, event, auditable_type, auditable_id, old_values, new_values, ip_address, user_agent, created_at) FROM stdin;
\.


--
-- Data for Name: banners; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.banners (id, image, link_url, sort_order, is_active, created_at, updated_at) FROM stdin;
1	banners/vHHr6IomteFgzdeopN45iJWjn1VTSBA0KXTlzjhz.png	\N	2	t	2026-05-02 14:09:44	2026-05-02 14:15:16
2	banners/VDuTpVcZyJceSOjXbJBdiAPrAp6oqncdqRlLf1lw.png	\N	1	t	2026-05-02 14:15:13	2026-05-02 14:15:16
\.


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cache (key, value, expiration) FROM stdin;
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cart_items (id, cart_id, variant_id, quantity, price_snapshot, created_at, updated_at) FROM stdin;
019ded35-0a8c-73ad-87c3-7771c888405f	019de918-9ccb-7329-9e6b-100ce7bad3b4	019de8cb-f6a6-70f6-96af-a0940259d080	1	55000	2026-05-03 09:39:29	2026-05-03 09:39:29
\.


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.carts (id, user_id, session_id, created_at, updated_at) FROM stdin;
019de918-9ccb-7329-9e6b-100ce7bad3b4	019de8c2-9d00-7387-846d-fc9555495464	\N	2026-05-02 14:29:57	2026-05-02 14:29:57
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categories (id, parent_id, name, slug, description, image_url, sort_order, is_active, created_at, updated_at, icon_name) FROM stdin;
b0690c41-c5f0-4eab-887a-c50d8d8017b8	\N	Elektronik	elektronik	\N	\N	0	t	\N	\N	\N
d3b15e51-0a08-4dcf-b624-2fe3721f57b2	\N	Fashion	fashion	\N	\N	0	t	\N	\N	\N
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: flash_sale_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.flash_sale_items (id, flash_sale_id, variant_id, sale_price, stock_quota, sold_count, created_at) FROM stdin;
\.


--
-- Data for Name: flash_sales; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.flash_sales (id, name, banner_url, starts_at, ends_at, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- Data for Name: loyalty_points; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.loyalty_points (id, user_id, points, type, reference_type, reference_id, description, expires_at, created_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2026_04_26_050206_create_personal_access_tokens_table	1
5	2026_04_26_050933_modify_users_table_for_ecommerce	1
6	2026_04_26_051229_create_user_addresses_table	1
7	2026_04_26_051244_create_oauth_providers_table	1
8	2026_04_26_051255_create_password_resets_table	1
9	2026_04_26_051311_create_categories_table	1
10	2026_04_26_051325_create_products_table	1
11	2026_04_26_051402_create_product_attributes_table	1
12	2026_04_26_051429_create_product_variants_table	1
13	2026_04_26_051444_create_product_variant_attributes_table	1
14	2026_04_26_051500_create_product_images_table	1
15	2026_04_26_051510_create_stock_ledger_table	1
16	2026_04_26_051523_create_wishlists_table	1
17	2026_04_26_051534_create_vouchers_table	1
18	2026_04_26_051546_create_carts_table	1
19	2026_04_26_051605_create_orders_table	1
20	2026_04_26_051621_create_order_items_table	1
21	2026_04_26_051631_create_payments_table	1
22	2026_04_26_051642_create_refunds_and_shipments_table	1
23	2026_04_26_051702_create_promotions_table	1
24	2026_04_26_051716_create_loyalty_and_wallet_table	1
25	2026_04_26_051732_create_system_tables	1
26	2026_04_29_045049_add_icon_name_to_categories_table	1
27	2026_05_02_124003_create_wishlists_table	1
28	2026_05_02_140028_create_banners_table	2
29	2026_05_03_140000_create_site_settings_table	3
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.notifications (id, user_id, type, title, body, data, channel, read_at, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_providers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.oauth_providers (id, user_id, provider, provider_id, access_token, refresh_token, token_expires_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_items (id, order_id, variant_id, product_name, variant_name, sku, product_image_url, quantity, unit_price, subtotal, created_at) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders (id, user_id, order_number, status, subtotal, shipping_cost, discount_amount, tax_amount, grand_total, recipient_name, recipient_phone, shipping_address, province, city, postal_code, courier_code, courier_service, courier_etd, tracking_number, notes, voucher_id, paid_at, shipped_at, delivered_at, completed_at, cancelled_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pages (id, title, slug, content, meta_title, meta_description, is_published, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.password_resets (id, user_id, token, expires_at, used, created_at) FROM stdin;
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payments (id, order_id, gateway, gateway_transaction_id, payment_method, status, amount, gateway_response, payment_url, paid_at, expired_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
3	App\\Models\\User	019de8c2-9b4c-70db-8171-1fe8a822ae66	test	0f790e499b00dacf8d9dc5f28f75da21f05e9130a59950e6aa206734d6c4c8ee	["*"]	\N	\N	2026-05-02 14:54:03	2026-05-02 14:54:03
6	App\\Models\\User	019de8c2-9d00-7387-846d-fc9555495464	auth_token	bab6fd6a7cd9649159aebe0b63570f0dc923889f6db43110103b32fd3383dda8	["*"]	2026-05-03 09:59:34	\N	2026-05-03 09:39:12	2026-05-03 09:59:34
7	App\\Models\\User	019de8c2-9c25-70d0-a8dd-23b434a6db01	auth_token	98faa1fc84a849b6ecafc35462c31f1dcab4077e7e69b9569e544daae381f9b2	["*"]	2026-05-05 09:21:34	\N	2026-05-05 08:56:39	2026-05-05 09:21:34
\.


--
-- Data for Name: product_attribute_values; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_attribute_values (id, attribute_id, value, sort_order) FROM stdin;
019de8ca-d7a5-7220-b6cd-a9a6bd647ceb	019de8ca-d7a4-71ca-9fcf-4efe65c469eb	hitam	0
019de8ca-d7a6-71bd-8ff5-f77652b193bc	019de8ca-d7a4-71ca-9fcf-4efe65c469eb	putih	0
019de8cb-f6a3-7146-9a2b-b3913728418a	019de8cb-f6a3-7146-9a2b-b391366d92c5	Hitam	0
019de8cb-f6a4-72c0-84e0-f6b23d6582ff	019de8cb-f6a3-7146-9a2b-b391366d92c5	Putih	0
019de8cb-f6a4-72c0-84e0-f6b23d7af61b	019de8cb-f6a3-7146-9a2b-b391366d92c5	Kuning	0
019de8cc-ba25-713d-bb5e-1ae03d90ae92	019de8cc-ba24-71ca-941d-d2cc8c442f53	S	0
019de8cc-ba26-71d0-a9b3-7c287ddb78c8	019de8cc-ba24-71ca-941d-d2cc8c442f53	m	0
019de8cc-ba28-7399-b6ff-d32a974340ff	019de8cc-ba24-71ca-941d-d2cc8c442f53	l	0
019de8cd-c47f-71d7-8598-6838126dd804	019de8cc-ba24-71ca-941d-d2cc8c442f53	M	0
019de8cd-c480-7256-b03e-3f171e0b47c5	019de8cc-ba24-71ca-941d-d2cc8c442f53	L	0
019de8cd-c481-73a2-bad8-c0a304d6e8d6	019de8cb-f6a3-7146-9a2b-b391366d92c5	HItam	0
019de8d0-b8a6-71c7-ae28-f59dd6071c1b	019de8d0-b8a5-7396-9c44-5afd68bd8326	intel	0
019de8d0-b8a7-7112-95ff-3615bc008755	019de8d0-b8a5-7396-9c44-5afd68bd8326	amd	0
019de8d1-7d32-7157-b060-e06f54dd630f	019de8d0-b8a5-7396-9c44-5afd68bd8326	Intel i5 gen 11; RAM 16GB; SSD 512GB	0
019de8d1-7d33-73d8-ad6e-978059b316d3	019de8d0-b8a5-7396-9c44-5afd68bd8326	Intel i5 gen 11; RAM 16GB SSD 1 TB	0
\.


--
-- Data for Name: product_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_attributes (id, name, created_at) FROM stdin;
019de8ca-d7a4-71ca-9fcf-4efe65c469eb	Color	2026-05-02 20:05:01
019de8cb-f6a3-7146-9a2b-b391366d92c5	Warna	2026-05-02 20:06:14
019de8cc-ba24-71ca-941d-d2cc8c442f53	Ukuran	2026-05-02 20:07:04
019de8d0-b8a5-7396-9c44-5afd68bd8326	Spek	2026-05-02 20:11:26
\.


--
-- Data for Name: product_images; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_images (id, product_id, variant_id, url, alt_text, sort_order, is_primary, created_at) FROM stdin;
1f7b47f0-1287-4746-aec7-09a831c3607c	019de8c2-9d25-72c1-9e1e-438dcc795b1e	\N	https://via.placeholder.com/300	\N	0	t	2026-05-02 19:56:02
9932890d-b350-4a4d-8666-8a2318c8fa09	019de8c2-9d26-7068-bd53-09ade586c5fc	\N	https://via.placeholder.com/300	\N	0	t	2026-05-02 19:56:02
0c56276b-3c0e-499e-b081-0caf35aaa799	019de8c2-9d27-72e7-b7bf-171708a040dd	\N	https://via.placeholder.com/300	\N	0	t	2026-05-02 19:56:02
d3f03299-c3b3-4da4-ae42-a428ab192fda	019de8c2-9d27-72e7-b7bf-1717092606b3	\N	https://via.placeholder.com/300	\N	0	t	2026-05-02 19:56:02
7a74655d-7e52-4c2b-b01a-6d0bd8139f7f	019de8c2-9d28-73a4-9b71-7ff957b864d6	\N	https://via.placeholder.com/300	\N	0	t	2026-05-02 19:56:02
a2771fda-eec9-414d-b267-8cce0477b120	019de8c2-9d29-71c6-9268-ac81f8144e39	\N	https://via.placeholder.com/300	\N	0	t	2026-05-02 19:56:02
71ea450e-a58d-45d5-8a55-a0e7c390b4c1	019de8c2-9d2a-7161-b707-d8ba00eeb7e0	\N	https://via.placeholder.com/300	\N	0	t	2026-05-02 19:56:02
51f81e7c-6da2-4c9a-904b-8e420cdba824	019de8c2-9d2b-7193-8b14-1ec12e3a5f80	\N	https://via.placeholder.com/300	\N	0	t	2026-05-02 19:56:02
5feedf54-612a-4868-98cc-c8fbc7106bfb	019de8c2-9d2c-73c3-9973-cea4b9d7329f	\N	https://via.placeholder.com/300	\N	0	t	2026-05-02 19:56:02
9cdb2188-84e0-4220-917a-76e462c73ca8	019de8c2-9d2c-73c3-9973-cea4b9e05b72	\N	https://via.placeholder.com/300	\N	0	t	2026-05-02 19:56:02
3144bd9e-12c6-4295-91e8-ce903ce617c9	019de8c2-9d2d-73cd-b079-3fbb65cddac8	\N	https://via.placeholder.com/300	\N	0	t	2026-05-02 19:56:02
8b404a1d-e87a-48d2-8e49-27c389cc780a	019de8c2-9d2e-733a-ba1f-8e1777dc1c98	\N	https://via.placeholder.com/300	\N	0	t	2026-05-02 19:56:02
78b8b506-9400-4b3c-949d-0bdd8277549d	019de8c2-9d2f-71f8-8999-e2db11006881	\N	https://via.placeholder.com/300	\N	0	t	2026-05-02 19:56:02
64ba0073-ac92-4cfa-973d-b11a57186d8c	019de8c2-9d2f-71f8-8999-e2db11133d0a	\N	https://via.placeholder.com/300	\N	0	t	2026-05-02 19:56:02
8bf261ba-5e6a-4fa6-a151-985901b3add2	019de8c2-9d30-7158-8180-7261d6aafa1b	\N	https://via.placeholder.com/300	\N	0	t	2026-05-02 19:56:02
019de8ca-d79c-7294-9014-5881590e4c4d	019de8c2-9d20-7202-ac47-a1dd6cb88a12	\N	products/hOfhRoKvYCtJtotoQYnKWwLvqjPbOOc2Ui4s5JYE.png	\N	0	t	2026-05-02 20:05:01
019de8cb-5711-715a-9dbd-a29a68e380fe	019de8c2-9d22-728f-8ba0-7545352bf85f	\N	products/72JxwlWJyLyZVc54QPqQEqKkvjsi32w4Or0pkfsu.png	\N	0	t	2026-05-02 20:05:33
019de8cc-ba1f-71af-874c-668636163df7	019de8c2-9d23-7039-9514-86aaadd748e7	\N	products/du1UmuLxRwrRitITHdmsTBArS5s3yoN5hTuN00iE.png	\N	0	t	2026-05-02 20:07:04
019de8cd-c476-7019-b323-3179941ba92b	019de8c2-9d29-71c6-9268-ac81f898b21a	\N	products/ltb2evStL8q2oB5sJtO16lYQ8smOdcqxFdqiDQv3.png	\N	0	t	2026-05-02 20:08:13
019de8ee-0b03-7061-9b8b-af0f8bd42631	019de8c2-9d24-72b6-9312-d441371bce92	\N	products/gallery/XurZts1BILBg6UnPmAZzHDWP0ZX4qi5VFhZhG1md.png	\N	1	f	2026-05-02 20:43:28
019de8d0-b89e-70f4-8ea4-c3e25aed578a	019de8c2-9d24-72b6-9312-d441371bce92	\N	products/PPwTK73LclueKaMeTUpiEVfKsD4Ku1wcjYflTjQ7.png	\N	0	t	2026-05-02 20:11:26
019de8ef-ba7d-7273-8a1b-30cc38fef32c	019de8c2-9d24-72b6-9312-d441371bce92	019de8d1-7d34-7300-9d9c-41394bbf1d25	products/variants/k9rjijFtZt0FNY8FxQfXOcYho5r0epB9mPt1JokL.png	\N	0	t	2026-05-02 20:45:18
019de8ef-ba7f-72d7-bee4-7a3de1bc1c5d	019de8c2-9d24-72b6-9312-d441371bce92	019de8d1-7d34-7300-9d9c-41394bbf1d25	products/variants/FbHnIU6OmiVvB0Qp4sC6lSnFQOmAiCBXQWNcmrdp.png	\N	1	f	2026-05-02 20:45:18
019de8ef-ba81-7316-a18c-edb9c5bbb6fc	019de8c2-9d24-72b6-9312-d441371bce92	019de8d1-7d36-71f4-bc4e-58ae8c4e5109	products/variants/KxnRQOLwUfGq7vV6c6mNGq445pzvPEgISRL5BsHD.png	\N	0	t	2026-05-02 20:45:18
019de8ef-ba83-70c5-ace2-e8e110fa5b89	019de8c2-9d24-72b6-9312-d441371bce92	019de8d1-7d36-71f4-bc4e-58ae8c4e5109	products/variants/6lS5aSSUJqNP5Z65nvvY0B4SNhPnvEOfbmW0Ma8x.png	\N	1	f	2026-05-02 20:45:18
\.


--
-- Data for Name: product_variant_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_variant_attributes (variant_id, attribute_value_id) FROM stdin;
019de8ca-d7a7-7234-a59a-6cb86028949d	019de8ca-d7a5-7220-b6cd-a9a6bd647ceb
019de8ca-d7aa-7384-8ae3-e86ec08ec939	019de8ca-d7a6-71bd-8ff5-f77652b193bc
019de8cb-f6a6-70f6-96af-a0940259d080	019de8cb-f6a3-7146-9a2b-b3913728418a
019de8cb-f6a9-7067-a5e6-2d3548332993	019de8cb-f6a4-72c0-84e0-f6b23d6582ff
019de8cb-f6ab-73de-ace0-54f415191154	019de8cb-f6a4-72c0-84e0-f6b23d7af61b
019de8cc-ba2b-70cf-b818-5b1259c22863	019de8cc-ba25-713d-bb5e-1ae03d90ae92
019de8cc-ba2e-73f0-a660-099cd71143f1	019de8cc-ba26-71d0-a9b3-7c287ddb78c8
019de8cc-ba33-70a7-ba20-b0a8ee9f41de	019de8cc-ba28-7399-b6ff-d32a974340ff
019de8cd-c483-7176-88d3-3a4b5036e6fa	019de8cc-ba25-713d-bb5e-1ae03d90ae92
019de8cd-c483-7176-88d3-3a4b5036e6fa	019de8cd-c481-73a2-bad8-c0a304d6e8d6
019de8cd-c486-73c7-9c24-5216aee25ce0	019de8cc-ba25-713d-bb5e-1ae03d90ae92
019de8cd-c486-73c7-9c24-5216aee25ce0	019de8cb-f6a4-72c0-84e0-f6b23d6582ff
019de8cd-c48b-73aa-b2a7-13f564e18edc	019de8cc-ba25-713d-bb5e-1ae03d90ae92
019de8cd-c48b-73aa-b2a7-13f564e18edc	019de8cb-f6a4-72c0-84e0-f6b23d7af61b
019de8cd-c48f-7277-bed0-818794416698	019de8cd-c47f-71d7-8598-6838126dd804
019de8cd-c48f-7277-bed0-818794416698	019de8cd-c481-73a2-bad8-c0a304d6e8d6
019de8cd-c492-71e7-9e25-ac7cfde33e2a	019de8cd-c47f-71d7-8598-6838126dd804
019de8cd-c492-71e7-9e25-ac7cfde33e2a	019de8cb-f6a4-72c0-84e0-f6b23d6582ff
019de8cd-c495-7384-a4e0-50a3e74a2421	019de8cd-c47f-71d7-8598-6838126dd804
019de8cd-c495-7384-a4e0-50a3e74a2421	019de8cb-f6a4-72c0-84e0-f6b23d7af61b
019de8cd-c499-7283-80df-e56754ed988f	019de8cd-c480-7256-b03e-3f171e0b47c5
019de8cd-c499-7283-80df-e56754ed988f	019de8cd-c481-73a2-bad8-c0a304d6e8d6
019de8cd-c49e-73fe-a6b2-161b5a0b7125	019de8cd-c480-7256-b03e-3f171e0b47c5
019de8cd-c49e-73fe-a6b2-161b5a0b7125	019de8cb-f6a4-72c0-84e0-f6b23d6582ff
019de8cd-c4a0-7140-8242-bde643d682a6	019de8cd-c480-7256-b03e-3f171e0b47c5
019de8cd-c4a0-7140-8242-bde643d682a6	019de8cb-f6a4-72c0-84e0-f6b23d7af61b
019de8d1-7d34-7300-9d9c-41394bbf1d25	019de8d1-7d32-7157-b060-e06f54dd630f
019de8d1-7d36-71f4-bc4e-58ae8c4e5109	019de8d1-7d33-73d8-ad6e-978059b316d3
\.


--
-- Data for Name: product_variants; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_variants (id, product_id, sku, barcode, price, compare_price, stock, low_stock_threshold, weight_gram, length_cm, width_cm, height_cm, is_active, created_at, updated_at) FROM stdin;
8e846fca-19ec-4c46-8a80-cc06f1240763	019de8c2-9d25-72c1-9e1e-438dcc795b1e	NOBIS-QUAM-SIT-OPTIO-OPTIO-001	\N	50000	\N	100	5	200.00	\N	\N	\N	t	2026-05-02 12:56:01	2026-05-02 12:56:01
7c89671e-07cf-4194-baf0-8d23cb2379cc	019de8c2-9d26-7068-bd53-09ade586c5fc	MAGNAM-LABORE-POSSIMUS-001	\N	50000	\N	100	5	200.00	\N	\N	\N	t	2026-05-02 12:56:01	2026-05-02 12:56:01
e6739a32-668c-46a6-a2ba-0e77f2613ada	019de8c2-9d27-72e7-b7bf-171708a040dd	ITAQUE-APERIAM-AUT-AUT-001	\N	50000	\N	100	5	200.00	\N	\N	\N	t	2026-05-02 12:56:01	2026-05-02 12:56:01
f434b64c-87ed-434c-b502-88eafb304381	019de8c2-9d27-72e7-b7bf-1717092606b3	SAEPE-DOLOREM-CONSEQUATUR-001	\N	50000	\N	100	5	200.00	\N	\N	\N	t	2026-05-02 12:56:01	2026-05-02 12:56:01
d8615073-55ac-4e90-84ca-4be78b385827	019de8c2-9d28-73a4-9b71-7ff957b864d6	VELIT-IN-SIT-TEMPORA-001	\N	50000	\N	100	5	200.00	\N	\N	\N	t	2026-05-02 12:56:01	2026-05-02 12:56:01
4da18c91-7859-4955-84de-ab0abff74a19	019de8c2-9d29-71c6-9268-ac81f8144e39	EIUS-AUT-EOS-ET-001	\N	50000	\N	100	5	200.00	\N	\N	\N	t	2026-05-02 12:56:01	2026-05-02 12:56:01
60b07053-8e12-4c33-8c86-e5c62ca4e70c	019de8c2-9d2a-7161-b707-d8ba00eeb7e0	IPSA-EIUS-AB-001	\N	50000	\N	100	5	200.00	\N	\N	\N	t	2026-05-02 12:56:01	2026-05-02 12:56:01
e9decb2c-1491-4591-b508-9ed40688b83e	019de8c2-9d2b-7193-8b14-1ec12e3a5f80	HIC-DOLOREMQUE-EST-001	\N	50000	\N	100	5	200.00	\N	\N	\N	t	2026-05-02 12:56:01	2026-05-02 12:56:01
7212009a-8830-467d-a501-cd5b2c178624	019de8c2-9d2c-73c3-9973-cea4b9d7329f	SUSCIPIT-ET-DOLOREMQUE-001	\N	50000	\N	100	5	200.00	\N	\N	\N	t	2026-05-02 12:56:01	2026-05-02 12:56:01
59287f86-53cb-4617-a2ab-21c5eee1edf1	019de8c2-9d2c-73c3-9973-cea4b9e05b72	RECUSANDAE-VOLUPTATEM-NEMO-SEQUI-001	\N	50000	\N	100	5	200.00	\N	\N	\N	t	2026-05-02 12:56:01	2026-05-02 12:56:01
1ed063c9-5cbe-41b0-b899-0741519f0918	019de8c2-9d2d-73cd-b079-3fbb65cddac8	EOS-MOLESTIAE-DOLORES-001	\N	50000	\N	100	5	200.00	\N	\N	\N	t	2026-05-02 12:56:01	2026-05-02 12:56:01
d211dd44-5c0d-4985-9e22-e49b143604ac	019de8c2-9d2e-733a-ba1f-8e1777dc1c98	EXERCITATIONEM-MINUS-001	\N	50000	\N	100	5	200.00	\N	\N	\N	t	2026-05-02 12:56:01	2026-05-02 12:56:01
b1badc7a-de56-48a6-a865-917cc7227ba0	019de8c2-9d2f-71f8-8999-e2db11006881	MOLLITIA-QUASI-EX-PERSPICIATIS-001	\N	50000	\N	100	5	200.00	\N	\N	\N	t	2026-05-02 12:56:01	2026-05-02 12:56:01
be4b42f3-9c08-4cdd-bd9b-18fc84045886	019de8c2-9d2f-71f8-8999-e2db11133d0a	SUNT-NOBIS-MOLLITIA-001	\N	50000	\N	100	5	200.00	\N	\N	\N	t	2026-05-02 12:56:01	2026-05-02 12:56:01
ef75ff12-f2b9-453e-8165-ef356d0a6203	019de8c2-9d30-7158-8180-7261d6aafa1b	VOLUPTATES-CUM-OFFICIIS-001	\N	50000	\N	100	5	200.00	\N	\N	\N	t	2026-05-02 12:56:01	2026-05-02 12:56:01
019de8ca-d7a7-7234-a59a-6cb86028949d	019de8c2-9d20-7202-ac47-a1dd6cb88a12	FAS-XD6H-021-HIT	\N	55000	\N	100	5	0.00	\N	\N	\N	t	2026-05-02 13:05:00	2026-05-02 13:05:00
019de8ca-d7aa-7384-8ae3-e86ec08ec939	019de8c2-9d20-7202-ac47-a1dd6cb88a12	FAS-DVMR-021-PUT	\N	60000	\N	100	5	0.00	\N	\N	\N	t	2026-05-02 13:05:00	2026-05-02 13:05:00
019de8cb-f6a6-70f6-96af-a0940259d080	019de8c2-9d22-728f-8ba0-7545352bf85f	ELE-YCBH-021-HIT	\N	55000	\N	100	5	0.00	\N	\N	\N	t	2026-05-02 13:06:14	2026-05-02 13:06:14
019de8cb-f6a9-7067-a5e6-2d3548332993	019de8c2-9d22-728f-8ba0-7545352bf85f	ELE-PFXZ-021-PUT	\N	60000	\N	100	5	0.00	\N	\N	\N	t	2026-05-02 13:06:14	2026-05-02 13:06:14
019de8cb-f6ab-73de-ace0-54f415191154	019de8c2-9d22-728f-8ba0-7545352bf85f	ELE-FC82-021-KUN	\N	70000	\N	100	5	0.00	\N	\N	\N	t	2026-05-02 13:06:14	2026-05-02 13:06:14
019de8cc-ba2b-70cf-b818-5b1259c22863	019de8c2-9d23-7039-9514-86aaadd748e7	ELE-CHMG-021-S	\N	50000	\N	100	5	0.00	\N	\N	\N	t	2026-05-02 13:07:04	2026-05-02 13:07:04
019de8cc-ba2e-73f0-a660-099cd71143f1	019de8c2-9d23-7039-9514-86aaadd748e7	ELE-GSYO-021-M	\N	55000	\N	100	5	0.00	\N	\N	\N	t	2026-05-02 13:07:04	2026-05-02 13:07:04
019de8cc-ba33-70a7-ba20-b0a8ee9f41de	019de8c2-9d23-7039-9514-86aaadd748e7	ELE-EKLY-021-L	\N	70000	\N	100	5	0.00	\N	\N	\N	t	2026-05-02 13:07:04	2026-05-02 13:07:04
019de8cd-c483-7176-88d3-3a4b5036e6fa	019de8c2-9d29-71c6-9268-ac81f898b21a	ELE-E43U-021-SHI	\N	50000	\N	100	5	0.00	\N	\N	\N	t	2026-05-02 13:08:12	2026-05-02 13:08:12
019de8cd-c486-73c7-9c24-5216aee25ce0	019de8c2-9d29-71c6-9268-ac81f898b21a	ELE-PNVA-021-SPU	\N	50000	\N	100	5	0.00	\N	\N	\N	t	2026-05-02 13:08:12	2026-05-02 13:08:12
019de8cd-c48b-73aa-b2a7-13f564e18edc	019de8c2-9d29-71c6-9268-ac81f898b21a	ELE-JTZA-021-SKU	\N	50000	\N	100	5	0.00	\N	\N	\N	t	2026-05-02 13:08:12	2026-05-02 13:08:12
019de8cd-c48f-7277-bed0-818794416698	019de8c2-9d29-71c6-9268-ac81f898b21a	ELE-CGJZ-021-MHI	\N	50000	\N	100	5	0.00	\N	\N	\N	t	2026-05-02 13:08:12	2026-05-02 13:08:12
019de8cd-c492-71e7-9e25-ac7cfde33e2a	019de8c2-9d29-71c6-9268-ac81f898b21a	ELE-AXSL-021-MPU	\N	50000	\N	100	5	0.00	\N	\N	\N	t	2026-05-02 13:08:12	2026-05-02 13:08:12
019de8cd-c495-7384-a4e0-50a3e74a2421	019de8c2-9d29-71c6-9268-ac81f898b21a	ELE-8ZY3-021-MKU	\N	50000	\N	100	5	0.00	\N	\N	\N	t	2026-05-02 13:08:12	2026-05-02 13:08:12
019de8cd-c499-7283-80df-e56754ed988f	019de8c2-9d29-71c6-9268-ac81f898b21a	ELE-ASMP-021-LHI	\N	50000	\N	100	5	0.00	\N	\N	\N	t	2026-05-02 13:08:12	2026-05-02 13:08:12
019de8cd-c49e-73fe-a6b2-161b5a0b7125	019de8c2-9d29-71c6-9268-ac81f898b21a	ELE-K5KD-021-LPU	\N	50000	\N	100	5	0.00	\N	\N	\N	t	2026-05-02 13:08:12	2026-05-02 13:08:12
019de8cd-c4a0-7140-8242-bde643d682a6	019de8c2-9d29-71c6-9268-ac81f898b21a	ELE-MFYG-021-LKU	\N	50000	\N	100	5	0.00	\N	\N	\N	t	2026-05-02 13:08:12	2026-05-02 13:08:12
019de8d1-7d34-7300-9d9c-41394bbf1d25	019de8c2-9d24-72b6-9312-d441371bce92	ELE-2OD5-021-INT	\N	9000000	\N	200	5	0.00	\N	\N	\N	t	2026-05-02 13:12:16	2026-05-02 13:45:18
019de8d1-7d36-71f4-bc4e-58ae8c4e5109	019de8c2-9d24-72b6-9312-d441371bce92	ELE-LT01-021-INT	\N	10000000	\N	200	5	0.00	\N	\N	\N	t	2026-05-02 13:12:16	2026-05-02 13:45:18
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products (id, category_id, name, slug, description, status, is_featured, total_sold, average_rating, review_count, meta_title, meta_description, created_at, updated_at) FROM stdin;
019de8c2-9d25-72c1-9e1e-438dcc795b1e	d3b15e51-0a08-4dcf-b624-2fe3721f57b2	Nobis quam sit optio optio.	nobis-quam-sit-optio-optio	Sint exercitationem atque modi magnam ut et. Voluptatem accusamus atque cumque earum provident non. Non quidem itaque sed autem itaque est vero.\n\nEaque temporibus minus praesentium nulla dolorum in commodi. Modi accusamus minima nostrum et. Sunt dolores suscipit incidunt. Esse eaque sunt doloremque eos ex.\n\nVitae maiores qui a est dolorem tempora sint. Voluptatem voluptatem sint consequatur nihil. Nihil quia ipsa neque dolor. Ut praesentium dolores aut aut explicabo corrupti qui.	active	f	0	0.00	0	\N	\N	2026-05-02 12:56:01	2026-05-02 12:56:01
019de8c2-9d26-7068-bd53-09ade586c5fc	d3b15e51-0a08-4dcf-b624-2fe3721f57b2	Magnam labore possimus.	magnam-labore-possimus	Blanditiis natus explicabo voluptas voluptates nobis eos. Sed eum cumque qui qui cumque occaecati.\n\nEst sit rerum nulla cumque quis est. Et laborum qui cumque est at quae sapiente doloremque. Consectetur et aut ipsa magnam optio aut.\n\nOccaecati et et laudantium et consequatur blanditiis. Corrupti vitae ut iure quia optio impedit. Eius nobis voluptas autem iusto odit ut omnis.	active	f	0	0.00	0	\N	\N	2026-05-02 12:56:01	2026-05-02 12:56:01
019de8c2-9d27-72e7-b7bf-171708a040dd	d3b15e51-0a08-4dcf-b624-2fe3721f57b2	Itaque aperiam aut aut.	itaque-aperiam-aut-aut	Tenetur architecto enim autem corrupti sed voluptas. Sed et nihil eum occaecati eos sit culpa. Esse ut provident nobis. Sit doloribus sed qui facilis molestiae. Consequuntur iusto ut est assumenda voluptatum nesciunt.\n\nRem nisi nisi aut expedita quod et dolorem voluptatum. Architecto eaque quis eius nobis. Qui nulla repellendus consectetur aut. Culpa distinctio tempora consectetur aliquam molestiae natus est.\n\nNon tempora consequuntur et dolor quae. Ducimus iste sed corporis porro molestiae at. Voluptas quibusdam aliquid facilis a sed numquam et. Maxime qui vero nemo velit voluptatem ad qui.	active	f	0	0.00	0	\N	\N	2026-05-02 12:56:01	2026-05-02 12:56:01
019de8c2-9d27-72e7-b7bf-1717092606b3	d3b15e51-0a08-4dcf-b624-2fe3721f57b2	Saepe dolorem consequatur.	saepe-dolorem-consequatur	Rerum consequuntur autem beatae porro. Culpa quisquam veritatis quos amet deserunt. Numquam numquam qui quia sed.\n\nSunt eius harum velit eos ducimus veniam est. Et deleniti impedit voluptatem eum. Nam ea quae vel laudantium consequatur aut voluptas.\n\nPerspiciatis fugit rem non debitis provident atque. Est laudantium illum omnis sit. Vel atque itaque asperiores sint ut accusantium.	active	f	0	0.00	0	\N	\N	2026-05-02 12:56:01	2026-05-02 12:56:01
019de8c2-9d28-73a4-9b71-7ff957b864d6	b0690c41-c5f0-4eab-887a-c50d8d8017b8	Velit in sit tempora.	velit-in-sit-tempora	Rem sed vel dolores aut est consequatur. Ut nam saepe nihil at eos placeat sed. Consequuntur voluptatibus rerum iste voluptatibus in maiores.\n\nConsequatur id rerum dolores facilis a. Ea iure qui accusantium magni dolorem harum. Nesciunt dolore porro earum adipisci blanditiis dignissimos dolore. Sequi ut id unde. Sed nostrum pariatur temporibus culpa eum.\n\nNulla illo tempore cupiditate placeat consequuntur quidem. A officiis iusto natus ut.	active	f	0	0.00	0	\N	\N	2026-05-02 12:56:01	2026-05-02 12:56:01
019de8c2-9d29-71c6-9268-ac81f8144e39	d3b15e51-0a08-4dcf-b624-2fe3721f57b2	Eius aut eos et.	eius-aut-eos-et	Ipsam rerum corporis fuga sit. Non ea debitis nesciunt culpa voluptas sed. Sed nihil dolor aut temporibus odio tempora corporis. Ut voluptatem cum atque sed maxime.\n\nAt delectus impedit sed exercitationem enim rerum. Nihil voluptatem iure ea blanditiis dolorem. Voluptate a hic sit corrupti aut neque qui. Itaque rerum aut voluptatem. Ullam nobis alias nulla in soluta ullam.\n\nVelit laudantium quo et ipsum. Fugit autem velit nemo voluptatem quaerat architecto illo. Ad quis quo omnis.	active	f	0	0.00	0	\N	\N	2026-05-02 12:56:01	2026-05-02 12:56:01
019de8c2-9d2a-7161-b707-d8ba00eeb7e0	d3b15e51-0a08-4dcf-b624-2fe3721f57b2	Ipsa eius ab.	ipsa-eius-ab	Doloremque nihil quod commodi ratione. Sunt consequatur eveniet qui eum. Sequi dignissimos voluptate nobis debitis. Voluptatem earum ex ut ut minus beatae.\n\nEveniet quo ea sint atque suscipit ipsa quo. Pariatur perspiciatis blanditiis accusantium possimus nobis doloribus. Ratione aut ducimus omnis qui. Non velit non amet excepturi quia consectetur.\n\nQuibusdam quod eos et labore autem maxime possimus. Facere sequi velit consequatur quasi sint tempora doloremque. Soluta nesciunt accusamus fuga et omnis nam.	active	f	0	0.00	0	\N	\N	2026-05-02 12:56:01	2026-05-02 12:56:01
019de8c2-9d2b-7193-8b14-1ec12e3a5f80	b0690c41-c5f0-4eab-887a-c50d8d8017b8	Hic doloremque est.	hic-doloremque-est	Suscipit facilis asperiores reiciendis cupiditate aspernatur ex. Modi laborum omnis pariatur eum ea omnis. Iste nihil et dolorum praesentium. Minima eum earum reiciendis fugiat a et recusandae.\n\nAut magnam in aut officia. Sequi nihil eum soluta enim optio. Cum maiores dolorem nostrum ratione.\n\nVeniam et quos et molestias. Voluptas itaque minus accusantium vel quos dolorem. Inventore et maiores molestiae eveniet eveniet. Sit deleniti cumque qui vel explicabo.	active	f	0	0.00	0	\N	\N	2026-05-02 12:56:01	2026-05-02 12:56:01
019de8c2-9d22-728f-8ba0-7545352bf85f	b0690c41-c5f0-4eab-887a-c50d8d8017b8	Ullam dolorem laudantium.	ullam-dolorem-laudantium	Amet voluptas sit laudantium quas veniam. Porro quod vero eum ut suscipit aut. Ut expedita et in vitae. Voluptatem rem non praesentium ullam rerum ex.\r\n\r\nSequi eligendi veniam ab qui debitis. Facere culpa est consectetur. Numquam possimus sunt non quis exercitationem.\r\n\r\nRerum fugiat ducimus nulla omnis quasi quia. Optio hic veritatis consectetur quia et minus. Vel molestias aut fugit autem.	active	f	0	0.00	0	\N	\N	2026-05-02 12:56:01	2026-05-02 13:05:33
019de8c2-9d23-7039-9514-86aaadd748e7	b0690c41-c5f0-4eab-887a-c50d8d8017b8	Rerum et tempore.	rerum-et-tempore	Laboriosam accusantium tenetur ipsum sapiente. Quia ex eum explicabo quis. Placeat repudiandae consequatur ipsa veniam eum molestias aut.\r\n\r\nEst perspiciatis corporis tenetur doloremque numquam. Eligendi quidem quod ut suscipit est. Necessitatibus dicta id labore. Odit corporis sequi quia et labore velit consequuntur.\r\n\r\nAssumenda est eos corrupti atque provident aspernatur consequuntur maiores. Et earum nobis dolor cupiditate ea. A consequatur ipsa est. Odio voluptatem ut aliquid nihil.	active	f	0	0.00	0	\N	\N	2026-05-02 12:56:01	2026-05-02 13:07:04
019de8c2-9d24-72b6-9312-d441371bce92	b0690c41-c5f0-4eab-887a-c50d8d8017b8	Autem voluptas nihil.	autem-voluptas-nihil	Voluptatem atque et dolorem voluptas rerum voluptas perferendis. Assumenda quis reiciendis voluptas eum odit facere saepe atque. Nesciunt culpa eos repudiandae eligendi et. Voluptatem quia cupiditate excepturi at.\r\n\r\nOdio voluptatibus vel saepe est. Dolor ut molestias quidem deserunt. Consequatur ullam et at ut. Rerum amet eos asperiores reiciendis et.\r\n\r\nDolorem reiciendis a nam rem illo. Reiciendis perferendis vero aut tempora fugiat debitis quia. Ullam exercitationem beatae vel.	active	f	0	0.00	0	\N	\N	2026-05-02 12:56:01	2026-05-02 13:11:26
019de8c2-9d2c-73c3-9973-cea4b9d7329f	d3b15e51-0a08-4dcf-b624-2fe3721f57b2	Suscipit et doloremque.	suscipit-et-doloremque	Praesentium consequatur labore voluptas consequuntur dignissimos. Explicabo et omnis ipsum et. Quia ut sequi similique voluptatum omnis sit saepe. Qui excepturi aut et et. Officiis quia numquam quo dolore repellat.\n\nFacilis magni veritatis tempora. Qui ut quasi dolorum omnis nisi et voluptatem. Nam enim necessitatibus tempore perferendis voluptas quo.\n\nBlanditiis dignissimos eligendi autem quia nulla alias magnam. Sapiente dolore eos voluptates quisquam temporibus. Voluptatem et qui consequatur atque debitis consequatur.	active	f	0	0.00	0	\N	\N	2026-05-02 12:56:01	2026-05-02 12:56:01
019de8c2-9d2c-73c3-9973-cea4b9e05b72	b0690c41-c5f0-4eab-887a-c50d8d8017b8	Recusandae voluptatem nemo sequi.	recusandae-voluptatem-nemo-sequi	Aliquam fugit aut ut consectetur a harum aliquid. Debitis veritatis maiores sequi.\n\nNecessitatibus exercitationem voluptatum soluta aperiam necessitatibus est et. Amet nostrum beatae exercitationem quia et minima. Sunt at tempora debitis temporibus quo tempore totam ut.\n\nInventore sunt temporibus similique. Eum eaque sint error vel. Nesciunt quis quaerat quia cupiditate est dolores.	active	f	0	0.00	0	\N	\N	2026-05-02 12:56:01	2026-05-02 12:56:01
019de8c2-9d2d-73cd-b079-3fbb65cddac8	b0690c41-c5f0-4eab-887a-c50d8d8017b8	Eos molestiae dolores.	eos-molestiae-dolores	Aut et voluptas adipisci ullam quia. Officia error nisi id corporis. Velit sint dignissimos voluptatem aut ipsum maiores.\n\nUt maiores occaecati animi voluptatem. Esse amet magni in asperiores sunt ut commodi. Nostrum assumenda non exercitationem quam at voluptatem quia. Error et voluptatem hic officiis ipsum repellendus soluta voluptatem.\n\nRepellat expedita non cupiditate iure id est et ut. Nam doloremque eligendi occaecati neque. Consequuntur culpa id corrupti est aut aperiam libero hic. Qui facere iste fugiat sapiente magnam illo est.	active	f	0	0.00	0	\N	\N	2026-05-02 12:56:01	2026-05-02 12:56:01
019de8c2-9d2e-733a-ba1f-8e1777dc1c98	b0690c41-c5f0-4eab-887a-c50d8d8017b8	Exercitationem minus.	exercitationem-minus	Maiores et repellendus reiciendis vel quo facere. Incidunt velit maxime ab. Quasi nostrum labore et nesciunt ex odio.\n\nAut aut quis autem et. Est quaerat animi nesciunt minus ad non hic. Qui itaque ducimus repellat qui mollitia aliquam. Et ipsum consequatur odio ea consectetur deserunt laboriosam.\n\nEt dolores quia molestiae accusamus ducimus quae architecto. Ut voluptates ab nihil inventore aut sint. Rerum quo laboriosam nisi dicta.	active	f	0	0.00	0	\N	\N	2026-05-02 12:56:01	2026-05-02 12:56:01
019de8c2-9d2f-71f8-8999-e2db11006881	b0690c41-c5f0-4eab-887a-c50d8d8017b8	Mollitia quasi ex perspiciatis.	mollitia-quasi-ex-perspiciatis	Sunt voluptate velit laborum nemo. In accusantium minus repellendus aspernatur culpa sunt saepe. Dignissimos ipsa consequatur error qui est. Eos consequatur temporibus porro ut.\n\nAut quam nostrum non ipsam. Non voluptatibus veniam officia quod vel aut sit et. Fugiat dolorum et velit reiciendis. Voluptas libero in consequatur temporibus.\n\nSint velit nam inventore adipisci molestias vero repudiandae. Ut distinctio beatae modi molestiae sit voluptatem exercitationem officiis. Quibusdam architecto ex eos nulla natus a maxime sunt. Molestiae doloribus non officiis sint eveniet quia.	active	f	0	0.00	0	\N	\N	2026-05-02 12:56:01	2026-05-02 12:56:01
019de8c2-9d2f-71f8-8999-e2db11133d0a	d3b15e51-0a08-4dcf-b624-2fe3721f57b2	Sunt nobis mollitia.	sunt-nobis-mollitia	Consequuntur optio qui necessitatibus voluptas. Ut alias accusantium qui ullam aut. Vel ea quia sit nihil deleniti ipsam.\n\nAmet quia ipsam harum beatae velit odit. Qui ad deleniti modi. Voluptatum incidunt necessitatibus amet ut ut aut. Exercitationem ut aut laudantium alias dolorum. Reprehenderit suscipit unde quia et deserunt deserunt repudiandae tempore.\n\nAt ullam dolorem aut maiores. Cum blanditiis aliquid sint. Cumque itaque ratione laudantium minima. Dolorum ad praesentium reprehenderit aut assumenda labore.	active	f	0	0.00	0	\N	\N	2026-05-02 12:56:01	2026-05-02 12:56:01
019de8c2-9d30-7158-8180-7261d6aafa1b	d3b15e51-0a08-4dcf-b624-2fe3721f57b2	Voluptates cum officiis.	voluptates-cum-officiis	Vel consequatur id debitis. Ut maxime ut facilis at eaque vel. Quaerat voluptas et odit in quo eum dolore. Quam deserunt consequatur expedita aperiam.\n\nOfficiis nam mollitia assumenda et et modi. Perferendis cumque consectetur repellat nulla sed. Ducimus sit cum ullam consequatur.\n\nPossimus perferendis ratione velit porro quia. Delectus consequuntur velit non quam.	active	f	0	0.00	0	\N	\N	2026-05-02 12:56:01	2026-05-02 12:56:01
019de8c2-9d20-7202-ac47-a1dd6cb88a12	d3b15e51-0a08-4dcf-b624-2fe3721f57b2	Possimus veritatis laborum.	possimus-veritatis-laborum	Numquam cumque est tenetur totam fugiat. Fuga rem voluptates porro et vel sed natus. Quae velit magni dolorem libero voluptatem voluptate in neque. Labore quae quo aperiam qui.\r\n\r\nAssumenda perferendis ea dolor velit. Dolore ut qui ut at. Fugiat fugit aut reprehenderit molestiae facilis sunt sit.\r\n\r\nSed porro aut doloribus id vel. Consequatur sed quidem tempora id pariatur voluptatem ad. Maiores ex saepe voluptate voluptates ex. Ipsa rerum asperiores aut dicta doloribus iure.	active	f	0	0.00	0	\N	\N	2026-05-02 12:56:01	2026-05-02 13:05:00
019de8c2-9d29-71c6-9268-ac81f898b21a	b0690c41-c5f0-4eab-887a-c50d8d8017b8	Repellendus veritatis quia ex.	repellendus-veritatis-quia-ex	Quaerat ipsam qui est minus ut nulla sit. Sed itaque praesentium quo. Amet alias eos eos tenetur.\r\n\r\nModi quam temporibus quae voluptatum neque quo sunt. Nisi et similique qui enim. Ut repellendus at ratione qui quia veniam. Incidunt expedita possimus eos.\r\n\r\nEa sapiente soluta officiis soluta. Architecto dicta omnis laboriosam labore nihil est est aut. Molestiae voluptatem voluptatem voluptatem provident. Exercitationem ipsum et aliquid quisquam praesentium. Quia omnis pariatur est et repudiandae aspernatur quo.	active	f	0	0.00	0	\N	\N	2026-05-02 12:56:01	2026-05-02 13:08:12
\.


--
-- Data for Name: referrals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.referrals (id, referrer_id, referee_id, code, status, referrer_reward, referee_reward, rewarded_at, created_at) FROM stdin;
\.


--
-- Data for Name: refunds; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.refunds (id, order_id, payment_id, requested_by, amount, status, reason, description, evidence_urls, admin_notes, gateway_refund_id, processed_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reviews (id, order_item_id, user_id, product_id, rating, title, body, image_urls, is_anonymous, status, admin_reply, replied_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
lTJ8La1cr1Fk1IaegzBf9AKIFc5kRDCShV4gUUVE	\N	127.0.0.1	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:150.0) Gecko/20100101 Firefox/150.0	eyJfdG9rZW4iOiJRWHJvYWZJRlhhbVRMeldlNkdZS3RFQ1pURHpSY2RrcmlHM0xTeUM1IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19	1777756158
IRuvRIf8joeC3SRshBlYTBdotDCNmnXmi8cSPa5v	\N	127.0.0.1	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:150.0) Gecko/20100101 Firefox/150.0	eyJfdG9rZW4iOiJlRHFlZW1JRkYwNkZYTnR3VGpsU0lIaUQ5NUQ5TjJXWktRUEs1TU53IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19	1777970611
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.settings (id, key, value, type, "group", label, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: shipments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipments (id, order_id, courier_code, courier_service, tracking_number, status, tracking_history, shipper_name, shipper_address, picked_up_at, delivered_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: site_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.site_settings (id, key, value, is_encrypted, created_at, updated_at) FROM stdin;
4	midtrans_is_production		f	2026-05-03 09:35:33	2026-05-03 09:35:33
5	rajaongkir_is_production		f	2026-05-03 09:35:33	2026-05-03 09:35:33
6	shipping_origin_city	Jakarta Pusat	f	2026-05-03 09:47:24	2026-05-03 09:47:24
1	midtrans_server_key	eyJpdiI6InFqMThtL1hHKytHK0tDT3ZuNVlrZ0E9PSIsInZhbHVlIjoiS0xQeEwzVWUyUGJvYVVTR09UTmR5Yk9rbEM4bVcraHg3TTd0aUNRZVc1V1ZONGMreTdCYWRTK3kxY3RzM2tmUyIsIm1hYyI6Ijc1NDhkMDEwMDBlNTFjZjFhYzgxNTJhODNiOTYwNzljYjA1ZTk2Yjc2NTNkZDc2ZmMzZWE5MmQwYWJiNjA3NDUiLCJ0YWciOiIifQ==	t	2026-05-03 09:35:33	2026-05-03 09:59:16
2	midtrans_client_key	eyJpdiI6IkFaYVNBRlVLd2F3WjhzODJBcXJGK1E9PSIsInZhbHVlIjoiMU9Zb1M3MHIyTFIyaHlmQ2hvc043cnI4clFQbXA5TjJYNzlicWhjNVprRStLOE1Qb0ljTUEyRUx3d3hIdWNJSiIsIm1hYyI6ImM1MzJhMjJmYWIxMzNjMTg4M2FiMjhmMTNkZDM0ODlhY2QzNzNjNjc4OTQyMjA0NmRlZGFhZTI2Zjk2MjY4YzAiLCJ0YWciOiIifQ==	t	2026-05-03 09:35:33	2026-05-03 09:59:16
3	rajaongkir_api_key	eyJpdiI6IkpIMXYxVmk3SG9lQTVTOHcxTkRvMFE9PSIsInZhbHVlIjoiZjBmSVlYeEFtVkFmcjJ6NDNBQ2ZSVWNRTEMrMXhUTE1qeGd2NkJCMXZsVCtKVzBQczh4V2dsQUQybnNoNHZ0bSIsIm1hYyI6ImZlODNlZWFlYTQ0MDhmNzZhNzE3N2U5MTMwNDYwYTMxMThhOGFhMzg3MWQwNGNhNjJlZDI5MDY2ZGMxYmViOGYiLCJ0YWciOiIifQ==	t	2026-05-03 09:35:33	2026-05-03 09:59:16
\.


--
-- Data for Name: stock_ledger; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.stock_ledger (id, variant_id, quantity_change, stock_after, reason, reference_type, reference_id, actor_id, created_at) FROM stdin;
\.


--
-- Data for Name: user_addresses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_addresses (id, user_id, label, recipient_name, phone, address_line, province, city, district, village, postal_code, latitude, longitude, is_default, created_at, updated_at) FROM stdin;
019dea72-0870-72d8-b4b0-0d89a90b3cea	019de8c2-9d00-7387-846d-fc9555495464	Kost	Valen	082253400079	Lingkat UTY Barat	Special Region of Yogyakarta	Sleman Regency	Sleman Regency		55291	-7.7495051	110.3530694	f	2026-05-02 20:47:15	2026-05-02 20:47:15
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at, phone, avatar_url, role, status, last_login_at) FROM stdin;
019de8c2-9b4c-70db-8171-1fe8a822ae66	Super Admin	superadmin@app.com	\N	$2y$12$P2AQbkBgxX1/KJiohOM.c.YygZ6U.VA.NX9t.uIYhtjCeJkB2bzcy	\N	2026-05-02 12:56:01	2026-05-02 12:56:01	\N	\N	super_admin	active	\N
019de8c2-9c25-70d0-a8dd-23b434a6db01	Admin	admin@app.com	\N	$2y$12$GxPECsF3uN7cnyRynyJRsO31k.Hjk7f6m4Mp4favaVF6vzw6xLiai	\N	2026-05-02 12:56:01	2026-05-02 12:56:01	\N	\N	admin	active	\N
019de8c2-9d00-7387-846d-fc9555495464	Customer	user@app.com	\N	$2y$12$KxULVffWfeOgJ5oqoBiYOuDclvlBnkDiiuwrGWMTLexk0zGn0YJ5K	\N	2026-05-02 12:56:01	2026-05-02 12:56:01	\N	\N	customer	active	\N
\.


--
-- Data for Name: voucher_usages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.voucher_usages (id, voucher_id, user_id, order_id, discount_applied, created_at) FROM stdin;
\.


--
-- Data for Name: vouchers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.vouchers (id, code, name, type, discount_type, discount_value, min_purchase, max_discount, is_free_shipping, usage_limit, usage_count, usage_limit_per_user, applies_to_all, starts_at, expires_at, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: wallet_transactions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.wallet_transactions (id, wallet_id, type, amount, balance_after, description, reference_type, reference_id, status, created_at) FROM stdin;
\.


--
-- Data for Name: wallets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.wallets (id, user_id, balance, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: wishlists; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.wishlists (id, user_id, product_id, variant_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: banners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.banners_id_seq', 2, true);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.migrations_id_seq', 29, true);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 7, true);


--
-- Name: site_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.site_settings_id_seq', 6, true);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: banners banners_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.banners
    ADD CONSTRAINT banners_pkey PRIMARY KEY (id);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: cart_items cart_items_cart_id_variant_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_cart_id_variant_id_unique UNIQUE (cart_id, variant_id);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categories categories_slug_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_slug_unique UNIQUE (slug);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: flash_sale_items flash_sale_items_flash_sale_id_variant_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flash_sale_items
    ADD CONSTRAINT flash_sale_items_flash_sale_id_variant_id_unique UNIQUE (flash_sale_id, variant_id);


--
-- Name: flash_sale_items flash_sale_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flash_sale_items
    ADD CONSTRAINT flash_sale_items_pkey PRIMARY KEY (id);


--
-- Name: flash_sales flash_sales_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flash_sales
    ADD CONSTRAINT flash_sales_pkey PRIMARY KEY (id);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: loyalty_points loyalty_points_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.loyalty_points
    ADD CONSTRAINT loyalty_points_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: oauth_providers oauth_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_providers
    ADD CONSTRAINT oauth_providers_pkey PRIMARY KEY (id);


--
-- Name: oauth_providers oauth_providers_provider_provider_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_providers
    ADD CONSTRAINT oauth_providers_provider_provider_id_unique UNIQUE (provider, provider_id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_order_number_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_order_number_unique UNIQUE (order_number);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: pages pages_slug_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_slug_unique UNIQUE (slug);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: password_resets password_resets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_resets
    ADD CONSTRAINT password_resets_pkey PRIMARY KEY (id);


--
-- Name: password_resets password_resets_token_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_resets
    ADD CONSTRAINT password_resets_token_unique UNIQUE (token);


--
-- Name: payments payments_gateway_transaction_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_gateway_transaction_id_unique UNIQUE (gateway_transaction_id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: product_attribute_values product_attribute_values_attribute_id_value_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_attribute_values
    ADD CONSTRAINT product_attribute_values_attribute_id_value_unique UNIQUE (attribute_id, value);


--
-- Name: product_attribute_values product_attribute_values_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_attribute_values
    ADD CONSTRAINT product_attribute_values_pkey PRIMARY KEY (id);


--
-- Name: product_attributes product_attributes_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_attributes
    ADD CONSTRAINT product_attributes_name_unique UNIQUE (name);


--
-- Name: product_attributes product_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_attributes
    ADD CONSTRAINT product_attributes_pkey PRIMARY KEY (id);


--
-- Name: product_images product_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT product_images_pkey PRIMARY KEY (id);


--
-- Name: product_variant_attributes product_variant_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variant_attributes
    ADD CONSTRAINT product_variant_attributes_pkey PRIMARY KEY (variant_id, attribute_value_id);


--
-- Name: product_variants product_variants_barcode_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_barcode_unique UNIQUE (barcode);


--
-- Name: product_variants product_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_pkey PRIMARY KEY (id);


--
-- Name: product_variants product_variants_sku_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_sku_unique UNIQUE (sku);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: products products_slug_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_slug_unique UNIQUE (slug);


--
-- Name: referrals referrals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_pkey PRIMARY KEY (id);


--
-- Name: referrals referrals_referee_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_referee_id_unique UNIQUE (referee_id);


--
-- Name: refunds refunds_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refunds
    ADD CONSTRAINT refunds_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_order_item_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_order_item_id_unique UNIQUE (order_item_id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: settings settings_key_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_key_unique UNIQUE (key);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: shipments shipments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_pkey PRIMARY KEY (id);


--
-- Name: site_settings site_settings_key_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_settings
    ADD CONSTRAINT site_settings_key_unique UNIQUE (key);


--
-- Name: site_settings site_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_settings
    ADD CONSTRAINT site_settings_pkey PRIMARY KEY (id);


--
-- Name: stock_ledger stock_ledger_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_ledger
    ADD CONSTRAINT stock_ledger_pkey PRIMARY KEY (id);


--
-- Name: user_addresses user_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_addresses
    ADD CONSTRAINT user_addresses_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_phone_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_unique UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: voucher_usages voucher_usages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.voucher_usages
    ADD CONSTRAINT voucher_usages_pkey PRIMARY KEY (id);


--
-- Name: vouchers vouchers_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vouchers
    ADD CONSTRAINT vouchers_code_unique UNIQUE (code);


--
-- Name: vouchers vouchers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vouchers
    ADD CONSTRAINT vouchers_pkey PRIMARY KEY (id);


--
-- Name: wallet_transactions wallet_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT wallet_transactions_pkey PRIMARY KEY (id);


--
-- Name: wallets wallets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_pkey PRIMARY KEY (id);


--
-- Name: wallets wallets_user_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_user_id_unique UNIQUE (user_id);


--
-- Name: wishlists wishlists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT wishlists_pkey PRIMARY KEY (id);


--
-- Name: wishlists wishlists_user_id_product_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT wishlists_user_id_product_id_unique UNIQUE (user_id, product_id);


--
-- Name: audit_logs_auditable_type_auditable_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX audit_logs_auditable_type_auditable_id_index ON public.audit_logs USING btree (auditable_type, auditable_id);


--
-- Name: audit_logs_created_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX audit_logs_created_at_index ON public.audit_logs USING btree (created_at);


--
-- Name: audit_logs_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX audit_logs_user_id_index ON public.audit_logs USING btree (user_id);


--
-- Name: cache_expiration_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cache_expiration_index ON public.cache USING btree (expiration);


--
-- Name: cache_locks_expiration_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cache_locks_expiration_index ON public.cache_locks USING btree (expiration);


--
-- Name: cart_items_cart_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cart_items_cart_id_index ON public.cart_items USING btree (cart_id);


--
-- Name: carts_session_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX carts_session_id_index ON public.carts USING btree (session_id);


--
-- Name: carts_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX carts_user_id_index ON public.carts USING btree (user_id);


--
-- Name: categories_is_active_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX categories_is_active_index ON public.categories USING btree (is_active);


--
-- Name: categories_parent_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX categories_parent_id_index ON public.categories USING btree (parent_id);


--
-- Name: categories_slug_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX categories_slug_index ON public.categories USING btree (slug);


--
-- Name: flash_sales_is_active_starts_at_ends_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX flash_sales_is_active_starts_at_ends_at_index ON public.flash_sales USING btree (is_active, starts_at, ends_at);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: loyalty_points_reference_type_reference_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX loyalty_points_reference_type_reference_id_index ON public.loyalty_points USING btree (reference_type, reference_id);


--
-- Name: loyalty_points_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX loyalty_points_user_id_index ON public.loyalty_points USING btree (user_id);


--
-- Name: notifications_created_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notifications_created_at_index ON public.notifications USING btree (created_at);


--
-- Name: notifications_user_id_read_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notifications_user_id_read_at_index ON public.notifications USING btree (user_id, read_at);


--
-- Name: oauth_providers_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX oauth_providers_user_id_index ON public.oauth_providers USING btree (user_id);


--
-- Name: order_items_order_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_items_order_id_index ON public.order_items USING btree (order_id);


--
-- Name: order_items_variant_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_items_variant_id_index ON public.order_items USING btree (variant_id);


--
-- Name: orders_created_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_created_at_index ON public.orders USING btree (created_at);


--
-- Name: orders_order_number_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_order_number_index ON public.orders USING btree (order_number);


--
-- Name: orders_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_status_index ON public.orders USING btree (status);


--
-- Name: orders_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_user_id_index ON public.orders USING btree (user_id);


--
-- Name: password_resets_token_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX password_resets_token_index ON public.password_resets USING btree (token);


--
-- Name: password_resets_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX password_resets_user_id_index ON public.password_resets USING btree (user_id);


--
-- Name: payments_gateway_transaction_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payments_gateway_transaction_id_index ON public.payments USING btree (gateway_transaction_id);


--
-- Name: payments_order_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payments_order_id_index ON public.payments USING btree (order_id);


--
-- Name: payments_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payments_status_index ON public.payments USING btree (status);


--
-- Name: personal_access_tokens_expires_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX personal_access_tokens_expires_at_index ON public.personal_access_tokens USING btree (expires_at);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: product_attribute_values_attribute_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_attribute_values_attribute_id_index ON public.product_attribute_values USING btree (attribute_id);


--
-- Name: product_images_product_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_images_product_id_index ON public.product_images USING btree (product_id);


--
-- Name: product_images_product_id_is_primary_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_images_product_id_is_primary_index ON public.product_images USING btree (product_id, is_primary);


--
-- Name: product_variants_product_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_variants_product_id_index ON public.product_variants USING btree (product_id);


--
-- Name: product_variants_product_id_is_active_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_variants_product_id_is_active_index ON public.product_variants USING btree (product_id, is_active);


--
-- Name: product_variants_sku_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_variants_sku_index ON public.product_variants USING btree (sku);


--
-- Name: product_variants_stock_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_variants_stock_index ON public.product_variants USING btree (stock);


--
-- Name: products_category_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_category_id_index ON public.products USING btree (category_id);


--
-- Name: products_is_featured_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_is_featured_index ON public.products USING btree (is_featured);


--
-- Name: products_slug_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_slug_index ON public.products USING btree (slug);


--
-- Name: products_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_status_index ON public.products USING btree (status);


--
-- Name: products_status_is_featured_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_status_is_featured_index ON public.products USING btree (status, is_featured);


--
-- Name: referrals_referrer_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX referrals_referrer_id_index ON public.referrals USING btree (referrer_id);


--
-- Name: refunds_order_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX refunds_order_id_index ON public.refunds USING btree (order_id);


--
-- Name: refunds_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX refunds_status_index ON public.refunds USING btree (status);


--
-- Name: reviews_product_id_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reviews_product_id_status_index ON public.reviews USING btree (product_id, status);


--
-- Name: reviews_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reviews_user_id_index ON public.reviews USING btree (user_id);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: settings_group_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX settings_group_index ON public.settings USING btree ("group");


--
-- Name: shipments_order_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX shipments_order_id_index ON public.shipments USING btree (order_id);


--
-- Name: shipments_tracking_number_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX shipments_tracking_number_index ON public.shipments USING btree (tracking_number);


--
-- Name: stock_ledger_created_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX stock_ledger_created_at_index ON public.stock_ledger USING btree (created_at);


--
-- Name: stock_ledger_reference_type_reference_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX stock_ledger_reference_type_reference_id_index ON public.stock_ledger USING btree (reference_type, reference_id);


--
-- Name: stock_ledger_variant_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX stock_ledger_variant_id_index ON public.stock_ledger USING btree (variant_id);


--
-- Name: user_addresses_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_addresses_user_id_index ON public.user_addresses USING btree (user_id);


--
-- Name: user_addresses_user_id_is_default_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_addresses_user_id_is_default_index ON public.user_addresses USING btree (user_id, is_default);


--
-- Name: voucher_usages_voucher_id_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX voucher_usages_voucher_id_user_id_index ON public.voucher_usages USING btree (voucher_id, user_id);


--
-- Name: vouchers_code_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX vouchers_code_index ON public.vouchers USING btree (code);


--
-- Name: vouchers_is_active_starts_at_expires_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX vouchers_is_active_starts_at_expires_at_index ON public.vouchers USING btree (is_active, starts_at, expires_at);


--
-- Name: wallet_transactions_reference_type_reference_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX wallet_transactions_reference_type_reference_id_index ON public.wallet_transactions USING btree (reference_type, reference_id);


--
-- Name: wallet_transactions_wallet_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX wallet_transactions_wallet_id_index ON public.wallet_transactions USING btree (wallet_id);


--
-- Name: wishlists_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX wishlists_user_id_index ON public.wishlists USING btree (user_id);


--
-- Name: audit_logs audit_logs_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: cart_items cart_items_cart_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_cart_id_foreign FOREIGN KEY (cart_id) REFERENCES public.carts(id) ON DELETE CASCADE;


--
-- Name: cart_items cart_items_variant_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_variant_id_foreign FOREIGN KEY (variant_id) REFERENCES public.product_variants(id) ON DELETE CASCADE;


--
-- Name: carts carts_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: categories categories_parent_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_parent_id_foreign FOREIGN KEY (parent_id) REFERENCES public.categories(id) ON DELETE SET NULL;


--
-- Name: flash_sale_items flash_sale_items_flash_sale_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flash_sale_items
    ADD CONSTRAINT flash_sale_items_flash_sale_id_foreign FOREIGN KEY (flash_sale_id) REFERENCES public.flash_sales(id) ON DELETE CASCADE;


--
-- Name: flash_sale_items flash_sale_items_variant_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flash_sale_items
    ADD CONSTRAINT flash_sale_items_variant_id_foreign FOREIGN KEY (variant_id) REFERENCES public.product_variants(id) ON DELETE CASCADE;


--
-- Name: loyalty_points loyalty_points_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.loyalty_points
    ADD CONSTRAINT loyalty_points_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: notifications notifications_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: oauth_providers oauth_providers_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_providers
    ADD CONSTRAINT oauth_providers_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_variant_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_variant_id_foreign FOREIGN KEY (variant_id) REFERENCES public.product_variants(id) ON DELETE SET NULL;


--
-- Name: orders orders_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: orders orders_voucher_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_voucher_id_foreign FOREIGN KEY (voucher_id) REFERENCES public.vouchers(id) ON DELETE SET NULL;


--
-- Name: password_resets password_resets_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_resets
    ADD CONSTRAINT password_resets_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: payments payments_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: product_attribute_values product_attribute_values_attribute_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_attribute_values
    ADD CONSTRAINT product_attribute_values_attribute_id_foreign FOREIGN KEY (attribute_id) REFERENCES public.product_attributes(id) ON DELETE CASCADE;


--
-- Name: product_images product_images_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT product_images_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: product_images product_images_variant_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT product_images_variant_id_foreign FOREIGN KEY (variant_id) REFERENCES public.product_variants(id) ON DELETE CASCADE;


--
-- Name: product_variant_attributes product_variant_attributes_attribute_value_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variant_attributes
    ADD CONSTRAINT product_variant_attributes_attribute_value_id_foreign FOREIGN KEY (attribute_value_id) REFERENCES public.product_attribute_values(id) ON DELETE CASCADE;


--
-- Name: product_variant_attributes product_variant_attributes_variant_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variant_attributes
    ADD CONSTRAINT product_variant_attributes_variant_id_foreign FOREIGN KEY (variant_id) REFERENCES public.product_variants(id) ON DELETE CASCADE;


--
-- Name: product_variants product_variants_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: products products_category_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_foreign FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE RESTRICT;


--
-- Name: referrals referrals_referee_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_referee_id_foreign FOREIGN KEY (referee_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: referrals referrals_referrer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_referrer_id_foreign FOREIGN KEY (referrer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: refunds refunds_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refunds
    ADD CONSTRAINT refunds_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: refunds refunds_payment_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refunds
    ADD CONSTRAINT refunds_payment_id_foreign FOREIGN KEY (payment_id) REFERENCES public.payments(id) ON DELETE CASCADE;


--
-- Name: refunds refunds_requested_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refunds
    ADD CONSTRAINT refunds_requested_by_foreign FOREIGN KEY (requested_by) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: reviews reviews_order_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_order_item_id_foreign FOREIGN KEY (order_item_id) REFERENCES public.order_items(id) ON DELETE CASCADE;


--
-- Name: reviews reviews_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: reviews reviews_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: shipments shipments_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: stock_ledger stock_ledger_actor_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_ledger
    ADD CONSTRAINT stock_ledger_actor_id_foreign FOREIGN KEY (actor_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: stock_ledger stock_ledger_variant_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_ledger
    ADD CONSTRAINT stock_ledger_variant_id_foreign FOREIGN KEY (variant_id) REFERENCES public.product_variants(id) ON DELETE CASCADE;


--
-- Name: user_addresses user_addresses_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_addresses
    ADD CONSTRAINT user_addresses_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: voucher_usages voucher_usages_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.voucher_usages
    ADD CONSTRAINT voucher_usages_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: voucher_usages voucher_usages_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.voucher_usages
    ADD CONSTRAINT voucher_usages_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: voucher_usages voucher_usages_voucher_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.voucher_usages
    ADD CONSTRAINT voucher_usages_voucher_id_foreign FOREIGN KEY (voucher_id) REFERENCES public.vouchers(id) ON DELETE CASCADE;


--
-- Name: wallet_transactions wallet_transactions_wallet_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT wallet_transactions_wallet_id_foreign FOREIGN KEY (wallet_id) REFERENCES public.wallets(id) ON DELETE CASCADE;


--
-- Name: wallets wallets_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: wishlists wishlists_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT wishlists_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: wishlists wishlists_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT wishlists_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: wishlists wishlists_variant_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT wishlists_variant_id_foreign FOREIGN KEY (variant_id) REFERENCES public.product_variants(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict 5bZTavnoQQtzW2GQn4xJitJXRoEhc2jwaai4NZXkM0AgQ7hH33iFHVBQ7RscVMh

