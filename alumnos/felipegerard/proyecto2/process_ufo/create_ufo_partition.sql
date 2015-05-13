
DROP TABLE IF EXISTS clean.ufo CASCADE;
CREATE TABLE clean.ufo (
origin varchar,
id varchar,
date_time timestamp,
year smallint,
month smallint,
day smallint,
weekday smallint,
city varchar,
state varchar,
shape varchar,
duration varchar,
number float,
units varchar,
seconds bigint,
summary varchar,
posted timestamp,
description_url varchar,
long_description varchar
);
CREATE TABLE clean.ufo_1000 (CONSTRAINT partition_date_range CHECK (date_time >= '1000-01-01'::date AND date_time <= '1000-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1400 (CONSTRAINT partition_date_range CHECK (date_time >= '1400-01-01'::date AND date_time <= '1400-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1561 (CONSTRAINT partition_date_range CHECK (date_time >= '1561-01-01'::date AND date_time <= '1561-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1715 (CONSTRAINT partition_date_range CHECK (date_time >= '1715-01-01'::date AND date_time <= '1715-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1762 (CONSTRAINT partition_date_range CHECK (date_time >= '1762-01-01'::date AND date_time <= '1762-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1790 (CONSTRAINT partition_date_range CHECK (date_time >= '1790-01-01'::date AND date_time <= '1790-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1800 (CONSTRAINT partition_date_range CHECK (date_time >= '1800-01-01'::date AND date_time <= '1800-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1830 (CONSTRAINT partition_date_range CHECK (date_time >= '1830-01-01'::date AND date_time <= '1830-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1860 (CONSTRAINT partition_date_range CHECK (date_time >= '1860-01-01'::date AND date_time <= '1860-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1861 (CONSTRAINT partition_date_range CHECK (date_time >= '1861-01-01'::date AND date_time <= '1861-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1864 (CONSTRAINT partition_date_range CHECK (date_time >= '1864-01-01'::date AND date_time <= '1864-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1865 (CONSTRAINT partition_date_range CHECK (date_time >= '1865-01-01'::date AND date_time <= '1865-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1871 (CONSTRAINT partition_date_range CHECK (date_time >= '1871-01-01'::date AND date_time <= '1871-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1880 (CONSTRAINT partition_date_range CHECK (date_time >= '1880-01-01'::date AND date_time <= '1880-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1886 (CONSTRAINT partition_date_range CHECK (date_time >= '1886-01-01'::date AND date_time <= '1886-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1896 (CONSTRAINT partition_date_range CHECK (date_time >= '1896-01-01'::date AND date_time <= '1896-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1897 (CONSTRAINT partition_date_range CHECK (date_time >= '1897-01-01'::date AND date_time <= '1897-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1899 (CONSTRAINT partition_date_range CHECK (date_time >= '1899-01-01'::date AND date_time <= '1899-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1900 (CONSTRAINT partition_date_range CHECK (date_time >= '1900-01-01'::date AND date_time <= '1900-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1905 (CONSTRAINT partition_date_range CHECK (date_time >= '1905-01-01'::date AND date_time <= '1905-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1906 (CONSTRAINT partition_date_range CHECK (date_time >= '1906-01-01'::date AND date_time <= '1906-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1910 (CONSTRAINT partition_date_range CHECK (date_time >= '1910-01-01'::date AND date_time <= '1910-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1914 (CONSTRAINT partition_date_range CHECK (date_time >= '1914-01-01'::date AND date_time <= '1914-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1916 (CONSTRAINT partition_date_range CHECK (date_time >= '1916-01-01'::date AND date_time <= '1916-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1917 (CONSTRAINT partition_date_range CHECK (date_time >= '1917-01-01'::date AND date_time <= '1917-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1920 (CONSTRAINT partition_date_range CHECK (date_time >= '1920-01-01'::date AND date_time <= '1920-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1922 (CONSTRAINT partition_date_range CHECK (date_time >= '1922-01-01'::date AND date_time <= '1922-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1925 (CONSTRAINT partition_date_range CHECK (date_time >= '1925-01-01'::date AND date_time <= '1925-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1929 (CONSTRAINT partition_date_range CHECK (date_time >= '1929-01-01'::date AND date_time <= '1929-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1930 (CONSTRAINT partition_date_range CHECK (date_time >= '1930-01-01'::date AND date_time <= '1930-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1931 (CONSTRAINT partition_date_range CHECK (date_time >= '1931-01-01'::date AND date_time <= '1931-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1933 (CONSTRAINT partition_date_range CHECK (date_time >= '1933-01-01'::date AND date_time <= '1933-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1934 (CONSTRAINT partition_date_range CHECK (date_time >= '1934-01-01'::date AND date_time <= '1934-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1935 (CONSTRAINT partition_date_range CHECK (date_time >= '1935-01-01'::date AND date_time <= '1935-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1936 (CONSTRAINT partition_date_range CHECK (date_time >= '1936-01-01'::date AND date_time <= '1936-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1937 (CONSTRAINT partition_date_range CHECK (date_time >= '1937-01-01'::date AND date_time <= '1937-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1939 (CONSTRAINT partition_date_range CHECK (date_time >= '1939-01-01'::date AND date_time <= '1939-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1941 (CONSTRAINT partition_date_range CHECK (date_time >= '1941-01-01'::date AND date_time <= '1941-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1942 (CONSTRAINT partition_date_range CHECK (date_time >= '1942-01-01'::date AND date_time <= '1942-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1943 (CONSTRAINT partition_date_range CHECK (date_time >= '1943-01-01'::date AND date_time <= '1943-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1944 (CONSTRAINT partition_date_range CHECK (date_time >= '1944-01-01'::date AND date_time <= '1944-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1945 (CONSTRAINT partition_date_range CHECK (date_time >= '1945-01-01'::date AND date_time <= '1945-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1946 (CONSTRAINT partition_date_range CHECK (date_time >= '1946-01-01'::date AND date_time <= '1946-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1947 (CONSTRAINT partition_date_range CHECK (date_time >= '1947-01-01'::date AND date_time <= '1947-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1948 (CONSTRAINT partition_date_range CHECK (date_time >= '1948-01-01'::date AND date_time <= '1948-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1949 (CONSTRAINT partition_date_range CHECK (date_time >= '1949-01-01'::date AND date_time <= '1949-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1950 (CONSTRAINT partition_date_range CHECK (date_time >= '1950-01-01'::date AND date_time <= '1950-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1951 (CONSTRAINT partition_date_range CHECK (date_time >= '1951-01-01'::date AND date_time <= '1951-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1952 (CONSTRAINT partition_date_range CHECK (date_time >= '1952-01-01'::date AND date_time <= '1952-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1953 (CONSTRAINT partition_date_range CHECK (date_time >= '1953-01-01'::date AND date_time <= '1953-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1954 (CONSTRAINT partition_date_range CHECK (date_time >= '1954-01-01'::date AND date_time <= '1954-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1955 (CONSTRAINT partition_date_range CHECK (date_time >= '1955-01-01'::date AND date_time <= '1955-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1956 (CONSTRAINT partition_date_range CHECK (date_time >= '1956-01-01'::date AND date_time <= '1956-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1957 (CONSTRAINT partition_date_range CHECK (date_time >= '1957-01-01'::date AND date_time <= '1957-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1958 (CONSTRAINT partition_date_range CHECK (date_time >= '1958-01-01'::date AND date_time <= '1958-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1959 (CONSTRAINT partition_date_range CHECK (date_time >= '1959-01-01'::date AND date_time <= '1959-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1960 (CONSTRAINT partition_date_range CHECK (date_time >= '1960-01-01'::date AND date_time <= '1960-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1961 (CONSTRAINT partition_date_range CHECK (date_time >= '1961-01-01'::date AND date_time <= '1961-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1962 (CONSTRAINT partition_date_range CHECK (date_time >= '1962-01-01'::date AND date_time <= '1962-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1963 (CONSTRAINT partition_date_range CHECK (date_time >= '1963-01-01'::date AND date_time <= '1963-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1964 (CONSTRAINT partition_date_range CHECK (date_time >= '1964-01-01'::date AND date_time <= '1964-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1965 (CONSTRAINT partition_date_range CHECK (date_time >= '1965-01-01'::date AND date_time <= '1965-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1966 (CONSTRAINT partition_date_range CHECK (date_time >= '1966-01-01'::date AND date_time <= '1966-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1967 (CONSTRAINT partition_date_range CHECK (date_time >= '1967-01-01'::date AND date_time <= '1967-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1968 (CONSTRAINT partition_date_range CHECK (date_time >= '1968-01-01'::date AND date_time <= '1968-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1969 (CONSTRAINT partition_date_range CHECK (date_time >= '1969-01-01'::date AND date_time <= '1969-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1970 (CONSTRAINT partition_date_range CHECK (date_time >= '1970-01-01'::date AND date_time <= '1970-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1971 (CONSTRAINT partition_date_range CHECK (date_time >= '1971-01-01'::date AND date_time <= '1971-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1972 (CONSTRAINT partition_date_range CHECK (date_time >= '1972-01-01'::date AND date_time <= '1972-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1973 (CONSTRAINT partition_date_range CHECK (date_time >= '1973-01-01'::date AND date_time <= '1973-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1974 (CONSTRAINT partition_date_range CHECK (date_time >= '1974-01-01'::date AND date_time <= '1974-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1975 (CONSTRAINT partition_date_range CHECK (date_time >= '1975-01-01'::date AND date_time <= '1975-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1976 (CONSTRAINT partition_date_range CHECK (date_time >= '1976-01-01'::date AND date_time <= '1976-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1977 (CONSTRAINT partition_date_range CHECK (date_time >= '1977-01-01'::date AND date_time <= '1977-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1978 (CONSTRAINT partition_date_range CHECK (date_time >= '1978-01-01'::date AND date_time <= '1978-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1979 (CONSTRAINT partition_date_range CHECK (date_time >= '1979-01-01'::date AND date_time <= '1979-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1980 (CONSTRAINT partition_date_range CHECK (date_time >= '1980-01-01'::date AND date_time <= '1980-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1981 (CONSTRAINT partition_date_range CHECK (date_time >= '1981-01-01'::date AND date_time <= '1981-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1982 (CONSTRAINT partition_date_range CHECK (date_time >= '1982-01-01'::date AND date_time <= '1982-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1983 (CONSTRAINT partition_date_range CHECK (date_time >= '1983-01-01'::date AND date_time <= '1983-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1984 (CONSTRAINT partition_date_range CHECK (date_time >= '1984-01-01'::date AND date_time <= '1984-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1985 (CONSTRAINT partition_date_range CHECK (date_time >= '1985-01-01'::date AND date_time <= '1985-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1986 (CONSTRAINT partition_date_range CHECK (date_time >= '1986-01-01'::date AND date_time <= '1986-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1987 (CONSTRAINT partition_date_range CHECK (date_time >= '1987-01-01'::date AND date_time <= '1987-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1988 (CONSTRAINT partition_date_range CHECK (date_time >= '1988-01-01'::date AND date_time <= '1988-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1989 (CONSTRAINT partition_date_range CHECK (date_time >= '1989-01-01'::date AND date_time <= '1989-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1990 (CONSTRAINT partition_date_range CHECK (date_time >= '1990-01-01'::date AND date_time <= '1990-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1991 (CONSTRAINT partition_date_range CHECK (date_time >= '1991-01-01'::date AND date_time <= '1991-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1992 (CONSTRAINT partition_date_range CHECK (date_time >= '1992-01-01'::date AND date_time <= '1992-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1993 (CONSTRAINT partition_date_range CHECK (date_time >= '1993-01-01'::date AND date_time <= '1993-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1994 (CONSTRAINT partition_date_range CHECK (date_time >= '1994-01-01'::date AND date_time <= '1994-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1995 (CONSTRAINT partition_date_range CHECK (date_time >= '1995-01-01'::date AND date_time <= '1995-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1996 (CONSTRAINT partition_date_range CHECK (date_time >= '1996-01-01'::date AND date_time <= '1996-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1997 (CONSTRAINT partition_date_range CHECK (date_time >= '1997-01-01'::date AND date_time <= '1997-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1998 (CONSTRAINT partition_date_range CHECK (date_time >= '1998-01-01'::date AND date_time <= '1998-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_1999 (CONSTRAINT partition_date_range CHECK (date_time >= '1999-01-01'::date AND date_time <= '1999-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_2000 (CONSTRAINT partition_date_range CHECK (date_time >= '2000-01-01'::date AND date_time <= '2000-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_2001 (CONSTRAINT partition_date_range CHECK (date_time >= '2001-01-01'::date AND date_time <= '2001-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_2002 (CONSTRAINT partition_date_range CHECK (date_time >= '2002-01-01'::date AND date_time <= '2002-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_2003 (CONSTRAINT partition_date_range CHECK (date_time >= '2003-01-01'::date AND date_time <= '2003-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_2004 (CONSTRAINT partition_date_range CHECK (date_time >= '2004-01-01'::date AND date_time <= '2004-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_2005 (CONSTRAINT partition_date_range CHECK (date_time >= '2005-01-01'::date AND date_time <= '2005-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_2006 (CONSTRAINT partition_date_range CHECK (date_time >= '2006-01-01'::date AND date_time <= '2006-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_2007 (CONSTRAINT partition_date_range CHECK (date_time >= '2007-01-01'::date AND date_time <= '2007-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_2008 (CONSTRAINT partition_date_range CHECK (date_time >= '2008-01-01'::date AND date_time <= '2008-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_2009 (CONSTRAINT partition_date_range CHECK (date_time >= '2009-01-01'::date AND date_time <= '2009-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_2010 (CONSTRAINT partition_date_range CHECK (date_time >= '2010-01-01'::date AND date_time <= '2010-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_2011 (CONSTRAINT partition_date_range CHECK (date_time >= '2011-01-01'::date AND date_time <= '2011-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_2012 (CONSTRAINT partition_date_range CHECK (date_time >= '2012-01-01'::date AND date_time <= '2012-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_2013 (CONSTRAINT partition_date_range CHECK (date_time >= '2013-01-01'::date AND date_time <= '2013-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_2014 (CONSTRAINT partition_date_range CHECK (date_time >= '2014-01-01'::date AND date_time <= '2014-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_2015 (CONSTRAINT partition_date_range CHECK (date_time >= '2015-01-01'::date AND date_time <= '2015-12-31'::date)) INHERITS (clean.ufo);
CREATE TABLE clean.ufo_overflow () INHERITS (clean.ufo);
