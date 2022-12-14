PGDMP     6                     z            postgres    14.5    14.4 f               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    14021    postgres    DATABASE     ]   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';
    DROP DATABASE postgres;
                postgres    false            ?           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3714                        2615    16386 	   test_task    SCHEMA        CREATE SCHEMA test_task;
    DROP SCHEMA test_task;
                postgres    false            ?            1259    16559    accounts    TABLE     ?   CREATE TABLE public.accounts (
    account_id integer NOT NULL,
    balance bigint DEFAULT 0 NOT NULL,
    user_id integer NOT NULL
);
    DROP TABLE public.accounts;
       public         heap    postgres    false            ?            1259    16490    products    TABLE     ?   CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    definition text,
    price bigint DEFAULT 0 NOT NULL
);
    DROP TABLE public.products;
       public         heap    postgres    false            ?            1259    16489    products_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.products_id_seq;
       public          postgres    false    226            ?           0    0    products_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;
          public          postgres    false    225            ?            1259    16516    roles    TABLE     `   CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);
    DROP TABLE public.roles;
       public         heap    postgres    false            ?            1259    16515    roles_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.roles_id_seq;
       public          postgres    false    228            ?           0    0    roles_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;
          public          postgres    false    227            ?            1259    16570    transactions    TABLE     ?   CREATE TABLE public.transactions (
    id integer NOT NULL,
    transaction_timestamp timestamp(3) with time zone NOT NULL,
    amount bigint NOT NULL,
    account_id integer NOT NULL
);
     DROP TABLE public.transactions;
       public         heap    postgres    false            ?            1259    16480    users    TABLE     ?   CREATE TABLE public.users (
    id integer NOT NULL,
    login character varying(50) NOT NULL,
    password character varying(256) NOT NULL,
    active boolean DEFAULT false NOT NULL,
    activate_hash character varying
);
    DROP TABLE public.users;
       public         heap    postgres    false            ?            1259    16479    users_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    224            ?           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    223            ?            1259    16526    users_roles    TABLE     `   CREATE TABLE public.users_roles (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);
    DROP TABLE public.users_roles;
       public         heap    postgres    false            ?            1259    16525    users_roles_role_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.users_roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.users_roles_role_id_seq;
       public          postgres    false    231            ?           0    0    users_roles_role_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.users_roles_role_id_seq OWNED BY public.users_roles.role_id;
          public          postgres    false    230            ?            1259    16524    users_roles_user_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.users_roles_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.users_roles_user_id_seq;
       public          postgres    false    231            ?           0    0    users_roles_user_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.users_roles_user_id_seq OWNED BY public.users_roles.user_id;
          public          postgres    false    229            ?            1259    16426    account    TABLE     ?   CREATE TABLE test_task.account (
    account_id uuid NOT NULL,
    balance bigint DEFAULT 0 NOT NULL,
    user_id integer NOT NULL
);
    DROP TABLE test_task.account;
    	   test_task         heap    postgres    false    4            ?            1259    16425    account_user_id_seq    SEQUENCE     ?   CREATE SEQUENCE test_task.account_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE test_task.account_user_id_seq;
    	   test_task          postgres    false    215    4            ?           0    0    account_user_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE test_task.account_user_id_seq OWNED BY test_task.account.user_id;
       	   test_task          postgres    false    214            ?            1259    16416    products    TABLE     ?   CREATE TABLE test_task.products (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    definition text,
    price bigint DEFAULT 0 NOT NULL
);
    DROP TABLE test_task.products;
    	   test_task         heap    postgres    false    4            ?            1259    16415    products_id_seq    SEQUENCE     ?   CREATE SEQUENCE test_task.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE test_task.products_id_seq;
    	   test_task          postgres    false    213    4            ?           0    0    products_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE test_task.products_id_seq OWNED BY test_task.products.id;
       	   test_task          postgres    false    212            ?            1259    16442    roles    TABLE     c   CREATE TABLE test_task.roles (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);
    DROP TABLE test_task.roles;
    	   test_task         heap    postgres    false    4            ?            1259    16441    roles_id_seq    SEQUENCE     ?   CREATE SEQUENCE test_task.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE test_task.roles_id_seq;
    	   test_task          postgres    false    4    219            ?           0    0    roles_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE test_task.roles_id_seq OWNED BY test_task.roles.id;
       	   test_task          postgres    false    218            ?            1259    16434    transactions    TABLE     ?   CREATE TABLE test_task.transactions (
    id integer NOT NULL,
    transaction_timestamp time(3) with time zone DEFAULT clock_timestamp(),
    amount bigint NOT NULL,
    account_id uuid NOT NULL
);
 #   DROP TABLE test_task.transactions;
    	   test_task         heap    postgres    false    4            ?            1259    16433    transactions_id_seq    SEQUENCE     ?   CREATE SEQUENCE test_task.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE test_task.transactions_id_seq;
    	   test_task          postgres    false    217    4            ?           0    0    transactions_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE test_task.transactions_id_seq OWNED BY test_task.transactions.id;
       	   test_task          postgres    false    216            ?            1259    16406    users    TABLE     ?   CREATE TABLE test_task.users (
    id integer NOT NULL,
    login character varying(50) NOT NULL,
    password character varying(50) NOT NULL,
    active boolean DEFAULT false NOT NULL
);
    DROP TABLE test_task.users;
    	   test_task         heap    postgres    false    4            ?            1259    16405    users_id_seq    SEQUENCE     ?   CREATE SEQUENCE test_task.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE test_task.users_id_seq;
    	   test_task          postgres    false    4    211            ?           0    0    users_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE test_task.users_id_seq OWNED BY test_task.users.id;
       	   test_task          postgres    false    210            ?            1259    16452    users_roles    TABLE     c   CREATE TABLE test_task.users_roles (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);
 "   DROP TABLE test_task.users_roles;
    	   test_task         heap    postgres    false    4            ?            1259    16451    users_roles_role_id_seq    SEQUENCE     ?   CREATE SEQUENCE test_task.users_roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE test_task.users_roles_role_id_seq;
    	   test_task          postgres    false    222    4            ?           0    0    users_roles_role_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE test_task.users_roles_role_id_seq OWNED BY test_task.users_roles.role_id;
       	   test_task          postgres    false    221            ?            1259    16450    users_roles_user_id_seq    SEQUENCE     ?   CREATE SEQUENCE test_task.users_roles_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE test_task.users_roles_user_id_seq;
    	   test_task          postgres    false    222    4            ?           0    0    users_roles_user_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE test_task.users_roles_user_id_seq OWNED BY test_task.users_roles.user_id;
       	   test_task          postgres    false    220            ?           2604    16493    products id    DEFAULT     j   ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);
 :   ALTER TABLE public.products ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225    226            ?           2604    16519    roles id    DEFAULT     d   ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
 7   ALTER TABLE public.roles ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    228    228            ?           2604    16483    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223    224            ?           2604    16529    users_roles user_id    DEFAULT     z   ALTER TABLE ONLY public.users_roles ALTER COLUMN user_id SET DEFAULT nextval('public.users_roles_user_id_seq'::regclass);
 B   ALTER TABLE public.users_roles ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    229    231    231            ?           2604    16530    users_roles role_id    DEFAULT     z   ALTER TABLE ONLY public.users_roles ALTER COLUMN role_id SET DEFAULT nextval('public.users_roles_role_id_seq'::regclass);
 B   ALTER TABLE public.users_roles ALTER COLUMN role_id DROP DEFAULT;
       public          postgres    false    230    231    231            ?           2604    16430    account user_id    DEFAULT     x   ALTER TABLE ONLY test_task.account ALTER COLUMN user_id SET DEFAULT nextval('test_task.account_user_id_seq'::regclass);
 A   ALTER TABLE test_task.account ALTER COLUMN user_id DROP DEFAULT;
    	   test_task          postgres    false    215    214    215            ?           2604    16419    products id    DEFAULT     p   ALTER TABLE ONLY test_task.products ALTER COLUMN id SET DEFAULT nextval('test_task.products_id_seq'::regclass);
 =   ALTER TABLE test_task.products ALTER COLUMN id DROP DEFAULT;
    	   test_task          postgres    false    213    212    213            ?           2604    16445    roles id    DEFAULT     j   ALTER TABLE ONLY test_task.roles ALTER COLUMN id SET DEFAULT nextval('test_task.roles_id_seq'::regclass);
 :   ALTER TABLE test_task.roles ALTER COLUMN id DROP DEFAULT;
    	   test_task          postgres    false    218    219    219            ?           2604    16437    transactions id    DEFAULT     x   ALTER TABLE ONLY test_task.transactions ALTER COLUMN id SET DEFAULT nextval('test_task.transactions_id_seq'::regclass);
 A   ALTER TABLE test_task.transactions ALTER COLUMN id DROP DEFAULT;
    	   test_task          postgres    false    216    217    217            ?           2604    16409    users id    DEFAULT     j   ALTER TABLE ONLY test_task.users ALTER COLUMN id SET DEFAULT nextval('test_task.users_id_seq'::regclass);
 :   ALTER TABLE test_task.users ALTER COLUMN id DROP DEFAULT;
    	   test_task          postgres    false    211    210    211            ?           2604    16455    users_roles user_id    DEFAULT     ?   ALTER TABLE ONLY test_task.users_roles ALTER COLUMN user_id SET DEFAULT nextval('test_task.users_roles_user_id_seq'::regclass);
 E   ALTER TABLE test_task.users_roles ALTER COLUMN user_id DROP DEFAULT;
    	   test_task          postgres    false    222    220    222            ?           2604    16456    users_roles role_id    DEFAULT     ?   ALTER TABLE ONLY test_task.users_roles ALTER COLUMN role_id SET DEFAULT nextval('test_task.users_roles_role_id_seq'::regclass);
 E   ALTER TABLE test_task.users_roles ALTER COLUMN role_id DROP DEFAULT;
    	   test_task          postgres    false    221    222    222            {          0    16559    accounts 
   TABLE DATA           @   COPY public.accounts (account_id, balance, user_id) FROM stdin;
    public          postgres    false    232   ?p       u          0    16490    products 
   TABLE DATA           ?   COPY public.products (id, name, definition, price) FROM stdin;
    public          postgres    false    226   ?p       w          0    16516    roles 
   TABLE DATA           )   COPY public.roles (id, name) FROM stdin;
    public          postgres    false    228   Dq       |          0    16570    transactions 
   TABLE DATA           U   COPY public.transactions (id, transaction_timestamp, amount, account_id) FROM stdin;
    public          postgres    false    233   pq       s          0    16480    users 
   TABLE DATA           K   COPY public.users (id, login, password, active, activate_hash) FROM stdin;
    public          postgres    false    224   ?q       z          0    16526    users_roles 
   TABLE DATA           7   COPY public.users_roles (user_id, role_id) FROM stdin;
    public          postgres    false    231   7s       j          0    16426    account 
   TABLE DATA           B   COPY test_task.account (account_id, balance, user_id) FROM stdin;
 	   test_task          postgres    false    215   ]s       h          0    16416    products 
   TABLE DATA           B   COPY test_task.products (id, name, definition, price) FROM stdin;
 	   test_task          postgres    false    213   zs       n          0    16442    roles 
   TABLE DATA           ,   COPY test_task.roles (id, name) FROM stdin;
 	   test_task          postgres    false    219   ?s       l          0    16434    transactions 
   TABLE DATA           X   COPY test_task.transactions (id, transaction_timestamp, amount, account_id) FROM stdin;
 	   test_task          postgres    false    217   ?s       f          0    16406    users 
   TABLE DATA           ?   COPY test_task.users (id, login, password, active) FROM stdin;
 	   test_task          postgres    false    211   ?s       q          0    16452    users_roles 
   TABLE DATA           :   COPY test_task.users_roles (user_id, role_id) FROM stdin;
 	   test_task          postgres    false    222   ?s       ?           0    0    products_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.products_id_seq', 2, true);
          public          postgres    false    225            ?           0    0    roles_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.roles_id_seq', 1, false);
          public          postgres    false    227            ?           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 12, true);
          public          postgres    false    223            ?           0    0    users_roles_role_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.users_roles_role_id_seq', 1, false);
          public          postgres    false    230            ?           0    0    users_roles_user_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.users_roles_user_id_seq', 1, false);
          public          postgres    false    229            ?           0    0    account_user_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('test_task.account_user_id_seq', 1, false);
       	   test_task          postgres    false    214            ?           0    0    products_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('test_task.products_id_seq', 1, false);
       	   test_task          postgres    false    212            ?           0    0    roles_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('test_task.roles_id_seq', 1, false);
       	   test_task          postgres    false    218            ?           0    0    transactions_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('test_task.transactions_id_seq', 1, false);
       	   test_task          postgres    false    216            ?           0    0    users_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('test_task.users_id_seq', 1, false);
       	   test_task          postgres    false    210            ?           0    0    users_roles_role_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('test_task.users_roles_role_id_seq', 1, false);
       	   test_task          postgres    false    221            ?           0    0    users_roles_user_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('test_task.users_roles_user_id_seq', 1, false);
       	   test_task          postgres    false    220            ?           2606    16564    accounts accounts_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (account_id);
 @   ALTER TABLE ONLY public.accounts DROP CONSTRAINT accounts_pkey;
       public            postgres    false    232            ?           2606    16574    transactions id_unique 
   CONSTRAINT     O   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT id_unique UNIQUE (id);
 @   ALTER TABLE ONLY public.transactions DROP CONSTRAINT id_unique;
       public            postgres    false    233            ?           2606    16523 
   roles name 
   CONSTRAINT     E   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT name UNIQUE (name);
 4   ALTER TABLE ONLY public.roles DROP CONSTRAINT name;
       public            postgres    false    228            ?           2606    16486    users pk_id_users 
   CONSTRAINT     O   ALTER TABLE ONLY public.users
    ADD CONSTRAINT pk_id_users PRIMARY KEY (id);
 ;   ALTER TABLE ONLY public.users DROP CONSTRAINT pk_id_users;
       public            postgres    false    224            ?           2606    16498    products pk_products_id 
   CONSTRAINT     U   ALTER TABLE ONLY public.products
    ADD CONSTRAINT pk_products_id PRIMARY KEY (id);
 A   ALTER TABLE ONLY public.products DROP CONSTRAINT pk_products_id;
       public            postgres    false    226            ?           2606    16521    roles pk_roles_id 
   CONSTRAINT     O   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT pk_roles_id PRIMARY KEY (id);
 ;   ALTER TABLE ONLY public.roles DROP CONSTRAINT pk_roles_id;
       public            postgres    false    228            ?           2606    16532    users_roles pk_users_roles 
   CONSTRAINT     f   ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT pk_users_roles PRIMARY KEY (user_id, role_id);
 D   ALTER TABLE ONLY public.users_roles DROP CONSTRAINT pk_users_roles;
       public            postgres    false    231    231            ?           2606    16488    users unique_login_user 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_login_user UNIQUE (login);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT unique_login_user;
       public            postgres    false    224            ?           2606    16449 
   roles name 
   CONSTRAINT     H   ALTER TABLE ONLY test_task.roles
    ADD CONSTRAINT name UNIQUE (name);
 7   ALTER TABLE ONLY test_task.roles DROP CONSTRAINT name;
    	   test_task            postgres    false    219            ?           2606    16432    account pk_account_id 
   CONSTRAINT     ^   ALTER TABLE ONLY test_task.account
    ADD CONSTRAINT pk_account_id PRIMARY KEY (account_id);
 B   ALTER TABLE ONLY test_task.account DROP CONSTRAINT pk_account_id;
    	   test_task            postgres    false    215            ?           2606    16412    users pk_id_users 
   CONSTRAINT     R   ALTER TABLE ONLY test_task.users
    ADD CONSTRAINT pk_id_users PRIMARY KEY (id);
 >   ALTER TABLE ONLY test_task.users DROP CONSTRAINT pk_id_users;
    	   test_task            postgres    false    211            ?           2606    16424    products pk_products_id 
   CONSTRAINT     X   ALTER TABLE ONLY test_task.products
    ADD CONSTRAINT pk_products_id PRIMARY KEY (id);
 D   ALTER TABLE ONLY test_task.products DROP CONSTRAINT pk_products_id;
    	   test_task            postgres    false    213            ?           2606    16447    roles pk_roles_id 
   CONSTRAINT     R   ALTER TABLE ONLY test_task.roles
    ADD CONSTRAINT pk_roles_id PRIMARY KEY (id);
 >   ALTER TABLE ONLY test_task.roles DROP CONSTRAINT pk_roles_id;
    	   test_task            postgres    false    219            ?           2606    16440    transactions pk_transactions_id 
   CONSTRAINT     `   ALTER TABLE ONLY test_task.transactions
    ADD CONSTRAINT pk_transactions_id PRIMARY KEY (id);
 L   ALTER TABLE ONLY test_task.transactions DROP CONSTRAINT pk_transactions_id;
    	   test_task            postgres    false    217            ?           2606    16458    users_roles pk_users_roles 
   CONSTRAINT     i   ALTER TABLE ONLY test_task.users_roles
    ADD CONSTRAINT pk_users_roles PRIMARY KEY (user_id, role_id);
 G   ALTER TABLE ONLY test_task.users_roles DROP CONSTRAINT pk_users_roles;
    	   test_task            postgres    false    222    222            ?           2606    16414    users unique_login_user 
   CONSTRAINT     V   ALTER TABLE ONLY test_task.users
    ADD CONSTRAINT unique_login_user UNIQUE (login);
 D   ALTER TABLE ONLY test_task.users DROP CONSTRAINT unique_login_user;
    	   test_task            postgres    false    211            ?           2606    16575    transactions fk_account_id    FK CONSTRAINT     ?   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_account_id FOREIGN KEY (account_id) REFERENCES public.accounts(account_id);
 D   ALTER TABLE ONLY public.transactions DROP CONSTRAINT fk_account_id;
       public          postgres    false    232    233    3535            ?           2606    16548    users_roles fk_roles_id    FK CONSTRAINT     ?   ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT fk_roles_id FOREIGN KEY (role_id) REFERENCES public.roles(id) NOT VALID;
 A   ALTER TABLE ONLY public.users_roles DROP CONSTRAINT fk_roles_id;
       public          postgres    false    231    228    3531            ?           2606    16565    accounts fk_user_id    FK CONSTRAINT     r   ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(id);
 =   ALTER TABLE ONLY public.accounts DROP CONSTRAINT fk_user_id;
       public          postgres    false    3523    224    232            ?           2606    16543    users_roles fk_users_id    FK CONSTRAINT     ?   ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT fk_users_id FOREIGN KEY (user_id) REFERENCES public.users(id) NOT VALID;
 A   ALTER TABLE ONLY public.users_roles DROP CONSTRAINT fk_users_id;
       public          postgres    false    224    3523    231            ?           2606    16464    transactions fk_account_id    FK CONSTRAINT     ?   ALTER TABLE ONLY test_task.transactions
    ADD CONSTRAINT fk_account_id FOREIGN KEY (account_id) REFERENCES test_task.account(account_id) NOT VALID;
 G   ALTER TABLE ONLY test_task.transactions DROP CONSTRAINT fk_account_id;
    	   test_task          postgres    false    217    3513    215            ?           2606    16474    users_roles fk_roles_id    FK CONSTRAINT     ?   ALTER TABLE ONLY test_task.users_roles
    ADD CONSTRAINT fk_roles_id FOREIGN KEY (role_id) REFERENCES test_task.roles(id) NOT VALID;
 D   ALTER TABLE ONLY test_task.users_roles DROP CONSTRAINT fk_roles_id;
    	   test_task          postgres    false    3519    222    219            ?           2606    16459    account fk_user_id    FK CONSTRAINT     ?   ALTER TABLE ONLY test_task.account
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES test_task.users(id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;
 ?   ALTER TABLE ONLY test_task.account DROP CONSTRAINT fk_user_id;
    	   test_task          postgres    false    3507    215    211            ?           2606    16469    users_roles fk_users_id    FK CONSTRAINT     ?   ALTER TABLE ONLY test_task.users_roles
    ADD CONSTRAINT fk_users_id FOREIGN KEY (user_id) REFERENCES test_task.users(id) NOT VALID;
 D   ALTER TABLE ONLY test_task.users_roles DROP CONSTRAINT fk_users_id;
    	   test_task          postgres    false    222    211    3507            {      x?3??40?44?2?45??b???? ,?k      u   D   x?3?	????*-.Q	?4400?2?6?tO???KWH??+??I?4ɘpF8?G?K???b???? Wu?      w      x?3?,-N-?2?LL????????? :?      |   }   x?]???0??=E????dY?d?9?&(????R?ܛp??	??w?E??T??????7H?';Y??Z?2v;7,??_3.?o3R}?????
S??3/3&R5%(b??x??=?mr??A=????,z      s   *  x?5̹r?@  ???;?vK?dҀ?7????L?^?0?z7?x?	?M ?I?y?r?:?ts?XD? &?SԀ?\??e??Z?u?uD?)C?׷?!?8?+??,y???n?Q?NbK??A??:S?? ?EW???????Ty$[?I_?_k_?#eQW#ą?e|?B?~?????Aw?n?^z???ɜS@G@?隔j?n????ms??ML??X?a?A?A	v#?X?b?w?yo????????yh?4П????	?r.z?U?\bI4XY3?&d\?9???????ǲ?/Bnm?      z      x?34?4???4?????? ??      j      x?????? ? ?      h      x?????? ? ?      n      x?????? ? ?      l      x?????? ? ?      f      x?3?tLL?LJJ?,?????? $U?      q      x?????? ? ?     