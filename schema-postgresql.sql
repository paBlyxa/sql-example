DROP TABLE Incoming CASCADE;
DROP TABLE Outgoing CASCADE;
DROP TABLE Memo CASCADE;
DROP TABLE Orders CASCADE;

CREATE TABLE IF NOT EXISTS IN_TYPE (
  typeid INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE SEQUENCE IF NOT EXISTS SEQ_ID;
CREATE SEQUENCE IF NOT EXISTS SEQ_DOC_FILE_ID;

CREATE TABLE IF NOT EXISTS Department (
 departmentid INTEGER PRIMARY KEY,
 bitrixid INTEGER NOT NULL,
 name VARCHAR(255) NOT NULL,
 fullname VARCHAR(255),
 index VARCHAR(2)
);

CREATE TABLE IF NOT EXISTS Employee (
  employeeid INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  lastname VARCHAR(255),
  secondname VARCHAR(255),
  email VARCHAR(255),
  active BOOLEAN,
  admin BOOLEAN,
  executor BOOLEAN,
  coexecutor BOOLEAN,
  departmentid INTEGER NOT NULL REFERENCES Department
);

CREATE TABLE IF NOT EXISTS Company (
  companyid INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  deleted BOOLEAN
);

CREATE TABLE IF NOT EXISTS Project (
  projectid INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(1024),
  owner INTEGER REFERENCES Employee(employeeid),
  diskid INTEGER
);

CREATE TABLE IF NOT EXISTS Incoming (
  id BIGINT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  num INTEGER NOT NULL,
  index VARCHAR(10) NOT NULL,
  createdon TIMESTAMP NOT NULL,
  updatedon TIMESTAMP,
  controldate DATE,
  remind boolean,
  employeeid INTEGER NOT NULL REFERENCES Employee,
  clientid INTEGER REFERENCES Company(companyid),
  sentdate DATE NOT NULL,
  outnum VARCHAR(255),
  author VARCHAR,
  resolution VARCHAR(255),
  copy VARCHAR(255),
  status INTEGER NOT NULL,
  answer bigint,
  typeid INTEGER NOT NULL REFERENCES IN_TYPE,
  projectid INTEGER REFERENCES Project,
  comment VARCHAR(255),
  departmentid INTEGER NOT NULL REFERENCES Department,
  taskid INTEGER
);

CREATE TABLE IF NOT EXISTS Outgoing (
  id BIGINT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  num INTEGER NOT NULL,
  index VARCHAR(10) NOT NULL,
  innum VARCHAR,
  createdon TIMESTAMP NOT NULL,
  updatedon TIMESTAMP,
  employeeid INTEGER NOT NULL REFERENCES Employee,
  clientid INTEGER REFERENCES Company(companyid),
  who VARCHAR(255) NOT NULL,
  copy VARCHAR(255),
  hiddencopy VARCHAR(255),
  answer BIGINT REFERENCES Incoming(id),
  status INTEGER NOT NULL,
  projectid INTEGER REFERENCES Project,
  myself BOOLEAN,
  comment VARCHAR(255),
  departmentid INTEGER NOT NULL REFERENCES Department,
  taskid INTEGER
);

CREATE TABLE IF NOT EXISTS Orders (
  id BIGINT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  num INTEGER NOT NULL,
  index VARCHAR(10) NOT NULL,
  createdon TIMESTAMP NOT NULL,
  updatedon TIMESTAMP,
  employeeid INTEGER NOT NULL REFERENCES Employee,
  who VARCHAR(255),
  copy VARCHAR(255),
  status INTEGER NOT NULL,
  comment TEXT,
  departmentid INTEGER NOT NULL REFERENCES Department,
  localdate DATE NOT NULL,
  taskid INTEGER
);

CREATE TABLE IF NOT EXISTS Memo (
  id BIGINT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  num INTEGER NOT NULL,
  index VARCHAR(10) NOT NULL,
  createdon TIMESTAMP NOT NULL,
  updatedon TIMESTAMP,
  controldate DATE,
  employeeid INTEGER NOT NULL REFERENCES Employee,
  resolution VARCHAR(255),
  status INTEGER NOT NULL,
  comment VARCHAR(255),
  departmentid INTEGER NOT NULL REFERENCES Department,
  taskid INTEGER
);

CREATE TABLE IF NOT EXISTS Trust (
  id BIGINT PRIMARY KEY,
  name TEXT NOT NULL,
  num INTEGER NOT NULL,
  index VARCHAR(10) NOT NULL,
  createdon TIMESTAMP NOT NULL,
  updatedon TIMESTAMP,
  localdate DATE NOT NULL,
  expirationdate DATE,
  employeeid INTEGER NOT NULL REFERENCES Employee,
  departmentid INTEGER REFERENCES Department,
  type TEXT,
  comment TEXT,
  taskid INTEGER
);

CREATE TABLE IF NOT EXISTS Report (
  id BIGINT PRIMARY KEY,
  name TEXT NOT NULL,
  num INTEGER NOT NULL,
  index VARCHAR(10) NOT NULL,
  createdon TIMESTAMP NOT NULL,
  updatedon TIMESTAMP,
  employeeid INTEGER NOT NULL REFERENCES Employee,
  departmentid INTEGER REFERENCES Department,
  projectid INTEGER REFERENCES Project,
  comment TEXT,
  localdate DATE NOT NULL,
  taskid INTEGER
);

CREATE TABLE IF NOT EXISTS DOCUMENT_FILE (
  id BIGINT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  path VARCHAR(255) NOT NULL,
  filetype VARCHAR(255) NOT NULL,
  createdon TIMESTAMP NOT NULL,
  documentid BIGINT,
  bitrixid INTEGER
);

CREATE TABLE IF NOT EXISTS Document_Executor (
  documentid BIGINT NOT NULL,
  employeeid INTEGER NOT NULL REFERENCES Employee
);

CREATE TABLE IF NOT EXISTS Memo_Who (
  documentid BIGINT NOT NULL,
  employeeid INTEGER NOT NULL REFERENCES Employee
);

CREATE TABLE IF NOT EXISTS Project_Member (
  projectid BIGINT NOT NULL,
  employeeid INTEGER NOT NULL REFERENCES Employee
);

CREATE TABLE IF NOT EXISTS Document_Index (
  id INTEGER PRIMARY KEY ,
  departmentid INTEGER NOT NULL REFERENCES Department,
  documenttype INTEGER NOT NULL,
  index VARCHAR(10) NOT NULL,
  name VARCHAR(255) NOT NULL
);
