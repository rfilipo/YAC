    --
    -- YAC cms
    -- Tabelas: user, stack e stack_user
    --
    PRAGMA foreign_keys = ON;
    DROP TABLE IF EXISTS settings;
    CREATE TABLE settings (
            id           INTEGER PRIMARY KEY,
            nome         VARCHAR (255),
            url          VARCHAR (255),
            template     VARCHAR (255),
            data         DATE
    );

    -- stack_id aponta o stack pai ou 0 se stack raiz
    DROP TABLE IF EXISTS stack;
    CREATE TABLE stack (
            id           INTEGER PRIMARY KEY,
            tipo         VARCHAR (255),
            url          VARCHAR (255),
            titulo       VARCHAR (255),
            content      TEXT
    );
    -- 'substack' tabela relacionamento muitos-muitos entre stacks
    DROP TABLE IF EXISTS substack;
    CREATE TABLE substack (
            stack_id  INTEGER REFERENCES stack(id),
            id  INTEGER REFERENCES stack(id),
            PRIMARY KEY (id, stack_id)
    );

    -- 'stack_user' tabela relacionamento muitos-muitos entre stacks e user
    DROP TABLE IF EXISTS stack_user;
    CREATE TABLE stack_user (
            stack_id  INTEGER REFERENCES stack(id) ON DELETE CASCADE ON UPDATE CASCADE,
            user_id   INTEGER REFERENCES user(id)  ON DELETE CASCADE ON UPDATE CASCADE,
            PRIMARY KEY (stack_id, user_id)
    );
    DROP TABLE IF EXISTS user;
    CREATE TABLE user (
            id          INTEGER PRIMARY KEY,
            first_name      TEXT,
            last_name       TEXT,
            username        TEXT,
            email_address   TEXT,
            password        TEXT,
            active          INTEGER
    );
    DROP TABLE IF EXISTS role;
    CREATE TABLE role (
            id   INTEGER PRIMARY KEY,
            role TEXT
    );
    DROP TABLE IF EXISTS user_role;
    CREATE TABLE user_role (
            user_id INTEGER REFERENCES user(id) ON DELETE CASCADE ON UPDATE CASCADE,
            role_id INTEGER REFERENCES role(id) ON DELETE CASCADE ON UPDATE CASCADE,
            PRIMARY KEY (user_id, role_id)
    );


    ---
    --- Dados de exemplo
    ---

    -- Settings

    INSERT INTO settings VALUES (1, 'YAC', 'http://www.kobkob.com.br', 'YAC', 2011-01-02);

    -- Stacks

    INSERT INTO stack VALUES (1, 'html', 'index', 'YAC', '<h1>YAC</h1>');
    INSERT INTO stack VALUES (2, 'css', 'bg_yac', 'YAC', 'body { background-image:url("/static/images/yeast.jpg"); }');
    INSERT INTO stack VALUES (3, 'html', 'admin', 'YAC', '<li><a href="/admin">Administrar</a>');
    INSERT INTO stack VALUES (4, 'html', 'home_edit', 'YAC', '<li><a href="/edit">Editar</a>');
    INSERT INTO stack VALUES (5, 'html', 'home_hack', 'YAC', '<li><a href="/hack">Programar</a>');
    INSERT INTO stack VALUES (6, 'html', 'teste1', 'TESTE YAC', '<h1>YAC TESTS</h1>');
    INSERT INTO stack VALUES (7, 'html', 'teste1_1', 'SUB T Yac', '<h2>Test 1</h2>');
    INSERT INTO stack VALUES (8, 'html', 'home_submenu1', 'SUB 1 Yac', '<p><a href="/">YAC</a>');
    INSERT INTO stack VALUES (9, 'html', 'home_submenu2', 'SUB 2 Yac', '<p><a href="/">YAC</a>');
    INSERT INTO stack VALUES (10,'html', 'home_submenu3', 'SUB 3 Yac', '<p><a href="/">YAC</a>');
    INSERT INTO stack VALUES (11,'js'  , 'welcome_alert'  , 'YAC', 'alert("Welcome to YAC!!!")');

    INSERT INTO substack VALUES (2, 1) ;
    INSERT INTO substack VALUES (3, 1) ;
    INSERT INTO substack VALUES (4, 1) ;
    INSERT INTO substack VALUES (5, 1) ;
    INSERT INTO substack VALUES (6, 0) ;
    INSERT INTO substack VALUES (7, 6) ;
    INSERT INTO substack VALUES (8, 4) ;
    INSERT INTO substack VALUES (9, 4) ;
    INSERT INTO substack VALUES (10, 3);
    INSERT INTO substack VALUES (11, 1);

-- Users

    INSERT INTO user VALUES (1, 'Greg', 'Bastien',     'greg@cpan.org',        'greg@cpan.org',        'novasenha', 1);
    INSERT INTO user VALUES (2, 'Sara', 'Nasseh',      'sara@pan.org',         'sara@pan.org',         'novasenha', 1);
    INSERT INTO user VALUES (3, 'Christian', 'Degu',   'degu@cpan.org',        'degu@cpan.org',        'novasenha', 1);
    INSERT INTO user VALUES (4, 'Richard', 'Stevens',  'stev@cpan.org',        'stev@cpan.org',        'novasenha', 1);
    INSERT INTO user VALUES (5, 'Douglas', 'Comer',    'comer@gmail.com',      'comer@gmail.com',      'novasenha', 2);
    INSERT INTO user VALUES (9, 'Ricardo', 'Filipo',   'filipo@kobkob.com.br', 'filipo@kobkob.com.br', 'novasenha',3);

    INSERT INTO role VALUES (1, 'user');
    INSERT INTO role VALUES (2, 'admin');
    INSERT INTO user_role VALUES (9, 2);
    INSERT INTO user_role VALUES (1, 1);
    INSERT INTO user_role VALUES (2, 1);
    INSERT INTO user_role VALUES (3, 1);
    INSERT INTO user_role VALUES (4, 1);
    INSERT INTO user_role VALUES (5, 1);
    INSERT INTO user_role VALUES (9, 1);

-- Stack Users

    INSERT INTO stack_user VALUES (1, 1);
    INSERT INTO stack_user VALUES (1, 2);
    INSERT INTO stack_user VALUES (1, 3);
    INSERT INTO stack_user VALUES (2, 4);
    INSERT INTO stack_user VALUES (3, 5);
    INSERT INTO stack_user VALUES (4, 6);
    INSERT INTO stack_user VALUES (4, 7);
    INSERT INTO stack_user VALUES (5, 8);
    INSERT INTO stack_user VALUES (6, 8);
    INSERT INTO stack_user VALUES (7, 8);


