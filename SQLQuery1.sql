USE [master]
GO
/****** Object:  Database [Ejemplo]    Script Date: 12/01/2021 15:53:16 ******/
CREATE DATABASE [Ejemplo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Ejemplo', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Ejemplo.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Ejemplo_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Ejemplo_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Ejemplo] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Ejemplo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Ejemplo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Ejemplo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Ejemplo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Ejemplo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Ejemplo] SET ARITHABORT OFF 
GO
ALTER DATABASE [Ejemplo] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Ejemplo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Ejemplo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Ejemplo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Ejemplo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Ejemplo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Ejemplo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Ejemplo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Ejemplo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Ejemplo] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Ejemplo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Ejemplo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Ejemplo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Ejemplo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Ejemplo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Ejemplo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Ejemplo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Ejemplo] SET RECOVERY FULL 
GO
ALTER DATABASE [Ejemplo] SET  MULTI_USER 
GO
ALTER DATABASE [Ejemplo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Ejemplo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Ejemplo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Ejemplo] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Ejemplo] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Ejemplo', N'ON'
GO
ALTER DATABASE [Ejemplo] SET QUERY_STORE = OFF
GO
USE [Ejemplo]
GO
/****** Object:  Table [dbo].[addresses]    Script Date: 12/01/2021 15:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[addresses](
	[id_adress] [int] IDENTITY(1,1) NOT NULL,
	[calle] [varchar](50) NULL,
	[numero] [numeric](18, 0) NULL,
	[colonia] [varchar](50) NULL,
	[usuario_id] [int] NOT NULL,
 CONSTRAINT [PK_addresses] PRIMARY KEY CLUSTERED 
(
	[id_adress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[distributors]    Script Date: 12/01/2021 15:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[distributors](
	[id_distribuidor] [int] IDENTITY(1,1) NOT NULL,
	[num_distribuidor] [numeric](18, 0) NOT NULL,
	[fecha_registro] [date] NOT NULL,
 CONSTRAINT [PK_distribuidor] PRIMARY KEY CLUSTERED 
(
	[id_distribuidor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[persons]    Script Date: 12/01/2021 15:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[persons](
	[id_usuario] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[apellidop] [varchar](50) NOT NULL,
	[apellidoM] [varchar](50) NOT NULL,
	[telefono] [varchar](20) NULL,
	[distribuidor_id] [int] NOT NULL,
 CONSTRAINT [PK_persons] PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[addresses] ON 
GO
INSERT [dbo].[addresses] ([id_adress], [calle], [numero], [colonia], [usuario_id]) VALUES (2, N'VICENTE SUAREZ', CAST(1910 AS Numeric(18, 0)), N'CONSTITUCION', 2)
GO
INSERT [dbo].[addresses] ([id_adress], [calle], [numero], [colonia], [usuario_id]) VALUES (3, N'DEL DELFIN', CAST(1520 AS Numeric(18, 0)), N'INFO PLAYAS', 3)
GO
INSERT [dbo].[addresses] ([id_adress], [calle], [numero], [colonia], [usuario_id]) VALUES (4, N'PRUEBA ', CAST(1212 AS Numeric(18, 0)), N'PRUEBAA', 4)
GO
SET IDENTITY_INSERT [dbo].[addresses] OFF
GO
SET IDENTITY_INSERT [dbo].[distributors] ON 
GO
INSERT [dbo].[distributors] ([id_distribuidor], [num_distribuidor], [fecha_registro]) VALUES (2, CAST(21 AS Numeric(18, 0)), CAST(N'2021-01-06' AS Date))
GO
INSERT [dbo].[distributors] ([id_distribuidor], [num_distribuidor], [fecha_registro]) VALUES (3, CAST(50 AS Numeric(18, 0)), CAST(N'2021-01-06' AS Date))
GO
INSERT [dbo].[distributors] ([id_distribuidor], [num_distribuidor], [fecha_registro]) VALUES (4, CAST(50 AS Numeric(18, 0)), CAST(N'2021-01-06' AS Date))
GO
SET IDENTITY_INSERT [dbo].[distributors] OFF
GO
SET IDENTITY_INSERT [dbo].[persons] ON 
GO
INSERT [dbo].[persons] ([id_usuario], [nombre], [apellidop], [apellidoM], [telefono], [distribuidor_id]) VALUES (2, N'CARLOS MANUEL', N'BARRON', N'ESPINOZA', N'9843374', 2)
GO
INSERT [dbo].[persons] ([id_usuario], [nombre], [apellidop], [apellidoM], [telefono], [distribuidor_id]) VALUES (3, N'SIQUIE GUADALUPE', N'DOMINGUEZ', N'GARCIA', N'9801010', 3)
GO
INSERT [dbo].[persons] ([id_usuario], [nombre], [apellidop], [apellidoM], [telefono], [distribuidor_id]) VALUES (4, N'PREUAB', N' PRUEBA', N'PRUEBA', N'12345', 4)
GO
SET IDENTITY_INSERT [dbo].[persons] OFF
GO
ALTER TABLE [dbo].[addresses]  WITH CHECK ADD  CONSTRAINT [FK_addresses_persons] FOREIGN KEY([usuario_id])
REFERENCES [dbo].[persons] ([id_usuario])
GO
ALTER TABLE [dbo].[addresses] CHECK CONSTRAINT [FK_addresses_persons]
GO
ALTER TABLE [dbo].[persons]  WITH CHECK ADD  CONSTRAINT [FK_persons_distributors] FOREIGN KEY([distribuidor_id])
REFERENCES [dbo].[distributors] ([id_distribuidor])
GO
ALTER TABLE [dbo].[persons] CHECK CONSTRAINT [FK_persons_distributors]
GO
/****** Object:  StoredProcedure [dbo].[SP_Buscar]    Script Date: 12/01/2021 15:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC SP_Buscar 21

CREATE PROC [dbo].[SP_Buscar](
	@num_distribuidor int
)

AS
BEGIN 

SELECT num_distribuidor, concat(nombre, ' ', apellidop, ' ', apellidoM) as Nombre_Completo, telefono, calle, numero, colonia
FROM distributors dist
INNER JOIN persons p ON dist.id_distribuidor = p.distribuidor_id
INNER JOIN addresses ad ON p.id_usuario = ad.usuario_id
WHERE num_distribuidor = @num_distribuidor
ORDER BY dist.id_distribuidor asc

END
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_persons]    Script Date: 12/01/2021 15:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from persons

CREATE PROC [dbo].[SP_INSERT_persons](
	@distribuidor_id int,
	@nombre varchar(50),
	@apellidop varchar(50),
	@apellidoM varchar(50),
	@telefono varchar(20)

)
AS 
--contenido

INSERT INTO persons VALUES (@distribuidor_id, @nombre, @apellidop, @apellidoM, @telefono)
DECLARE @id_usuario BIGINT
SET @id_usuario = SCOPE_IDENTITY()
PRINT @id_usuario

GO
USE [master]
GO
ALTER DATABASE [Ejemplo] SET  READ_WRITE 
GO
