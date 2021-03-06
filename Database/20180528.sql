/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.4206)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
USE [master]
GO
/****** Object:  Database [KuteShop]    Script Date: 28-May-18 23:40:38 ******/
CREATE DATABASE [KuteShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'KuteShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\KuteShop.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'KuteShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\KuteShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [KuteShop] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [KuteShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [KuteShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [KuteShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [KuteShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [KuteShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [KuteShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [KuteShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [KuteShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [KuteShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [KuteShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [KuteShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [KuteShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [KuteShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [KuteShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [KuteShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [KuteShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [KuteShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [KuteShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [KuteShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [KuteShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [KuteShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [KuteShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [KuteShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [KuteShop] SET RECOVERY FULL 
GO
ALTER DATABASE [KuteShop] SET  MULTI_USER 
GO
ALTER DATABASE [KuteShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [KuteShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [KuteShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [KuteShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [KuteShop] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'KuteShop', N'ON'
GO
ALTER DATABASE [KuteShop] SET QUERY_STORE = OFF
GO
USE [KuteShop]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [KuteShop]
GO
/****** Object:  Table [dbo].[Address]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](4000) NULL,
	[LastName] [nvarchar](4000) NULL,
	[Email] [nvarchar](4000) NULL,
	[Company] [nvarchar](4000) NULL,
	[CountryId] [int] NULL,
	[StateProvinceId] [int] NULL,
	[City] [nvarchar](4000) NULL,
	[Address1] [nvarchar](4000) NULL,
	[Address2] [nvarchar](4000) NULL,
	[ZipPostalCode] [nvarchar](4000) NULL,
	[PhoneNumber] [nvarchar](4000) NULL,
	[FaxNumber] [nvarchar](4000) NULL,
	[Salutation] [nvarchar](max) NULL,
	[Title] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttribureValue]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttribureValue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ValueName] [nvarchar](max) NULL,
	[ColorHex] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[Status] [int] NOT NULL,
	[OrderDisplay] [int] NULL,
	[AttributeId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.AttribureValue] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Attribute]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attribute](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AttributeName] [nvarchar](max) NULL,
	[OrderDisplay] [int] NULL,
	[Status] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.Attribute] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Banner]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banner](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NULL,
	[WebsiteLink] [nvarchar](250) NULL,
	[ImgPath] [nvarchar](max) NULL,
	[Language] [nvarchar](5) NULL,
	[Width] [nvarchar](50) NULL,
	[Height] [nvarchar](50) NULL,
	[Target] [nvarchar](50) NULL,
	[FromDate] [time](7) NULL,
	[ToDate] [time](7) NULL,
	[Status] [int] NOT NULL,
	[OrderDisplay] [int] NOT NULL,
	[PageId] [int] NOT NULL,
	[MenuId] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.Banner] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Brand]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brand](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[OrderDisplay] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.Branch] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Claim]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Claim](
	[ClaimId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ClaimType] [nvarchar](4000) NULL,
	[ClaimValue] [nvarchar](4000) NULL,
 CONSTRAINT [PK_dbo.Claim] PRIMARY KEY CLUSTERED 
(
	[ClaimId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactInformation]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactInformation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Language] [nvarchar](5) NULL,
	[Title] [nvarchar](max) NULL,
	[Lag] [nvarchar](50) NULL,
	[Lat] [nvarchar](50) NULL,
	[Type] [int] NOT NULL,
	[OrderDisplay] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[Email] [nvarchar](50) NULL,
	[Hotline] [nvarchar](50) NULL,
	[Address] [nvarchar](250) NULL,
	[MobilePhone] [nvarchar](50) NULL,
	[Fax] [nvarchar](50) NULL,
	[NumberOfStore] [nvarchar](max) NULL,
	[ProvinceId] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.ContactInfomation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerGuid] [uniqueidentifier] NOT NULL,
	[Username] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Password] [nvarchar](500) NULL,
	[PasswordFormatId] [int] NOT NULL,
	[PasswordSalt] [nvarchar](500) NULL,
	[AdminComment] [nvarchar](4000) NULL,
	[IsTaxExempt] [bit] NOT NULL,
	[AffiliateId] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[IsSystemAccount] [bit] NOT NULL,
	[SystemName] [nvarchar](500) NULL,
	[LastIpAddress] [nvarchar](100) NULL,
	[CreatedOnUtc] [datetime] NOT NULL,
	[LastLoginDateUtc] [datetime] NULL,
	[LastActivityDateUtc] [datetime] NOT NULL,
	[BillingAddress_Id] [int] NULL,
	[ShippingAddress_Id] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerAddresses]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerAddresses](
	[Customer_Id] [int] NOT NULL,
	[Address_Id] [int] NOT NULL,
 CONSTRAINT [PK_CustomerAddresses] PRIMARY KEY CLUSTERED 
(
	[Customer_Id] ASC,
	[Address_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExternalLogin]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExternalLogin](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_dbo.ExternalLogin] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GalleryImage]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GalleryImage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NULL,
	[ImageBig] [nvarchar](max) NULL,
	[ImageThumbnail] [nvarchar](max) NULL,
	[Status] [int] NOT NULL,
	[OrderDisplay] [int] NOT NULL,
	[PostId] [int] NOT NULL,
	[AttributeValueId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
	[Price] [decimal](18, 4) NULL,
 CONSTRAINT [PK_dbo.GalleryImage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GenericAttribute]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GenericAttribute](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EntityId] [int] NOT NULL,
	[KeyGroup] [nvarchar](400) NOT NULL,
	[Key] [nvarchar](400) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[StoreId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GenericControl]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GenericControl](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[OrderDisplay] [int] NULL,
	[Status] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
	[MenuId] [int] NULL,
	[ControlTypeId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.GenControl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GenericControlMenuLink]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GenericControlMenuLink](
	[GenericControlId] [int] NOT NULL,
	[MenuLinkId] [int] NOT NULL,
 CONSTRAINT [PK__GenericC__91DE8CB0EEE6FC71] PRIMARY KEY CLUSTERED 
(
	[GenericControlId] ASC,
	[MenuLinkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GenericControlValue]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GenericControlValue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ValueName] [nvarchar](max) NULL,
	[ColorHex] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[Status] [int] NOT NULL,
	[OrderDisplay] [int] NULL,
	[GenericControlId] [int] NOT NULL,
	[EntityId] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.GenericControlValue] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GenericControlValueItem]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GenericControlValueItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NULL,
	[ImagePath] [nvarchar](max) NULL,
	[ImageThumbnail] [nvarchar](max) NULL,
	[Status] [int] NOT NULL,
	[OrderDisplay] [int] NOT NULL,
	[EntityId] [int] NOT NULL,
	[GenericControlValueId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
	[Value] [nvarchar](4000) NULL,
 CONSTRAINT [PK_dbo.GenericControlValueItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LandingPage]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LandingPage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](max) NULL,
	[DateOfBith] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[Status] [int] NOT NULL,
	[ShopId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.LandingPage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Language]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Language](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LanguageName] [nvarchar](250) NOT NULL,
	[LanguageCode] [nvarchar](50) NOT NULL,
	[Flag] [nvarchar](250) NULL,
	[Status] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.Language] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocaleStringResource]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocaleStringResource](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LanguageId] [int] NOT NULL,
	[ResourceName] [nvarchar](200) NOT NULL,
	[ResourceValue] [nvarchar](max) NULL,
	[IsFromPlugin] [bit] NOT NULL,
	[IsTouched] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocalizedProperty]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocalizedProperty](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EntityId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[LocaleKeyGroup] [nvarchar](400) NOT NULL,
	[LocaleKey] [nvarchar](400) NOT NULL,
	[LocaleValue] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manufacturer]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manufacturer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NULL,
	[OtherLink] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[Status] [int] NOT NULL,
	[OrderDisplay] [int] NOT NULL,
	[ImageUrl] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.FlowStep] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MenuLink]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuLink](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParentId] [int] NULL,
	[CurrentVirtualId] [nvarchar](250) NULL,
	[VirtualId] [nvarchar](250) NULL,
	[MenuName] [nvarchar](250) NULL,
	[Status] [int] NOT NULL,
	[TypeMenu] [int] NOT NULL,
	[Position] [int] NOT NULL,
	[TemplateType] [int] NOT NULL,
	[Language] [nvarchar](5) NULL,
	[OrderDisplay] [int] NOT NULL,
	[SourceLink] [nvarchar](250) NULL,
	[SeoUrl] [nvarchar](250) NULL,
	[VirtualSeoUrl] [nvarchar](250) NULL,
	[MetaKeywords] [nvarchar](550) NULL,
	[MetaTitle] [nvarchar](550) NULL,
	[MetaDescription] [nvarchar](550) NULL,
	[DisplayOnHomePage] [bit] NOT NULL,
	[DisplayOnMenu] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
	[DisplayOnSearch] [bit] NOT NULL,
	[ImageBigSize] [nvarchar](250) NULL,
	[ImageMediumSize] [nvarchar](250) NULL,
	[ImageSmallSize] [nvarchar](250) NULL,
	[ColorHex] [nvarchar](4000) NULL,
 CONSTRAINT [PK_dbo.MenuLink] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[News]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[News](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MenuId] [int] NOT NULL,
	[VirtualCategoryId] [nvarchar](max) NULL,
	[Language] [nvarchar](max) NULL,
	[Title] [nvarchar](max) NULL,
	[Video] [bit] NOT NULL,
	[VideoLink] [nvarchar](max) NULL,
	[OtherLink] [nvarchar](max) NULL,
	[ShortDesc] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[Status] [int] NOT NULL,
	[OrderDisplay] [int] NOT NULL,
	[SpecialDisplay] [bit] NOT NULL,
	[HomeDisplay] [bit] NOT NULL,
	[ViewCount] [int] NOT NULL,
	[MetaTitle] [nvarchar](max) NULL,
	[MetaKeywords] [nvarchar](max) NULL,
	[MetaDescription] [nvarchar](max) NULL,
	[SeoUrl] [nvarchar](max) NULL,
	[VirtualCatUrl] [nvarchar](max) NULL,
	[ImageBigSize] [nvarchar](max) NULL,
	[ImageMediumSize] [nvarchar](max) NULL,
	[ImageSmallSize] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.News] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderNumber] [nvarchar](4000) NULL,
	[OrderGuid] [uniqueidentifier] NULL,
	[StoreId] [int] NULL,
	[CustomerId] [int] NULL,
	[BillingAddressId] [int] NULL,
	[ShippingAddressId] [int] NULL,
	[OrderStatusId] [int] NULL,
	[ShippingStatusId] [int] NULL,
	[PaymentStatusId] [int] NULL,
	[PaymentMethodSystemName] [nvarchar](4000) NULL,
	[CustomerCurrencyCode] [nvarchar](4000) NULL,
	[CurrencyRate] [decimal](18, 8) NULL,
	[CustomerTaxDisplayTypeId] [int] NULL,
	[VatNumber] [nvarchar](4000) NULL,
	[OrderSubtotalInclTax] [decimal](18, 4) NULL,
	[OrderSubtotalExclTax] [decimal](18, 4) NULL,
	[OrderSubTotalDiscountInclTax] [decimal](18, 4) NULL,
	[OrderSubTotalDiscountExclTax] [decimal](18, 4) NULL,
	[OrderShippingInclTax] [decimal](18, 4) NULL,
	[OrderShippingExclTax] [decimal](18, 4) NULL,
	[PaymentMethodAdditionalFeeInclTax] [decimal](18, 4) NULL,
	[PaymentMethodAdditionalFeeExclTax] [decimal](18, 4) NULL,
	[TaxRates] [nvarchar](4000) NULL,
	[OrderTax] [decimal](18, 4) NULL,
	[OrderDiscount] [decimal](18, 4) NULL,
	[OrderTotal] [decimal](18, 4) NULL,
	[RefundedAmount] [decimal](18, 4) NULL,
	[RewardPointsWereAdded] [bit] NULL,
	[CheckoutAttributeDescription] [nvarchar](4000) NULL,
	[CheckoutAttributesXml] [nvarchar](4000) NULL,
	[CustomerLanguageId] [int] NULL,
	[AffiliateId] [int] NULL,
	[CustomerIp] [nvarchar](4000) NULL,
	[AllowStoringCreditCardNumber] [bit] NULL,
	[CardType] [nvarchar](4000) NULL,
	[CardName] [nvarchar](4000) NULL,
	[CardNumber] [nvarchar](4000) NULL,
	[MaskedCreditCardNumber] [nvarchar](4000) NULL,
	[CardCvv2] [nvarchar](4000) NULL,
	[CardExpirationMonth] [nvarchar](4000) NULL,
	[CardExpirationYear] [nvarchar](4000) NULL,
	[AllowStoringDirectDebit] [bit] NULL,
	[DirectDebitAccountHolder] [nvarchar](4000) NULL,
	[DirectDebitAccountNumber] [nvarchar](4000) NULL,
	[DirectDebitBankCode] [nvarchar](4000) NULL,
	[DirectDebitBankName] [nvarchar](4000) NULL,
	[DirectDebitBIC] [nvarchar](4000) NULL,
	[DirectDebitCountry] [nvarchar](4000) NULL,
	[DirectDebitIban] [nvarchar](4000) NULL,
	[AuthorizationTransactionId] [nvarchar](4000) NULL,
	[AuthorizationTransactionCode] [nvarchar](4000) NULL,
	[AuthorizationTransactionResult] [nvarchar](4000) NULL,
	[CaptureTransactionId] [nvarchar](4000) NULL,
	[CaptureTransactionResult] [nvarchar](4000) NULL,
	[SubscriptionTransactionId] [nvarchar](4000) NULL,
	[PurchaseOrderNumber] [nvarchar](4000) NULL,
	[PaidDateUtc] [datetime] NULL,
	[ShippingMethod] [nvarchar](4000) NULL,
	[ShippingRateComputationMethodSystemName] [nvarchar](4000) NULL,
	[Deleted] [bit] NULL,
	[CreatedOnUtc] [datetime] NULL,
	[UpdatedOnUtc] [datetime] NULL,
	[RewardPointsRemaining] [int] NULL,
	[CustomerOrderComment] [nvarchar](max) NULL,
	[OrderShippingTaxRate] [decimal](18, 4) NULL,
	[PaymentMethodAdditionalFeeTaxRate] [decimal](18, 4) NULL,
	[HasNewPaymentNotification] [bit] NULL,
	[AcceptThirdPartyEmailHandOver] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.Order] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItem]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderItemGuid] [uniqueidentifier] NOT NULL,
	[OrderId] [int] NOT NULL,
	[PostId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPriceInclTax] [decimal](18, 4) NOT NULL,
	[UnitPriceExclTax] [decimal](18, 4) NOT NULL,
	[PriceInclTax] [decimal](18, 4) NOT NULL,
	[PriceExclTax] [decimal](18, 4) NOT NULL,
	[DiscountAmountInclTax] [decimal](18, 4) NOT NULL,
	[DiscountAmountExclTax] [decimal](18, 4) NOT NULL,
	[AttributeDescription] [nvarchar](4000) NULL,
	[AttributesXml] [nvarchar](max) NULL,
	[DownloadCount] [int] NOT NULL,
	[IsDownloadActivated] [bit] NOT NULL,
	[LicenseDownloadId] [int] NULL,
	[ItemWeight] [decimal](18, 4) NULL,
	[BundleData] [nvarchar](max) NULL,
	[PostCost] [decimal](18, 4) NOT NULL,
	[TaxRate] [decimal](18, 4) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.OrderItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderNote]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderNote](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[Note] [nvarchar](max) NULL,
	[DisplayToCustomer] [bit] NOT NULL,
	[CreatedOnUtc] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.OrderNote] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PageBanner]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PageBanner](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Language] [nvarchar](5) NULL,
	[PageName] [nvarchar](250) NULL,
	[Status] [int] NOT NULL,
	[OrderDisplay] [int] NOT NULL,
	[Position] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.PageBanner] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentMethod]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentMethod](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PaymentMethodSystemName] [nvarchar](4000) NOT NULL,
	[Description] [nvarchar](4000) NULL,
	[ImageUrl] [nvarchar](4000) NULL,
	[Status] [int] NULL,
	[OrderDisplay] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.PaymentMethod] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Post]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Post](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MenuId] [int] NOT NULL,
	[VirtualCategoryId] [nvarchar](256) NULL,
	[Language] [nvarchar](4000) NULL,
	[Title] [nvarchar](4000) NULL,
	[ShortDesc] [nvarchar](4000) NULL,
	[Description] [nvarchar](4000) NULL,
	[Status] [int] NOT NULL,
	[OrderDisplay] [int] NOT NULL,
	[ViewCount] [int] NOT NULL,
	[MetaTitle] [nvarchar](4000) NULL,
	[MetaKeywords] [nvarchar](4000) NULL,
	[MetaDescription] [nvarchar](4000) NULL,
	[SeoUrl] [nvarchar](4000) NULL,
	[Price] [decimal](18, 4) NULL,
	[Discount] [decimal](18, 4) NULL,
	[ShowOnHomePage] [bit] NOT NULL,
	[ProductHot] [bit] NOT NULL,
	[OutOfStock] [bit] NOT NULL,
	[ProductNew] [bit] NOT NULL,
	[VirtualCatUrl] [nvarchar](4000) NULL,
	[ImageBigSize] [nvarchar](256) NULL,
	[ImageMediumSize] [nvarchar](256) NULL,
	[ImageSmallSize] [nvarchar](256) NULL,
	[StartDate] [datetime] NULL,
	[PostType] [int] NOT NULL,
	[ProductCode] [nvarchar](250) NULL,
	[EndDate] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
	[TechInfo] [nvarchar](4000) NULL,
	[OldOrNew] [bit] NOT NULL,
	[ManufacturerId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Post] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PostAttribute]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostAttribute](
	[AttibuteValueId] [int] NOT NULL,
	[PostId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.PostAttribute] PRIMARY KEY CLUSTERED 
(
	[AttibuteValueId] ASC,
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PostGallery]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostGallery](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PostId] [int] NOT NULL,
	[Title] [nvarchar](500) NULL,
	[OrderDisplay] [int] NOT NULL,
	[ImageBigSize] [nvarchar](256) NULL,
	[ImageSmallSize] [nvarchar](256) NULL,
	[ImageMediumSize] [nvarchar](256) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
	[Status] [int] NULL,
	[IsAvatar] [int] NULL,
 CONSTRAINT [PK_dbo.PostGallery] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Province]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Province](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[OrderDisplay] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.Province] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Repair]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Repair](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Model] [nvarchar](max) NULL,
	[ModelBrand] [nvarchar](max) NULL,
	[SerialNumber] [nvarchar](max) NULL,
	[BrandId] [int] NOT NULL,
	[OrderCode] [nvarchar](max) NULL,
	[CustomerCode] [nvarchar](max) NULL,
	[StoreName] [nvarchar](max) NULL,
	[CustomerName] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[CustomerIdNumber] [nvarchar](max) NULL,
	[Address] [nvarchar](max) NULL,
	[Accessories] [nvarchar](max) NULL,
	[PasswordPhone] [nvarchar](max) NULL,
	[AppleId] [nvarchar](max) NULL,
	[IcloudPassword] [nvarchar](max) NULL,
	[FixedTags] [nvarchar](max) NULL,
	[Category] [nvarchar](max) NULL,
	[OldWarranty] [int] NULL,
	[PhoneStatus] [nvarchar](max) NULL,
	[WarrantyFrom] [datetime] NULL,
	[WarrantyTo] [datetime] NULL,
	[FixedFee] [decimal](18, 2) NULL,
	[Status] [int] NULL,
	[Note] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.Repair] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairGallery]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairGallery](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ImagePath] [nvarchar](max) NULL,
	[RepairId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.RepairGallery] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairItem]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WarrantyFrom] [datetime] NULL,
	[WarrantyTo] [datetime] NULL,
	[FixedFee] [decimal](18, 2) NULL,
	[Category] [nvarchar](max) NULL,
	[RepairId] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.RepairItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](450) NULL,
 CONSTRAINT [PK_dbo.Role] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServerMailSetting]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServerMailSetting](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FromAddress] [nvarchar](250) NULL,
	[SmtpClient] [nvarchar](250) NULL,
	[UserID] [nvarchar](250) NULL,
	[Password] [nvarchar](250) NULL,
	[SMTPPort] [nvarchar](50) NULL,
	[EnableSSL] [bit] NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.ServerMailSetting] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Setting]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Setting](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[StoreId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.Setting] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SettingSeoGlobal]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SettingSeoGlobal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FbAppId] [nvarchar](max) NULL,
	[FbAdminsId] [nvarchar](max) NULL,
	[SnippetGoogleAnalytics] [nvarchar](max) NULL,
	[MetaTagMasterTool] [nvarchar](max) NULL,
	[PublisherGooglePlus] [nvarchar](max) NULL,
	[FacebookRetargetSnippet] [nvarchar](max) NULL,
	[GoogleRetargetSnippet] [nvarchar](max) NULL,
	[Status] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
	[FbLink] [nvarchar](3000) NULL,
	[GooglePlusLink] [nvarchar](3000) NULL,
	[TwitterLink] [nvarchar](3000) NULL,
	[PinterestLink] [nvarchar](3000) NULL,
	[YoutubeLink] [nvarchar](3000) NULL,
 CONSTRAINT [PK_dbo.SettingSeoGlobal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShippingMethod]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShippingMethod](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
	[Description] [nvarchar](4000) NULL,
	[DisplayOrder] [int] NOT NULL,
	[IgnoreCharges] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.ShippingMethod] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShoppingCartItem]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingCartItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StoreId] [int] NULL,
	[ParentItemId] [int] NULL,
	[BundleItemId] [int] NULL,
	[ShoppingCartTypeId] [int] NULL,
	[CustomerId] [int] NULL,
	[PostId] [int] NULL,
	[AttributesXml] [nvarchar](max) NULL,
	[CustomerEnteredPrice] [decimal](18, 4) NULL,
	[Quantity] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.ShoppingCartItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SlideShow]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SlideShow](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NULL,
	[WebsiteLink] [nvarchar](max) NULL,
	[ImgPath] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[Video] [bit] NOT NULL,
	[Width] [nvarchar](50) NULL,
	[Height] [nvarchar](50) NULL,
	[Target] [nvarchar](50) NULL,
	[FromDate] [time](7) NULL,
	[ToDate] [time](7) NULL,
	[Status] [int] NOT NULL,
	[OrderDisplay] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.SlideShow] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StaticContent]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StaticContent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MenuId] [int] NOT NULL,
	[VirtualCategoryId] [nvarchar](max) NULL,
	[Language] [nvarchar](max) NULL,
	[Title] [nvarchar](max) NULL,
	[ShortDesc] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[Status] [int] NOT NULL,
	[MetaTitle] [nvarchar](max) NULL,
	[MetaKeywords] [nvarchar](max) NULL,
	[MetaDescription] [nvarchar](max) NULL,
	[SeoUrl] [nvarchar](max) NULL,
	[ImagePath] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
	[ViewCount] [int] NOT NULL,
 CONSTRAINT [PK_dbo.StaticContents] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemSetting]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemSetting](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Language] [nvarchar](5) NULL,
	[Title] [nvarchar](4000) NULL,
	[FooterContent] [nvarchar](4000) NULL,
	[MetaTitle] [nvarchar](4000) NULL,
	[MetaDescription] [nvarchar](4000) NULL,
	[MetaKeywords] [nvarchar](4000) NULL,
	[Status] [int] NOT NULL,
	[FaviconImage] [nvarchar](500) NULL,
	[LogoImage] [nvarchar](500) NULL,
	[LogoFooterImage] [nvarchar](500) NULL,
	[MaintanceSite] [bit] NOT NULL,
	[Hotline] [nvarchar](4000) NULL,
	[Email] [nvarchar](4000) NULL,
	[Description] [nvarchar](4000) NULL,
	[TimeWork] [nvarchar](4000) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](256) NULL,
	[Slogan] [nvarchar](4000) NULL,
 CONSTRAINT [PK_dbo.SystemSetting] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[Email] [nvarchar](50) NULL,
	[EmailConfirmed] [bit] NULL,
	[PasswordHash] [nvarchar](4000) NULL,
	[SecurityStamp] [nvarchar](4000) NULL,
	[FirstName] [nvarchar](max) NULL,
	[MiddleName] [nvarchar](max) NULL,
	[LastName] [nvarchar](max) NULL,
	[Address] [nvarchar](max) NULL,
	[City] [nvarchar](max) NULL,
	[State] [nvarchar](max) NULL,
	[Phone] [nvarchar](max) NULL,
	[IsLockedOut] [bit] NOT NULL,
	[IsSuperAdmin] [bit] NOT NULL,
	[Created] [datetime] NOT NULL,
	[LastLogin] [datetime] NULL,
 CONSTRAINT [PK_dbo.User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[RoleId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_dbo.UserRole] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Address] ON 

INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1, N'abb', N'b', N'ddemo9698@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-02-08T16:06:09.057' AS DateTime), N'c258456', CAST(N'2018-02-08T16:06:09.057' AS DateTime), N'c258456')
INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2, N'congtt', NULL, N'ddemo9698@gmail.com', NULL, 0, 0, NULL, N'hcm1', NULL, NULL, N'0123', NULL, NULL, NULL, CAST(N'2018-02-08T16:09:07.967' AS DateTime), N'c258456', CAST(N'2018-02-08T16:09:07.967' AS DateTime), N'c258456')
INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (3, N'Truong', N'Cong', N'ddemo9698@gmail.com', NULL, NULL, NULL, NULL, N'HCM', NULL, NULL, N'123456789', NULL, NULL, NULL, CAST(N'2018-02-10T09:17:10.017' AS DateTime), N'Administrator', CAST(N'2018-02-10T09:17:10.017' AS DateTime), N'Administrator')
INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (4, N'congtt1', NULL, N'ddemo9698@gmail.com', NULL, 0, 0, NULL, N'hcm', NULL, NULL, N'012345678', NULL, NULL, NULL, CAST(N'2018-02-19T10:12:18.463' AS DateTime), N'Administrator', CAST(N'2018-02-19T10:12:18.463' AS DateTime), N'Administrator')
INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (5, N'congtt1', NULL, N'ddemo9698@gmail.com', NULL, 0, 0, NULL, N'hcm', NULL, NULL, N'012345678', NULL, NULL, NULL, CAST(N'2018-02-19T10:23:14.053' AS DateTime), N'Administrator', CAST(N'2018-02-19T10:23:14.053' AS DateTime), N'Administrator')
INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (6, N'trahnh', N'cong', N'ddemo9698@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-02-21T15:15:21.377' AS DateTime), N'congtt', CAST(N'2018-02-21T15:15:21.377' AS DateTime), N'congtt')
INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (7, N'congtt2', NULL, N'ddemo9698@gmail.com', NULL, 0, 0, NULL, N'3104 Doctors Drive', NULL, NULL, N'123131231321', NULL, NULL, NULL, CAST(N'2018-02-21T15:39:56.707' AS DateTime), N'congtt', CAST(N'2018-02-21T15:39:56.707' AS DateTime), N'congtt')
INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (8, N'Truong', N'Cong', N'ddemo9698@gmail.com', NULL, NULL, NULL, NULL, N'HCM', NULL, NULL, N'123456789', NULL, NULL, NULL, CAST(N'2018-02-21T15:51:42.240' AS DateTime), N'Administrator', CAST(N'2018-02-21T15:51:42.240' AS DateTime), N'Administrator')
INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (9, N'trahnh', N'cong', N'ddemo9698@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-03-13T15:53:30.520' AS DateTime), N'congtt', CAST(N'2018-03-13T15:53:30.520' AS DateTime), N'congtt')
INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (10, N'congtt21', N'congtt21', N'truong.thanhcong89@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-03-17T00:35:39.717' AS DateTime), N'truongthanhcong', CAST(N'2018-03-17T00:35:39.717' AS DateTime), N'truongthanhcong')
INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (11, N'congtt21', N'congtt21', N'ddemo9698@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-03-22T13:52:20.747' AS DateTime), N'DemoVictim', CAST(N'2018-03-22T13:52:20.747' AS DateTime), N'DemoVictim')
INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (12, N'1212', NULL, N'ddemo9698@gmail.com', NULL, 0, 0, NULL, N'12', NULL, NULL, N'2', NULL, NULL, NULL, CAST(N'2018-04-13T15:14:16.733' AS DateTime), N'Administrator', CAST(N'2018-04-13T15:14:16.733' AS DateTime), N'Administrator')
INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (13, N'1212', NULL, N'ddemo9698@gmail.com', NULL, 0, 0, NULL, N'12', NULL, NULL, N'2', NULL, NULL, NULL, CAST(N'2018-04-13T15:15:45.030' AS DateTime), N'Administrator', CAST(N'2018-04-13T15:16:20.980' AS DateTime), N'Administrator')
INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (14, N'1212', NULL, N'ddemo9698@gmail.com', NULL, 0, 0, NULL, N'12', NULL, NULL, N'2', NULL, NULL, NULL, CAST(N'2018-04-13T15:16:03.383' AS DateTime), N'Administrator', CAST(N'2018-04-13T15:16:22.340' AS DateTime), N'Administrator')
INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (15, N'Cong', NULL, N'ddemo9698@gmail.com', NULL, 0, 0, NULL, N'3104 Doctors Drive', NULL, NULL, N'121231', NULL, NULL, NULL, CAST(N'2018-04-13T16:33:12.457' AS DateTime), N'Administrator', CAST(N'2018-04-13T16:33:12.457' AS DateTime), N'Administrator')
INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (16, N'12', NULL, N'fsdafas@gmail.com', NULL, 0, 0, NULL, N'12', NULL, NULL, N'12', NULL, NULL, NULL, CAST(N'2018-04-13T17:06:44.740' AS DateTime), N'truong thanh cong', CAST(N'2018-04-13T17:06:44.740' AS DateTime), N'truong thanh cong')
INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (17, N'12', NULL, N'fsdafas@gmail.com', NULL, 0, 0, NULL, N'12', NULL, NULL, N'12', NULL, NULL, NULL, CAST(N'2018-04-14T01:36:44.437' AS DateTime), N'truong thanh cong', CAST(N'2018-04-14T01:36:44.437' AS DateTime), N'truong thanh cong')
INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (18, N'Cong', NULL, N'ddemo9698@gmail.com', NULL, 0, 0, NULL, N'3104 Doctors Drive', NULL, NULL, N'1212', NULL, NULL, NULL, CAST(N'2018-04-14T16:01:07.503' AS DateTime), N'truong thanh cong', CAST(N'2018-04-14T16:01:07.503' AS DateTime), N'truong thanh cong')
INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (19, N'x', NULL, N'ddemo9698@gmail.com', NULL, 0, 0, NULL, N'3104 Doctors Drive', NULL, NULL, N'4155874779', NULL, NULL, NULL, CAST(N'2018-04-14T17:15:31.973' AS DateTime), N'Administrator', CAST(N'2018-04-14T17:15:31.973' AS DateTime), N'Administrator')
INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (20, N'tes', NULL, N'ddemo9698@gmail.com', NULL, 0, 0, NULL, N'3104 Doctors Drive', NULL, NULL, N'212', NULL, NULL, NULL, CAST(N'2018-05-10T14:41:13.950' AS DateTime), N'Administrator', CAST(N'2018-05-10T14:41:13.950' AS DateTime), N'Administrator')
INSERT [dbo].[Address] ([Id], [FirstName], [LastName], [Email], [Company], [CountryId], [StateProvinceId], [City], [Address1], [Address2], [ZipPostalCode], [PhoneNumber], [FaxNumber], [Salutation], [Title], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (21, N'hcm', NULL, N'ddemo9698@gmail.com', NULL, 0, 0, NULL, N'3104 Doctors Drive', NULL, NULL, N'4155874779', NULL, NULL, NULL, CAST(N'2018-05-13T12:53:41.827' AS DateTime), N'DemoVictim', CAST(N'2018-05-13T12:53:41.827' AS DateTime), N'DemoVictim')
SET IDENTITY_INSERT [dbo].[Address] OFF
SET IDENTITY_INSERT [dbo].[AttribureValue] ON 

INSERT [dbo].[AttribureValue] ([Id], [ValueName], [ColorHex], [Description], [Status], [OrderDisplay], [AttributeId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1, N'Gold', N'#ede9be', N'fdfdfdfd', 1, 1, 1, CAST(N'2017-02-20T05:39:48.157' AS DateTime), N'Administrator', CAST(N'2018-05-19T13:36:56.863' AS DateTime), N'Administrator')
INSERT [dbo].[AttribureValue] ([Id], [ValueName], [ColorHex], [Description], [Status], [OrderDisplay], [AttributeId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2, N'Black', N'#000000', NULL, 1, 2, 1, CAST(N'2017-02-26T10:00:49.053' AS DateTime), N'Administrator', CAST(N'2017-03-23T07:09:19.473' AS DateTime), N'Administrator')
INSERT [dbo].[AttribureValue] ([Id], [ValueName], [ColorHex], [Description], [Status], [OrderDisplay], [AttributeId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (3, N'Rose Gold', N'#f0cccc', NULL, 1, 3, 1, CAST(N'2017-03-23T07:06:36.943' AS DateTime), N'Administrator', CAST(N'2017-03-23T07:06:36.943' AS DateTime), N'Administrator')
INSERT [dbo].[AttribureValue] ([Id], [ValueName], [ColorHex], [Description], [Status], [OrderDisplay], [AttributeId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (4, N'Silver', N'#d4d4d4', NULL, 1, 4, 1, CAST(N'2017-03-23T07:07:07.693' AS DateTime), N'Administrator', CAST(N'2017-03-23T07:07:24.647' AS DateTime), N'Administrator')
INSERT [dbo].[AttribureValue] ([Id], [ValueName], [ColorHex], [Description], [Status], [OrderDisplay], [AttributeId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (5, N'Jet Black', N'#1c7dbd', N'2', 1, 5, 1, CAST(N'2017-03-23T07:09:00.457' AS DateTime), N'Administrator', CAST(N'2018-05-19T13:36:49.983' AS DateTime), N'Administrator')
INSERT [dbo].[AttribureValue] ([Id], [ValueName], [ColorHex], [Description], [Status], [OrderDisplay], [AttributeId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (6, N'Red', N'#e33232', NULL, 1, 6, 1, CAST(N'2017-03-23T07:10:06.347' AS DateTime), N'Administrator', CAST(N'2017-04-13T21:44:39.413' AS DateTime), N'Administrator')
INSERT [dbo].[AttribureValue] ([Id], [ValueName], [ColorHex], [Description], [Status], [OrderDisplay], [AttributeId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (7, N'Test', N'#1b5cd4', N'1', 1, 1, 1, CAST(N'2017-05-27T03:51:42.323' AS DateTime), N'Administrator', CAST(N'2017-05-27T03:51:42.323' AS DateTime), N'Administrator')
INSERT [dbo].[AttribureValue] ([Id], [ValueName], [ColorHex], [Description], [Status], [OrderDisplay], [AttributeId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (8, N'size M', NULL, N'12', 1, 12, 2, CAST(N'2017-05-27T03:56:27.213' AS DateTime), N'Administrator', CAST(N'2017-05-27T03:56:27.213' AS DateTime), N'Administrator')
INSERT [dbo].[AttribureValue] ([Id], [ValueName], [ColorHex], [Description], [Status], [OrderDisplay], [AttributeId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (10, N'Black', N'#000000', N'fdfdfd', 1, 2, 1, CAST(N'2018-04-14T15:54:15.450' AS DateTime), N'truong thanh cong', CAST(N'2018-05-19T13:30:21.373' AS DateTime), N'Administrator')
INSERT [dbo].[AttribureValue] ([Id], [ValueName], [ColorHex], [Description], [Status], [OrderDisplay], [AttributeId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (11, N'size M', NULL, N'12d', 1, 12, 2, CAST(N'2018-04-14T15:54:15.450' AS DateTime), N'truong thanh cong', CAST(N'2018-05-19T13:36:44.107' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[AttribureValue] OFF
SET IDENTITY_INSERT [dbo].[Attribute] ON 

INSERT [dbo].[Attribute] ([Id], [AttributeName], [OrderDisplay], [Status], [Description], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1, N'Màu', 1, 1, N'Màu điện thoại a', CAST(N'2017-02-20T05:39:20.593' AS DateTime), N'Administrator', CAST(N'2017-12-19T15:57:17.787' AS DateTime), N'Administrator')
INSERT [dbo].[Attribute] ([Id], [AttributeName], [OrderDisplay], [Status], [Description], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2, N'Size', 1, 1, N'121212 adfadsfsdaf', CAST(N'2017-05-27T03:52:20.183' AS DateTime), N'Administrator', CAST(N'2017-12-19T15:57:28.143' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[Attribute] OFF
SET IDENTITY_INSERT [dbo].[Banner] ON 

INSERT [dbo].[Banner] ([Id], [Title], [WebsiteLink], [ImgPath], [Language], [Width], [Height], [Target], [FromDate], [ToDate], [Status], [OrderDisplay], [PageId], [MenuId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2, N'Banner home product left', NULL, N'images/Ads/2018.BHPL/banner-bottom2.d2f7ee53.jpg', NULL, NULL, NULL, N'_blank', NULL, NULL, 1, 1, 6, 2123, CAST(N'2017-02-20T07:20:15.093' AS DateTime), N'Administrator', CAST(N'2018-05-22T15:20:01.083' AS DateTime), N'Administrator')
INSERT [dbo].[Banner] ([Id], [Title], [WebsiteLink], [ImgPath], [Language], [Width], [Height], [Target], [FromDate], [ToDate], [Status], [OrderDisplay], [PageId], [MenuId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (7, N'Banner top truyền thông', NULL, N'images/Ads/2018.BTTT/slide-du-an-khu-nha-o-nhan-vien-six-senses-con-dao-resort-f0723202.1de19d0d.jpg', NULL, NULL, NULL, N'_blank', NULL, NULL, 1, 3, 1, 110, CAST(N'2017-03-20T12:15:15.163' AS DateTime), N'Administrator', CAST(N'2018-05-13T10:16:31.670' AS DateTime), N'Administrator')
INSERT [dbo].[Banner] ([Id], [Title], [WebsiteLink], [ImgPath], [Language], [Width], [Height], [Target], [FromDate], [ToDate], [Status], [OrderDisplay], [PageId], [MenuId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (8, N'Slide dau trang', NULL, N'images/Ads/blog-nha-dep-3.jpg', NULL, NULL, NULL, N'_blank', NULL, NULL, 1, 4, 7, NULL, CAST(N'2017-03-23T09:47:41.567' AS DateTime), N'Administrator', CAST(N'2017-10-12T14:27:45.027' AS DateTime), N'Administrator')
INSERT [dbo].[Banner] ([Id], [Title], [WebsiteLink], [ImgPath], [Language], [Width], [Height], [Target], [FromDate], [ToDate], [Status], [OrderDisplay], [PageId], [MenuId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (9, N'Banner home product', NULL, N'images/Ads/2018.BHP/banner-botom1.0a0e11ad.jpg', NULL, NULL, NULL, N'_blank', NULL, NULL, 1, 1, 6, 2123, CAST(N'2017-05-14T05:10:32.647' AS DateTime), N'Administrator', CAST(N'2018-05-22T15:19:24.620' AS DateTime), N'Administrator')
INSERT [dbo].[Banner] ([Id], [Title], [WebsiteLink], [ImgPath], [Language], [Width], [Height], [Target], [FromDate], [ToDate], [Status], [OrderDisplay], [PageId], [MenuId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (11, N'Banner top trang gioi thieu', NULL, N'images/Ads/phoi-canh-vinhomes-central-park.jpg', NULL, NULL, NULL, N'_blank', NULL, NULL, 1, 1, 1, 45, CAST(N'2017-06-18T08:16:04.423' AS DateTime), N'Administrator', CAST(N'2017-10-11T16:40:59.317' AS DateTime), N'Administrator')
INSERT [dbo].[Banner] ([Id], [Title], [WebsiteLink], [ImgPath], [Language], [Width], [Height], [Target], [FromDate], [ToDate], [Status], [OrderDisplay], [PageId], [MenuId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (12, N'side dau trang', NULL, N'images/Ads/phong ngu 2.jpg', NULL, NULL, NULL, N'_blank', NULL, NULL, 1, 2, 7, NULL, CAST(N'2017-10-12T14:32:58.213' AS DateTime), N'Administrator', CAST(N'2017-10-12T14:32:58.213' AS DateTime), N'Administrator')
INSERT [dbo].[Banner] ([Id], [Title], [WebsiteLink], [ImgPath], [Language], [Width], [Height], [Target], [FromDate], [ToDate], [Status], [OrderDisplay], [PageId], [MenuId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (13, N'Banner top tuyển dụng', NULL, N'images/Ads/2018.BTTD/sixsence-v2.68e29e25.jpg', NULL, NULL, NULL, N'_blank', NULL, NULL, 1, 1, 1, 1111, CAST(N'2018-05-13T10:27:11.697' AS DateTime), N'Administrator', CAST(N'2018-05-13T10:27:11.697' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[Banner] OFF
SET IDENTITY_INSERT [dbo].[Brand] ON 

INSERT [dbo].[Brand] ([Id], [Name], [Description], [OrderDisplay], [Status], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1, N'HCM', NULL, 1, 1, CAST(N'2017-05-27T05:39:20.183' AS DateTime), N'Administrator', CAST(N'2018-05-17T14:55:05.033' AS DateTime), N'Administrator')
INSERT [dbo].[Brand] ([Id], [Name], [Description], [OrderDisplay], [Status], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2, N'MT', NULL, 2, 1, CAST(N'2017-05-27T05:39:27.437' AS DateTime), N'Administrator', CAST(N'2018-05-25T17:14:04.953' AS DateTime), N'Administrator')
INSERT [dbo].[Brand] ([Id], [Name], [Description], [OrderDisplay], [Status], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (3, N'HN1', NULL, 1, 1, CAST(N'2017-05-27T06:25:25.383' AS DateTime), N'Administrator', CAST(N'2018-05-25T17:14:09.780' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[Brand] OFF
SET IDENTITY_INSERT [dbo].[ContactInformation] ON 

INSERT [dbo].[ContactInformation] ([Id], [Language], [Title], [Lag], [Lat], [Type], [OrderDisplay], [Status], [Email], [Hotline], [Address], [MobilePhone], [Fax], [NumberOfStore], [ProvinceId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2, NULL, N'Thương hiệu thời trang Mazzola', N'105.80942804655763', N'21.00882386928425', 1, 73, 1, N'info@namlongfashion.com.vn', N'121233335', N'DD18 Bạch Mã, Phường 15, Quận 10, TP.HCM', N' 0901 801 268', NULL, NULL, 1, CAST(N'2017-06-28T16:21:18.527' AS DateTime), N'Administrator', CAST(N'2018-01-17T15:29:11.647' AS DateTime), N'Administrator')
INSERT [dbo].[ContactInformation] ([Id], [Language], [Title], [Lag], [Lat], [Type], [OrderDisplay], [Status], [Email], [Hotline], [Address], [MobilePhone], [Fax], [NumberOfStore], [ProvinceId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (5, NULL, N'Mazzola 1', NULL, NULL, 0, 1, 1, N'info@namlongfashion.com.vn', N'12', N'99 Trương Định, phường 6, Quận 3', N'12', N'12', NULL, 1, CAST(N'2018-01-17T15:39:55.323' AS DateTime), N'Administrator', CAST(N'2018-01-17T15:39:55.323' AS DateTime), N'Administrator')
INSERT [dbo].[ContactInformation] ([Id], [Language], [Title], [Lag], [Lat], [Type], [OrderDisplay], [Status], [Email], [Hotline], [Address], [MobilePhone], [Fax], [NumberOfStore], [ProvinceId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (6, NULL, N'Mazzola 2', NULL, NULL, 0, 1, 1, N'info@namlongfashion.com.vn', NULL, N'206 Quang Trung, P.10, Q.Gò Vấp', NULL, NULL, NULL, 1, CAST(N'2018-01-17T15:44:59.110' AS DateTime), N'Administrator', CAST(N'2018-01-17T15:44:59.110' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[ContactInformation] OFF
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([Id], [CustomerGuid], [Username], [Email], [Password], [PasswordFormatId], [PasswordSalt], [AdminComment], [IsTaxExempt], [AffiliateId], [Active], [Deleted], [IsSystemAccount], [SystemName], [LastIpAddress], [CreatedOnUtc], [LastLoginDateUtc], [LastActivityDateUtc], [BillingAddress_Id], [ShippingAddress_Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (5, N'90dc7ff0-ea2a-401e-a2d5-6b9737c76bbd', N'Administrator', N'ddemo9698@gmail.com', N'AEgZor3mVztRKy4Fy7cMAWDEpzvoi4xuY2gj6LbGC7B8z02IfO3lul4IZHMPnuS5Kg==', 0, NULL, NULL, 0, 0, 1, 0, 0, NULL, NULL, CAST(N'2018-02-21T15:51:42.240' AS DateTime), CAST(N'2018-02-21T15:51:42.240' AS DateTime), CAST(N'2018-02-21T15:51:42.240' AS DateTime), 20, 19, CAST(N'2018-02-21T15:51:42.240' AS DateTime), N'Administrator', CAST(N'2018-05-27T15:39:20.747' AS DateTime), N'Administrator')
INSERT [dbo].[Customer] ([Id], [CustomerGuid], [Username], [Email], [Password], [PasswordFormatId], [PasswordSalt], [AdminComment], [IsTaxExempt], [AffiliateId], [Active], [Deleted], [IsSystemAccount], [SystemName], [LastIpAddress], [CreatedOnUtc], [LastLoginDateUtc], [LastActivityDateUtc], [BillingAddress_Id], [ShippingAddress_Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (9, N'f3cf155c-e073-46b9-a933-593a29a29d91', N'congtt', N'ddemo9698@gmail.com', N'AJ0BGX7kg4ug5EiRNMUefNFpyo4MmuI7NbwaKS2PagaRkrVGAmNtErkKlUp/7Z7W9w==', 0, NULL, NULL, 0, 0, 1, 0, 0, NULL, NULL, CAST(N'2018-03-13T15:53:30.477' AS DateTime), CAST(N'2018-03-13T15:53:30.477' AS DateTime), CAST(N'2018-03-13T15:53:30.477' AS DateTime), 9, 9, CAST(N'2018-03-13T15:53:30.520' AS DateTime), N'congtt', CAST(N'2018-03-15T13:43:52.427' AS DateTime), N'congtt')
INSERT [dbo].[Customer] ([Id], [CustomerGuid], [Username], [Email], [Password], [PasswordFormatId], [PasswordSalt], [AdminComment], [IsTaxExempt], [AffiliateId], [Active], [Deleted], [IsSystemAccount], [SystemName], [LastIpAddress], [CreatedOnUtc], [LastLoginDateUtc], [LastActivityDateUtc], [BillingAddress_Id], [ShippingAddress_Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (10, N'bb72dda7-bc03-4e0d-96b6-1e8256770ea9', N'truongthanhcong', N'truong.thanhcong89@gmail.com', NULL, 0, NULL, NULL, 0, 0, 1, 0, 0, NULL, NULL, CAST(N'2018-03-17T00:35:39.703' AS DateTime), CAST(N'2018-03-17T00:35:39.703' AS DateTime), CAST(N'2018-03-17T00:35:39.703' AS DateTime), 18, 18, CAST(N'2018-03-17T00:35:39.717' AS DateTime), N'truongthanhcong', CAST(N'2018-04-14T17:08:23.737' AS DateTime), N'truong thanh cong')
INSERT [dbo].[Customer] ([Id], [CustomerGuid], [Username], [Email], [Password], [PasswordFormatId], [PasswordSalt], [AdminComment], [IsTaxExempt], [AffiliateId], [Active], [Deleted], [IsSystemAccount], [SystemName], [LastIpAddress], [CreatedOnUtc], [LastLoginDateUtc], [LastActivityDateUtc], [BillingAddress_Id], [ShippingAddress_Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (11, N'57f2e911-7e87-486f-9999-230c80ca769d', N'DemoVictim', N'ddemo9698@gmail.com', NULL, 0, NULL, NULL, 0, 0, 1, 0, 0, NULL, NULL, CAST(N'2018-03-22T13:52:20.737' AS DateTime), CAST(N'2018-03-22T13:52:20.737' AS DateTime), CAST(N'2018-03-22T13:52:20.737' AS DateTime), 21, 21, CAST(N'2018-03-22T13:52:20.747' AS DateTime), N'DemoVictim', CAST(N'2018-05-13T12:53:54.943' AS DateTime), N'DemoVictim')
INSERT [dbo].[Customer] ([Id], [CustomerGuid], [Username], [Email], [Password], [PasswordFormatId], [PasswordSalt], [AdminComment], [IsTaxExempt], [AffiliateId], [Active], [Deleted], [IsSystemAccount], [SystemName], [LastIpAddress], [CreatedOnUtc], [LastLoginDateUtc], [LastActivityDateUtc], [BillingAddress_Id], [ShippingAddress_Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (13, N'fa5fcd11-24fd-4376-a34a-197111b6f552', NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 1, 0, 0, NULL, NULL, CAST(N'2018-05-13T12:03:45.463' AS DateTime), CAST(N'2018-05-13T12:03:45.463' AS DateTime), CAST(N'2018-05-13T12:03:45.463' AS DateTime), NULL, NULL, CAST(N'2018-05-13T12:03:45.527' AS DateTime), N'', CAST(N'2018-05-13T12:03:45.527' AS DateTime), N'')
INSERT [dbo].[Customer] ([Id], [CustomerGuid], [Username], [Email], [Password], [PasswordFormatId], [PasswordSalt], [AdminComment], [IsTaxExempt], [AffiliateId], [Active], [Deleted], [IsSystemAccount], [SystemName], [LastIpAddress], [CreatedOnUtc], [LastLoginDateUtc], [LastActivityDateUtc], [BillingAddress_Id], [ShippingAddress_Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (14, N'270b3669-a413-44f6-901e-91167ae214f7', NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 1, 0, 0, NULL, NULL, CAST(N'2018-05-22T14:20:06.823' AS DateTime), CAST(N'2018-05-22T14:20:06.823' AS DateTime), CAST(N'2018-05-22T14:20:06.823' AS DateTime), NULL, NULL, CAST(N'2018-05-22T14:20:06.833' AS DateTime), N'', CAST(N'2018-05-22T14:20:06.833' AS DateTime), N'')
SET IDENTITY_INSERT [dbo].[Customer] OFF
INSERT [dbo].[CustomerAddresses] ([Customer_Id], [Address_Id]) VALUES (5, 19)
INSERT [dbo].[CustomerAddresses] ([Customer_Id], [Address_Id]) VALUES (5, 20)
INSERT [dbo].[CustomerAddresses] ([Customer_Id], [Address_Id]) VALUES (10, 18)
INSERT [dbo].[CustomerAddresses] ([Customer_Id], [Address_Id]) VALUES (11, 21)
INSERT [dbo].[ExternalLogin] ([LoginProvider], [ProviderKey], [UserId]) VALUES (N'Google', N'104725362127820015522', N'bb72dda7-bc03-4e0d-96b6-1e8256770ea9')
INSERT [dbo].[ExternalLogin] ([LoginProvider], [ProviderKey], [UserId]) VALUES (N'Google', N'107297564061909337921', N'57f2e911-7e87-486f-9999-230c80ca769d')
SET IDENTITY_INSERT [dbo].[GalleryImage] ON 

INSERT [dbo].[GalleryImage] ([Id], [Title], [ImageBig], [ImageThumbnail], [Status], [OrderDisplay], [PostId], [AttributeValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Price]) VALUES (1056, N'Khu du lịch Cát Vân', N'images/post/2018.KDLCV/attr-slide-biet-thu-chi-thuy-gamuda-garden-11d49eba.979aba06.JPG', N'images/post/2018.KDLCV/attr-slide-biet-thu-chi-thuy-gamuda-garden-11d49eba.de4e2f4f.JPG', 1, 1, 42, 2, CAST(N'2018-05-13T13:07:09.170' AS DateTime), N'Administrator', CAST(N'2018-05-13T15:59:03.327' AS DateTime), N'Administrator', CAST(50000.0000 AS Decimal(18, 4)))
INSERT [dbo].[GalleryImage] ([Id], [Title], [ImageBig], [ImageThumbnail], [Status], [OrderDisplay], [PostId], [AttributeValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Price]) VALUES (1057, N'Khu du lịch Cát Vân', N'images/post/2018.KDLCV/attr-sixsence-v2.21611130.jpg', N'images/post/2018.KDLCV/attr-sixsence-v2.ab217516.jpg', 1, 1, 42, 2, CAST(N'2018-05-13T13:46:20.177' AS DateTime), N'Administrator', CAST(N'2018-05-13T13:46:20.177' AS DateTime), N'Administrator', CAST(50000.0000 AS Decimal(18, 4)))
INSERT [dbo].[GalleryImage] ([Id], [Title], [ImageBig], [ImageThumbnail], [Status], [OrderDisplay], [PostId], [AttributeValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Price]) VALUES (1058, N'Khu du lịch Cát Vân', N'images/post/2018.KDLCV/attr-sixsence-v3.5dd4841f.jpg', N'images/post/2018.KDLCV/attr-sixsence-v3.8cc4b716.jpg', 1, 1, 42, 1, CAST(N'2018-05-13T13:48:32.173' AS DateTime), N'Administrator', CAST(N'2018-05-13T15:59:03.307' AS DateTime), N'Administrator', CAST(40000.0000 AS Decimal(18, 4)))
INSERT [dbo].[GalleryImage] ([Id], [Title], [ImageBig], [ImageThumbnail], [Status], [OrderDisplay], [PostId], [AttributeValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Price]) VALUES (1059, N'Ghế nhựa kiểu dạng lưới cao cấp', N'images/post/2018.GNKDLCC/attr-02_yellow-dress.70cee63e.jpg', N'images/post/2018.GNKDLCC/attr-02_yellow-dress.069b7ae7.jpg', 1, 1, 50, 1, CAST(N'2018-05-15T15:06:51.503' AS DateTime), N'Administrator', CAST(N'2018-05-15T15:06:51.623' AS DateTime), N'Administrator', CAST(30000.0000 AS Decimal(18, 4)))
INSERT [dbo].[GalleryImage] ([Id], [Title], [ImageBig], [ImageThumbnail], [Status], [OrderDisplay], [PostId], [AttributeValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Price]) VALUES (1060, N'Ghế nhựa kiểu dạng lưới cao cấp', N'images/post/2018.GNKDLCC/attr-2.ff809c1f.jpg', N'images/post/2018.GNKDLCC/attr-2.8fc61fe4.jpg', 1, 2, 50, 2, CAST(N'2018-05-15T15:06:51.503' AS DateTime), N'Administrator', CAST(N'2018-05-15T15:06:51.637' AS DateTime), N'Administrator', CAST(80000.0000 AS Decimal(18, 4)))
INSERT [dbo].[GalleryImage] ([Id], [Title], [ImageBig], [ImageThumbnail], [Status], [OrderDisplay], [PostId], [AttributeValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Price]) VALUES (1062, N'Dự án Long An', N'images/post/2018.DALA/attr-blog-full.7d7fc471.jpg', N'images/post/2018.DALA/attr-blog-full.15950884.jpg', 1, 1, 101, 1, CAST(N'2018-05-19T11:34:49.840' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:53:58.367' AS DateTime), N'Administrator', CAST(49974.0000 AS Decimal(18, 4)))
INSERT [dbo].[GalleryImage] ([Id], [Title], [ImageBig], [ImageThumbnail], [Status], [OrderDisplay], [PostId], [AttributeValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Price]) VALUES (1063, N'Dự án Long An', N'images/post/2018.DALA/attr-bs2.361cfc66.jpg', N'images/post/2018.DALA/attr-bs2.a0875f9b.jpg', 1, 2, 101, 1, CAST(N'2018-05-19T11:34:49.840' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:34:49.840' AS DateTime), N'Administrator', CAST(49974.0000 AS Decimal(18, 4)))
INSERT [dbo].[GalleryImage] ([Id], [Title], [ImageBig], [ImageThumbnail], [Status], [OrderDisplay], [PostId], [AttributeValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Price]) VALUES (1064, N'Dự án Long An', N'images/post/2018.DALA/attr-04_nice-dress.c1c88773.jpg', N'images/post/2018.DALA/attr-04_nice-dress.dbbfca66.jpg', 1, 1, 101, 2, CAST(N'2018-05-19T11:45:02.693' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:53:58.377' AS DateTime), N'Administrator', CAST(11.0000 AS Decimal(18, 4)))
INSERT [dbo].[GalleryImage] ([Id], [Title], [ImageBig], [ImageThumbnail], [Status], [OrderDisplay], [PostId], [AttributeValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Price]) VALUES (1068, N'Maecenas consequat mauris', N'images/post/2018.MCM/attr-bs1.5c50f024.jpg', N'images/post/2018.MCM/attr-bs1.e7b007fe.jpg', 1, 1, 102, 1, CAST(N'2018-05-19T12:23:22.303' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:23:22.333' AS DateTime), N'Administrator', CAST(50000.0000 AS Decimal(18, 4)))
SET IDENTITY_INSERT [dbo].[GalleryImage] OFF
SET IDENTITY_INSERT [dbo].[GenericAttribute] ON 

INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (3, 1, N'Customer', N'LanguageId', N'1', 1, CAST(N'2017-08-18T00:00:00.000' AS DateTime), N'Admin', CAST(N'2017-09-16T12:16:58.497' AS DateTime), N'Administrator')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (16, 1011, N'Customer', N'SelectedPaymentMethod', N'Thanh toán khi giao hàng (COD)', 0, CAST(N'2017-11-21T16:21:10.263' AS DateTime), N'Administrator', CAST(N'2017-11-21T16:21:10.263' AS DateTime), N'Administrator')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (17, 1011, N'Customer', N'SelectedShippingOption', N'In-Store Pickup', 0, CAST(N'2017-11-21T16:21:10.313' AS DateTime), N'Administrator', CAST(N'2017-11-21T16:21:10.313' AS DateTime), N'Administrator')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1008, 1011, N'Customer', N'LanguageId', N'1', 1, CAST(N'2017-12-08T15:49:16.143' AS DateTime), N'Administrator', CAST(N'2017-12-08T15:49:16.143' AS DateTime), N'Administrator')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1009, 2011, N'Customer', N'LanguageId', N'1', 1, CAST(N'2017-12-20T16:18:47.943' AS DateTime), N'', CAST(N'2017-12-20T16:18:47.943' AS DateTime), N'')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1010, 2012, N'Customer', N'LanguageId', N'1', 1, CAST(N'2017-12-20T16:43:43.807' AS DateTime), N'Administrator', CAST(N'2017-12-20T16:43:43.807' AS DateTime), N'Administrator')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1011, 2013, N'Customer', N'LanguageId', N'1', 1, CAST(N'2017-12-22T14:54:15.560' AS DateTime), N'', CAST(N'2017-12-22T14:54:15.560' AS DateTime), N'')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1012, 2014, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-01-06T01:17:29.020' AS DateTime), N'Administrator', CAST(N'2018-01-06T01:17:29.020' AS DateTime), N'Administrator')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1013, 2015, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-01-06T03:08:01.960' AS DateTime), N'', CAST(N'2018-01-06T03:08:01.960' AS DateTime), N'')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1014, 2014, N'Customer', N'SelectedPaymentMethod', N'Thanh toán khi giao hàng (COD)', 0, CAST(N'2018-01-12T15:59:18.430' AS DateTime), N'Administrator', CAST(N'2018-01-12T16:30:10.797' AS DateTime), N'Administrator')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1015, 2014, N'Customer', N'SelectedShippingOption', N'In-Store Pickup', 0, CAST(N'2018-01-12T15:59:18.447' AS DateTime), N'Administrator', CAST(N'2018-01-12T16:30:10.817' AS DateTime), N'Administrator')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1016, 2016, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-01-16T16:30:05.453' AS DateTime), N'', CAST(N'2018-01-16T16:30:05.453' AS DateTime), N'')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1017, 2020, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-01-21T17:16:00.940' AS DateTime), N'c258456', CAST(N'2018-01-21T17:16:00.940' AS DateTime), N'c258456')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1018, 2023, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-01-22T15:32:19.613' AS DateTime), N'c258456', CAST(N'2018-01-22T15:32:19.613' AS DateTime), N'c258456')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1019, 2024, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-01-22T16:08:07.353' AS DateTime), N'c258456', CAST(N'2018-01-22T16:08:07.353' AS DateTime), N'c258456')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1020, 2027, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-01-22T16:08:48.303' AS DateTime), N'c258456', CAST(N'2018-01-22T16:08:48.303' AS DateTime), N'c258456')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1021, 2026, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-01-22T16:08:48.303' AS DateTime), N'c258456', CAST(N'2018-01-22T16:08:48.303' AS DateTime), N'c258456')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1022, 2028, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-01-22T16:13:59.687' AS DateTime), N'c258456', CAST(N'2018-01-22T16:13:59.687' AS DateTime), N'c258456')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1023, 2030, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-01-22T16:16:17.537' AS DateTime), N'c258456', CAST(N'2018-01-22T16:16:17.537' AS DateTime), N'c258456')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1024, 2033, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-01-22T16:20:41.527' AS DateTime), N'c258456', CAST(N'2018-01-22T16:20:41.527' AS DateTime), N'c258456')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1025, 2032, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-01-22T16:21:05.243' AS DateTime), N'c258456', CAST(N'2018-01-22T16:21:05.243' AS DateTime), N'c258456')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1026, 2034, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-01-22T16:23:32.140' AS DateTime), N'c258456', CAST(N'2018-01-22T16:23:32.140' AS DateTime), N'c258456')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1027, 2034, N'Customer', N'SelectedPaymentMethod', N'Thanh toán khi giao hàng (COD)', 0, CAST(N'2018-01-22T16:25:55.320' AS DateTime), N'c258456', CAST(N'2018-01-27T17:05:01.560' AS DateTime), N'c258456')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1028, 2034, N'Customer', N'SelectedShippingOption', N'In-Store Pickup', 0, CAST(N'2018-01-22T16:25:55.347' AS DateTime), N'c258456', CAST(N'2018-01-27T17:05:01.597' AS DateTime), N'c258456')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1029, 2035, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-01-26T15:00:16.157' AS DateTime), N'', CAST(N'2018-01-26T15:00:16.157' AS DateTime), N'')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1030, 2036, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-01-26T15:11:57.527' AS DateTime), N'Administrator', CAST(N'2018-01-26T15:11:57.527' AS DateTime), N'Administrator')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1031, 2037, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-01-26T16:22:39.760' AS DateTime), N'', CAST(N'2018-01-26T16:22:39.760' AS DateTime), N'')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1032, 2036, N'Customer', N'SelectedPaymentMethod', N'Thanh toán khi giao hàng (COD)', 0, CAST(N'2018-01-27T07:06:53.083' AS DateTime), N'Administrator', CAST(N'2018-01-27T07:06:53.083' AS DateTime), N'Administrator')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1033, 2036, N'Customer', N'SelectedShippingOption', N'In-Store Pickup', 0, CAST(N'2018-01-27T07:06:53.103' AS DateTime), N'Administrator', CAST(N'2018-01-27T07:06:53.103' AS DateTime), N'Administrator')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1034, 2038, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-01-28T08:19:39.270' AS DateTime), N'c258456', CAST(N'2018-01-28T08:19:39.270' AS DateTime), N'c258456')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1035, 1, N'Customer', N'SelectedPaymentMethod', N'Thanh toán khi giao hàng (COD)', 0, CAST(N'2018-01-30T14:43:45.473' AS DateTime), N'c258456', CAST(N'2018-02-10T00:53:04.647' AS DateTime), N'c258456')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1036, 1, N'Customer', N'SelectedShippingOption', N'Giao tận nơi', 0, CAST(N'2018-01-30T14:43:45.500' AS DateTime), N'c258456', CAST(N'2018-02-10T00:53:04.657' AS DateTime), N'c258456')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1037, 2, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-02-03T15:37:07.783' AS DateTime), N'Administrator', CAST(N'2018-02-03T15:37:07.783' AS DateTime), N'Administrator')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1038, 2, N'Customer', N'SelectedPaymentMethod', N'Thanh toán khi giao hàng (COD)', 0, CAST(N'2018-02-04T09:23:01.713' AS DateTime), N'Administrator', CAST(N'2018-02-20T15:08:08.470' AS DateTime), N'Administrator')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1039, 2, N'Customer', N'SelectedShippingOption', N'Giao tận nơi', 0, CAST(N'2018-02-04T09:23:01.727' AS DateTime), N'Administrator', CAST(N'2018-02-20T15:08:08.480' AS DateTime), N'Administrator')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1040, 3, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-02-05T16:06:52.160' AS DateTime), N'', CAST(N'2018-02-05T16:06:52.160' AS DateTime), N'')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1041, 4, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-02-21T15:15:21.723' AS DateTime), N'congtt', CAST(N'2018-02-21T15:15:21.723' AS DateTime), N'congtt')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1042, 4, N'Customer', N'SelectedPaymentMethod', N'Thanh toán khi giao hàng (COD)', 0, CAST(N'2018-02-21T15:34:44.813' AS DateTime), N'congtt', CAST(N'2018-02-21T15:40:57.270' AS DateTime), N'congtt')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1043, 4, N'Customer', N'SelectedShippingOption', N'Giao tận nơi', 0, CAST(N'2018-02-21T15:34:44.850' AS DateTime), N'congtt', CAST(N'2018-02-21T15:40:57.280' AS DateTime), N'congtt')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1044, 5, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-02-21T15:51:42.270' AS DateTime), N'Administrator', CAST(N'2018-02-21T15:51:42.270' AS DateTime), N'Administrator')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1045, 5, N'Customer', N'SelectedPaymentMethod', N'DHL', 0, CAST(N'2018-02-21T15:51:58.160' AS DateTime), N'Administrator', CAST(N'2018-05-27T15:36:45.040' AS DateTime), N'Administrator')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1046, 5, N'Customer', N'SelectedShippingOption', N'Giao tận nơi', 0, CAST(N'2018-02-21T15:51:58.170' AS DateTime), N'Administrator', CAST(N'2018-05-27T15:36:45.050' AS DateTime), N'Administrator')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1047, 6, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-02-24T11:20:15.197' AS DateTime), N'', CAST(N'2018-02-24T11:20:15.197' AS DateTime), N'')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1048, 7, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-03-06T14:20:02.927' AS DateTime), N'', CAST(N'2018-03-06T14:20:02.927' AS DateTime), N'')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1049, 8, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-03-13T15:38:20.503' AS DateTime), N'', CAST(N'2018-03-13T15:38:20.503' AS DateTime), N'')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1050, 9, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-03-13T15:53:30.850' AS DateTime), N'congtt', CAST(N'2018-03-13T15:53:30.850' AS DateTime), N'congtt')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1051, 9, N'Customer', N'SelectedPaymentMethod', N'DHL', 0, CAST(N'2018-03-15T13:43:50.240' AS DateTime), N'congtt', CAST(N'2018-03-15T13:43:50.240' AS DateTime), N'congtt')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1052, 9, N'Customer', N'SelectedShippingOption', N'Giao tận nơi', 0, CAST(N'2018-03-15T13:43:50.273' AS DateTime), N'congtt', CAST(N'2018-03-15T13:43:50.273' AS DateTime), N'congtt')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1053, 10, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-03-17T00:35:39.900' AS DateTime), N'truongthanhcong', CAST(N'2018-03-17T00:35:39.900' AS DateTime), N'truongthanhcong')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1054, 10, N'Customer', N'SelectedPaymentMethod', N'Trademark', 0, CAST(N'2018-03-17T15:39:31.753' AS DateTime), N'truongthanhcong', CAST(N'2018-04-14T17:02:19.097' AS DateTime), N'truong thanh cong')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1055, 10, N'Customer', N'SelectedShippingOption', N'Giao tận nơi', 0, CAST(N'2018-03-17T15:39:31.767' AS DateTime), N'truongthanhcong', CAST(N'2018-04-14T17:02:19.110' AS DateTime), N'truong thanh cong')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1056, 11, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-03-22T13:52:20.880' AS DateTime), N'DemoVictim', CAST(N'2018-03-22T13:52:20.880' AS DateTime), N'DemoVictim')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1057, 12, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-04-05T15:54:24.860' AS DateTime), N'', CAST(N'2018-04-05T15:54:24.860' AS DateTime), N'')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1058, 13, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-05-13T12:03:45.840' AS DateTime), N'', CAST(N'2018-05-13T12:03:45.840' AS DateTime), N'')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1059, 11, N'Customer', N'SelectedPaymentMethod', N'DHL', 0, CAST(N'2018-05-13T12:53:49.767' AS DateTime), N'DemoVictim', CAST(N'2018-05-13T12:53:49.767' AS DateTime), N'DemoVictim')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1060, 11, N'Customer', N'SelectedShippingOption', N'Giao tận nơi', 0, CAST(N'2018-05-13T12:53:49.783' AS DateTime), N'DemoVictim', CAST(N'2018-05-13T12:53:49.783' AS DateTime), N'DemoVictim')
INSERT [dbo].[GenericAttribute] ([Id], [EntityId], [KeyGroup], [Key], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1061, 14, N'Customer', N'LanguageId', N'1', 1, CAST(N'2018-05-22T14:20:06.893' AS DateTime), N'', CAST(N'2018-05-22T14:20:06.893' AS DateTime), N'')
SET IDENTITY_INSERT [dbo].[GenericAttribute] OFF
SET IDENTITY_INSERT [dbo].[GenericControl] ON 

INSERT [dbo].[GenericControl] ([Id], [Name], [OrderDisplay], [Status], [Description], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [MenuId], [ControlTypeId]) VALUES (1, N'Thuộc tính post chi tiết', 0, 1, NULL, CAST(N'2017-08-20T11:04:33.387' AS DateTime), N'Administrator', CAST(N'2018-04-21T17:01:00.357' AS DateTime), N'Administrator', 3, 4)
SET IDENTITY_INSERT [dbo].[GenericControl] OFF
INSERT [dbo].[GenericControlMenuLink] ([GenericControlId], [MenuLinkId]) VALUES (1, 3)
INSERT [dbo].[GenericControlMenuLink] ([GenericControlId], [MenuLinkId]) VALUES (1, 5)
INSERT [dbo].[GenericControlMenuLink] ([GenericControlId], [MenuLinkId]) VALUES (1, 37)
SET IDENTITY_INSERT [dbo].[GenericControlValue] ON 

INSERT [dbo].[GenericControlValue] ([Id], [ValueName], [ColorHex], [Description], [Status], [OrderDisplay], [GenericControlId], [EntityId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (8, N'Chất liệu', NULL, NULL, 1, NULL, 1, 0, CAST(N'2017-05-27T03:56:27.213' AS DateTime), N'Administrator', CAST(N'2018-02-18T13:30:23.627' AS DateTime), N'Administrator')
INSERT [dbo].[GenericControlValue] ([Id], [ValueName], [ColorHex], [Description], [Status], [OrderDisplay], [GenericControlId], [EntityId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (9, N'Hướng dẫn bảo quản', N'#000000', N'2', 1, 1, 1, 0, CAST(N'2017-10-05T16:28:29.253' AS DateTime), N'Administrator', CAST(N'2018-05-19T13:28:58.350' AS DateTime), N'Administrator')
INSERT [dbo].[GenericControlValue] ([Id], [ValueName], [ColorHex], [Description], [Status], [OrderDisplay], [GenericControlId], [EntityId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (25, N'Kích thước', NULL, N'3333', 1, 12, 1, 0, CAST(N'2017-12-10T13:24:31.700' AS DateTime), N'Administrator', CAST(N'2018-05-25T17:11:34.070' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[GenericControlValue] OFF
SET IDENTITY_INSERT [dbo].[GenericControlValueItem] ON 

INSERT [dbo].[GenericControlValueItem] ([Id], [Title], [ImagePath], [ImageThumbnail], [Status], [OrderDisplay], [EntityId], [GenericControlValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Value]) VALUES (1, N'Địa điểm', NULL, NULL, 1, 1, 42, 8, CAST(N'2017-05-27T03:56:27.213' AS DateTime), N'Administator', CAST(N'2018-01-06T06:02:35.793' AS DateTime), N'Administrator', N'aaaa')
INSERT [dbo].[GenericControlValueItem] ([Id], [Title], [ImagePath], [ImageThumbnail], [Status], [OrderDisplay], [EntityId], [GenericControlValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Value]) VALUES (2, N'Thông tin chủ đầu tư', NULL, NULL, 1, 1, 42, 9, CAST(N'2017-12-10T12:35:22.257' AS DateTime), N'Administrator', CAST(N'2018-01-06T06:02:36.013' AS DateTime), N'Administrator', N'b')
INSERT [dbo].[GenericControlValueItem] ([Id], [Title], [ImagePath], [ImageThumbnail], [Status], [OrderDisplay], [EntityId], [GenericControlValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Value]) VALUES (16, N'Địa điểm', NULL, NULL, 1, 1, 46, 8, CAST(N'2017-12-10T13:22:06.223' AS DateTime), N'Administrator', CAST(N'2017-12-10T13:25:01.860' AS DateTime), N'Administrator', N'1')
INSERT [dbo].[GenericControlValueItem] ([Id], [Title], [ImagePath], [ImageThumbnail], [Status], [OrderDisplay], [EntityId], [GenericControlValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Value]) VALUES (17, N'Thông tin chủ đầu tư', NULL, NULL, 1, 1, 46, 9, CAST(N'2017-12-10T13:22:06.270' AS DateTime), N'Administrator', CAST(N'2017-12-10T13:25:01.873' AS DateTime), N'Administrator', N'2')
INSERT [dbo].[GenericControlValueItem] ([Id], [Title], [ImagePath], [ImageThumbnail], [Status], [OrderDisplay], [EntityId], [GenericControlValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Value]) VALUES (31, N'Quy mô', NULL, NULL, 1, 1, 42, 25, CAST(N'2017-12-10T13:24:42.137' AS DateTime), N'Administrator', CAST(N'2018-01-06T06:02:36.017' AS DateTime), N'Administrator', N'4000')
INSERT [dbo].[GenericControlValueItem] ([Id], [Title], [ImagePath], [ImageThumbnail], [Status], [OrderDisplay], [EntityId], [GenericControlValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Value]) VALUES (32, N'Quy mô', NULL, NULL, 1, 1, 46, 25, CAST(N'2017-12-10T13:25:01.880' AS DateTime), N'Administrator', CAST(N'2017-12-10T13:25:01.880' AS DateTime), N'Administrator', N'45.0000')
INSERT [dbo].[GenericControlValueItem] ([Id], [Title], [ImagePath], [ImageThumbnail], [Status], [OrderDisplay], [EntityId], [GenericControlValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Value]) VALUES (33, N'Địa điểm', NULL, NULL, 1, 1, 54, 8, CAST(N'2017-12-15T16:12:07.267' AS DateTime), N'Administrator', CAST(N'2017-12-15T16:12:14.453' AS DateTime), N'Administrator', N'14')
INSERT [dbo].[GenericControlValueItem] ([Id], [Title], [ImagePath], [ImageThumbnail], [Status], [OrderDisplay], [EntityId], [GenericControlValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Value]) VALUES (34, N'Thông tin chủ đầu tư', NULL, NULL, 1, 1, 54, 9, CAST(N'2017-12-15T16:12:07.510' AS DateTime), N'Administrator', CAST(N'2017-12-15T16:12:14.510' AS DateTime), N'Administrator', N'2')
INSERT [dbo].[GenericControlValueItem] ([Id], [Title], [ImagePath], [ImageThumbnail], [Status], [OrderDisplay], [EntityId], [GenericControlValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Value]) VALUES (35, N'Quy mô', NULL, NULL, 1, 1, 54, 25, CAST(N'2017-12-15T16:12:07.513' AS DateTime), N'Administrator', CAST(N'2017-12-15T16:12:14.517' AS DateTime), N'Administrator', N'3')
INSERT [dbo].[GenericControlValueItem] ([Id], [Title], [ImagePath], [ImageThumbnail], [Status], [OrderDisplay], [EntityId], [GenericControlValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Value]) VALUES (36, N'Địa điểm', NULL, NULL, 1, 1, 53, 8, CAST(N'2017-12-15T16:12:29.187' AS DateTime), N'Administrator', CAST(N'2017-12-19T15:25:26.483' AS DateTime), N'Administrator', N'3a')
INSERT [dbo].[GenericControlValueItem] ([Id], [Title], [ImagePath], [ImageThumbnail], [Status], [OrderDisplay], [EntityId], [GenericControlValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Value]) VALUES (37, N'Thông tin chủ đầu tư', NULL, NULL, 1, 1, 53, 9, CAST(N'2017-12-15T16:12:29.197' AS DateTime), N'Administrator', CAST(N'2017-12-19T15:25:26.503' AS DateTime), N'Administrator', N'3')
INSERT [dbo].[GenericControlValueItem] ([Id], [Title], [ImagePath], [ImageThumbnail], [Status], [OrderDisplay], [EntityId], [GenericControlValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Value]) VALUES (38, N'Quy mô', NULL, NULL, 1, 1, 53, 25, CAST(N'2017-12-15T16:12:29.200' AS DateTime), N'Administrator', CAST(N'2017-12-19T15:25:26.503' AS DateTime), N'Administrator', N'3')
INSERT [dbo].[GenericControlValueItem] ([Id], [Title], [ImagePath], [ImageThumbnail], [Status], [OrderDisplay], [EntityId], [GenericControlValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Value]) VALUES (39, N'Chất liệu', NULL, NULL, 1, 1, 48, 8, CAST(N'2018-02-18T13:30:45.417' AS DateTime), N'Administrator', CAST(N'2018-02-18T13:30:45.417' AS DateTime), N'Administrator', N'Hợp kim mạ vàng 18k')
INSERT [dbo].[GenericControlValueItem] ([Id], [Title], [ImagePath], [ImageThumbnail], [Status], [OrderDisplay], [EntityId], [GenericControlValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Value]) VALUES (40, N'Hướng dẫn bảo quản', NULL, NULL, 1, 1, 48, 9, CAST(N'2018-02-18T13:30:45.463' AS DateTime), N'Administrator', CAST(N'2018-02-18T13:30:45.463' AS DateTime), N'Administrator', N'Không nên tiếp xúc trực tiếp nhiều với ánh nắng mặt trời, thường xuyên lau sạch với khăn lau chuyên dụng dàng cho nữ trang.')
INSERT [dbo].[GenericControlValueItem] ([Id], [Title], [ImagePath], [ImageThumbnail], [Status], [OrderDisplay], [EntityId], [GenericControlValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Value]) VALUES (41, N'Kích thước', NULL, NULL, 1, 1, 48, 25, CAST(N'2018-02-18T13:30:45.467' AS DateTime), N'Administrator', CAST(N'2018-02-18T13:30:45.467' AS DateTime), N'Administrator', N'Đường kính: 17mm')
INSERT [dbo].[GenericControlValueItem] ([Id], [Title], [ImagePath], [ImageThumbnail], [Status], [OrderDisplay], [EntityId], [GenericControlValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Value]) VALUES (42, N'Chất liệu', NULL, NULL, 1, 1, 101, 8, CAST(N'2018-04-21T17:01:22.130' AS DateTime), N'Administrator', CAST(N'2018-04-21T17:01:22.130' AS DateTime), N'Administrator', N'1')
INSERT [dbo].[GenericControlValueItem] ([Id], [Title], [ImagePath], [ImageThumbnail], [Status], [OrderDisplay], [EntityId], [GenericControlValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Value]) VALUES (43, N'Hướng dẫn bảo quản', NULL, NULL, 1, 1, 101, 9, CAST(N'2018-04-21T17:01:22.147' AS DateTime), N'Administrator', CAST(N'2018-04-21T17:01:22.147' AS DateTime), N'Administrator', N'2')
INSERT [dbo].[GenericControlValueItem] ([Id], [Title], [ImagePath], [ImageThumbnail], [Status], [OrderDisplay], [EntityId], [GenericControlValueId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Value]) VALUES (44, N'Kích thước', NULL, NULL, 1, 1, 101, 25, CAST(N'2018-04-21T17:01:22.150' AS DateTime), N'Administrator', CAST(N'2018-04-21T17:01:22.150' AS DateTime), N'Administrator', N'3')
SET IDENTITY_INSERT [dbo].[GenericControlValueItem] OFF
SET IDENTITY_INSERT [dbo].[Language] ON 

INSERT [dbo].[Language] ([Id], [LanguageName], [LanguageCode], [Flag], [Status], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1, N'Viet nam', N'vi-VN', N'images/language/vn.png', 1, CAST(N'2017-05-30T16:31:44.337' AS DateTime), N'Administrator', CAST(N'2017-12-13T16:53:30.030' AS DateTime), N'Administrator')
INSERT [dbo].[Language] ([Id], [LanguageName], [LanguageCode], [Flag], [Status], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2, N'English', N'en-us', N'images/language/us.png', 1, CAST(N'2017-06-19T16:18:57.493' AS DateTime), N'Administrator', CAST(N'2017-12-13T16:54:00.800' AS DateTime), N'Administrator')
INSERT [dbo].[Language] ([Id], [LanguageName], [LanguageCode], [Flag], [Status], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (3, N'Japan', N'ja-Jp', N'images/language/jp.png', 1, CAST(N'2017-06-19T16:18:57.493' AS DateTime), N'Administrator', CAST(N'2017-12-13T16:55:11.373' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[Language] OFF
SET IDENTITY_INSERT [dbo].[LocaleStringResource] ON 

INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (3, 1, N'AboutUs', N'About', 0, 1, CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:43:10.530' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (17, 1, N'XemThem', N'Xem thêm', 0, 1, CAST(N'2017-07-20T00:42:46.653' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:46:44.253' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (18, 1, N'LienHeDatHang.Lable', N'Liên hệ đặt hàng', 0, 1, CAST(N'2017-07-20T00:44:30.590' AS DateTime), N'Administrator', CAST(N'2018-01-13T05:37:44.247' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (19, 1, N'XemChiTiet', N'Xem chi tiết', 0, 1, CAST(N'2017-07-20T00:52:20.307' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:41:55.533' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (20, 1, N'XemSanPham', N'Xem sản phẩm', 0, 1, CAST(N'2017-07-20T00:52:49.703' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:48:02.260' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (21, 1, N'ThongTinTruyenThong', N'thông tin truyền thông', 0, 1, CAST(N'2017-07-20T00:55:03.130' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:51:10.550' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (25, 1, N'CongTyThanhVien', N'công ty thành viên', 0, 1, CAST(N'2017-07-20T03:29:32.940' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:52:35.720' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (26, 1, N'DanhSachCongTy', N'Danh sách các đối tác Công ty Thiên Phát', 0, 1, CAST(N'2017-07-20T03:29:39.420' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:55:27.907' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (27, 1, N'DiaChi_ChiTiet', N'ẤP Tân Thuận, xã Bình Đức, huyện Châu Thành, tỉnh Tiền Giang', 0, 1, CAST(N'2017-07-20T03:38:47.157' AS DateTime), N'Administrator', CAST(N'2017-07-25T04:00:25.887' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (28, 1, N'DienThoai.Lable', N'Điện thoại', 0, 1, CAST(N'2017-07-20T03:49:00.200' AS DateTime), N'Administrator', CAST(N'2017-10-08T18:17:45.207' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (30, 2, N'XemThem', N'See more', 0, 1, CAST(N'2017-07-20T10:44:47.570' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:47:05.527' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (31, 3, N'Paymentinfo', N'ẤP Tân Thuận, xã Bình Đức, huyện Châu Thành, tỉnh Tiền Giang', 0, 1, CAST(N'2017-07-20T10:44:54.270' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:59:46.367' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (32, 2, N'LienHeDatHang', N'Contact order', 0, 1, CAST(N'2017-07-24T09:39:13.700' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:43:37.280' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (33, 2, N'XemChiTiet', N'See details', 0, 0, CAST(N'2017-07-25T03:42:16.647' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:42:16.647' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (34, 3, N'XemChiTiet', N'詳細を見ます', 0, 0, CAST(N'2017-07-25T03:42:39.547' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:42:39.547' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (35, 3, N'LienHeDatHang', N'問い合わせ注文', 0, 0, CAST(N'2017-07-25T03:43:55.667' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:43:55.667' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (36, 3, N'XemThem', N'もっと', 0, 0, CAST(N'2017-07-25T03:47:20.887' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:47:20.887' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (37, 2, N'XemSanPham', N'See product', 0, 0, CAST(N'2017-07-25T03:48:32.130' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:48:32.130' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (38, 3, N'XemSanPham', N'ビュー製品', 0, 0, CAST(N'2017-07-25T03:48:44.767' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:48:44.767' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (39, 2, N'ThongTinTruyenThong', N'Information Communication', 0, 0, CAST(N'2017-07-25T03:51:26.337' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:51:26.337' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (40, 3, N'ThongTinTruyenThong', N'情報通信', 0, 0, CAST(N'2017-07-25T03:51:45.667' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:51:45.667' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (41, 2, N'CongTyThanhVien', N'Member companies', 0, 0, CAST(N'2017-07-25T03:52:56.850' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:52:56.850' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (42, 3, N'CongTyThanhVien', N'会員企業', 0, 0, CAST(N'2017-07-25T03:53:08.703' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:53:08.703' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (43, 2, N'DanhSachCongTy', N'List of partners Thien Phat Company', 0, 0, CAST(N'2017-07-25T03:55:52.270' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:55:52.270' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (44, 3, N'DanhSachCongTy', N'一覧パートナーティエンファット', 0, 0, CAST(N'2017-07-25T03:56:07.297' AS DateTime), N'Administrator', CAST(N'2017-07-25T03:56:07.297' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (45, 1, N'DiaChi.Lable', N'Địa chỉ', 0, 1, CAST(N'2017-07-25T03:58:21.767' AS DateTime), N'Administrator', CAST(N'2017-07-25T08:19:12.833' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (46, 2, N'DiaChi.Lable', N'Address', 0, 1, CAST(N'2017-07-25T03:58:32.623' AS DateTime), N'Administrator', CAST(N'2017-07-25T08:19:26.550' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (47, 3, N'DiaChi.Lable', N'アドレス', 0, 1, CAST(N'2017-07-25T03:58:51.547' AS DateTime), N'Administrator', CAST(N'2017-07-25T08:19:36.103' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (48, 2, N'DiaChi_ChiTiet', N'Tan Thuan Hamlet, Binh Duc Commune, Chau Thanh District, Tien Giang Province', 0, 0, CAST(N'2017-07-25T04:00:53.847' AS DateTime), N'Administrator', CAST(N'2017-07-25T04:00:53.847' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (49, 3, N'DiaChi_ChiTiet', N'タントゥアンハムレット、ビンドクコミューン、チョウ・タン、ティエンザン省', 0, 0, CAST(N'2017-07-25T04:01:05.440' AS DateTime), N'Administrator', CAST(N'2017-07-25T04:01:05.440' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (50, 2, N'DienThoai.Lable', N'Phone', 0, 0, CAST(N'2017-07-25T04:02:31.567' AS DateTime), N'Administrator', CAST(N'2017-07-25T04:02:31.567' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (51, 3, N'DienThoai.Lable', N'電話', 0, 0, CAST(N'2017-07-25T04:02:51.537' AS DateTime), N'Administrator', CAST(N'2017-07-25T04:02:51.537' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (52, 1, N'CongTy.Name', N'Công ty Thiên Phát', 0, 0, CAST(N'2017-07-25T04:03:51.457' AS DateTime), N'Administrator', CAST(N'2017-07-25T04:03:51.457' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (53, 2, N'CongTy.Name', N'Thien Phat Company', 0, 0, CAST(N'2017-07-25T04:04:05.657' AS DateTime), N'Administrator', CAST(N'2017-07-25T04:04:05.657' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (54, 3, N'CongTy.Name', N'企業THIEN PHAT', 0, 0, CAST(N'2017-07-25T04:04:24.163' AS DateTime), N'Administrator', CAST(N'2017-07-25T04:04:24.163' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (55, 1, N'HoTen.Lable', N'Họ tên', 0, 0, CAST(N'2017-07-25T09:22:02.913' AS DateTime), N'Administrator', CAST(N'2017-07-25T09:22:02.913' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (56, 2, N'HoTen.Lable', N'Full name', 0, 0, CAST(N'2017-07-25T09:23:15.653' AS DateTime), N'Administrator', CAST(N'2017-07-25T09:23:15.653' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (57, 3, N'HoTen.Lable', N'自分の名前', 0, 0, CAST(N'2017-07-25T09:23:39.600' AS DateTime), N'Administrator', CAST(N'2017-07-25T09:23:39.600' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (58, 1, N'NoiDungLienLac', N'Nội dung liên lạc', 0, 0, CAST(N'2017-07-25T15:48:34.867' AS DateTime), N'Administrator', CAST(N'2017-07-25T15:48:34.867' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (59, 2, N'NoiDungLienLac', N'Contact content', 0, 0, CAST(N'2017-07-25T15:49:00.517' AS DateTime), N'Administrator', CAST(N'2017-07-25T15:49:00.517' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (60, 3, N'NoiDungLienLac', N'通信内容', 0, 0, CAST(N'2017-07-25T15:49:12.823' AS DateTime), N'Administrator', CAST(N'2017-07-25T15:49:12.823' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (61, 1, N'btnSend', N'Gửi', 0, 0, CAST(N'2017-07-25T15:50:04.307' AS DateTime), N'Administrator', CAST(N'2017-07-25T15:50:04.307' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (62, 2, N'btnSend', N'Send', 0, 0, CAST(N'2017-07-25T15:50:13.483' AS DateTime), N'Administrator', CAST(N'2017-07-25T15:50:13.483' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (63, 3, N'btnSend', N'投稿', 0, 0, CAST(N'2017-07-25T15:50:35.257' AS DateTime), N'Administrator', CAST(N'2017-07-25T15:50:35.257' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (65, 2, N'NhapLai', N'Re-enter', 0, 0, CAST(N'2017-07-25T15:51:51.117' AS DateTime), N'Administrator', CAST(N'2017-07-25T15:51:51.117' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (66, 3, N'NhapLai', N'再入力', 0, 0, CAST(N'2017-07-25T15:52:02.507' AS DateTime), N'Administrator', CAST(N'2017-07-25T15:52:02.507' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (67, 1, N'Contact.Thanks', N'Cảm ơn Quý Khách đã quan tâm tới dịch vụ của chúng tôi, Quý Khách vui lòng liên hệ trực tiếp tại bất kỳ chi nhánh thành viên gần nhất hoặc liên hệ qua form:', 0, 0, CAST(N'2017-07-25T15:52:51.297' AS DateTime), N'Administrator', CAST(N'2017-07-25T15:52:51.297' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (68, 2, N'Contact.Thanks', N'Thank you for your interest in our services, please contact us directly at any of our nearest affiliates or contact us via:', 0, 0, CAST(N'2017-07-25T15:53:19.470' AS DateTime), N'Administrator', CAST(N'2017-07-25T15:53:19.470' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (69, 3, N'Contact.Thanks', N'当社のサービスで関心をお寄せいただきありがとうございます、任意のブランチ最寄りの部材に直接ご連絡いただくか、フォームでご連絡ください。', 0, 0, CAST(N'2017-07-25T15:53:32.203' AS DateTime), N'Administrator', CAST(N'2017-07-25T15:53:32.203' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (70, 1, N'Email.Lable', N'Email', 0, 0, CAST(N'2017-07-26T06:26:24.550' AS DateTime), N'Administrator', CAST(N'2017-07-26T06:26:24.550' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (71, 2, N'Email.Lable', N'Email', 0, 0, CAST(N'2017-07-26T06:26:33.437' AS DateTime), N'Administrator', CAST(N'2017-07-26T06:26:33.437' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (72, 3, N'Email.Lable', N'メール', 0, 0, CAST(N'2017-07-26T06:26:43.190' AS DateTime), N'Administrator', CAST(N'2017-07-26T06:26:43.190' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (73, 1, N'ProductReleate.Lable', N'sản phẩm khác', 0, 0, CAST(N'2017-07-26T09:32:29.697' AS DateTime), N'Administrator', CAST(N'2017-07-26T09:32:29.697' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (74, 2, N'ProductReleate.Lable', N'Product release', 0, 0, CAST(N'2017-07-26T09:32:40.707' AS DateTime), N'Administrator', CAST(N'2017-07-26T09:32:40.707' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (75, 3, N'ProductReleate.Lable', N'その他の製品', 0, 0, CAST(N'2017-07-26T09:32:58.110' AS DateTime), N'Administrator', CAST(N'2017-07-26T09:32:58.110' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (76, 1, N'Tax.Lable', N'Mã số thuế', 0, 0, CAST(N'2017-08-11T15:59:54.813' AS DateTime), N'Administrator', CAST(N'2017-08-11T15:59:54.813' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (81, 1, N'Continus.Lable', N'Tiếp tục', 0, 0, CAST(N'2017-10-08T16:36:57.207' AS DateTime), N'Administrator', CAST(N'2017-10-08T16:36:57.207' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (82, 1, N'Social.Lable', N'Mạng xã hội', 0, 0, CAST(N'2017-10-08T17:17:40.547' AS DateTime), N'Administrator', CAST(N'2017-10-08T17:17:40.547' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (83, 1, N'Address.Lable', N'Địa chỉ', 0, 0, CAST(N'2017-10-08T18:01:47.623' AS DateTime), N'Administrator', CAST(N'2017-10-08T18:01:47.623' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (85, 1, N'Hotline.Lable', N'Hotline', 0, 0, CAST(N'2018-01-17T15:38:23.407' AS DateTime), N'Administrator', CAST(N'2018-01-17T15:38:23.407' AS DateTime), N'Administrator')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (86, 1, N'Checkout.ThankYou', N'Cảm ơn bạn đã mua hàng tại cửa hàng chúng tôi', 0, 0, CAST(N'2018-02-08T14:46:14.250' AS DateTime), N'c258456', CAST(N'2018-02-08T14:46:14.250' AS DateTime), N'c258456')
INSERT [dbo].[LocaleStringResource] ([Id], [LanguageId], [ResourceName], [ResourceValue], [IsFromPlugin], [IsTouched], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (87, 1, N'Order.Phone', N'Điện thoại', 0, 0, CAST(N'2018-04-01T15:23:46.813' AS DateTime), N'Administrator', CAST(N'2018-04-01T15:23:46.813' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[LocaleStringResource] OFF
SET IDENTITY_INSERT [dbo].[LocalizedProperty] ON 

INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (18, 2123, 1, N'MenuLink', N'MenuName', N'Trang chủ', CAST(N'2017-07-06T16:58:04.527' AS DateTime), N'Administrator', CAST(N'2017-08-09T16:20:29.017' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (19, 2123, 1, N'MenuLink', N'MetaTitle', N'Trang chủ', CAST(N'2017-07-06T16:58:04.553' AS DateTime), N'Administrator', CAST(N'2017-08-09T16:20:29.057' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (20, 2123, 1, N'MenuLink', N'MetaKeywords', N'Trang chủ', CAST(N'2017-07-06T16:58:04.557' AS DateTime), N'Administrator', CAST(N'2017-08-09T16:20:29.083' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (21, 2123, 1, N'MenuLink', N'MetaDescription', N'Trang chủ', CAST(N'2017-07-06T16:58:04.560' AS DateTime), N'Administrator', CAST(N'2017-08-09T16:20:29.097' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (22, 2123, 2, N'MenuLink', N'MenuName', N'Home', CAST(N'2017-07-06T16:58:04.563' AS DateTime), N'Administrator', CAST(N'2017-08-09T16:20:29.110' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (23, 2123, 2, N'MenuLink', N'MetaTitle', N'Home', CAST(N'2017-07-06T16:58:04.567' AS DateTime), N'Administrator', CAST(N'2017-08-09T16:20:29.147' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (24, 2123, 2, N'MenuLink', N'MetaKeywords', N'Home', CAST(N'2017-07-06T16:58:04.567' AS DateTime), N'Administrator', CAST(N'2017-08-09T16:20:29.167' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (25, 2123, 2, N'MenuLink', N'MetaDescription', N'Home', CAST(N'2017-07-06T16:58:04.570' AS DateTime), N'Administrator', CAST(N'2017-08-09T16:20:29.173' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (26, 2123, 3, N'MenuLink', N'MenuName', N'家', CAST(N'2017-07-06T16:58:04.573' AS DateTime), N'Administrator', CAST(N'2017-08-09T16:20:29.180' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (27, 2123, 3, N'MenuLink', N'MetaTitle', N'家', CAST(N'2017-07-06T16:58:04.577' AS DateTime), N'Administrator', CAST(N'2017-08-09T16:20:29.193' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (28, 2123, 3, N'MenuLink', N'MetaKeywords', N'家', CAST(N'2017-07-06T16:58:04.580' AS DateTime), N'Administrator', CAST(N'2017-08-09T16:20:29.197' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (29, 2123, 3, N'MenuLink', N'MetaDescription', N'家', CAST(N'2017-07-06T16:58:04.583' AS DateTime), N'Administrator', CAST(N'2017-08-09T16:20:29.203' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (30, 110, 1, N'MenuLink', N'MenuName', N'Tin tức', CAST(N'2017-07-06T17:22:38.677' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:27.577' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (31, 110, 1, N'MenuLink', N'MetaTitle', N'Tin tức', CAST(N'2017-07-06T17:22:38.707' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:27.587' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (32, 110, 1, N'MenuLink', N'MetaKeywords', N'Tin tức', CAST(N'2017-07-06T17:22:38.710' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:27.587' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (33, 110, 1, N'MenuLink', N'MetaDescription', N'Tin tức', CAST(N'2017-07-06T17:22:38.713' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:27.590' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (34, 110, 2, N'MenuLink', N'MenuName', N'Traditional', CAST(N'2017-07-06T17:22:38.757' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:27.593' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (35, 110, 2, N'MenuLink', N'MetaTitle', N'Traditional', CAST(N'2017-07-06T17:22:38.763' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:27.597' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (36, 110, 2, N'MenuLink', N'MetaKeywords', N'Traditional', CAST(N'2017-07-06T17:22:38.767' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:27.597' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (37, 110, 2, N'MenuLink', N'MetaDescription', N'Traditional', CAST(N'2017-07-06T17:22:38.770' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:27.603' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (38, 110, 3, N'MenuLink', N'MenuName', N'コミュニケーション', CAST(N'2017-07-06T17:22:38.777' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:27.603' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (39, 110, 3, N'MenuLink', N'MetaTitle', N'コミュニケーション', CAST(N'2017-07-06T17:22:38.783' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:27.610' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (40, 110, 3, N'MenuLink', N'MetaKeywords', N'コミュニケーション', CAST(N'2017-07-06T17:22:38.787' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:27.610' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (41, 110, 3, N'MenuLink', N'MetaDescription', N'コミュニケーション', CAST(N'2017-07-06T17:22:38.793' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:27.613' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (44, 2138, 1, N'MenuLink', N'MenuName', N'Sản phẩm', CAST(N'2017-07-10T14:35:33.247' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:32:17.823' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (45, 2138, 1, N'MenuLink', N'MetaTitle', N'Sản phẩm', CAST(N'2017-07-10T14:35:33.257' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:32:17.840' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (46, 2138, 1, N'MenuLink', N'MetaKeywords', N'Sản phẩm', CAST(N'2017-07-10T14:35:33.260' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:32:17.857' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (47, 2138, 1, N'MenuLink', N'MetaDescription', N'Sản phẩm', CAST(N'2017-07-10T14:35:33.263' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:32:17.867' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (48, 2138, 2, N'MenuLink', N'MenuName', NULL, CAST(N'2017-07-10T14:35:33.263' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:32:17.877' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (49, 2138, 2, N'MenuLink', N'MetaTitle', NULL, CAST(N'2017-07-10T14:35:33.270' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:32:17.900' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (50, 2138, 2, N'MenuLink', N'MetaKeywords', NULL, CAST(N'2017-07-10T14:35:33.273' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:32:17.910' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (51, 2138, 2, N'MenuLink', N'MetaDescription', NULL, CAST(N'2017-07-10T14:35:33.277' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:32:17.913' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (52, 2138, 3, N'MenuLink', N'MenuName', NULL, CAST(N'2017-07-10T14:35:33.277' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:32:17.917' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (53, 2138, 3, N'MenuLink', N'MetaTitle', NULL, CAST(N'2017-07-10T14:35:33.280' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:32:17.923' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (54, 2138, 3, N'MenuLink', N'MetaKeywords', NULL, CAST(N'2017-07-10T14:35:33.283' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:32:17.937' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (59, 2140, 1, N'MenuLink', N'MenuName', N'dfd', CAST(N'2017-07-10T15:28:40.887' AS DateTime), N'Administrator', CAST(N'2018-05-12T17:07:15.267' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (60, 2140, 2, N'MenuLink', N'MenuName', NULL, CAST(N'2017-07-10T15:28:40.900' AS DateTime), N'Administrator', CAST(N'2018-05-12T17:07:15.347' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (61, 2140, 3, N'MenuLink', N'MenuName', NULL, CAST(N'2017-07-10T15:28:40.917' AS DateTime), N'Administrator', CAST(N'2018-05-12T17:07:15.363' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (110, 14, 1, N'StaticContent', N'Title', N'Giới thiệu công ty', CAST(N'2017-07-22T02:20:41.997' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:10:12.287' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (111, 14, 1, N'StaticContent', N'MetaTitle', N'Giới thiệu công ty', CAST(N'2017-07-22T02:20:42.470' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:10:12.307' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (112, 14, 1, N'StaticContent', N'MetaKeywords', N'Giới thiệu công ty', CAST(N'2017-07-22T02:20:42.530' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:10:12.310' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (113, 14, 1, N'StaticContent', N'MetaDescription', N'Giới thiệu công ty', CAST(N'2017-07-22T02:20:42.570' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:10:12.310' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (114, 14, 2, N'StaticContent', N'Title', NULL, CAST(N'2017-07-22T02:20:42.630' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:10:12.313' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (115, 14, 3, N'StaticContent', N'Title', NULL, CAST(N'2017-07-22T02:20:42.770' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:10:12.333' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (116, 2119, 1, N'MenuLink', N'MenuName', N'Hồ sơ năng lực', CAST(N'2017-07-22T02:32:02.743' AS DateTime), N'Administrator', CAST(N'2017-10-14T06:12:44.147' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (117, 2119, 1, N'MenuLink', N'MetaTitle', N'Hồ sơ năng lực', CAST(N'2017-07-22T02:32:02.777' AS DateTime), N'Administrator', CAST(N'2017-10-14T06:12:44.167' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (118, 2119, 1, N'MenuLink', N'MetaKeywords', N'Hồ sơ năng lực', CAST(N'2017-07-22T02:32:02.780' AS DateTime), N'Administrator', CAST(N'2017-10-14T06:12:44.173' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (119, 2119, 1, N'MenuLink', N'MetaDescription', N'Hồ sơ năng lực', CAST(N'2017-07-22T02:32:02.787' AS DateTime), N'Administrator', CAST(N'2017-10-14T06:12:44.180' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (120, 2119, 2, N'MenuLink', N'MenuName', NULL, CAST(N'2017-07-22T02:32:02.793' AS DateTime), N'Administrator', CAST(N'2017-10-14T06:12:44.187' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (121, 2119, 3, N'MenuLink', N'MenuName', N'組織装置', CAST(N'2017-07-22T02:32:02.807' AS DateTime), N'Administrator', CAST(N'2017-10-14T06:12:44.223' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (125, 14, 1, N'StaticContent', N'SeoUrl', N'gioi-thieu-cong-ty', CAST(N'2017-07-22T05:26:28.990' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:10:12.300' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (126, 14, 2, N'StaticContent', N'SeoUrl', N'', CAST(N'2017-07-22T05:26:29.270' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:10:12.323' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (127, 14, 2, N'StaticContent', N'MetaTitle', NULL, CAST(N'2017-07-22T05:26:29.300' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:10:12.323' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (128, 14, 2, N'StaticContent', N'MetaKeywords', NULL, CAST(N'2017-07-22T05:26:29.330' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:10:12.327' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (129, 14, 2, N'StaticContent', N'MetaDescription', NULL, CAST(N'2017-07-22T05:26:29.330' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:10:12.330' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (130, 14, 3, N'StaticContent', N'SeoUrl', N'', CAST(N'2017-07-22T05:26:29.430' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:10:12.343' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (131, 16, 1, N'StaticContent', N'Title', N'Hướng dẫn mua hàng', CAST(N'2017-07-23T07:28:23.157' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:44:18.153' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (132, 16, 1, N'StaticContent', N'ShortDesc', N'<div class="policies nobottommargin">
<div class="container clearfix">
<div class="row">
<div class="col-xs-12 col-sm-3">
<div class="feature-box fbox-plain fbox-dark fbox-small">
<div class="fbox-icon"><img alt="Công ty thương mại và thời trang NAM LONG" src="/assets/lib/policies_icon_1677f.png?v=226" /></div>

<h3>GIAO H&Agrave;NG TO&Agrave;N QUỐC</h3>

<p>Miễn ph&iacute; khi mua nhiều</p>
</div>
</div>

<div class="col-xs-12 col-sm-3">
<div class="feature-box fbox-plain fbox-dark fbox-small">
<div class="fbox-icon"><img alt="Công ty thương mại và thời trang NAM LONG" src="/assets/lib/policies_icon_2677f.png?v=226" /></div>

<h3>QU&Agrave; TẶNG</h3>

<p>Nhiều qu&agrave; tặng v&agrave; ưu đ&atilde;i hấp dẫn</p>
</div>
</div>

<div class="col-xs-12 col-sm-3">
<div class="feature-box fbox-plain fbox-dark fbox-small">
<div class="fbox-icon"><img alt="Công ty thương mại và thời trang NAM LONG" src="/assets/lib/policies_icon_3677f.png?v=226" /></div>

<h3>CHẤT LƯỢNG</h3>

<p>Sản phẩm đẹp, bền - G&iacute;a tốt nhất</p>
</div>
</div>

<div class="col-xs-12 col-sm-3">
<div class="feature-box fbox-plain fbox-dark fbox-small">
<div class="fbox-icon"><img alt="Công ty thương mại và thời trang NAM LONG" src="/assets/lib/policies_icon_4677f.png?v=226" /></div>

<h3>ĐẶT H&Agrave;NG NHANH</h3>

<p>0937 996 063</p>
</div>
</div>
</div>
</div>
</div>
', CAST(N'2017-07-23T07:28:23.187' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:44:18.177' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (133, 16, 1, N'StaticContent', N'Description', N'<p>Ng&agrave;y nay, điện thoại di động th&ocirc;ng minh l&agrave; thiết bị kh&ocirc;ng thể thiếu của con người bởi t&iacute;nh nhanh gọn, tiện &iacute;ch v&agrave; đa dạng của n&oacute;. META đ&atilde; lu&ocirc;n cải tiến v&agrave; kh&ocirc;ng ngừng khắc phục mọi kh&oacute; khăn để c&oacute; thể đem đến cho người mua h&agrave;ng những tiện &iacute;ch tốt nhất cũng như thao t&aacute;c ng&agrave;y c&agrave;ng nhanh ch&oacute;ng v&agrave; tiện lợi, kh&ocirc;ng mất qu&aacute; nhiều thời gian v&agrave; c&ocirc;ng sức. Bạn chỉ cần ngồi tại nh&agrave;, truy cập v&agrave;o website meta.vn qua điện thoại th&ocirc;ng minh của m&igrave;nh v&agrave; Đặt h&agrave;ng, ch&uacute;ng t&ocirc;i sẽ giao h&agrave;ng đến tận nh&agrave;. Lu&ocirc;n d&agrave;nh kh&oacute; khăn, phiền phức về m&igrave;nh để thỏa m&atilde;n kh&aacute;ch h&agrave;ng l&agrave; ti&ecirc;u ch&iacute; số 1 của META ch&uacute;ng t&ocirc;i.</p>

<p>Sau đ&acirc;y, META xin gửi tới Qu&yacute; kh&aacute;ch h&agrave;ng c&aacute;ch đặt h&agrave;ng th&ocirc;ng minh tr&ecirc;n META dễ d&agrave;ng v&agrave; thuận tiện bằng điện thoại di động.</p>

<p style="text-align:center"><iframe allowfullscreen="" frameborder="0" height="422" src="https://www.youtube.com/embed/-DWDpvaMAZU" style="box-sizing: border-box; margin: 0px; padding: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit;" width="750"></iframe></p>

<p style="text-align:center">Video giới thiệu hướng dẫn đặt h&agrave;ng tr&ecirc;n website meta.vn qua điện thoại dễ d&agrave;ng v&agrave; thuận tiện</p>

<p><strong>Bước 1</strong>. Qu&yacute; kh&aacute;ch truy cập v&agrave;o&nbsp;<em>website META.vn&nbsp;</em>tr&ecirc;n thiết bị di động của m&igrave;nh<em>,</em>&nbsp;lựa chọn sản phẩm theo&nbsp;<strong>Danh mục</strong>&nbsp;- từng ng&agrave;nh sản phẩm hoặc g&otilde; t&ecirc;n sản phẩm (từ kh&oacute;a) v&agrave;o phần&nbsp;<strong>T&igrave;m kiếm</strong>&nbsp;(Xem hướng dẫn chi tiết t&igrave;m kiếm sản phẩm&nbsp;<a href="http://meta.vn/hotro/huong-dan-tim-kiem-san-pham-tai-meta/67" style="box-sizing: border-box; background-color: transparent; margin: 0px; padding: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; color: rgb(0, 0, 255) !important; text-decoration-line: none !important;" target="_blank" title="Xem thêm tìm kiếm"><strong>tại đ&acirc;y</strong></a>).</p>

<p style="text-align:center"><img alt="Truy cập vào website META trên điện thoại." src="https://st.meta.com.vn/img/thumb.ashx/data/image/2016/08/31/hotro-mobile-b1.jpg" style="border:0px; box-sizing:border-box; font-family:inherit; font-size:inherit; font-stretch:inherit; font-style:inherit; font-variant:inherit; font-weight:inherit; height:auto; line-height:inherit; margin:0px; max-width:100%; padding:0px; vertical-align:middle; width:422px" title="Truy cập vào website META trên điện thoại." /></p>

<p style="text-align:center"><span style="color:rgb(51, 102, 255); font-family:inherit; font-size:inherit">Truy cập v&agrave;o website META tr&ecirc;n điện thoại.</span></p>

<p>- V&iacute; dụ, Qu&yacute; kh&aacute;ch cần t&igrave;m mua sản phẩm&nbsp;<a href="http://meta.vn/may-chay-bo-dien-co-lon-impulse-pt300-p28279" style="box-sizing: border-box; background-color: transparent; margin: 0px; padding: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; color: rgb(0, 0, 255) !important; text-decoration-line: none !important;" target="_blank" title="Xem thêm máy chạy bộ điện cỡ lớn."><strong>M&aacute;y chạy bộ điện cỡ lớn PT300</strong></a>, Qu&yacute; kh&aacute;ch g&otilde; ở &ocirc; t&igrave;m kiếm m&aacute;y chạy bộ điện cỡ lớn PT300 v&agrave; k&iacute;ch chọn sản phẩm đ&oacute;.</p>

<p style="text-align:center"><img alt="Gõ tên sản phẩm cần mua vào ô Tìm kiếm." src="https://st.meta.com.vn/img/thumb.ashx/data/image/2016/08/31/hotro-mobile-b2.jpg" style="border:0px; box-sizing:border-box; font-family:inherit; font-size:inherit; font-stretch:inherit; font-style:inherit; font-variant:inherit; font-weight:inherit; height:auto; line-height:inherit; margin:0px; max-width:100%; padding:0px; vertical-align:middle; width:422px" title="Gõ tên sản phẩm cần mua vào ô Tìm kiếm." /></p>

<p style="text-align:center"><span style="color:rgb(51, 102, 255); font-family:inherit; font-size:inherit">G&otilde; t&ecirc;n sản phẩm cần mua v&agrave;o &ocirc;&nbsp;<strong>T&igrave;m kiếm.</strong></span></p>

<p>- Th&ocirc;ng tin chi tiết của sản phẩm m&aacute;y chạy bộ điện hiển thị, Qu&yacute; kh&aacute;ch n&ecirc;n đọc kỹ<strong>&nbsp;th&ocirc;ng tin sản phẩm</strong>&nbsp;v&agrave;&nbsp;<strong>th&ocirc;ng số kỹ thuật</strong>&nbsp;cũng như&nbsp;<strong>đ&aacute;nh gi&aacute;</strong>&nbsp;về sản phẩm đ&oacute; để c&oacute; thể đưa ra quyết định mua h&agrave;ng đ&uacute;ng đắn.</p>

<p style="text-align:center"><img alt="Bạn cần đọc kỹ thông tin trước khi quyết định mua hàng." src="https://st.meta.com.vn/img/thumb.ashx/data/image/2016/08/31/hotro-mobile-b3.jpg" style="border:0px; box-sizing:border-box; font-family:inherit; font-size:inherit; font-stretch:inherit; font-style:inherit; font-variant:inherit; font-weight:inherit; height:auto; line-height:inherit; margin:0px; max-width:100%; padding:0px; vertical-align:middle; width:422px" title="Bạn cần đọc kỹ thông tin trước khi quyết định mua hàng." /></p>
', CAST(N'2017-07-23T07:28:23.190' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:44:18.180' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (134, 16, 1, N'StaticContent', N'SeoUrl', N'huong-dan-mua-hang', CAST(N'2017-07-23T07:28:23.193' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:44:18.187' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (135, 16, 1, N'StaticContent', N'MetaTitle', N'Hướng dẫn mua hàng', CAST(N'2017-07-23T07:28:23.197' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:44:18.190' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (136, 16, 1, N'StaticContent', N'MetaKeywords', N'Hướng dẫn mua hàng', CAST(N'2017-07-23T07:28:23.200' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:44:18.190' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (137, 16, 1, N'StaticContent', N'MetaDescription', N'Hướng dẫn mua hàng', CAST(N'2017-07-23T07:28:23.203' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:44:18.197' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (138, 16, 2, N'StaticContent', N'Title', N'Bộ máy tổ chức 2', CAST(N'2017-07-23T07:28:23.207' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:44:18.200' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (139, 16, 2, N'StaticContent', N'SeoUrl', N'bo-may-to-chuc-2', CAST(N'2017-07-23T07:28:23.213' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:44:18.217' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (140, 16, 2, N'StaticContent', N'MetaTitle', N'Bộ máy tổ chức 2', CAST(N'2017-07-23T07:28:23.217' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:44:18.223' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (141, 16, 2, N'StaticContent', N'MetaKeywords', N'Bộ máy tổ chức 2', CAST(N'2017-07-23T07:28:23.220' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:44:18.230' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (142, 16, 2, N'StaticContent', N'MetaDescription', N'Bộ máy tổ chức 2', CAST(N'2017-07-23T07:28:23.223' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:44:18.233' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (143, 16, 3, N'StaticContent', N'Title', N'Bộ máy tổ chức 3', CAST(N'2017-07-23T07:28:23.227' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:44:18.233' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (144, 16, 3, N'StaticContent', N'SeoUrl', N'bo-may-to-chuc-3', CAST(N'2017-07-23T07:28:23.233' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:44:18.247' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (181, 14, 1, N'StaticContent', N'ShortDesc', N'<p>Ut tellus dolor, dapibus eget, elementum vel, cursus eleifend, elit. Aenean auctor wisi et urna. Aliquam erat volutpat. Duis ac turpis. Donec sit amet eros. Lorem ipsum dolor sit amet, consecvtetuer adipiscing elit. Mauris fermentum dictum magna. Sed laoreet aliquam leo. Ut tellus dolor, dapibus eget, elementum vel.</p>
', CAST(N'2017-07-24T02:20:28.490' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:10:12.297' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (182, 14, 1, N'StaticContent', N'Description', N'<p>ABOUT US Ut tellus dolor, dapibus eget, elementum vel, cursus eleifend, elit. Aenean auctor wisi et urna. Aliquam erat volutpat. Duis ac turpis. Donec sit amet eros. Lorem ipsum dolor sit amet, consecvtetuer adipiscing elit. Mauris fermentum dictum magna. Sed laoreet aliquam leo. Ut tellus dolor, dapibus eget, elementum vel. Aenean auctor wisi et urna. Aliquam erat volutpat. Duis ac turpis. Integer rutrum ante eu lacus. Vestibulum libero nisl, porta vel, scelerisque eget, malesuada at, neque. Vivamus eget nibh. Etiam cursus leo vel metus. Nulla facilisi. Aenean nec eros. Integer rutrum ante eu lacus.Vestibulum libero nisl, porta vel, scelerisque eget, malesuada at, neque. Vivamus eget nibh. Etiam cursus leo vel metus. Nulla facilisi. Aenean nec eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse sollicitudin velit sed leo. Ut pharetra augue nec augue. Nam elit agna,endrerit sit amet, tincidunt ac, viverra sed, nulla. Donec porta diam eu massa. Quisque diam lorem, interdum vitae,dapibus ac, scelerisque vitae, pede. Donec eget tellus non erat lacinia fermentum. Donec in velit vel ipsum auctor pulvinar. Vestibulum iaculis lacinia est. Proin dictum elementum velit. Fusce euismod consequat ante. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Pellentesque sed dolor. Aliquam congue fermentum nisl. Aenean auctor wisi et urna. Aliquam erat volutpat. Duis ac turpis. Integer rutrum ante eu lacus. Vestibulum libero nisl, porta vel, scelerisque eget, malesuada at, neque. Vivamus eget nibh. Etiam cursus leo vel metus. Nulla facilisi. Aenean nec eros. Integer rutrum ante eu lacus.Vestibulum libero nisl, porta vel, scelerisque eget, malesuada at, neque. Vivamus eget nibh. Etiam cursus leo vel metus. Nulla facilisi. Aenean nec eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse sollicitudin velit sed leo. Ut pharetra augue nec augue.</p>
', CAST(N'2017-07-24T02:20:28.520' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:10:12.300' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (183, 14, 2, N'StaticContent', N'ShortDesc', NULL, CAST(N'2017-07-24T02:20:28.540' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:10:12.317' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (184, 14, 2, N'StaticContent', N'Description', NULL, CAST(N'2017-07-24T02:20:28.543' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:10:12.320' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (185, 14, 3, N'StaticContent', N'ShortDesc', NULL, CAST(N'2017-07-24T02:20:28.563' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:10:12.333' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (186, 14, 3, N'StaticContent', N'Description', NULL, CAST(N'2017-07-24T02:20:28.567' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:10:12.340' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (223, 1115, 1, N'MenuLink', N'MenuName', N'Nội thất phong thủy', CAST(N'2017-07-24T08:39:25.307' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:33:48.847' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (224, 1115, 1, N'MenuLink', N'SeoUrl', N'noi-that-phong-thuy', CAST(N'2017-07-24T08:39:25.333' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:33:48.850' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (225, 1115, 1, N'MenuLink', N'MetaTitle', N'Nội thất phong thủy', CAST(N'2017-07-24T08:39:25.337' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:33:48.853' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (226, 1115, 1, N'MenuLink', N'MetaKeywords', N'Nội thất phong thủy', CAST(N'2017-07-24T08:39:25.340' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:33:48.857' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (227, 1115, 1, N'MenuLink', N'MetaDescription', N'Nội thất phong thủy', CAST(N'2017-07-24T08:39:25.350' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:33:48.863' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (228, 1115, 2, N'MenuLink', N'MenuName', N'News - events', CAST(N'2017-07-24T08:39:25.360' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:33:48.870' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (229, 1115, 2, N'MenuLink', N'SeoUrl', N'news-events', CAST(N'2017-07-24T08:39:25.367' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:33:48.873' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (230, 1115, 2, N'MenuLink', N'MetaTitle', N'News - events', CAST(N'2017-07-24T08:39:25.377' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:33:48.880' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (231, 1115, 2, N'MenuLink', N'MetaKeywords', N'News - events', CAST(N'2017-07-24T08:39:25.390' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:33:48.887' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (232, 1115, 2, N'MenuLink', N'MetaDescription', N'News - events', CAST(N'2017-07-24T08:39:25.397' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:33:48.890' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (233, 1115, 3, N'MenuLink', N'MenuName', N'ニュース - イベント', CAST(N'2017-07-24T08:39:25.407' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:33:48.897' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (234, 1115, 3, N'MenuLink', N'SeoUrl', N'', CAST(N'2017-07-24T08:39:25.417' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:33:48.903' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (235, 110, 1, N'MenuLink', N'SeoUrl', N'tin-tuc', CAST(N'2017-07-24T08:42:57.950' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:27.580' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (236, 110, 2, N'MenuLink', N'SeoUrl', N'traditional', CAST(N'2017-07-24T08:42:57.977' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:27.593' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (237, 110, 3, N'MenuLink', N'SeoUrl', N'', CAST(N'2017-07-24T08:42:58.000' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:27.607' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (238, 42, 1, N'Post', N'Title', N'Khu du lịch Cát Vân', CAST(N'2017-07-24T09:08:27.937' AS DateTime), N'Administrator', CAST(N'2018-05-13T16:09:14.410' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (239, 42, 1, N'Post', N'ProductCode', N'KDLCV2018.05.10', CAST(N'2017-07-24T09:08:27.963' AS DateTime), N'Administrator', CAST(N'2018-05-13T16:09:14.427' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (240, 42, 1, N'Post', N'MetaTitle', N'Khu du lịch Cát Vân', CAST(N'2017-07-24T09:08:27.973' AS DateTime), N'Administrator', CAST(N'2018-05-13T16:09:14.477' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (241, 42, 1, N'Post', N'MetaKeywords', N'Khu du lịch Cát Vân', CAST(N'2017-07-24T09:08:27.977' AS DateTime), N'Administrator', CAST(N'2018-05-13T16:09:14.487' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (242, 42, 1, N'Post', N'MetaDescription', N'Khu du lịch Cát Vân', CAST(N'2017-07-24T09:08:27.980' AS DateTime), N'Administrator', CAST(N'2018-05-13T16:09:14.497' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (243, 42, 2, N'Post', N'Title', N'ROUGH FISH GREASE', CAST(N'2017-07-24T09:08:27.983' AS DateTime), N'Administrator', CAST(N'2018-05-13T16:09:14.507' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (244, 42, 2, N'Post', N'ProductCode', N'ROUGH FISH GREASE', CAST(N'2017-07-24T09:08:27.987' AS DateTime), N'Administrator', CAST(N'2018-05-13T16:09:14.513' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (245, 42, 3, N'Post', N'Title', N'グリース', CAST(N'2017-07-24T09:08:27.997' AS DateTime), N'Administrator', CAST(N'2018-05-13T16:09:14.557' AS DateTime), N'Administrator')
GO
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (246, 42, 3, N'Post', N'ProductCode', N'グリース', CAST(N'2017-07-24T09:08:27.997' AS DateTime), N'Administrator', CAST(N'2018-05-13T16:09:14.567' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (278, 1, 1, N'ContactInformation', N'Title', N'Công ty TNHH Sản Xuất Thương Mại Thiên Phát ', CAST(N'2017-07-25T08:18:08.160' AS DateTime), N'Administrator', CAST(N'2017-07-25T08:18:08.160' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (279, 1, 1, N'ContactInformation', N'Address', N'Ấp Tân Thuận, Xã Bình Đức, Huyện Châu Thành, Tỉnh   Tiền Giang, Việt Nam', CAST(N'2017-07-25T08:18:08.170' AS DateTime), N'Administrator', CAST(N'2017-07-25T08:18:08.170' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (280, 1, 2, N'ContactInformation', N'Title', N'Thien Phat Trading Production Co., Ltd', CAST(N'2017-07-25T08:18:08.187' AS DateTime), N'Administrator', CAST(N'2017-07-25T08:18:08.187' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (281, 1, 2, N'ContactInformation', N'Address', N'Tan Thuan Hamlet, Binh Duc Village, Chau Thanh District, Tien Giang Province, Vietnam', CAST(N'2017-07-25T08:18:08.197' AS DateTime), N'Administrator', CAST(N'2017-07-25T08:18:08.197' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (282, 1, 3, N'ContactInformation', N'Title', N'コーン・ティーTNHHSảnXuấtThươngMạiThiênPhát', CAST(N'2017-07-25T08:18:08.210' AS DateTime), N'Administrator', CAST(N'2017-07-25T08:18:08.210' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (283, 1, 3, N'ContactInformation', N'Address', N'Tan Thuan Hamlet, Binh Duc Village, Chau Thanh District, Tien Giang Province, Vietnam', CAST(N'2017-07-25T08:18:08.220' AS DateTime), N'Administrator', CAST(N'2017-07-25T08:18:08.220' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (288, 1, 1, N'SystemSetting', N'Title', N'– Công ty thương mại và thời trang NAM LONG', CAST(N'2017-07-25T15:58:52.127' AS DateTime), N'Administrator', CAST(N'2018-04-10T15:42:32.210' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (289, 1, 1, N'SystemSetting', N'FooterContent', N'<p>Copyright &copy; 2016 C&ocirc;ng ty TNHH SX-TM NAM LONG</p>
', CAST(N'2017-07-25T15:58:52.153' AS DateTime), N'Administrator', CAST(N'2018-04-10T15:42:32.270' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (290, 1, 1, N'SystemSetting', N'MetaTitle', N'– Công ty thương mại và thời trang NAM LONG', CAST(N'2017-07-25T15:58:52.157' AS DateTime), N'Administrator', CAST(N'2018-04-10T15:42:32.307' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (291, 1, 1, N'SystemSetting', N'MetaKeywords', N'– Công ty thương mại và thời trang NAM LONG', CAST(N'2017-07-25T15:58:52.160' AS DateTime), N'Administrator', CAST(N'2018-04-10T15:42:32.320' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (292, 1, 1, N'SystemSetting', N'MetaDescription', N'– Công ty thương mại và thời trang NAM LONG', CAST(N'2017-07-25T15:58:52.163' AS DateTime), N'Administrator', CAST(N'2018-04-10T15:42:32.333' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (293, 1, 2, N'SystemSetting', N'Title', N'– Công ty thương mại và thời trang NAM LONG', CAST(N'2017-07-25T15:58:52.167' AS DateTime), N'Administrator', CAST(N'2018-04-10T15:42:32.357' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (294, 1, 3, N'SystemSetting', N'Title', N'– Công ty thương mại và thời trang NAM LONG', CAST(N'2017-07-25T15:58:52.177' AS DateTime), N'Administrator', CAST(N'2018-04-10T15:42:32.423' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (295, 1, 2, N'SystemSetting', N'MetaTitle', N'Thien Phat Co., Ltd', CAST(N'2017-07-25T16:02:14.123' AS DateTime), N'Administrator', CAST(N'2018-04-10T15:42:32.383' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (296, 1, 2, N'SystemSetting', N'MetaKeywords', N'Thien Phat Co., Ltd', CAST(N'2017-07-25T16:02:14.137' AS DateTime), N'Administrator', CAST(N'2018-04-10T15:42:32.393' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (297, 1, 2, N'SystemSetting', N'MetaDescription', N'Thien Phat Co., Ltd', CAST(N'2017-07-25T16:02:14.143' AS DateTime), N'Administrator', CAST(N'2018-04-10T15:42:32.403' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (298, 1, 3, N'SystemSetting', N'MetaTitle', N'ティエンファット', CAST(N'2017-07-25T16:02:14.163' AS DateTime), N'Administrator', CAST(N'2018-04-10T15:42:32.450' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (299, 1, 3, N'SystemSetting', N'MetaKeywords', N'ティエンファット', CAST(N'2017-07-25T16:02:14.167' AS DateTime), N'Administrator', CAST(N'2018-04-10T15:42:32.457' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (300, 1, 3, N'SystemSetting', N'MetaDescription', N'ティエンファット', CAST(N'2017-07-25T16:02:14.187' AS DateTime), N'Administrator', CAST(N'2018-04-10T15:42:32.467' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (301, 1, 2, N'SystemSetting', N'FooterContent', N'<p>Copyright &copy; 2016 Thien Phat Company</p>
', CAST(N'2017-07-25T16:03:07.220' AS DateTime), N'Administrator', CAST(N'2018-04-10T15:42:32.363' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (302, 1, 3, N'SystemSetting', N'FooterContent', N'<p>著作権&copy;2016ティエンファット・カンパニー</p>
', CAST(N'2017-07-25T16:03:07.273' AS DateTime), N'Administrator', CAST(N'2018-04-10T15:42:32.430' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (303, 2123, 1, N'MenuLink', N'SeoUrl', N'trang-chu', CAST(N'2017-07-25T16:46:15.690' AS DateTime), N'Administrator', CAST(N'2017-08-09T16:20:29.047' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (304, 2123, 3, N'MenuLink', N'SeoUrl', N'', CAST(N'2017-07-25T16:46:15.923' AS DateTime), N'Administrator', CAST(N'2017-08-09T16:20:29.187' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (321, 2120, 1, N'MenuLink', N'MenuName', N'Liên hệ', CAST(N'2017-07-25T16:48:08.277' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:47:45.760' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (322, 2120, 1, N'MenuLink', N'SeoUrl', N'lien-he', CAST(N'2017-07-25T16:48:08.283' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:47:45.790' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (323, 2120, 1, N'MenuLink', N'MetaTitle', N'Liên hệ', CAST(N'2017-07-25T16:48:08.287' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:47:45.800' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (324, 2120, 1, N'MenuLink', N'MetaKeywords', N'Liên hệ', CAST(N'2017-07-25T16:48:08.293' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:47:45.803' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (325, 2120, 1, N'MenuLink', N'MetaDescription', N'Liên hệ', CAST(N'2017-07-25T16:48:08.297' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:47:45.813' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (326, 2120, 2, N'MenuLink', N'MenuName', N'Contact', CAST(N'2017-07-25T16:48:08.303' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:47:45.817' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (327, 2120, 2, N'MenuLink', N'SeoUrl', N'contact', CAST(N'2017-07-25T16:48:08.310' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:47:45.823' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (328, 2120, 2, N'MenuLink', N'MetaTitle', N'Contact', CAST(N'2017-07-25T16:48:08.320' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:47:45.830' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (329, 2120, 2, N'MenuLink', N'MetaKeywords', N'Contact', CAST(N'2017-07-25T16:48:08.327' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:47:45.833' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (330, 2120, 2, N'MenuLink', N'MetaDescription', N'Contact', CAST(N'2017-07-25T16:48:08.380' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:47:45.840' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (331, 2120, 3, N'MenuLink', N'MenuName', N'接続', CAST(N'2017-07-25T16:48:08.497' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:47:45.843' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (332, 2120, 3, N'MenuLink', N'MetaTitle', N'接続', CAST(N'2017-07-25T16:48:08.723' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:47:45.853' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (333, 2120, 3, N'MenuLink', N'MetaKeywords', N'接続', CAST(N'2017-07-25T16:48:08.793' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:47:45.863' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (334, 2120, 3, N'MenuLink', N'MetaDescription', N'接続', CAST(N'2017-07-25T16:48:08.807' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:47:45.863' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (335, 2123, 2, N'MenuLink', N'SeoUrl', N'home', CAST(N'2017-07-25T16:48:46.013' AS DateTime), N'Administrator', CAST(N'2017-08-09T16:20:29.120' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (377, 42, 1, N'Post', N'ShortDesc', N'<p><span style="background-color:rgba(255, 255, 255, 0.85); font-family:myriadpro; font-size:16px">Sản Phẩm Mỡ C&aacute; Basa được chế biến trong m&ocirc;i trường vệ sinh, an to&agrave;n thực phẩm với hệ thống nh&agrave; m&aacute;y sản xuất ...</span></p>
', CAST(N'2017-07-26T02:46:53.220' AS DateTime), N'Administrator', CAST(N'2018-05-13T16:09:14.437' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (378, 42, 1, N'Post', N'TechInfo', N'<p>Sản Phẩm Mỡ C&aacute; Basa được chế biến trong m&ocirc;i trường vệ sinh, an to&agrave;n thực phẩm với hệ thống nh&agrave; m&aacute;y sản xuất được &aacute;p dụng c&aacute;c c&ocirc;ng nghệ ti&ecirc;n tiến hiện đại.</p>

<p>Xuất xứ: Việt Nam</p>

<p>Loại c&aacute;: C&aacute; Tra</p>

<p>Qui c&aacute;ch đ&oacute;ng g&oacute;i: 193kg/th&ugrave;ng phi hoặc 20 tấn/flexitank</p>

<p>Số lượng cung ứng: 1000-1200 tấn/th&aacute;ng</p>

<table border="1" cellpadding="5" cellspacing="1" style="border-collapse:collapse; border-spacing:0px; box-sizing:border-box; font-family:myriadpro; font-size:16px; outline:0px; width:500px">
	<tbody>
		<tr>
			<td style="text-align:center"><span style="color:rgb(0, 128, 0)"><strong>Ti&ecirc;u chuẩn chất lượng</strong></span></td>
			<td style="text-align:center"><span style="color:rgb(0, 128, 0)"><strong>Ti&ecirc;u chuẩn Việt Nam</strong></span></td>
		</tr>
		<tr>
			<td style="text-align:center">Chỉ số Acid (mgKOH/g)</td>
			<td style="text-align:center">3% max</td>
		</tr>
		<tr>
			<td style="text-align:center">Chỉ số Iodine (gI&shy;2/100g)</td>
			<td style="text-align:center">80 max</td>
		</tr>
	</tbody>
</table>
', CAST(N'2017-07-26T02:47:07.180' AS DateTime), N'Administrator', CAST(N'2018-05-13T16:09:14.460' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (379, 42, 2, N'Post', N'ShortDesc', N'<p>Basa fish fat products are processed in hygienic environment, food safety system factory ...</p>
', CAST(N'2017-07-26T02:49:12.080' AS DateTime), N'Administrator', CAST(N'2018-05-13T16:09:14.523' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (380, 42, 2, N'Post', N'TechInfo', N'<p>Basa fish fat products are processed in hygienic environment, food safety with factory system is applied modern advanced technology.</p>

<p>Made in Viet Nam</p>

<p>Type of fish: Pangasius</p>

<p>Packing: 193kg / barrel or 20 tons / flexitank</p>

<p>Supply quantity: 1000-1200 tons / month</p>

<table border="1" cellpadding="5" cellspacing="1" style="border-collapse:collapse; border-spacing:0px; box-sizing:border-box; font-family:myriadpro; font-size:16px; outline:0px; width:500px">
	<tbody>
		<tr>
			<td style="text-align:center"><span style="font-size:13px">Quality standards</span></td>
			<td style="text-align:center"><span style="font-size:13px">Vietnam standard</span></td>
		</tr>
		<tr>
			<td style="text-align:center"><span style="font-size:13px">Acid Index (mgKOH / g)</span></td>
			<td style="text-align:center"><span style="font-size:13px">3% max</span></td>
		</tr>
		<tr>
			<td style="text-align:center">Iodine index<span style="font-size:13px"> (gI&shy;2/100g)</span></td>
			<td style="text-align:center"><span style="font-size:13px">80 max</span></td>
		</tr>
	</tbody>
</table>
', CAST(N'2017-07-26T02:49:12.087' AS DateTime), N'Administrator', CAST(N'2018-05-13T16:09:14.537' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (381, 42, 3, N'Post', N'ShortDesc', N'<p>製品のナマズの脂肪は、工場での衛生的な環境、食品安全システムで処理されました...</p>
', CAST(N'2017-07-26T02:50:44.253' AS DateTime), N'Administrator', CAST(N'2018-05-13T16:09:14.577' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (382, 42, 3, N'Post', N'TechInfo', N'<p>製品のナマズの脂肪は衛生的な環境で処理された、工場での食品安全システムは、現代の高度な技術を適用しました。</p>

<p>原産国：ベトナム</p>

<p>魚：ナマズ</p>

<p>パッキング：193キロ/バレルまたは20トン/ flexitank</p>

<p>数量供給：1000〜1200トン/月</p>

<table border="1" cellpadding="5" cellspacing="1" style="border-collapse:collapse; border-spacing:0px; box-sizing:border-box; font-family:myriadpro; font-size:16px; outline:0px; width:500px">
	<tbody>
		<tr>
			<td style="text-align:center"><span style="font-size:13px">品質基準</span></td>
			<td style="text-align:center"><span style="font-size:13px">ベトナム規格</span></td>
		</tr>
		<tr>
			<td style="text-align:center"><span style="font-size:13px">インデックス酸（mgKOH/ g）で</span></td>
			<td style="text-align:center"><span style="font-size:13px">3% max</span></td>
		</tr>
		<tr>
			<td style="text-align:center">ヨウ素指数（GI2/100グラム）</td>
			<td style="text-align:center"><span style="font-size:13px">80 max</span></td>
		</tr>
	</tbody>
</table>
', CAST(N'2017-07-26T02:50:44.257' AS DateTime), N'Administrator', CAST(N'2018-05-13T16:09:14.593' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (398, 2119, 1, N'MenuLink', N'SeoUrl', N'ho-so-nang-luc', CAST(N'2017-07-26T06:12:59.213' AS DateTime), N'Administrator', CAST(N'2017-10-14T06:12:44.160' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (399, 2119, 2, N'MenuLink', N'SeoUrl', N'', CAST(N'2017-07-26T06:12:59.240' AS DateTime), N'Administrator', CAST(N'2017-10-14T06:12:44.197' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (400, 2119, 2, N'MenuLink', N'MetaTitle', N'Organizational structure', CAST(N'2017-07-26T06:12:59.243' AS DateTime), N'Administrator', CAST(N'2017-10-14T06:12:44.207' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (401, 2119, 2, N'MenuLink', N'MetaKeywords', N'Organizational structure', CAST(N'2017-07-26T06:12:59.303' AS DateTime), N'Administrator', CAST(N'2017-10-14T06:12:44.210' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (402, 2119, 2, N'MenuLink', N'MetaDescription', N'Organizational structure', CAST(N'2017-07-26T06:12:59.307' AS DateTime), N'Administrator', CAST(N'2017-10-14T06:12:44.217' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (403, 2119, 3, N'MenuLink', N'MetaTitle', N'組織装置', CAST(N'2017-07-26T06:12:59.317' AS DateTime), N'Administrator', CAST(N'2017-10-14T06:12:44.233' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (404, 2119, 3, N'MenuLink', N'MetaKeywords', N'組織装置', CAST(N'2017-07-26T06:12:59.323' AS DateTime), N'Administrator', CAST(N'2017-10-14T06:12:44.237' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (405, 2119, 3, N'MenuLink', N'MetaDescription', N'組織装置', CAST(N'2017-07-26T06:12:59.327' AS DateTime), N'Administrator', CAST(N'2017-10-14T06:12:44.243' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (406, 2121, 1, N'MenuLink', N'MenuName', N'Resort', CAST(N'2017-07-26T06:40:02.690' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:18:22.907' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (407, 2121, 1, N'MenuLink', N'SeoUrl', N'resort', CAST(N'2017-07-26T06:40:02.703' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:18:22.920' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (408, 2121, 1, N'MenuLink', N'MetaTitle', N'Resort', CAST(N'2017-07-26T06:40:02.707' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:18:22.927' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (409, 2121, 1, N'MenuLink', N'MetaKeywords', N'Resort', CAST(N'2017-07-26T06:40:02.713' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:18:22.933' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (410, 2121, 1, N'MenuLink', N'MetaDescription', N'Resort', CAST(N'2017-07-26T06:40:02.717' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:18:22.937' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (411, 2121, 2, N'MenuLink', N'MenuName', N'Material', CAST(N'2017-07-26T06:40:02.723' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:18:22.943' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (412, 2121, 2, N'MenuLink', N'SeoUrl', N'material', CAST(N'2017-07-26T06:40:02.730' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:18:22.950' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (413, 2121, 2, N'MenuLink', N'MetaTitle', N'Material', CAST(N'2017-07-26T06:40:02.733' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:18:22.957' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (414, 2121, 2, N'MenuLink', N'MetaKeywords', N'Material', CAST(N'2017-07-26T06:40:02.737' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:18:22.963' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (415, 2121, 2, N'MenuLink', N'MetaDescription', N'Material', CAST(N'2017-07-26T06:40:02.743' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:18:22.967' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (416, 2121, 3, N'MenuLink', N'MenuName', N'原料', CAST(N'2017-07-26T06:40:02.747' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:18:22.977' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (417, 2121, 3, N'MenuLink', N'MetaTitle', N'原料', CAST(N'2017-07-26T06:40:02.753' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:18:22.993' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (418, 2121, 3, N'MenuLink', N'MetaKeywords', N'原料', CAST(N'2017-07-26T06:40:02.760' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:18:22.997' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (419, 2121, 3, N'MenuLink', N'MetaDescription', N'原料', CAST(N'2017-07-26T06:40:02.767' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:18:23.003' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (420, 2122, 1, N'MenuLink', N'MenuName', N'Quy hoạch đô thị', CAST(N'2017-07-26T06:40:39.813' AS DateTime), N'Administrator', CAST(N'2018-03-06T16:26:22.630' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (421, 2122, 1, N'MenuLink', N'SeoUrl', N'quy-hoach-do-thi', CAST(N'2017-07-26T06:40:39.820' AS DateTime), N'Administrator', CAST(N'2018-03-06T16:26:22.660' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (422, 2122, 1, N'MenuLink', N'MetaTitle', N'Quy hoạch đô thị', CAST(N'2017-07-26T06:40:39.823' AS DateTime), N'Administrator', CAST(N'2018-03-06T16:26:22.667' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (423, 2122, 1, N'MenuLink', N'MetaKeywords', N'Quy hoạch đô thị', CAST(N'2017-07-26T06:40:39.827' AS DateTime), N'Administrator', CAST(N'2018-03-06T16:26:22.680' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (424, 2122, 1, N'MenuLink', N'MetaDescription', N'Quy hoạch đô thị', CAST(N'2017-07-26T06:40:39.833' AS DateTime), N'Administrator', CAST(N'2018-03-06T16:26:22.687' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (425, 2122, 2, N'MenuLink', N'MenuName', N'Production process', CAST(N'2017-07-26T06:40:39.837' AS DateTime), N'Administrator', CAST(N'2018-03-06T16:26:22.693' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (426, 2122, 2, N'MenuLink', N'SeoUrl', N'production-process', CAST(N'2017-07-26T06:40:39.843' AS DateTime), N'Administrator', CAST(N'2018-03-06T16:26:22.697' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (427, 2122, 2, N'MenuLink', N'MetaTitle', N'Production process', CAST(N'2017-07-26T06:40:39.847' AS DateTime), N'Administrator', CAST(N'2018-03-06T16:26:22.730' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (428, 2122, 2, N'MenuLink', N'MetaKeywords', N'Production process', CAST(N'2017-07-26T06:40:39.853' AS DateTime), N'Administrator', CAST(N'2018-03-06T16:26:22.767' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (429, 2122, 2, N'MenuLink', N'MetaDescription', N'Production process', CAST(N'2017-07-26T06:40:40.140' AS DateTime), N'Administrator', CAST(N'2018-03-06T16:26:22.770' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (430, 2122, 3, N'MenuLink', N'MenuName', N'生産プロセス', CAST(N'2017-07-26T06:40:40.147' AS DateTime), N'Administrator', CAST(N'2018-03-06T16:26:22.777' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (431, 2122, 3, N'MenuLink', N'MetaTitle', N'生産プロセス', CAST(N'2017-07-26T06:40:40.153' AS DateTime), N'Administrator', CAST(N'2018-03-06T16:26:22.780' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (432, 2122, 3, N'MenuLink', N'MetaKeywords', N'生産プロセス', CAST(N'2017-07-26T06:40:40.160' AS DateTime), N'Administrator', CAST(N'2018-03-06T16:26:22.783' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (433, 2122, 3, N'MenuLink', N'MetaDescription', N'生産プロセス', CAST(N'2017-07-26T06:40:40.163' AS DateTime), N'Administrator', CAST(N'2018-03-06T16:26:22.790' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (443, 1115, 3, N'MenuLink', N'MetaTitle', N'ニュース - イベント', CAST(N'2017-07-26T09:09:17.970' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:33:48.910' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (444, 1115, 3, N'MenuLink', N'MetaKeywords', N'ニュース - イベント', CAST(N'2017-07-26T09:09:18.007' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:33:48.917' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (445, 1115, 3, N'MenuLink', N'MetaDescription', N'ニュース - イベント', CAST(N'2017-07-26T09:09:18.010' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:33:48.923' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (446, 2115, 1, N'MenuLink', N'MenuName', N'Không gian xanh', CAST(N'2017-07-26T09:09:51.357' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:18.490' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (447, 2115, 1, N'MenuLink', N'SeoUrl', N'khong-gian-xanh', CAST(N'2017-07-26T09:09:51.363' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:18.493' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (448, 2115, 1, N'MenuLink', N'MetaTitle', N'Không gian xanh', CAST(N'2017-07-26T09:09:51.367' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:18.497' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (449, 2115, 1, N'MenuLink', N'MetaKeywords', N'Không gian xanh', CAST(N'2017-07-26T09:09:51.373' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:18.500' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (450, 2115, 1, N'MenuLink', N'MetaDescription', N'Không gian xanh', CAST(N'2017-07-26T09:09:51.377' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:18.503' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (451, 2115, 2, N'MenuLink', N'MenuName', N'News', CAST(N'2017-07-26T09:09:51.380' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:18.507' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (452, 2115, 2, N'MenuLink', N'SeoUrl', N'news', CAST(N'2017-07-26T09:09:51.387' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:18.510' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (453, 2115, 2, N'MenuLink', N'MetaTitle', N'News', CAST(N'2017-07-26T09:09:51.390' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:18.510' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (454, 2115, 2, N'MenuLink', N'MetaKeywords', N'News', CAST(N'2017-07-26T09:09:51.397' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:18.513' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (455, 2115, 2, N'MenuLink', N'MetaDescription', N'News', CAST(N'2017-07-26T09:09:51.400' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:18.517' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (456, 2115, 3, N'MenuLink', N'MenuName', N'ニュース', CAST(N'2017-07-26T09:09:51.403' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:18.520' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (457, 2115, 3, N'MenuLink', N'MetaTitle', N'ニュース', CAST(N'2017-07-26T09:09:51.410' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:18.527' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (458, 2115, 3, N'MenuLink', N'MetaKeywords', N'ニュース', CAST(N'2017-07-26T09:09:51.417' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:18.527' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (459, 2115, 3, N'MenuLink', N'MetaDescription', N'ニュース', CAST(N'2017-07-26T09:09:51.420' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:18.530' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (460, 9, 1, N'News', N'Title', N'CHẤT BÉO CÓ THỰC SỰ LÀ KẺ THÙ CỦA CƠ THỂ 1', CAST(N'2017-07-26T09:35:23.897' AS DateTime), N'Administrator', CAST(N'2018-02-25T15:45:14.230' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (461, 9, 1, N'News', N'ShortDesc', N'<p>L&agrave; một trong bốn nh&oacute;m dinh dưỡng quan trọng kh&ocirc;ng thể thiếu trong bữa ăn hằng ng&agrave;y nhưng chất b&eacute;o cũng thường xuy&ecirc;n bị &ldquo;tố c&aacute;o&rdquo; l&agrave; nguy&ecirc;n nh&acirc;n ch&iacute;nh l&agrave;m tăng c&acirc;n v&agrave; nhiều vấn đề sức khỏe kh&aacute;c. Vậy thực sự, chất b&eacute;o l&agrave; &ldquo;bạn hay th&ugrave;&rdquo;? Chất b&eacute;o l&agrave;nh mạnh tốt cho sức khỏe</p>
', CAST(N'2017-07-26T09:35:23.907' AS DateTime), N'Administrator', CAST(N'2018-02-25T15:45:14.240' AS DateTime), N'Administrator')
GO
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (462, 9, 1, N'News', N'Description', N'<p><strong><span style="font-family:arial; font-size:14px">L&agrave; một trong bốn nh&oacute;m dinh dưỡng quan trọng kh&ocirc;ng thể thiếu trong bữa ăn hằng ng&agrave;y nhưng chất b&eacute;o cũng thường xuy&ecirc;n bị &ldquo;tố c&aacute;o&rdquo; l&agrave; nguy&ecirc;n nh&acirc;n ch&iacute;nh l&agrave;m tăng c&acirc;n v&agrave; nhiều vấn đề sức khỏe kh&aacute;c. Vậy thực sự, chất b&eacute;o l&agrave; &ldquo;bạn hay th&ugrave;&rdquo;?&nbsp;</span></strong></p>

<p style="text-align:justify"><strong>Chất b&eacute;o l&agrave;nh mạnh tốt cho sức khỏe</strong></p>

<p style="text-align:justify">Cơ thể lu&ocirc;n cần một lượng chất b&eacute;o nhất định để hoạt động. C&aacute;c loại chất b&eacute;o c&oacute; lợi c&oacute; nhiệm vụ chuyển h&oacute;a v&agrave; dự trữ năng lượng, bảo vệ c&aacute;c cơ quan. Khi được bổ sung đủ chất b&eacute;o l&agrave;nh mạnh, cơ thể sẽ vừa vui vừa khỏe -&nbsp;l&acirc;u đ&oacute;i hơn, cơ săn chắc, &iacute;t đau mỏi, da dẻ mịn m&agrave;ng v&agrave; tinh thần phấn chấn. Chưa kể, chất b&eacute;o c&ograve;n c&oacute; t&aacute;c dụng trong việc cải thiện hương vị v&agrave; kết cấu của m&oacute;n ăn.&nbsp;</p>

<p style="text-align:justify">Viện Dinh dưỡng quốc gia kết luận cơ thể nếu chỉ bổ sung nguồn chất b&eacute;o từ thực vật sẽ thiếu dinh dưỡng, cần phải bổ sung chất b&eacute;o từ động vật để ph&aacute;t huy tối đa lợi &iacute;ch. Mỡ động vật l&agrave; mỡ lấy từ gia s&uacute;c, gia cầm, hải sản như mỡ g&agrave;, mỡ lợn, mỡ b&ograve;&hellip;,&nbsp;c&ograve;n dầu thực vật l&agrave; nguồn chất b&eacute;o từ c&aacute;c loại dầu thực vật như dầu n&agrave;nh, dầu cọ&hellip;&nbsp;</p>

<p style="text-align:justify">Theo nhu cầu khuyến nghị dinh dưỡng cho người Việt Nam giai đoạn từ năm 2016-2020, người trưởng th&agrave;nh cần 5 muỗng c&agrave; ph&ecirc; dầu, mỡ mỗi ng&agrave;y.&nbsp;</p>

<p style="text-align:justify">Đặc biệt, trẻ c&agrave;ng nhỏ, nhu cầu chất b&eacute;o lại c&agrave;ng cao, c&oacute; thể l&ecirc;n đến 50% tổng nhu cầu năng lượng khẩu phần. Trong những năm đầu đời, b&eacute; cần đầy đủ v&agrave; đa dạng chất b&eacute;o từ 2 nguồn động vật v&agrave; thực vật xen kẽ để đ&aacute;p ứng nhu cầu tăng trưởng thể chất lẫn tr&iacute; tuệ.&nbsp;</p>

<p style="text-align:justify">Mỡ động vật c&oacute; khả năng cung cấp cholesterol tốt, cần thiết cho cấu tr&uacute;c tế b&agrave;o, đặc biệt l&agrave; tế b&agrave;o thần kinh, l&agrave;m bền th&agrave;nh mao mạch, gi&uacute;p ph&ograve;ng ngừa xuất huyết n&atilde;o.</p>

<table align="center" border="0" cellpadding="0" cellspacing="0" class="desc_image slide_content" style="border-collapse:collapse; border-spacing:0px; box-sizing:border-box; color:rgb(102, 102, 102); font-family:arial; font-size:14px; line-height:18px; margin:0px auto 14px; max-width:100%; outline:0px; padding:0px; position:relative; text-align:justify">
	<tbody>
		<tr>
			<td><img alt="​Chất béo có thực sự là kẻ thù của cơ thể? " src="http://static.new.tuoitre.vn/tto/r/2016/10/11/ranee-1-1476183992.jpg" style="background:transparent; border:0px; box-sizing:border-box; cursor:url(&quot;../images/zoom_cursor.png&quot;), auto; display:block; margin:0px; max-width:100%; outline:0px; padding:0px; vertical-align:baseline; width:490px" /></td>
		</tr>
		<tr>
			<td>Kh&ocirc;ng n&ecirc;n l&atilde;ng qu&ecirc;n chất b&eacute;o trong chế độ ăn hằng ng&agrave;y</td>
		</tr>
	</tbody>
</table>

<p style="text-align:justify"><strong>Kh&ocirc;ng n&ecirc;n l&atilde;ng qu&ecirc;n chất b&eacute;o&nbsp;</strong></p>

<p style="text-align:justify">Để nạp chất b&eacute;o hợp l&yacute;, cần tăng cường bổ sung c&aacute;c axit b&eacute;o kh&ocirc;ng b&atilde;o h&ograve;a, giảm chất b&eacute;o b&atilde;o h&ograve;a v&agrave; chất b&eacute;o chuyển h&oacute;a. Kh&ocirc;ng n&ecirc;n ăn qu&aacute; nhiều trứng, thịt đỏ, hải sản v&igrave; c&aacute;c loại thực phẩm n&agrave;y chứa nhiều chất b&eacute;o b&atilde;o h&ograve;a.&nbsp;</p>

<p style="text-align:justify">Thay v&agrave;o đ&oacute;, tăng cường c&aacute;c loại c&aacute; b&eacute;o, thịt nạc, sữa &iacute;t b&eacute;o v&agrave; c&aacute;c loại hạt vốn gi&agrave;u c&aacute;c axit b&eacute;o kh&ocirc;ng b&atilde;o h&ograve;a. Đặc biệt, c&aacute; b&eacute;o ch&iacute;nh l&agrave; nguồn cung cấp DHA, Omega-3-6-9 phong ph&uacute;, vốn l&agrave; những dưỡng chất quan trọng, đặc biệt cần thiết cho người gi&agrave; v&agrave; trẻ nhỏ.&nbsp;</p>

<p style="text-align:justify">Chiết xuất từ c&aacute; b&eacute;o, mỡ c&aacute; kh&ocirc;ng chỉ l&agrave; loại mỡ động vật dễ ti&ecirc;u h&agrave;ng đầu m&agrave; c&ograve;n l&agrave; nguồn cung cấp c&aacute;c axit b&eacute;o Omega-3-6-9 v&agrave; vitamin dồi d&agrave;o. &ldquo;Đối với trẻ em, c&aacute;c axit b&eacute;o gi&uacute;p trẻ th&ocirc;ng minh hơn. Đối với người cao tuổi, c&aacute;c axit b&eacute;o c&oacute; t&aacute;c dụng l&agrave;m chậm qu&aacute; tr&igrave;nh l&atilde;o h&oacute;a v&agrave; suy giảm tr&iacute; tuệ&rdquo; -&nbsp;ThS-BS CK2 Đỗ Thị Ngọc Diệp, gi&aacute;m đốc Trung t&acirc;m Dinh dưỡng TP.HCM, cho biết.</p>

<table align="center" border="0" cellpadding="0" cellspacing="0" class="desc_image slide_content" style="border-collapse:collapse; border-spacing:0px; box-sizing:border-box; color:rgb(102, 102, 102); font-family:arial; font-size:14px; line-height:18px; margin:0px auto 14px; max-width:100%; outline:0px; padding:0px; position:relative; text-align:justify">
	<tbody>
		<tr>
			<td style="text-align:center"><img alt="​Chất béo có thực sự là kẻ thù của cơ thể? " src="http://static.new.tuoitre.vn/tto/r/2016/10/11/ranee-2-1476183991.jpg" style="background:transparent; border:0px; box-sizing:border-box; cursor:url(&quot;../images/zoom_cursor.png&quot;), auto; display:block; margin:0px; max-width:100%; outline:0px; padding:0px; vertical-align:baseline; width:490px" /></td>
		</tr>
		<tr>
			<td>Với dầu ăn dinh dưỡng Ranee từ tinh dầu c&aacute; da trơn, b&agrave;i to&aacute;n c&acirc;n bằng giữa sức khỏe lẫn vị ngon đ&atilde; được giải quyết</td>
		</tr>
	</tbody>
</table>

<p style="text-align:justify"><strong>Dầu ăn bổ sung th&ecirc;m chất b&eacute;o tốt v&agrave; vitamin&nbsp;</strong></p>

<p style="text-align:justify">L&agrave; sản phẩm dầu ăn đầu ti&ecirc;n c&oacute; nguồn gốc từ động vật, dầu ăn dinh dưỡng Ranee chiết xuất từ 100% tinh dầu c&aacute; da trơn rất gi&agrave;u c&aacute;c axit b&eacute;o kh&ocirc;ng b&atilde;o h&ograve;a, bổ sung th&ecirc;m chất b&eacute;o tốt v&agrave; vitamin v&agrave;o chế độ ăn hằng ng&agrave;y của c&aacute;c gia đ&igrave;nh Việt.&nbsp;</p>

<p style="text-align:justify">PGS.TS Trương Tuyết Mai, ph&oacute; viện trưởng Viện Dinh dưỡng quốc gia, cho biết th&agrave;nh phần dinh dưỡng của dầu c&aacute; cao cấp Ranee c&oacute; t&aacute;c dụng b&igrave;nh ổn cholesterol m&aacute;u, hỗ trợ ph&ograve;ng ngừa c&aacute;c bệnh tim mạch v&agrave; c&aacute;c bệnh li&ecirc;n quan đến sa s&uacute;t tr&iacute; tuệ, hỗ trợ ph&ograve;ng chống thiếu vitamin A.&nbsp;</p>

<p style="text-align:justify">Ngo&agrave;i t&aacute;c dụng dinh dưỡng, dầu c&aacute; Ranee c&ograve;n ph&aacute;t huy c&aacute;c ưu điểm của truyền thống chi&ecirc;n r&aacute;n bằng mỡ động vật, gi&uacute;p m&oacute;n ăn b&eacute;o ngậy, gi&ograve;n rụm, v&agrave;ng đều v&agrave; dậy m&ugrave;i thơm kh&oacute; cưỡng.&nbsp;</p>

<p style="text-align:justify">Một điểm đặc biệt nữa khiến Ranee được l&ograve;ng c&aacute;c chị em nội trợ đ&oacute; l&agrave; kh&ocirc;ng c&oacute; m&ugrave;i tanh kh&oacute; chịu, v&igrave; thế rất dễ ứng dụng v&agrave;o c&aacute;c m&oacute;n chi&ecirc;n x&agrave;o, trộn hoặc canh, ch&aacute;o, bột. Nhiều b&agrave; nội trợ chia sẻ sử dụng dầu ăn cao cấp Ranee họ vừa thoải m&aacute;i s&aacute;ng tạo th&ecirc;m nhiều m&oacute;n mới trong thực đơn, vừa y&ecirc;n t&acirc;m rằng những bữa ăn gia đ&igrave;nh lu&ocirc;n đủ đầy dinh dưỡng tốt cho sức khỏe.</p>
', CAST(N'2017-07-26T09:35:23.910' AS DateTime), N'Administrator', CAST(N'2018-02-25T15:45:14.243' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (463, 9, 1, N'News', N'SeoUrl', N'chat-beo-co-thuc-su-la-ke-thu-cua-co-the-1', CAST(N'2017-07-26T09:35:23.917' AS DateTime), N'Administrator', CAST(N'2018-02-25T15:45:14.247' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (464, 9, 1, N'News', N'MetaTitle', N'CHẤT BÉO CÓ THỰC SỰ LÀ KẺ THÙ CỦA CƠ THỂ 1', CAST(N'2017-07-26T09:35:23.920' AS DateTime), N'Administrator', CAST(N'2018-02-25T15:45:14.250' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (465, 9, 1, N'News', N'MetaKeywords', N'CHẤT BÉO CÓ THỰC SỰ LÀ KẺ THÙ CỦA CƠ THỂ 1', CAST(N'2017-07-26T09:35:23.927' AS DateTime), N'Administrator', CAST(N'2018-02-25T15:45:14.253' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (466, 9, 1, N'News', N'MetaDescription', N'CHẤT BÉO CÓ THỰC SỰ LÀ KẺ THÙ CỦA CƠ THỂ 1', CAST(N'2017-07-26T09:35:23.930' AS DateTime), N'Administrator', CAST(N'2018-02-25T15:45:14.257' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (467, 9, 2, N'News', N'Title', N'Fat is really the enemy of the body?', CAST(N'2017-07-26T09:37:14.260' AS DateTime), N'Administrator', CAST(N'2018-02-25T15:45:14.257' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (468, 9, 2, N'News', N'ShortDesc', N'<p>As one of the four important nutritional groups indispensable in daily meals but fat is also frequently &quot;denounced&quot; as the main cause of ...</p>
', CAST(N'2017-07-26T09:37:14.267' AS DateTime), N'Administrator', CAST(N'2018-02-25T15:45:14.260' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (469, 9, 2, N'News', N'Description', N'<p>Being one of the four important nutrients indispensable in daily meals but fat is also frequently &quot;accused&quot; as the main cause of weight gain and many other health problems. So really, fat is &quot;friend or foe&quot;?</p>

<p>Healthy fats are good for your health</p>

<p>The body always needs a certain amount of fat to function. The types of beneficial fats are responsible for metabolizing and storing energy, protecting the organs. When you are fortified with healthy fats, your body will be happy and well-hungry, firm, less aching, smoother, and spirited. Not to mention, fat also has the effect of improving the flavor and texture of the dish.</p>

<p>The National Diet Institute concludes that if the only source of vegetable fat is malnutrition, it is necessary to add animal fats to maximize the benefits. Animal fat is fat derived from livestock, poultry and seafood such as chicken fat, lard, beef tallow ... and vegetable oil is a source of fat from vegetable oils such as soybean oil, palm oil.</p>

<p>According to the nutritional recommendations for Vietnamese people in the period 2016-2020, adults need 5 teaspoons of oil and fat per day.</p>

<p>In particular, the smaller the child, the higher the fat requirement, up to 50% of the total energy requirement. In the early years of life, the baby needs adequate and diverse fats from two sources of animals and plants intermingled to meet both physical and intellectual growth needs.</p>

<p>Animal fats are capable of providing good cholesterol, essential for cellular structure, especially nerve cells, to harden the capillaries, to help prevent cerebral hemorrhage.</p>

<table align="center" border="0" cellpadding="0" cellspacing="0" class="desc_image slide_content" style="border-collapse:collapse; border-spacing:0px; box-sizing:border-box; color:rgb(102, 102, 102); font-family:arial; font-size:14px; line-height:18px; margin:0px auto 14px; max-width:100%; outline:0px; padding:0px; position:relative; text-align:justify">
	<tbody>
		<tr>
			<td><img alt="​Chất béo có thực sự là kẻ thù của cơ thể? " src="http://static.new.tuoitre.vn/tto/r/2016/10/11/ranee-1-1476183992.jpg" style="background:transparent; border:0px; box-sizing:border-box; cursor:url(&quot;../images/zoom_cursor.png&quot;), auto; display:block; margin:0px; max-width:100%; outline:0px; padding:0px; vertical-align:baseline; width:490px" /></td>
		</tr>
		<tr>
			<td>Kh&ocirc;ng n&ecirc;n l&atilde;ng qu&ecirc;n chất b&eacute;o trong chế độ ăn hằng ng&agrave;y</td>
		</tr>
	</tbody>
</table>

<p style="text-align:justify"><strong>Kh&ocirc;ng n&ecirc;n l&atilde;ng qu&ecirc;n chất b&eacute;o&nbsp;</strong></p>

<p style="text-align:justify">Để nạp chất b&eacute;o hợp l&yacute;, cần tăng cường bổ sung c&aacute;c axit b&eacute;o kh&ocirc;ng b&atilde;o h&ograve;a, giảm chất b&eacute;o b&atilde;o h&ograve;a v&agrave; chất b&eacute;o chuyển h&oacute;a. Kh&ocirc;ng n&ecirc;n ăn qu&aacute; nhiều trứng, thịt đỏ, hải sản v&igrave; c&aacute;c loại thực phẩm n&agrave;y chứa nhiều chất b&eacute;o b&atilde;o h&ograve;a.&nbsp;</p>

<p style="text-align:justify">Thay v&agrave;o đ&oacute;, tăng cường c&aacute;c loại c&aacute; b&eacute;o, thịt nạc, sữa &iacute;t b&eacute;o v&agrave; c&aacute;c loại hạt vốn gi&agrave;u c&aacute;c axit b&eacute;o kh&ocirc;ng b&atilde;o h&ograve;a. Đặc biệt, c&aacute; b&eacute;o ch&iacute;nh l&agrave; nguồn cung cấp DHA, Omega-3-6-9 phong ph&uacute;, vốn l&agrave; những dưỡng chất quan trọng, đặc biệt cần thiết cho người gi&agrave; v&agrave; trẻ nhỏ.&nbsp;</p>

<p style="text-align:justify">Chiết xuất từ c&aacute; b&eacute;o, mỡ c&aacute; kh&ocirc;ng chỉ l&agrave; loại mỡ động vật dễ ti&ecirc;u h&agrave;ng đầu m&agrave; c&ograve;n l&agrave; nguồn cung cấp c&aacute;c axit b&eacute;o Omega-3-6-9 v&agrave; vitamin dồi d&agrave;o. &ldquo;Đối với trẻ em, c&aacute;c axit b&eacute;o gi&uacute;p trẻ th&ocirc;ng minh hơn. Đối với người cao tuổi, c&aacute;c axit b&eacute;o c&oacute; t&aacute;c dụng l&agrave;m chậm qu&aacute; tr&igrave;nh l&atilde;o h&oacute;a v&agrave; suy giảm tr&iacute; tuệ&rdquo; -&nbsp;ThS-BS CK2 Đỗ Thị Ngọc Diệp, gi&aacute;m đốc Trung t&acirc;m Dinh dưỡng TP.HCM, cho biết.</p>

<table align="center" border="0" cellpadding="0" cellspacing="0" class="desc_image slide_content" style="border-collapse:collapse; border-spacing:0px; box-sizing:border-box; color:rgb(102, 102, 102); font-family:arial; font-size:14px; line-height:18px; margin:0px auto 14px; max-width:100%; outline:0px; padding:0px; position:relative; text-align:justify">
	<tbody>
		<tr>
			<td style="text-align:center"><img alt="​Chất béo có thực sự là kẻ thù của cơ thể? " src="http://static.new.tuoitre.vn/tto/r/2016/10/11/ranee-2-1476183991.jpg" style="background:transparent; border:0px; box-sizing:border-box; cursor:url(&quot;../images/zoom_cursor.png&quot;), auto; display:block; margin:0px; max-width:100%; outline:0px; padding:0px; vertical-align:baseline; width:490px" /></td>
		</tr>
		<tr>
			<td>Với dầu ăn dinh dưỡng Ranee từ tinh dầu c&aacute; da trơn, b&agrave;i to&aacute;n c&acirc;n bằng giữa sức khỏe lẫn vị ngon đ&atilde; được giải quyết</td>
		</tr>
	</tbody>
</table>

<p style="text-align:justify"><strong>Dầu ăn bổ sung th&ecirc;m chất b&eacute;o tốt v&agrave; vitamin&nbsp;</strong></p>

<p style="text-align:justify">L&agrave; sản phẩm dầu ăn đầu ti&ecirc;n c&oacute; nguồn gốc từ động vật, dầu ăn dinh dưỡng Ranee chiết xuất từ 100% tinh dầu c&aacute; da trơn rất gi&agrave;u c&aacute;c axit b&eacute;o kh&ocirc;ng b&atilde;o h&ograve;a, bổ sung th&ecirc;m chất b&eacute;o tốt v&agrave; vitamin v&agrave;o chế độ ăn hằng ng&agrave;y của c&aacute;c gia đ&igrave;nh Việt.&nbsp;</p>

<p style="text-align:justify">PGS.TS Trương Tuyết Mai, ph&oacute; viện trưởng Viện Dinh dưỡng quốc gia, cho biết th&agrave;nh phần dinh dưỡng của dầu c&aacute; cao cấp Ranee c&oacute; t&aacute;c dụng b&igrave;nh ổn cholesterol m&aacute;u, hỗ trợ ph&ograve;ng ngừa c&aacute;c bệnh tim mạch v&agrave; c&aacute;c bệnh li&ecirc;n quan đến sa s&uacute;t tr&iacute; tuệ, hỗ trợ ph&ograve;ng chống thiếu vitamin A.&nbsp;</p>

<p style="text-align:justify">Ngo&agrave;i t&aacute;c dụng dinh dưỡng, dầu c&aacute; Ranee c&ograve;n ph&aacute;t huy c&aacute;c ưu điểm của truyền thống chi&ecirc;n r&aacute;n bằng mỡ động vật, gi&uacute;p m&oacute;n ăn b&eacute;o ngậy, gi&ograve;n rụm, v&agrave;ng đều v&agrave; dậy m&ugrave;i thơm kh&oacute; cưỡng.&nbsp;</p>

<p style="text-align:justify">Một điểm đặc biệt nữa khiến Ranee được l&ograve;ng c&aacute;c chị em nội trợ đ&oacute; l&agrave; kh&ocirc;ng c&oacute; m&ugrave;i tanh kh&oacute; chịu, v&igrave; thế rất dễ ứng dụng v&agrave;o c&aacute;c m&oacute;n chi&ecirc;n x&agrave;o, trộn hoặc canh, ch&aacute;o, bột. Nhiều b&agrave; nội trợ chia sẻ sử dụng dầu ăn cao cấp Ranee họ vừa thoải m&aacute;i s&aacute;ng tạo th&ecirc;m nhiều m&oacute;n mới trong thực đơn, vừa y&ecirc;n t&acirc;m rằng những bữa ăn gia đ&igrave;nh lu&ocirc;n đủ đầy dinh dưỡng tốt cho sức khỏe.</p>
', CAST(N'2017-07-26T09:37:14.270' AS DateTime), N'Administrator', CAST(N'2018-02-25T15:45:14.260' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (470, 9, 2, N'News', N'SeoUrl', N'fat-is-really-the-enemy-of-the-body', CAST(N'2017-07-26T09:37:14.277' AS DateTime), N'Administrator', CAST(N'2018-02-25T15:45:14.263' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (471, 9, 3, N'News', N'Title', N'脂肪は体の敵ですか？', CAST(N'2017-07-26T09:37:14.287' AS DateTime), N'Administrator', CAST(N'2018-02-25T15:45:14.273' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (472, 9, 3, N'News', N'ShortDesc', N'<p>重要な栄養素の4基の1つが、多くの場合、主な理由を「非難」毎日の食事に欠かせないだけでなく、太っているのは...</p>
', CAST(N'2017-07-26T09:37:14.290' AS DateTime), N'Administrator', CAST(N'2018-02-25T15:45:14.273' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (473, 9, 3, N'News', N'Description', N'<p>重要な栄養素の4基の1つが、多くの場合、「非難は、」体重増加やその他の健康上の問題の主な原因である毎日の食事に欠かせないだけでなく、脂肪です。だから、本当に、脂肪は「敵か味方」ですか？</p>

<p>健康な脂肪は健康に良いです</p>

<p>ボディは、関数に脂肪の一定量を必要とします。脂肪の種類は、代謝およびエネルギー貯蔵、保護機関を任務としています。十分な健康的な脂肪を追加すると、体が喜びと健康の両方になります - 長い飢餓、筋緊張、不快感、滑らかで元気で栗の皮。もちろんのこと、脂肪はまた、料理の味や食感を向上させるために働きます。</p>

<p>栄養失調に植物材料からのみ、追加の体脂肪源は、利益を最大化するために動物から追加の脂肪が必要な場合は、国民栄養研究所は結論付けました。植物油は、大豆油、パーム油などの植物油からの脂肪の源である一方、動物性脂肪は...、このような鶏脂肪、ラード、牛脂などの家畜、家禽、魚介類から太っています...</p>

<p>2016-2020以来、ベトナムの期間を要求する栄養勧告によると、成人は油、グリースの5杯、毎日を必要としています。</p>

<p>特に、子供の小さい、高脂肪のためのより多くの需要は、総食物エネルギー必要量の最大50％とすることができます。人生の最初の年では、赤ちゃんは、物理的および知的な需要の伸びを満たすために動物源及び2つの交流所からの完全かつ多様な脂肪を必要とします。</p>

<p>セル構造のために必要な善玉コレステロールを提供することが可能牛脂、特に神経細胞は、毛細血管を安定させる、脳内出血を防ぐことができます。</p>

<table align="center" border="0" cellpadding="0" cellspacing="0" class="desc_image slide_content" style="border-collapse:collapse; border-spacing:0px; box-sizing:border-box; color:rgb(102, 102, 102); font-family:arial; font-size:14px; line-height:18px; margin:0px auto 14px; max-width:100%; outline:0px; padding:0px; position:relative; text-align:justify">
	<tbody>
		<tr>
			<td><img alt="​Chất béo có thực sự là kẻ thù của cơ thể? " src="http://static.new.tuoitre.vn/tto/r/2016/10/11/ranee-1-1476183992.jpg" style="background:transparent; border:0px; box-sizing:border-box; cursor:url(&quot;../images/zoom_cursor.png&quot;), auto; display:block; margin:0px; max-width:100%; outline:0px; padding:0px; vertical-align:baseline; width:490px" /></td>
		</tr>
		<tr>
			<td>Kh&ocirc;ng n&ecirc;n l&atilde;ng qu&ecirc;n chất b&eacute;o trong chế độ ăn hằng ng&agrave;y</td>
		</tr>
	</tbody>
</table>

<p style="text-align:justify"><strong>Kh&ocirc;ng n&ecirc;n l&atilde;ng qu&ecirc;n chất b&eacute;o&nbsp;</strong></p>

<p style="text-align:justify">Để nạp chất b&eacute;o hợp l&yacute;, cần tăng cường bổ sung c&aacute;c axit b&eacute;o kh&ocirc;ng b&atilde;o h&ograve;a, giảm chất b&eacute;o b&atilde;o h&ograve;a v&agrave; chất b&eacute;o chuyển h&oacute;a. Kh&ocirc;ng n&ecirc;n ăn qu&aacute; nhiều trứng, thịt đỏ, hải sản v&igrave; c&aacute;c loại thực phẩm n&agrave;y chứa nhiều chất b&eacute;o b&atilde;o h&ograve;a.&nbsp;</p>

<p style="text-align:justify">Thay v&agrave;o đ&oacute;, tăng cường c&aacute;c loại c&aacute; b&eacute;o, thịt nạc, sữa &iacute;t b&eacute;o v&agrave; c&aacute;c loại hạt vốn gi&agrave;u c&aacute;c axit b&eacute;o kh&ocirc;ng b&atilde;o h&ograve;a. Đặc biệt, c&aacute; b&eacute;o ch&iacute;nh l&agrave; nguồn cung cấp DHA, Omega-3-6-9 phong ph&uacute;, vốn l&agrave; những dưỡng chất quan trọng, đặc biệt cần thiết cho người gi&agrave; v&agrave; trẻ nhỏ.&nbsp;</p>

<p style="text-align:justify">Chiết xuất từ c&aacute; b&eacute;o, mỡ c&aacute; kh&ocirc;ng chỉ l&agrave; loại mỡ động vật dễ ti&ecirc;u h&agrave;ng đầu m&agrave; c&ograve;n l&agrave; nguồn cung cấp c&aacute;c axit b&eacute;o Omega-3-6-9 v&agrave; vitamin dồi d&agrave;o. &ldquo;Đối với trẻ em, c&aacute;c axit b&eacute;o gi&uacute;p trẻ th&ocirc;ng minh hơn. Đối với người cao tuổi, c&aacute;c axit b&eacute;o c&oacute; t&aacute;c dụng l&agrave;m chậm qu&aacute; tr&igrave;nh l&atilde;o h&oacute;a v&agrave; suy giảm tr&iacute; tuệ&rdquo; -&nbsp;ThS-BS CK2 Đỗ Thị Ngọc Diệp, gi&aacute;m đốc Trung t&acirc;m Dinh dưỡng TP.HCM, cho biết.</p>

<table align="center" border="0" cellpadding="0" cellspacing="0" class="desc_image slide_content" style="border-collapse:collapse; border-spacing:0px; box-sizing:border-box; color:rgb(102, 102, 102); font-family:arial; font-size:14px; line-height:18px; margin:0px auto 14px; max-width:100%; outline:0px; padding:0px; position:relative; text-align:justify">
	<tbody>
		<tr>
			<td style="text-align:center"><img alt="​Chất béo có thực sự là kẻ thù của cơ thể? " src="http://static.new.tuoitre.vn/tto/r/2016/10/11/ranee-2-1476183991.jpg" style="background:transparent; border:0px; box-sizing:border-box; cursor:url(&quot;../images/zoom_cursor.png&quot;), auto; display:block; margin:0px; max-width:100%; outline:0px; padding:0px; vertical-align:baseline; width:490px" /></td>
		</tr>
		<tr>
			<td>Với dầu ăn dinh dưỡng Ranee từ tinh dầu c&aacute; da trơn, b&agrave;i to&aacute;n c&acirc;n bằng giữa sức khỏe lẫn vị ngon đ&atilde; được giải quyết</td>
		</tr>
	</tbody>
</table>

<p style="text-align:justify"><strong>Dầu ăn bổ sung th&ecirc;m chất b&eacute;o tốt v&agrave; vitamin&nbsp;</strong></p>

<p style="text-align:justify">L&agrave; sản phẩm dầu ăn đầu ti&ecirc;n c&oacute; nguồn gốc từ động vật, dầu ăn dinh dưỡng Ranee chiết xuất từ 100% tinh dầu c&aacute; da trơn rất gi&agrave;u c&aacute;c axit b&eacute;o kh&ocirc;ng b&atilde;o h&ograve;a, bổ sung th&ecirc;m chất b&eacute;o tốt v&agrave; vitamin v&agrave;o chế độ ăn hằng ng&agrave;y của c&aacute;c gia đ&igrave;nh Việt.&nbsp;</p>

<p style="text-align:justify">PGS.TS Trương Tuyết Mai, ph&oacute; viện trưởng Viện Dinh dưỡng quốc gia, cho biết th&agrave;nh phần dinh dưỡng của dầu c&aacute; cao cấp Ranee c&oacute; t&aacute;c dụng b&igrave;nh ổn cholesterol m&aacute;u, hỗ trợ ph&ograve;ng ngừa c&aacute;c bệnh tim mạch v&agrave; c&aacute;c bệnh li&ecirc;n quan đến sa s&uacute;t tr&iacute; tuệ, hỗ trợ ph&ograve;ng chống thiếu vitamin A.&nbsp;</p>

<p style="text-align:justify">Ngo&agrave;i t&aacute;c dụng dinh dưỡng, dầu c&aacute; Ranee c&ograve;n ph&aacute;t huy c&aacute;c ưu điểm của truyền thống chi&ecirc;n r&aacute;n bằng mỡ động vật, gi&uacute;p m&oacute;n ăn b&eacute;o ngậy, gi&ograve;n rụm, v&agrave;ng đều v&agrave; dậy m&ugrave;i thơm kh&oacute; cưỡng.&nbsp;</p>

<p style="text-align:justify">Một điểm đặc biệt nữa khiến Ranee được l&ograve;ng c&aacute;c chị em nội trợ đ&oacute; l&agrave; kh&ocirc;ng c&oacute; m&ugrave;i tanh kh&oacute; chịu, v&igrave; thế rất dễ ứng dụng v&agrave;o c&aacute;c m&oacute;n chi&ecirc;n x&agrave;o, trộn hoặc canh, ch&aacute;o, bột. Nhiều b&agrave; nội trợ chia sẻ sử dụng dầu ăn cao cấp Ranee họ vừa thoải m&aacute;i s&aacute;ng tạo th&ecirc;m nhiều m&oacute;n mới trong thực đơn, vừa y&ecirc;n t&acirc;m rằng những bữa ăn gia đ&igrave;nh lu&ocirc;n đủ đầy dinh dưỡng tốt cho sức khỏe.</p>
', CAST(N'2017-07-26T09:37:14.297' AS DateTime), N'Administrator', CAST(N'2018-02-25T15:45:14.277' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (496, 9, 1, N'GenericControl', N'Name', N'aaa', CAST(N'2017-08-20T10:19:20.347' AS DateTime), N'Administrator', CAST(N'2017-08-20T10:19:20.347' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (497, 9, 1, N'GenericControl', N'Description', N'aa', CAST(N'2017-08-20T10:19:20.350' AS DateTime), N'Administrator', CAST(N'2017-08-20T10:19:20.350' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (498, 9, 2, N'GenericControl', N'Name', N'b', CAST(N'2017-08-20T10:19:20.357' AS DateTime), N'Administrator', CAST(N'2017-08-20T10:19:20.357' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (499, 9, 3, N'GenericControl', N'Name', N'c', CAST(N'2017-08-20T10:19:20.367' AS DateTime), N'Administrator', CAST(N'2017-08-20T10:19:20.367' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (500, 1, 1, N'GenericControl', N'Name', N'Thuộc tính post chi tiết', CAST(N'2017-08-20T11:04:33.637' AS DateTime), N'Administrator', CAST(N'2018-04-21T17:01:00.430' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (501, 1, 1, N'GenericControl', N'Description', N'Thuộc tính post chi tiết', CAST(N'2017-08-20T11:04:33.647' AS DateTime), N'Administrator', CAST(N'2018-04-21T17:01:00.440' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (502, 1, 2, N'GenericControl', N'Name', N'2', CAST(N'2017-08-20T11:04:33.650' AS DateTime), N'Administrator', CAST(N'2018-04-21T17:01:00.450' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (503, 1, 2, N'GenericControl', N'Description', N'2', CAST(N'2017-08-20T11:04:33.653' AS DateTime), N'Administrator', CAST(N'2018-04-21T17:01:00.483' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (504, 1, 3, N'GenericControl', N'Name', N'3', CAST(N'2017-08-20T11:04:33.657' AS DateTime), N'Administrator', CAST(N'2018-04-21T17:01:00.490' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (505, 1, 3, N'GenericControl', N'Description', N'3', CAST(N'2017-08-20T11:04:33.660' AS DateTime), N'Administrator', CAST(N'2018-04-21T17:01:00.497' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (506, 6, 1, N'MenuLink', N'MenuName', N'Thời trang', CAST(N'2017-08-20T14:06:44.333' AS DateTime), N'Administrator', CAST(N'2018-03-07T17:07:21.227' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (507, 6, 1, N'MenuLink', N'SeoUrl', N'thoi-trang', CAST(N'2017-08-20T14:06:44.360' AS DateTime), N'Administrator', CAST(N'2018-03-07T17:07:21.243' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (508, 6, 1, N'MenuLink', N'MetaTitle', N'Thời trang', CAST(N'2017-08-20T14:06:44.363' AS DateTime), N'Administrator', CAST(N'2018-03-07T17:07:21.247' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (509, 6, 1, N'MenuLink', N'MetaKeywords', N'Thời trang', CAST(N'2017-08-20T14:06:44.367' AS DateTime), N'Administrator', CAST(N'2018-03-07T17:07:21.250' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (510, 6, 1, N'MenuLink', N'MetaDescription', N'Thời trang', CAST(N'2017-08-20T14:06:44.370' AS DateTime), N'Administrator', CAST(N'2018-03-07T17:07:21.253' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (511, 5, 1, N'MenuLink', N'MenuName', N'Phụ kiện công nghệ', CAST(N'2017-08-20T14:07:07.827' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:47:10.923' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (512, 5, 1, N'MenuLink', N'SeoUrl', N'phu-kien-cong-nghe', CAST(N'2017-08-20T14:07:07.843' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:47:10.930' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (513, 5, 1, N'MenuLink', N'MetaTitle', N'Phụ kiện công nghệ', CAST(N'2017-08-20T14:07:07.847' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:47:10.940' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (514, 5, 1, N'MenuLink', N'MetaKeywords', N'Phụ kiện công nghệ', CAST(N'2017-08-20T14:07:07.853' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:47:10.953' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (515, 5, 1, N'MenuLink', N'MetaDescription', N'Phụ kiện công nghệ', CAST(N'2017-08-20T14:07:07.863' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:47:10.957' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1591, 2126, 1, N'MenuLink', N'MenuName', N'Áo khoác', CAST(N'2017-10-14T12:23:17.283' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:14:09.017' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1592, 2126, 1, N'MenuLink', N'SeoUrl', N'ao-khoac', CAST(N'2017-10-14T12:23:17.293' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:14:09.033' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1593, 2126, 1, N'MenuLink', N'MetaTitle', N'Áo khoác', CAST(N'2017-10-14T12:23:17.297' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:14:09.037' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1594, 2126, 1, N'MenuLink', N'MetaKeywords', N'Áo khoác', CAST(N'2017-10-14T12:23:17.300' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:14:09.040' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1595, 2126, 1, N'MenuLink', N'MetaDescription', N'Áo khoác', CAST(N'2017-10-14T12:23:17.303' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:14:09.043' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1596, 2127, 1, N'MenuLink', N'MenuName', N'Quần tây', CAST(N'2017-10-14T12:24:02.017' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:14:52.933' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1597, 2127, 1, N'MenuLink', N'SeoUrl', N'quan-tay', CAST(N'2017-10-14T12:24:02.053' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:14:52.950' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1598, 2127, 1, N'MenuLink', N'MetaTitle', N'Quần tây', CAST(N'2017-10-14T12:24:02.060' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:14:52.957' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1599, 2127, 1, N'MenuLink', N'MetaKeywords', N'Quần tây', CAST(N'2017-10-14T12:24:02.077' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:14:52.977' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1600, 2127, 1, N'MenuLink', N'MetaDescription', N'Quần tây', CAST(N'2017-10-14T12:24:02.100' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:14:52.987' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1601, 2128, 1, N'MenuLink', N'MenuName', N'Biệt thự', CAST(N'2017-10-14T12:24:33.653' AS DateTime), N'Administrator', CAST(N'2018-02-16T08:19:56.193' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1602, 2128, 1, N'MenuLink', N'SeoUrl', N'biet-thu', CAST(N'2017-10-14T12:24:33.657' AS DateTime), N'Administrator', CAST(N'2018-02-16T08:19:56.203' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1603, 2128, 1, N'MenuLink', N'MetaTitle', N'Biệt thự', CAST(N'2017-10-14T12:24:33.663' AS DateTime), N'Administrator', CAST(N'2018-02-16T08:19:56.207' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1604, 2128, 1, N'MenuLink', N'MetaKeywords', N'Biệt thự', CAST(N'2017-10-14T12:24:33.667' AS DateTime), N'Administrator', CAST(N'2018-02-16T08:19:56.207' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1605, 2128, 1, N'MenuLink', N'MetaDescription', N'Biệt thự', CAST(N'2017-10-14T12:24:33.673' AS DateTime), N'Administrator', CAST(N'2018-02-16T08:19:56.210' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1606, 2129, 1, N'MenuLink', N'MenuName', N'Văn phòng', CAST(N'2017-10-14T12:31:05.573' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:31:05.573' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1607, 2129, 1, N'MenuLink', N'SeoUrl', N'van-phong', CAST(N'2017-10-14T12:31:05.580' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:31:05.580' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1608, 2129, 1, N'MenuLink', N'MetaTitle', N'Văn phòng', CAST(N'2017-10-14T12:31:05.593' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:31:05.593' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1609, 2129, 1, N'MenuLink', N'MetaKeywords', N'Văn phòng', CAST(N'2017-10-14T12:31:05.600' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:31:05.600' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1610, 2129, 1, N'MenuLink', N'MetaDescription', N'Văn phòng', CAST(N'2017-10-14T12:31:05.607' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:31:05.607' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1611, 2130, 1, N'MenuLink', N'MenuName', N'Quy hoạch khác', CAST(N'2017-10-14T12:32:15.200' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:32:15.200' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1612, 2130, 1, N'MenuLink', N'SeoUrl', N'quy-hoach-khac', CAST(N'2017-10-14T12:32:15.207' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:32:15.207' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1613, 2130, 1, N'MenuLink', N'MetaTitle', N'Quy hoạch khác', CAST(N'2017-10-14T12:32:15.213' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:32:15.213' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1614, 2130, 1, N'MenuLink', N'MetaKeywords', N'Quy hoạch khác', CAST(N'2017-10-14T12:32:15.223' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:32:15.223' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1615, 2130, 1, N'MenuLink', N'MetaDescription', N'Quy hoạch khác', CAST(N'2017-10-14T12:32:15.230' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:32:15.230' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1616, 2125, 1, N'MenuLink', N'MenuName', N'Đang thực hiện', CAST(N'2017-10-14T14:56:06.013' AS DateTime), N'Administrator', CAST(N'2017-10-14T14:57:37.647' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1617, 2125, 1, N'MenuLink', N'SeoUrl', N'dang-thuc-hien', CAST(N'2017-10-14T14:56:06.030' AS DateTime), N'Administrator', CAST(N'2017-10-14T14:57:37.650' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1618, 2125, 1, N'MenuLink', N'MetaTitle', N'Đang thực hiện', CAST(N'2017-10-14T14:56:06.033' AS DateTime), N'Administrator', CAST(N'2017-10-14T14:57:37.653' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1619, 2125, 1, N'MenuLink', N'MetaKeywords', N'Đang thực hiện', CAST(N'2017-10-14T14:56:06.037' AS DateTime), N'Administrator', CAST(N'2017-10-14T14:57:37.667' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1620, 2125, 1, N'MenuLink', N'MetaDescription', N'Đang thực hiện', CAST(N'2017-10-14T14:56:06.040' AS DateTime), N'Administrator', CAST(N'2017-10-14T14:57:37.673' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1629, 45, 1, N'MenuLink', N'MenuName', N'Giới thiệu', CAST(N'2017-10-15T14:22:22.330' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:09:30.330' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1630, 45, 1, N'MenuLink', N'SeoUrl', N'gioi-thieu', CAST(N'2017-10-15T14:22:22.357' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:09:30.343' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1631, 45, 1, N'MenuLink', N'MetaTitle', N'Giới thiệu', CAST(N'2017-10-15T14:22:22.363' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:09:30.347' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1632, 45, 1, N'MenuLink', N'MetaKeywords', N'Giới thiệu', CAST(N'2017-10-15T14:22:22.367' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:09:30.350' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1633, 45, 1, N'MenuLink', N'MetaDescription', N'Giới thiệu', CAST(N'2017-10-15T14:22:22.370' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:09:30.353' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1634, 2131, 1, N'MenuLink', N'MenuName', N'Thời trang', CAST(N'2017-10-15T15:39:42.023' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:02:49.160' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1635, 2131, 1, N'MenuLink', N'SeoUrl', N'thoi-trang', CAST(N'2017-10-15T15:39:42.033' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:02:49.167' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1636, 2131, 1, N'MenuLink', N'MetaTitle', N'Thời trang', CAST(N'2017-10-15T15:39:42.037' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:02:49.173' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1637, 2131, 1, N'MenuLink', N'MetaKeywords', N'Thời trang', CAST(N'2017-10-15T15:39:42.040' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:02:49.177' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1638, 2131, 1, N'MenuLink', N'MetaDescription', N'Thời trang', CAST(N'2017-10-15T15:39:42.043' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:02:49.180' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1639, 2132, 1, N'MenuLink', N'MenuName', N'Chân váy', CAST(N'2017-10-15T15:43:36.717' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:19:13.973' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1640, 2132, 1, N'MenuLink', N'SeoUrl', N'chan-vay', CAST(N'2017-10-15T15:43:36.727' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:19:13.987' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1641, 2132, 1, N'MenuLink', N'MetaTitle', N'Chân váy', CAST(N'2017-10-15T15:43:36.730' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:19:14.003' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1642, 2132, 1, N'MenuLink', N'MetaKeywords', N'Chân váy', CAST(N'2017-10-15T15:43:36.733' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:19:14.010' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1643, 2132, 1, N'MenuLink', N'MetaDescription', N'Chân váy', CAST(N'2017-10-15T15:43:36.737' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:19:14.020' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1655, 6, 1, N'SlideShow', N'Title', N'slide 1', CAST(N'2017-10-16T15:54:41.050' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:46:47.120' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1656, 17, 1, N'StaticContent', N'Title', N'Ý kiến khách hàng', CAST(N'2017-10-17T17:52:25.957' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:43:06.373' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1657, 17, 1, N'StaticContent', N'SeoUrl', N'y-kien-khach-hang', CAST(N'2017-10-17T17:52:25.973' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:43:06.397' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1658, 17, 1, N'StaticContent', N'MetaTitle', N'Ý kiến khách hàng', CAST(N'2017-10-17T17:52:25.987' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:43:06.400' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1659, 17, 1, N'StaticContent', N'MetaKeywords', N'Ý kiến khách hàng', CAST(N'2017-10-17T17:52:26.003' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:43:06.410' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1660, 17, 1, N'StaticContent', N'MetaDescription', N'Ý kiến khách hàng', CAST(N'2017-10-17T17:52:26.017' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:43:06.420' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1678, 17, 1, N'StaticContent', N'ShortDesc', N'<p><img alt="" src="http://localhost:9358/images/post/edf43991-16bc-4f72-bcca-f5e77da9f1a4.jpg" style="height:160px; width:800px" /></p>
', CAST(N'2017-12-14T16:34:46.410' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:43:06.390' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1733, 17, 1, N'StaticContent', N'Description', N'<p>fgsfdgsfdgfdsa fsdaf sdafas</p>
', CAST(N'2017-12-15T17:30:07.150' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:43:06.393' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1734, 6, 2, N'SlideShow', N'Title', N'slide 1', CAST(N'2017-12-16T08:05:51.500' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:46:47.140' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1735, 6, 3, N'SlideShow', N'Title', N'slide 1', CAST(N'2017-12-16T08:05:51.530' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:46:47.143' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1736, 1, 1, N'SystemSetting', N'Slogan', N'fdasfsdafsaf', CAST(N'2017-12-19T15:56:42.763' AS DateTime), N'Administrator', CAST(N'2018-04-10T15:42:32.347' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1750, 42, 1, N'Post', N'Description', N'<p>- Chất liệu somi mềm mại, tho&aacute;ng m&aacute;t v&agrave; mang lại nhiều t&iacute;nh năng vượt trội: Thấm h&uacute;t ẩm tốt, Kh&ocirc;ng co r&uacute;t&hellip;.</p>

<p>- Vải giữ m&agrave;u tốt khi được nhuộm n&ecirc;n loại vải n&agrave;y bền theo thời gian</p>

<p>- Sử dụng c&ocirc;ng nghệ dệt may hiện đại hạn chế tối đa nhăn vải trong sử dụng.</p>

<p>- Vải kh&ocirc;ng nhuộm với ch&igrave; an to&agrave;n cho sức khỏe, nhưng vẫn &iacute;t ra m&agrave;u.</p>

<p>- Họa tiết caro hiện đại, vẫn đang rất hợp thời trang v&agrave; xu hướng.</p>
', CAST(N'2018-01-13T05:29:38.860' AS DateTime), N'Administrator', CAST(N'2018-05-13T16:09:14.447' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1751, 2, 1, N'ContactInformation', N'Title', N'Thương hiệu thời trang Mazzola', CAST(N'2018-01-17T15:22:47.470' AS DateTime), N'Administrator', CAST(N'2018-01-17T15:29:11.947' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1752, 2, 1, N'ContactInformation', N'Address', N'DD18 Bạch Mã, Phường 15, Quận 10, TP.HCM', CAST(N'2018-01-17T15:22:47.497' AS DateTime), N'Administrator', CAST(N'2018-01-17T15:29:11.957' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1753, 5, 1, N'ContactInformation', N'Title', N'Mazzola 1', CAST(N'2018-01-17T15:39:55.360' AS DateTime), N'Administrator', CAST(N'2018-01-17T15:39:55.360' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1754, 5, 1, N'ContactInformation', N'Address', N'99 Trương Định, phường 6, Quận 3', CAST(N'2018-01-17T15:39:55.373' AS DateTime), N'Administrator', CAST(N'2018-01-17T15:39:55.373' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1755, 6, 1, N'ContactInformation', N'Title', N'Mazzola 2', CAST(N'2018-01-17T15:44:59.173' AS DateTime), N'Administrator', CAST(N'2018-01-17T15:44:59.173' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1756, 6, 1, N'ContactInformation', N'Address', N'206 Quang Trung, P.10, Q.Gò Vấp', CAST(N'2018-01-17T15:44:59.197' AS DateTime), N'Administrator', CAST(N'2018-01-17T15:44:59.197' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1764, 21, 1, N'MenuLink', N'MenuName', N'Hướng dẫn mua hàng', CAST(N'2018-02-11T15:55:40.530' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:08:20.770' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1765, 21, 1, N'MenuLink', N'SeoUrl', N'huong-dan-mua-hang', CAST(N'2018-02-11T15:55:40.593' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:08:20.787' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1766, 21, 1, N'MenuLink', N'MetaTitle', N'Hướng dẫn mua hàng', CAST(N'2018-02-11T15:55:40.600' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:08:20.790' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1767, 21, 1, N'MenuLink', N'MetaKeywords', N'Hướng dẫn mua hàng', CAST(N'2018-02-11T15:55:40.607' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:08:20.793' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1768, 21, 1, N'MenuLink', N'MetaDescription', N'Hướng dẫn mua hàng', CAST(N'2018-02-11T15:55:40.617' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:08:20.803' AS DateTime), N'Administrator')
GO
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1769, 3, 1, N'MenuLink', N'MenuName', N'Áo sơ mi', CAST(N'2018-02-11T16:10:45.850' AS DateTime), N'Administrator', CAST(N'2018-03-06T16:25:44.773' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1770, 3, 1, N'MenuLink', N'SeoUrl', N'ao-so-mi', CAST(N'2018-02-11T16:10:45.880' AS DateTime), N'Administrator', CAST(N'2018-03-06T16:25:44.783' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1771, 3, 1, N'MenuLink', N'MetaTitle', N'Áo sơ mi', CAST(N'2018-02-11T16:10:45.890' AS DateTime), N'Administrator', CAST(N'2018-03-06T16:25:44.787' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1772, 3, 1, N'MenuLink', N'MetaKeywords', N'Áo sơ mi', CAST(N'2018-02-11T16:10:45.897' AS DateTime), N'Administrator', CAST(N'2018-03-06T16:25:44.790' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1773, 3, 1, N'MenuLink', N'MetaDescription', N'Áo sơ mi', CAST(N'2018-02-11T16:10:45.910' AS DateTime), N'Administrator', CAST(N'2018-03-06T16:25:44.797' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1779, 54, 1, N'Post', N'Title', N'Áo tennis nữDonexpro MC-8882-X (Đen)', CAST(N'2018-02-16T11:45:04.677' AS DateTime), N'Administrator', CAST(N'2018-02-17T11:26:08.013' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1780, 54, 1, N'Post', N'ProductCode', N'MC-8882-', CAST(N'2018-02-16T11:45:04.687' AS DateTime), N'Administrator', CAST(N'2018-02-17T11:26:08.023' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1781, 54, 1, N'Post', N'ShortDesc', N'Áo tennis nữDonexpro MC-8882-X (Đen)Áo tennis nữDonexpro MC-8882-X (Đen)', CAST(N'2018-02-16T11:45:04.693' AS DateTime), N'Administrator', CAST(N'2018-02-17T11:26:08.040' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1782, 54, 1, N'Post', N'Description', N'<p>&Aacute;o tennis nữDonexpro MC-8882-X (Đen)&Aacute;o tennis nữDonexpro MC-8882-X (Đen)</p>
', CAST(N'2018-02-16T11:45:04.697' AS DateTime), N'Administrator', CAST(N'2018-02-17T11:26:08.053' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1783, 54, 1, N'Post', N'TechInfo', N'<p>&Aacute;o tennis nữDonexpro MC-8882-X (Đen)&Aacute;o tennis nữDonexpro MC-8882-X (Đen)&Aacute;o tennis nữDonexpro MC-8882-X (Đen)</p>
', CAST(N'2018-02-16T11:45:04.700' AS DateTime), N'Administrator', CAST(N'2018-02-17T11:26:08.073' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1784, 54, 1, N'Post', N'MetaTitle', N'Áo tennis nữDonexpro MC-8882-X (Đen)', CAST(N'2018-02-16T11:45:04.707' AS DateTime), N'Administrator', CAST(N'2018-02-17T11:26:08.107' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1785, 54, 1, N'Post', N'MetaKeywords', N'Áo tennis nữDonexpro MC-8882-X (Đen)', CAST(N'2018-02-16T11:45:04.713' AS DateTime), N'Administrator', CAST(N'2018-02-17T11:26:08.117' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1786, 54, 1, N'Post', N'MetaDescription', N'Áo tennis nữDonexpro MC-8882-X (Đen)', CAST(N'2018-02-16T11:45:04.717' AS DateTime), N'Administrator', CAST(N'2018-02-17T11:26:08.130' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1787, 50, 1, N'Post', N'Title', N'Ghế nhựa kiểu dạng lưới cao cấp', CAST(N'2018-02-16T11:47:29.597' AS DateTime), N'Administrator', CAST(N'2018-05-15T15:06:51.653' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1788, 50, 1, N'Post', N'ProductCode', N'GNKDLCC2018.05.15', CAST(N'2018-02-16T11:47:29.610' AS DateTime), N'Administrator', CAST(N'2018-05-15T15:06:51.673' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1789, 50, 1, N'Post', N'ShortDesc', N'Ghế nhựa kiểu dạng lưới cao cấp', CAST(N'2018-02-16T11:47:29.617' AS DateTime), N'Administrator', CAST(N'2018-05-15T15:06:51.680' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1790, 50, 1, N'Post', N'TechInfo', N'<p><span style="color:rgb(34, 34, 34); font-family:consolas,lucida console,courier new,monospace; font-size:12px">Ghế nhựa kiểu dạng lưới cao cấpGhế nhựa kiểu dạng lưới cao cấpGhế nhựa kiểu dạng lưới cao cấp</span></p>
', CAST(N'2018-02-16T11:47:29.623' AS DateTime), N'Administrator', CAST(N'2018-05-15T15:06:51.690' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1791, 50, 1, N'Post', N'MetaTitle', N'Ghế nhựa kiểu dạng lưới cao cấp', CAST(N'2018-02-16T11:47:29.630' AS DateTime), N'Administrator', CAST(N'2018-05-15T15:06:51.700' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1792, 50, 1, N'Post', N'MetaKeywords', N'Ghế nhựa kiểu dạng lưới cao cấp', CAST(N'2018-02-16T11:47:29.633' AS DateTime), N'Administrator', CAST(N'2018-05-15T15:06:51.707' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1793, 50, 1, N'Post', N'MetaDescription', N'Ghế nhựa kiểu dạng lưới cao cấp', CAST(N'2018-02-16T11:47:29.640' AS DateTime), N'Administrator', CAST(N'2018-05-15T15:06:51.710' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1794, 55, 1, N'Post', N'Title', N'Nồi Áp Suất MIDEA MY-12CH501B', CAST(N'2018-02-16T12:50:32.370' AS DateTime), N'Administrator', CAST(N'2018-02-17T14:51:30.007' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1795, 55, 1, N'Post', N'ProductCode', N'Nồi Áp Suất MIDEA MY-12CH501B', CAST(N'2018-02-16T12:50:32.387' AS DateTime), N'Administrator', CAST(N'2018-02-17T14:51:30.020' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1796, 55, 1, N'Post', N'ShortDesc', N'Nồi Áp Suất MIDEA MY-12CH501B', CAST(N'2018-02-16T12:50:32.400' AS DateTime), N'Administrator', CAST(N'2018-02-17T14:51:30.023' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1797, 55, 1, N'Post', N'Description', N'<p><span style="color:rgb(34, 34, 34); font-family:consolas,lucida console,courier new,monospace; font-size:12px">Nồi &Aacute;p Suất MIDEA MY-12CH501BNồi &Aacute;p Suất MIDEA MY-12CH501B</span></p>
', CAST(N'2018-02-16T12:50:32.413' AS DateTime), N'Administrator', CAST(N'2018-02-17T14:51:30.030' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1798, 55, 1, N'Post', N'TechInfo', N'<p><span style="color:rgb(34, 34, 34); font-family:consolas,lucida console,courier new,monospace; font-size:12px">Nồi &Aacute;p Suất MIDEA MY-12CH501B</span></p>
', CAST(N'2018-02-16T12:50:32.430' AS DateTime), N'Administrator', CAST(N'2018-02-17T14:51:30.037' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1799, 55, 1, N'Post', N'MetaTitle', N'Nồi Áp Suất MIDEA MY-12CH501B', CAST(N'2018-02-16T12:50:32.447' AS DateTime), N'Administrator', CAST(N'2018-02-17T14:51:30.040' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1800, 55, 1, N'Post', N'MetaKeywords', N'Nồi Áp Suất MIDEA MY-12CH501B', CAST(N'2018-02-16T12:50:32.460' AS DateTime), N'Administrator', CAST(N'2018-02-17T14:51:30.043' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1801, 55, 1, N'Post', N'MetaDescription', N'Nồi Áp Suất MIDEA MY-12CH501B', CAST(N'2018-02-16T12:50:32.470' AS DateTime), N'Administrator', CAST(N'2018-02-17T14:51:30.053' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1802, 6, 1, N'News', N'Title', N'20 bộ váy đẹp của các diễn viên từng đoạt giải Oscar', CAST(N'2018-02-18T09:24:39.707' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:24:39.707' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1803, 6, 1, N'News', N'ShortDesc', N'<p><strong>C&ugrave;ng điểm lại 20 trang phục tinh tế m&agrave; c&aacute;c nữ diễn vi&ecirc;n ch&iacute;nh xuất sắc từng mặc khi l&ecirc;n nhận tượng v&agrave;ng Oscar từ năm 1996-2015.</strong></p>
', CAST(N'2018-02-18T09:24:39.763' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:24:39.763' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1804, 6, 1, N'News', N'Description', N'<p style="text-align:justify">C&ugrave;ng điểm lại 20 trang phục tinh tế m&agrave; c&aacute;c nữ diễn vi&ecirc;n ch&iacute;nh xuất sắc từng mặc khi l&ecirc;n nhận tượng v&agrave;ng Oscar từ năm 1996-2015.</p>

<div class="the-article-body" style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; background: transparent; outline: 0px; vertical-align: baseline; font-size: 16px; max-width: 100%; width: 560px; text-align: justify; text-rendering: geometricPrecision; float: left; position: relative; font-family: &quot;Noto Serif&quot;, serif; color: rgb(34, 34, 34); line-height: 26px; -webkit-font-smoothing: antialiased;">
<table align="center" class="picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); float:none; font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:0px 0px 14px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="20 bộ váy đẹp của các diễn viên từng đoạt giải Oscar" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_02_27/oscar_1.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Tại Oscar năm ngo&aacute;i, Julianne Moore đ&atilde; được vinh danh với tượng v&agrave;ng Oscar trong vai ch&iacute;nh phim&nbsp;<em>Still Alice</em>. Ở tuổi 55, nữ diễn vi&ecirc;n vẫn rất quyến rũ với bộ v&aacute;y trắng tuyệt đẹp của Chanel.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="20 bộ váy đẹp của các diễn viên từng đoạt giải Oscar" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_02_27/oscar_2.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Cate Blanchett nhận giải cho vai diễn trong bộ phim&nbsp;<em>Blue Jasmine</em>&nbsp;tại thảm đỏ Oscar 2014. C&ocirc; tỏa s&aacute;ng lộng lẫy với thiết kế của Armani Priv&eacute;.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="20 bộ váy đẹp của các diễn viên từng đoạt giải Oscar" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_02_27/oscar_3.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Jennifer Lawrence nhận giải Oscar năm 2013 với vai ch&iacute;nh trong phim&nbsp;<em>Silver LiningsPlaybook</em>. Tr&ecirc;n thảm đỏ, tr&ocirc;ng c&ocirc; như một n&agrave;ng c&ocirc;ng ch&uacute;a với bộ v&aacute;y&nbsp;của Christian Dior.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="20 bộ váy đẹp của các diễn viên từng đoạt giải Oscar" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_02_27/oscar_4.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Meryl Streep lấp l&aacute;nh trong bộ v&aacute;y của Lanvin tại lễ trao giải Oscar 2012. Nữ diễn vi&ecirc;n g&acirc;y ấn tượng v&agrave; gi&agrave;nh giải cho vai ch&iacute;nh trong phim&nbsp;<em>The Iron Lady</em>.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="20 bộ váy đẹp của các diễn viên từng đoạt giải Oscar" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_02_27/oscar_5.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Natalie Portman tr&ocirc;ng như một nữ thần Hy Lạp trong chiếc v&aacute;y m&agrave;u t&iacute;m Rodarte tại Oscar 2011. C&ocirc; nhận giải thưởng cho bộ phim&nbsp;<em>Black Swan</em>.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="20 bộ váy đẹp của các diễn viên từng đoạt giải Oscar" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_02_27/oscar_6.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Sandra Bullock d&agrave;nh giải Oscar 2010 với bộ phim&nbsp;<em>The Blind Side</em>. Chiếc v&aacute;y của Marchesa mang lại vẻ thanh lịch, quyến rũ cho nữ diễn vi&ecirc;n.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="20 bộ váy đẹp của các diễn viên từng đoạt giải Oscar" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_02_27/oscar_7.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Tại lễ trao giải Oscar 2009, Kate Winslet sang trọng trong bộ v&aacute;y của Yves Saint Laurent. C&ocirc; đạt giải Oscar với vai ch&iacute;nh trong bộ phim&nbsp;<em>The Reader</em>.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="20 bộ váy đẹp của các diễn viên từng đoạt giải Oscar" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_02_27/oscar_8.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Marion Cotillard vương giả trong chiếc v&aacute;y đu&ocirc;i c&aacute; Jean Paul Gaultiertại lễ trao giải Oscar 2008 nhận giải cho vai ch&iacute;nh trong phim&nbsp;<em>La Vie En Rose</em>.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="20 bộ váy đẹp của các diễn viên từng đoạt giải Oscar" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_02_27/oscar_9.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Với vai ch&iacute;nh ấn tượng trong phim&nbsp;<em>The Queen</em>, Helen Mirren nhận giải Oscar năm 2007. Nữ diễn vi&ecirc;n diện bộ đầm sang trọng của Christian Lacroix khi tới tham dự.</p>
			</td>
		</tr>
	</tbody>
</table>
</div>
', CAST(N'2018-02-18T09:24:39.770' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:24:39.770' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1805, 6, 1, N'News', N'SeoUrl', N'20-bo-vay-dep-cua-cac-dien-vien-tung-doat-giai-oscar', CAST(N'2018-02-18T09:24:39.780' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:24:39.780' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1806, 6, 1, N'News', N'MetaTitle', N'20 bộ váy đẹp của các diễn viên từng đoạt giải Oscar', CAST(N'2018-02-18T09:24:39.787' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:24:39.787' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1807, 6, 1, N'News', N'MetaKeywords', N'20 bộ váy đẹp của các diễn viên từng đoạt giải Oscar', CAST(N'2018-02-18T09:24:39.797' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:24:39.797' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1808, 6, 1, N'News', N'MetaDescription', N'20 bộ váy đẹp của các diễn viên từng đoạt giải Oscar', CAST(N'2018-02-18T09:24:39.803' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:24:39.803' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1809, 5, 1, N'News', N'Title', N'Những chiếc vòng cổ tạo đẳng cấp cho sao ngoại trên thảm đỏ', CAST(N'2018-02-18T09:25:30.990' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:25:30.990' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1810, 5, 1, N'News', N'ShortDesc', N'<p><span style="color:rgb(34, 34, 34); font-family:consolas,lucida console,courier new,monospace; font-size:12px">Những chiếc v&ograve;ng cổ tạo đẳng cấp cho sao ngoại tr&ecirc;n thảm đỏNhững chiếc v&ograve;ng cổ tạo đẳng cấp cho sao ngoại tr&ecirc;n thảm đỏNhững chiếc v&ograve;ng cổ tạo đẳng cấp cho sao ngoại tr&ecirc;n thảm đỏ</span></p>
', CAST(N'2018-02-18T09:25:31.003' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:25:31.003' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1811, 5, 1, N'News', N'Description', N'<p style="text-align:justify">Những chiếc v&ograve;ng cổ được thiết kế cầu kỳ, lấp l&aacute;nh, tuy nhỏ nhưng lại l&agrave; điểm nhấn cho trang phục, gi&uacute;p c&aacute;c mỹ nh&acirc;n trở th&agrave;nh t&acirc;m điểm ở c&aacute;c sự kiện.</p>

<div class="the-article-body" style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; background: transparent; outline: 0px; vertical-align: baseline; font-size: 16px; max-width: 100%; width: 560px; text-align: justify; text-rendering: geometricPrecision; float: left; position: relative; font-family: &quot;Noto Serif&quot;, serif; color: rgb(34, 34, 34); line-height: 26px; -webkit-font-smoothing: antialiased;">
<table align="center" class="picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); float:none; font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:0px 0px 14px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="Những chiếc vòng cổ tạo đẳng cấp cho sao ngoại trên thảm đỏ" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_02_25/vong_co_1.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Taylor Swift xinh đẹp v&agrave; sang trọng với chiếc v&ograve;ng cổ choker thời thượng.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="Những chiếc vòng cổ tạo đẳng cấp cho sao ngoại trên thảm đỏ" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_02_25/vong_co_2.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>V&ograve;ng cổ sợi x&iacute;ch d&agrave;i trễ ngực, đ&ocirc;i b&ocirc;ng tai, những chiếc nhẫn chắc nịch, mọi thứ kết hợp mang lại vẻ đẹp ho&agrave;n hảo cho Demi Lovato.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="Những chiếc vòng cổ tạo đẳng cấp cho sao ngoại trên thảm đỏ" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_02_25/vong_co_3.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>C&aacute;c qu&yacute; c&ocirc; đ&atilde; quen với việc trưng diện những phụ kiện đẹp tr&ecirc;n thảm đỏ c&oacute; thể quen với v&ograve;ng cổ đ&aacute; của Carrie Underwood.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="Những chiếc vòng cổ tạo đẳng cấp cho sao ngoại trên thảm đỏ" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_02_25/vong_co_4.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Jennifer Lawrence, ng&ocirc;i sao của&nbsp;<em>Hunger Games</em>&nbsp;đ&atilde; trở th&agrave;nh t&acirc;m điểm của thảm đỏ Gloden Globes 2016 với đầm đỏ Dior v&agrave; đặc biệt l&agrave; v&ograve;ng cổ kim cương 156 carat của Chopard.&nbsp;</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="Những chiếc vòng cổ tạo đẳng cấp cho sao ngoại trên thảm đỏ" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_02_25/vong_co_5.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Olivia Palermo tỏa s&aacute;ng tại Golden Globes 2016 với chiếc v&ograve;ng cổ tuyệt đẹp của David Webb. Phụ kiện tr&ocirc;ng như những chiếc l&aacute; v&agrave;ng gh&eacute;p lại.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="Những chiếc vòng cổ tạo đẳng cấp cho sao ngoại trên thảm đỏ" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_02_25/vong_co_6.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Oliva Wilde cũng thu h&uacute;t v&agrave; c&aacute; t&iacute;nh hơn nhờ chiếc v&ograve;ng độc đ&aacute;o của Bulgari. V&ograve;ng được thiết kế từ những đồng tiền Roman v&ocirc; c&ugrave;ng ấn tượng v&agrave; lạ lẫm.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="Những chiếc vòng cổ tạo đẳng cấp cho sao ngoại trên thảm đỏ" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_02_25/vong_co_7.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Eva Mendes g&acirc;y ấn tượng mạnh với v&ograve;ng cổ Van Cleef &amp; Arpels.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="Những chiếc vòng cổ tạo đẳng cấp cho sao ngoại trên thảm đỏ" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_02_25/vong_co_8.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Sofia Vergara tỏa s&aacute;ng với chiếc v&ograve;ng cổ kết hoa m&agrave;u xanh tươi m&aacute;t của Lorraine Schwarts.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="Những chiếc vòng cổ tạo đẳng cấp cho sao ngoại trên thảm đỏ" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_02_25/vong_co_9.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Lorde rạng rỡ hơn nhờ chiếc v&ograve;ng cổ Cleopatra gắn kim cương 100 carat của thương hiệu Neil Lane.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="Những chiếc vòng cổ tạo đẳng cấp cho sao ngoại trên thảm đỏ" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_02_25/vong_co_10.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Noami Watts rạng rỡ trong bộ đầm v&agrave;ng với điểm nhấn l&agrave; chiếc v&ograve;ng kim cương h&igrave;nh rắn ki&ecirc;u h&atilde;nh của Bulgari.&nbsp;</p>
			</td>
		</tr>
	</tbody>
</table>
</div>
', CAST(N'2018-02-18T09:25:31.010' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:25:31.010' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1812, 5, 1, N'News', N'SeoUrl', N'nhung-chiec-vong-co-tao-dang-cap-cho-sao-ngoai-tren-tham-do', CAST(N'2018-02-18T09:25:31.027' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:25:31.027' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1813, 5, 1, N'News', N'MetaTitle', N'Những chiếc vòng cổ tạo đẳng cấp cho sao ngoại trên thảm đỏ', CAST(N'2018-02-18T09:25:31.030' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:25:31.030' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1814, 5, 1, N'News', N'MetaKeywords', N'Những chiếc vòng cổ tạo đẳng cấp cho sao ngoại trên thảm đỏ', CAST(N'2018-02-18T09:25:31.037' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:25:31.037' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1815, 5, 1, N'News', N'MetaDescription', N'Những chiếc vòng cổ tạo đẳng cấp cho sao ngoại trên thảm đỏ', CAST(N'2018-02-18T09:25:31.043' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:25:31.043' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1816, 4, 1, N'News', N'Title', N'Diện váy xẻ cao quyến rũ như Miranda Kerr', CAST(N'2018-02-18T09:26:24.040' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:26:24.040' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1817, 4, 1, N'News', N'ShortDesc', N'<p><strong>Với lợi thế đ&ocirc;i ch&acirc;n thon d&agrave;i kết hợp c&ugrave;ng th&acirc;n h&igrave;nh chuẩn của một si&ecirc;u mẫu, Miranda Kerr lựa chọn v&aacute;y xẻ t&agrave; cao để khoe kh&eacute;o ưu điểm n&agrave;y mỗi khi xuất hiện.</strong></p>
', CAST(N'2018-02-18T09:26:24.093' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:26:24.093' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1818, 4, 1, N'News', N'Description', N'<p style="text-align:justify">Với lợi thế đ&ocirc;i ch&acirc;n thon d&agrave;i kết hợp c&ugrave;ng th&acirc;n h&igrave;nh chuẩn của một si&ecirc;u mẫu, Miranda Kerr lựa chọn v&aacute;y xẻ t&agrave; cao để khoe kh&eacute;o ưu điểm n&agrave;y mỗi khi xuất hiện.</p>

<div class="the-article-body" style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; background: transparent; outline: 0px; vertical-align: baseline; font-size: 16px; max-width: 100%; width: 560px; text-align: justify; text-rendering: geometricPrecision; float: left; position: relative; font-family: &quot;Noto Serif&quot;, serif; color: rgb(34, 34, 34); line-height: 26px; -webkit-font-smoothing: antialiased;">
<table align="center" class="mce-item-table picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); float:none; font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:0px 0px 14px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="Diện váy xẻ cao quyến rũ như Miranda Kerr" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_03_03/Miranda_kerr_1.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Cựu thi&ecirc;n thần nội y nhiều lần khoe vẻ sexy khi diện v&aacute;y maxi xẻ cao đi sự kiện hoặc dạo phố.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="mce-item-table picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="Diện váy xẻ cao quyến rũ như Miranda Kerr" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_03_03/Miranda_kerr_2.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Si&ecirc;u mẫu khoe đ&ocirc;i ch&acirc;n thon d&agrave;i trong chiếc v&aacute;y Emanuel Ungaro m&agrave;u hồng, thiết kế xẻ t&agrave; v&agrave; kho&eacute;t ngực sexy tại sự kiện thuộc khu&ocirc;n khổ Li&ecirc;n hoan phim Cannes 2015.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="mce-item-table picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="Diện váy xẻ cao quyến rũ như Miranda Kerr" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_03_03/Miranda_kerr_3.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Những bộ v&aacute;y xẻ cao bất tận l&agrave; một đặc trưng phong c&aacute;ch của cựu thi&ecirc;n thần Victoria&rsquo;s Secret. N&agrave;ng từng ghi dấu ấn tr&ecirc;n thảm đỏ CFDA Awards với bộ đồ cut-out hiệu Michael Kors khi&ecirc;u gợi.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="mce-item-table picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="Diện váy xẻ cao quyến rũ như Miranda Kerr" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_03_03/Miranda_kerr_4.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Trang phục cắt c&uacute;p gợi cảm của Emilio Pucci gi&uacute;p b&agrave; mẹ một con khoe trọn lưng trần lẫn một b&ecirc;n h&ocirc;ng v&agrave; đ&ugrave;i.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="mce-item-table picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="Diện váy xẻ cao quyến rũ như Miranda Kerr" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_03_03/Miranda_kerr_5.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Miranda&nbsp;tỏa s&aacute;ng tr&ecirc;n thảm đỏ khi kho&aacute;c l&ecirc;n m&igrave;nh thiết kế vải chiffon Zuhair Murad. Trang phục cắt kho&eacute;t kiểu chữ V kh&aacute; t&aacute;o bạo.</p>
			</td>
		</tr>
	</tbody>
</table>

<table align="center" class="mce-item-table picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; font-weight:inherit; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="Diện váy xẻ cao quyến rũ như Miranda Kerr" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_03_03/Miranda_kerr_6.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Một bộ v&aacute;y phong c&aacute;ch Hy Lạp m&agrave;u đen trắng của Michael Kors g&oacute;p phần v&agrave;o tuyển tập v&aacute;y xẻ ph&oacute;ng kho&aacute;ng của Miranda.</p>
			</td>
		</tr>
	</tbody>
</table>
</div>
', CAST(N'2018-02-18T09:26:24.097' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:26:24.097' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1819, 4, 1, N'News', N'SeoUrl', N'dien-vay-xe-cao-quyen-ru-nhu-miranda-kerr', CAST(N'2018-02-18T09:26:24.113' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:26:24.113' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1820, 4, 1, N'News', N'MetaTitle', N'Diện váy xẻ cao quyến rũ như Miranda Kerr', CAST(N'2018-02-18T09:26:24.120' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:26:24.120' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1821, 4, 1, N'News', N'MetaKeywords', N'Diện váy xẻ cao quyến rũ như Miranda Kerr', CAST(N'2018-02-18T09:26:24.130' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:26:24.130' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1822, 4, 1, N'News', N'MetaDescription', N'Diện váy xẻ cao quyến rũ như Miranda Kerr', CAST(N'2018-02-18T09:26:24.137' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:26:24.137' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1823, 7, 1, N'SlideShow', N'Title', N'Slide 2', CAST(N'2018-02-18T09:29:34.953' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:47:33.603' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1824, 7, 2, N'SlideShow', N'Title', N'Slide 2', CAST(N'2018-02-18T09:29:41.053' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:47:33.617' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1825, 7, 3, N'SlideShow', N'Title', N'Slide 2', CAST(N'2018-02-18T09:29:41.073' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:47:33.620' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1836, 37, 1, N'MenuLink', N'MenuName', N'Trợ giúp', CAST(N'2018-02-24T15:42:30.400' AS DateTime), N'Administrator', CAST(N'2018-02-25T09:22:53.613' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1837, 37, 1, N'MenuLink', N'SeoUrl', N'tro-giup', CAST(N'2018-02-24T15:42:30.457' AS DateTime), N'Administrator', CAST(N'2018-02-25T09:22:53.617' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1838, 37, 1, N'MenuLink', N'MetaTitle', N'Trợ giúp', CAST(N'2018-02-24T15:42:30.467' AS DateTime), N'Administrator', CAST(N'2018-02-25T09:22:53.623' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1839, 37, 1, N'MenuLink', N'MetaKeywords', N'Trợ giúp', CAST(N'2018-02-24T15:42:30.470' AS DateTime), N'Administrator', CAST(N'2018-02-25T09:22:53.630' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1840, 37, 1, N'MenuLink', N'MetaDescription', N'Trợ giúp', CAST(N'2018-02-24T15:42:30.477' AS DateTime), N'Administrator', CAST(N'2018-02-25T09:22:53.633' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1841, 1110, 1, N'MenuLink', N'MenuName', N'Về GoWeb', CAST(N'2018-02-25T09:28:10.837' AS DateTime), N'Administrator', CAST(N'2018-02-25T09:28:10.837' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1842, 1110, 1, N'MenuLink', N'SeoUrl', N've-goweb', CAST(N'2018-02-25T09:28:10.903' AS DateTime), N'Administrator', CAST(N'2018-02-25T09:28:10.903' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1843, 1110, 1, N'MenuLink', N'MetaTitle', N'Về GoWeb', CAST(N'2018-02-25T09:28:10.913' AS DateTime), N'Administrator', CAST(N'2018-02-25T09:28:10.913' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1844, 1110, 1, N'MenuLink', N'MetaKeywords', N'Về GoWeb', CAST(N'2018-02-25T09:28:10.917' AS DateTime), N'Administrator', CAST(N'2018-02-25T09:28:10.917' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1845, 1110, 1, N'MenuLink', N'MetaDescription', N'Về GoWeb', CAST(N'2018-02-25T09:28:10.923' AS DateTime), N'Administrator', CAST(N'2018-02-25T09:28:10.923' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1846, 1112, 1, N'MenuLink', N'MenuName', N'Giới thiệu GoWeb', CAST(N'2018-02-25T09:28:43.140' AS DateTime), N'Administrator', CAST(N'2018-02-25T09:28:43.140' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1847, 1112, 1, N'MenuLink', N'SeoUrl', N'gioi-thieu-goweb', CAST(N'2018-02-25T09:28:43.147' AS DateTime), N'Administrator', CAST(N'2018-02-25T09:28:43.147' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1848, 1112, 1, N'MenuLink', N'MetaTitle', N'Giới thiệu GoWeb', CAST(N'2018-02-25T09:28:43.160' AS DateTime), N'Administrator', CAST(N'2018-02-25T09:28:43.160' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1849, 1112, 1, N'MenuLink', N'MetaKeywords', N'Giới thiệu GoWeb', CAST(N'2018-02-25T09:28:43.177' AS DateTime), N'Administrator', CAST(N'2018-02-25T09:28:43.177' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1850, 1112, 1, N'MenuLink', N'MetaDescription', N'Giới thiệu GoWeb', CAST(N'2018-02-25T09:28:43.180' AS DateTime), N'Administrator', CAST(N'2018-02-25T09:28:43.180' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1851, 1111, 1, N'MenuLink', N'MenuName', N'Tuyển Dụng', CAST(N'2018-02-25T09:28:59.203' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:16:21.670' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1852, 1111, 1, N'MenuLink', N'SeoUrl', N'tuyen-dung', CAST(N'2018-02-25T09:28:59.223' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:16:21.690' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1853, 1111, 1, N'MenuLink', N'MetaTitle', N'Tuyển Dụng', CAST(N'2018-02-25T09:28:59.230' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:16:21.707' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1854, 1111, 1, N'MenuLink', N'MetaKeywords', N'Tuyển Dụng', CAST(N'2018-02-25T09:28:59.237' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:16:21.720' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1855, 1111, 1, N'MenuLink', N'MetaDescription', N'Tuyển Dụng', CAST(N'2018-02-25T09:28:59.243' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:16:21.740' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1856, 18, 1, N'StaticContent', N'Title', N'Product Manager', CAST(N'2018-02-25T15:02:56.297' AS DateTime), N'Administrator', CAST(N'2018-05-24T16:02:22.747' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1857, 18, 1, N'StaticContent', N'ShortDesc', N'<p>At Tiki, we believe in growing a sustainable business with strong fundamentals. It means acquiring new customers not just based on promotion but also on excellent customer service. In the backend, it means aiming for efficiency and optimization in Supply Chain, Warehouse and Cost management. Together with a strong team, solid IT solutions is the key to enable all of those.</p>

<p>As a member of Operation Product team, you will work on various solutions that manage our entire fleet of warehouses (inventory management, order processing) and Tiki delivery team. We also need to connect with and manage the cost and quality of our third-party logistics providers. At the same time, we also support our FNA team to track all the cash spent or need to be collected to optimize the cash flow. All of those will ensure that our orders are processed and delivered to customers with a very short leadtime and optimal cost. This is a key differentiation that help Tiki to survive and grow fast in a tough market like Vietnamese e-commerce.</p>

<p>In more details, you will</p>

<ul>
	<li>Work with internal clients (Operation &amp; FNA team) to understand the requirement, finalize the solution with clear scope and detailed documentation</li>
	<li>Finalise delivery plan (scope, timeline, resource/support needed) based on business priorities and team capacity</li>
	<li>Collaborate with Software Architecture, Developer and QC to ensure the quality of product</li>
	<li>Provide guidance and last-tier support for assigned product lines</li>
	<li>Provide coaching to team member</li>
</ul>

<p>We have a strong team with diversified background and a keen interest on being the best in e-commerce. You will gain more domain knowledge in what probably is one of the hottest IT sectors right now and have chances to encounter and solve challenging problems at large scale (think of million of orders, millions of customers and a magnitude more of data in our backend system)</p>

<p><span style="font-size:14pt"><strong>REQUIREMENT</strong></span></p>

<ul>
	<li>3 &ndash; 5 years of working experience.</li>
	<li>Strong accounting background.</li>
	<li>E-commerce Operation knowledge is a plus.</li>
	<li>Product management skill (business analyst, UI/UX mockup, features prioritization).</li>
	<li>Project management skill.</li>
	<li>Technical writing skill.</li>
	<li>Resource planning skill.</li>
	<li>Customer-oriented and have a high bar of quality.</li>
	<li>Ability to work across functions and be aggressive to get things done.</li>
	<li>Coaching skill.</li>
	<li>Good English communication.</li>
</ul>

<p><span style="font-size:14pt"><strong>BENIFIT</strong></span></p>

<ul>
	<li>Competitive salary.</li>
	<li>Dynamic, open and challenging working environment.</li>
	<li>Modern office, cafeteria; library; computer gaming, HD TV platforms.</li>
	<li>Performance review (twice a year), 13th month pay based on performance.</li>
	<li>Annual health check-up and premium healthcare.</li>
	<li>Special internal programs for Tikiers.</li>
</ul>

<div class="wrap" style="box-sizing: border-box; margin-bottom: 45px; font-family: Arial, Helvetica, sans-serif; font-size: 14px;">
<div class="container" style="box-sizing: border-box; margin-right: auto; margin-left: auto; padding-left: 15px; padding-right: 15px; width: 1170px;">
<div class="row style-2" style="box-sizing: border-box; margin-left: -15px; margin-right: -15px;">
<div class="col-lg-8 col-md-7" style="box-sizing: border-box; position: relative; min-height: 1px; padding-left: 15px; padding-right: 15px; float: left; width: 877.5px;">
<div class="right2" style="box-sizing: border-box; margin-top: 20px; border-left: 1px dashed rgb(228, 228, 228); padding-left: 20px;">
<div class="content" style="box-sizing: border-box; border-top: 2px solid rgb(228, 228, 228); padding-top: 20px; line-height: 25px;">
<p><strong>If you are interested in Product Manager position</strong><br />
Please submit online application form via&nbsp;<a class="btn btn--primary btn--large apply-workable" href="https://tiki-corporation.workable.com/jobs/659218/candidates/new" style="box-sizing: border-box; background-color: transparent; color: rgb(0, 170, 241); text-decoration-line: none; background-image: none; white-space: nowrap; line-height: 1.42857; display: inline-block; margin-bottom: 0px; text-align: center; vertical-align: middle; touch-action: manipulation; border: 1px solid transparent; padding: 6px 12px; border-radius: 4px; user-select: none;">This Link</a>&nbsp;or send your CV via mail:&nbsp;<strong>careers@tiki.vn</strong>.</p>
</div>
</div>
</div>
</div>
</div>
</div>
', CAST(N'2018-02-25T15:02:56.307' AS DateTime), N'Administrator', CAST(N'2018-05-24T16:02:22.777' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1858, 18, 1, N'StaticContent', N'Description', N'<p>At Tiki, we believe in growing a sustainable business with strong fundamentals. It means acquiring new customers not just based on promotion but also on excellent customer service. In the backend, it means aiming for efficiency and optimization in Supply Chain, Warehouse and Cost management. Together with a strong team, solid IT solutions is the key to enable all of those.</p>

<p>As a member of Operation Product team, you will work on various solutions that manage our entire fleet of warehouses (inventory management, order processing) and Tiki delivery team. We also need to connect with and manage the cost and quality of our third-party logistics providers. At the same time, we also support our FNA team to track all the cash spent or need to be collected to optimize the cash flow. All of those will ensure that our orders are processed and delivered to customers with a very short leadtime and optimal cost. This is a key differentiation that help Tiki to survive and grow fast in a tough market like Vietnamese e-commerce.</p>

<p>In more details, you will</p>

<ul>
	<li>Work with internal clients (Operation &amp; FNA team) to understand the requirement, finalize the solution with clear scope and detailed documentation</li>
	<li>Finalise delivery plan (scope, timeline, resource/support needed) based on business priorities and team capacity</li>
	<li>Collaborate with Software Architecture, Developer and QC to ensure the quality of product</li>
	<li>Provide guidance and last-tier support for assigned product lines</li>
	<li>Provide coaching to team member</li>
</ul>

<p>We have a strong team with diversified background and a keen interest on being the best in e-commerce. You will gain more domain knowledge in what probably is one of the hottest IT sectors right now and have chances to encounter and solve challenging problems at large scale (think of million of orders, millions of customers and a magnitude more of data in our backend system)</p>

<p><span style="font-size:14pt"><strong>REQUIREMENT</strong></span></p>

<ul>
	<li>3 &ndash; 5 years of working experience.</li>
	<li>Strong accounting background.</li>
	<li>E-commerce Operation knowledge is a plus.</li>
	<li>Product management skill (business analyst, UI/UX mockup, features prioritization).</li>
	<li>Project management skill.</li>
	<li>Technical writing skill.</li>
	<li>Resource planning skill.</li>
	<li>Customer-oriented and have a high bar of quality.</li>
	<li>Ability to work across functions and be aggressive to get things done.</li>
	<li>Coaching skill.</li>
	<li>Good English communication.</li>
</ul>

<p><span style="font-size:14pt"><strong>BENIFIT</strong></span></p>

<ul>
	<li>Competitive salary.</li>
	<li>Dynamic, open and challenging working environment.</li>
	<li>Modern office, cafeteria; library; computer gaming, HD TV platforms.</li>
	<li>Performance review (twice a year), 13th month pay based on performance.</li>
	<li>Annual health check-up and premium healthcare.</li>
	<li>Special internal programs for Tikiers.</li>
</ul>

<div class="wrap" style="box-sizing: border-box; margin-bottom: 45px; font-family: Arial, Helvetica, sans-serif; font-size: 14px;">
<div class="container" style="box-sizing: border-box; margin-right: auto; margin-left: auto; padding-left: 15px; padding-right: 15px; width: 1170px;">
<div class="row style-2" style="box-sizing: border-box; margin-left: -15px; margin-right: -15px;">
<div class="col-lg-8 col-md-7" style="box-sizing: border-box; position: relative; min-height: 1px; padding-left: 15px; padding-right: 15px; float: left; width: 877.5px;">
<div class="right2" style="box-sizing: border-box; margin-top: 20px; border-left: 1px dashed rgb(228, 228, 228); padding-left: 20px;">
<div class="content" style="box-sizing: border-box; border-top: 2px solid rgb(228, 228, 228); padding-top: 20px; line-height: 25px;">
<p><strong>If you are interested in Product Manager position</strong><br />
Please submit online application form via&nbsp;<a class="btn btn--primary btn--large apply-workable" href="https://tiki-corporation.workable.com/jobs/659218/candidates/new" style="box-sizing: border-box; background-color: transparent; color: rgb(0, 170, 241); text-decoration-line: none; background-image: none; white-space: nowrap; line-height: 1.42857; display: inline-block; margin-bottom: 0px; text-align: center; vertical-align: middle; touch-action: manipulation; border: 1px solid transparent; padding: 6px 12px; border-radius: 4px; user-select: none;">This Link</a>&nbsp;or send your CV via mail:&nbsp;<strong>careers@tiki.vn</strong>.</p>
</div>
</div>
</div>
</div>
</div>
</div>
', CAST(N'2018-02-25T15:02:56.313' AS DateTime), N'Administrator', CAST(N'2018-05-24T16:02:22.800' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1859, 18, 1, N'StaticContent', N'SeoUrl', N'product-manager', CAST(N'2018-02-25T15:02:56.317' AS DateTime), N'Administrator', CAST(N'2018-05-24T16:02:22.827' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1860, 18, 1, N'StaticContent', N'MetaTitle', N'Product Manager', CAST(N'2018-02-25T15:02:56.320' AS DateTime), N'Administrator', CAST(N'2018-05-24T16:02:22.850' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1861, 18, 1, N'StaticContent', N'MetaKeywords', N'Product Manager', CAST(N'2018-02-25T15:02:56.327' AS DateTime), N'Administrator', CAST(N'2018-05-24T16:02:22.873' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1862, 18, 1, N'StaticContent', N'MetaDescription', N'Product Manager', CAST(N'2018-02-25T15:02:56.330' AS DateTime), N'Administrator', CAST(N'2018-05-24T16:02:22.903' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1863, 4, 1, N'PaymentMethod', N'PaymentMethodSystemName', N'aa', CAST(N'2018-03-06T15:30:08.207' AS DateTime), N'Administrator', CAST(N'2018-03-06T15:30:08.207' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1864, 4, 1, N'PaymentMethod', N'Description', N'ffsdaf', CAST(N'2018-03-06T15:30:08.240' AS DateTime), N'Administrator', CAST(N'2018-03-06T15:30:08.240' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1865, 5, 1, N'PaymentMethod', N'PaymentMethodSystemName', N'aaaaaaaaaa', CAST(N'2018-03-06T15:30:20.027' AS DateTime), N'Administrator', CAST(N'2018-03-06T15:30:25.667' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1866, 5, 1, N'PaymentMethod', N'Description', N'aaaaaaaaaaa', CAST(N'2018-03-06T15:30:20.060' AS DateTime), N'Administrator', CAST(N'2018-03-06T15:30:25.697' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1867, 1, 1, N'PaymentMethod', N'PaymentMethodSystemName', N'DHL', CAST(N'2018-03-08T15:16:54.663' AS DateTime), N'Administrator', CAST(N'2018-03-08T15:54:52.960' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1868, 2, 1, N'PaymentMethod', N'PaymentMethodSystemName', N'Trademark', CAST(N'2018-03-08T15:17:32.567' AS DateTime), N'Administrator', CAST(N'2018-03-08T15:55:08.947' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1873, 100, 1, N'Post', N'Title', N'Áo vest', CAST(N'2018-04-19T16:32:32.460' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:03:23.527' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1874, 100, 1, N'Post', N'ProductCode', N'AV2018.05.13', CAST(N'2018-04-19T16:32:32.483' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:03:23.537' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1875, 100, 1, N'Post', N'ShortDesc', N'Áo vest', CAST(N'2018-04-19T16:32:32.497' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:03:23.547' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1876, 100, 1, N'Post', N'Description', N'<p>&Aacute;o vest</p>
', CAST(N'2018-04-19T16:32:32.513' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:03:23.550' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1877, 100, 1, N'Post', N'TechInfo', N'<p>&Aacute;o vest&Aacute;o vest&Aacute;o vest</p>
', CAST(N'2018-04-19T16:32:32.527' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:03:23.553' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1878, 100, 1, N'Post', N'MetaTitle', N'Áo vest', CAST(N'2018-04-19T16:32:32.590' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:03:23.560' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1879, 100, 1, N'Post', N'MetaKeywords', N'Áo vest', CAST(N'2018-04-19T16:32:32.603' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:03:23.567' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1880, 100, 1, N'Post', N'MetaDescription', N'Áo vest', CAST(N'2018-04-19T16:32:32.620' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:03:23.587' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1881, 99, 1, N'Post', N'Title', N'Quần tây', CAST(N'2018-04-19T16:32:57.120' AS DateTime), N'Administrator', CAST(N'2018-05-13T13:52:31.430' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1882, 99, 1, N'Post', N'ProductCode', N'QT2018.05.13', CAST(N'2018-04-19T16:32:57.133' AS DateTime), N'Administrator', CAST(N'2018-05-13T13:52:31.460' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1883, 99, 1, N'Post', N'ShortDesc', N'Quần tây', CAST(N'2018-04-19T16:32:57.143' AS DateTime), N'Administrator', CAST(N'2018-05-13T13:52:31.527' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1884, 99, 1, N'Post', N'TechInfo', N'<p>Quần t&acirc;yQuần t&acirc;yQuần t&acirc;yQuần t&acirc;y</p>
', CAST(N'2018-04-19T16:32:57.157' AS DateTime), N'Administrator', CAST(N'2018-05-13T13:52:31.650' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1885, 99, 1, N'Post', N'MetaTitle', N'Quần tây', CAST(N'2018-04-19T16:32:57.177' AS DateTime), N'Administrator', CAST(N'2018-05-13T13:52:31.697' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1886, 99, 1, N'Post', N'MetaKeywords', N'Quần tây', CAST(N'2018-04-19T16:32:57.190' AS DateTime), N'Administrator', CAST(N'2018-05-13T13:52:31.760' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1887, 99, 1, N'Post', N'MetaDescription', N'Quần tây', CAST(N'2018-04-19T16:32:57.207' AS DateTime), N'Administrator', CAST(N'2018-05-13T13:52:31.920' AS DateTime), N'Administrator')
GO
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1888, 95, 1, N'Post', N'Title', N'Quần jean', CAST(N'2018-04-19T16:33:19.187' AS DateTime), N'Administrator', CAST(N'2018-05-15T14:50:48.483' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1889, 95, 1, N'Post', N'ProductCode', N'Quần jean', CAST(N'2018-04-19T16:33:19.213' AS DateTime), N'Administrator', CAST(N'2018-05-15T14:50:48.503' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1890, 95, 1, N'Post', N'ShortDesc', N'Quần jean', CAST(N'2018-04-19T16:33:19.240' AS DateTime), N'Administrator', CAST(N'2018-05-15T14:50:48.507' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1891, 95, 1, N'Post', N'TechInfo', N'<p>Quần jeanQuần jeanQuần jean</p>
', CAST(N'2018-04-19T16:33:19.257' AS DateTime), N'Administrator', CAST(N'2018-05-15T14:50:48.520' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1892, 95, 1, N'Post', N'MetaTitle', N'Quần jean', CAST(N'2018-04-19T16:33:19.273' AS DateTime), N'Administrator', CAST(N'2018-05-15T14:50:48.533' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1893, 95, 1, N'Post', N'MetaKeywords', N'Quần jean', CAST(N'2018-04-19T16:33:19.283' AS DateTime), N'Administrator', CAST(N'2018-05-15T14:50:48.540' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1894, 95, 1, N'Post', N'MetaDescription', N'Quần jean', CAST(N'2018-04-19T16:33:19.297' AS DateTime), N'Administrator', CAST(N'2018-05-15T14:50:48.550' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1895, 101, 1, N'Post', N'Title', N'Dự án Long An', CAST(N'2018-04-20T16:16:45.703' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:53:58.380' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1896, 101, 1, N'Post', N'ProductCode', N'DALA2018.04.20', CAST(N'2018-04-20T16:16:45.717' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:53:58.390' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1897, 101, 1, N'Post', N'ShortDesc', N'32', CAST(N'2018-04-20T16:16:45.720' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:53:58.393' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1898, 101, 1, N'Post', N'Description', N'<p>32</p>
', CAST(N'2018-04-20T16:16:45.723' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:53:58.397' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1899, 101, 1, N'Post', N'TechInfo', N'<p>32</p>
', CAST(N'2018-04-20T16:16:45.730' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:53:58.400' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1900, 101, 1, N'Post', N'MetaTitle', N'Dự án Long An', CAST(N'2018-04-20T16:16:45.733' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:53:58.403' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1901, 101, 1, N'Post', N'MetaKeywords', N'Dự án Long An', CAST(N'2018-04-20T16:16:45.737' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:53:58.410' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1902, 101, 1, N'Post', N'MetaDescription', N'Dự án Long An', CAST(N'2018-04-20T16:16:45.740' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:53:58.413' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1903, 2135, 1, N'MenuLink', N'MenuName', N'Dịch vụ', CAST(N'2018-04-22T15:20:16.157' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:39:14.903' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1904, 2135, 1, N'MenuLink', N'SeoUrl', N'dich-vu', CAST(N'2018-04-22T15:20:16.173' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:39:14.913' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1905, 2135, 1, N'MenuLink', N'MetaTitle', N'Dịch vụ', CAST(N'2018-04-22T15:20:16.187' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:39:14.913' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1906, 2135, 1, N'MenuLink', N'MetaKeywords', N'Dịch vụ', CAST(N'2018-04-22T15:20:16.200' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:39:14.917' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1907, 2135, 1, N'MenuLink', N'MetaDescription', N'Dịch vụ', CAST(N'2018-04-22T15:20:16.210' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:39:14.917' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1908, 2136, 1, N'MenuLink', N'MenuName', N'Giá trị lớn', CAST(N'2018-04-22T15:47:41.967' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:24:26.623' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1909, 2136, 1, N'MenuLink', N'SeoUrl', N'gia-tri-lon', CAST(N'2018-04-22T15:47:41.977' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:24:26.623' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1910, 2136, 1, N'MenuLink', N'MetaTitle', N'Giá trị lớn', CAST(N'2018-04-22T15:47:41.987' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:24:26.627' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1911, 2136, 1, N'MenuLink', N'MetaKeywords', N'Giá trị lớn', CAST(N'2018-04-22T15:47:41.993' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:24:26.627' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1912, 2136, 1, N'MenuLink', N'MetaDescription', N'Giá trị lớn', CAST(N'2018-04-22T15:47:42.003' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:24:26.630' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1913, 2137, 1, N'MenuLink', N'MenuName', N'Hổ trợ', CAST(N'2018-04-22T16:02:27.247' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:26:54.027' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1914, 2137, 1, N'MenuLink', N'SeoUrl', N'ho-tro', CAST(N'2018-04-22T16:02:27.263' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:26:54.040' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1915, 2137, 1, N'MenuLink', N'MetaTitle', N'Hổ trợ', CAST(N'2018-04-22T16:02:27.270' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:26:54.043' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1916, 2137, 1, N'MenuLink', N'MetaKeywords', N'Hổ trợ', CAST(N'2018-04-22T16:02:27.280' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:26:54.043' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1917, 2137, 1, N'MenuLink', N'MetaDescription', N'Hổ trợ', CAST(N'2018-04-22T16:02:27.287' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:26:54.050' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1918, 9, 1, N'SlideShow', N'Title', N'Slide 3', CAST(N'2018-05-10T14:33:03.150' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:47:38.837' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1919, 9, 2, N'SlideShow', N'Title', N'Slide 3', CAST(N'2018-05-10T14:33:10.180' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:47:38.843' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1920, 9, 3, N'SlideShow', N'Title', N'Slide 3', CAST(N'2018-05-10T14:33:10.200' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:47:38.850' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1921, 2138, 1, N'MenuLink', N'SeoUrl', N'san-pham', CAST(N'2018-05-12T16:57:37.693' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:32:17.833' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1922, 2139, 1, N'MenuLink', N'MenuName', N'Ứng dụng', CAST(N'2018-05-12T17:06:51.187' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:30:03.023' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1923, 2139, 1, N'MenuLink', N'SeoUrl', N'ung-dung', CAST(N'2018-05-12T17:06:51.220' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:30:03.027' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1924, 2139, 1, N'MenuLink', N'MetaTitle', N'Ứng dụng', CAST(N'2018-05-12T17:06:51.227' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:30:03.033' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1925, 2139, 1, N'MenuLink', N'MetaKeywords', N'Ứng dụng', CAST(N'2018-05-12T17:06:51.240' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:30:03.037' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1926, 2139, 1, N'MenuLink', N'MetaDescription', N'Ứng dụng', CAST(N'2018-05-12T17:06:51.243' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:30:03.040' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1927, 2140, 1, N'MenuLink', N'SeoUrl', N'dfd', CAST(N'2018-05-12T17:07:15.317' AS DateTime), N'Administrator', CAST(N'2018-05-12T17:07:15.317' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1928, 2140, 1, N'MenuLink', N'MetaTitle', N'dfd', CAST(N'2018-05-12T17:07:15.330' AS DateTime), N'Administrator', CAST(N'2018-05-12T17:07:15.330' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1929, 2140, 1, N'MenuLink', N'MetaKeywords', N'dfd', CAST(N'2018-05-12T17:07:15.337' AS DateTime), N'Administrator', CAST(N'2018-05-12T17:07:15.337' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1930, 2140, 1, N'MenuLink', N'MetaDescription', N'dfd', CAST(N'2018-05-12T17:07:15.340' AS DateTime), N'Administrator', CAST(N'2018-05-12T17:07:15.340' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1931, 2141, 1, N'MenuLink', N'MenuName', N'21212', CAST(N'2018-05-13T09:58:25.310' AS DateTime), N'Administrator', CAST(N'2018-05-13T09:58:25.310' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1932, 2141, 1, N'MenuLink', N'SeoUrl', N'21212', CAST(N'2018-05-13T09:58:25.320' AS DateTime), N'Administrator', CAST(N'2018-05-13T09:58:25.320' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1933, 2141, 1, N'MenuLink', N'MetaTitle', N'21212', CAST(N'2018-05-13T09:58:25.323' AS DateTime), N'Administrator', CAST(N'2018-05-13T09:58:25.323' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1934, 2141, 1, N'MenuLink', N'MetaKeywords', N'21212', CAST(N'2018-05-13T09:58:25.330' AS DateTime), N'Administrator', CAST(N'2018-05-13T09:58:25.330' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1935, 2141, 1, N'MenuLink', N'MetaDescription', N'21212', CAST(N'2018-05-13T09:58:25.337' AS DateTime), N'Administrator', CAST(N'2018-05-13T09:58:25.337' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1936, 2142, 1, N'MenuLink', N'MenuName', N'fd', CAST(N'2018-05-13T10:01:09.333' AS DateTime), N'Administrator', CAST(N'2018-05-13T10:01:09.333' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1937, 2142, 1, N'MenuLink', N'SeoUrl', N'fd', CAST(N'2018-05-13T10:01:09.370' AS DateTime), N'Administrator', CAST(N'2018-05-13T10:01:09.370' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1938, 2142, 1, N'MenuLink', N'MetaTitle', N'fd', CAST(N'2018-05-13T10:01:09.380' AS DateTime), N'Administrator', CAST(N'2018-05-13T10:01:09.380' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1939, 2142, 1, N'MenuLink', N'MetaKeywords', N'fd', CAST(N'2018-05-13T10:01:09.390' AS DateTime), N'Administrator', CAST(N'2018-05-13T10:01:09.390' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1940, 2142, 1, N'MenuLink', N'MetaDescription', N'fd', CAST(N'2018-05-13T10:01:09.397' AS DateTime), N'Administrator', CAST(N'2018-05-13T10:01:09.397' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1941, 2143, 1, N'MenuLink', N'MenuName', N'fdfdf', CAST(N'2018-05-13T10:02:40.740' AS DateTime), N'Administrator', CAST(N'2018-05-13T10:02:40.740' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1942, 2143, 1, N'MenuLink', N'SeoUrl', N'fdfdf', CAST(N'2018-05-13T10:02:40.763' AS DateTime), N'Administrator', CAST(N'2018-05-13T10:02:40.763' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1943, 2143, 1, N'MenuLink', N'MetaTitle', N'fdfdf', CAST(N'2018-05-13T10:02:40.773' AS DateTime), N'Administrator', CAST(N'2018-05-13T10:02:40.773' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1944, 2143, 1, N'MenuLink', N'MetaKeywords', N'fdfdf', CAST(N'2018-05-13T10:02:40.787' AS DateTime), N'Administrator', CAST(N'2018-05-13T10:02:40.787' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1945, 2143, 1, N'MenuLink', N'MetaDescription', N'fdfdf', CAST(N'2018-05-13T10:02:40.800' AS DateTime), N'Administrator', CAST(N'2018-05-13T10:02:40.800' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1946, 2144, 1, N'MenuLink', N'MenuName', N'fdfd', CAST(N'2018-05-13T10:03:47.913' AS DateTime), N'Administrator', CAST(N'2018-05-13T10:03:47.913' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1947, 2144, 1, N'MenuLink', N'SeoUrl', N'fdfd', CAST(N'2018-05-13T10:03:47.943' AS DateTime), N'Administrator', CAST(N'2018-05-13T10:03:47.943' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1948, 2144, 1, N'MenuLink', N'MetaTitle', N'fdfd', CAST(N'2018-05-13T10:03:47.950' AS DateTime), N'Administrator', CAST(N'2018-05-13T10:03:47.950' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1949, 2144, 1, N'MenuLink', N'MetaKeywords', N'fdfd', CAST(N'2018-05-13T10:03:47.957' AS DateTime), N'Administrator', CAST(N'2018-05-13T10:03:47.957' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1950, 2144, 1, N'MenuLink', N'MetaDescription', N'fdfd', CAST(N'2018-05-13T10:03:47.967' AS DateTime), N'Administrator', CAST(N'2018-05-13T10:03:47.967' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1951, 97, 1, N'Post', N'Title', N'Căn hộ Imperia An Phú Quận 2', CAST(N'2018-05-13T13:57:36.087' AS DateTime), N'Administrator', CAST(N'2018-05-13T13:57:36.087' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1952, 97, 1, N'Post', N'ProductCode', N'CHIAPQ22018.05.13', CAST(N'2018-05-13T13:57:36.103' AS DateTime), N'Administrator', CAST(N'2018-05-13T13:57:36.103' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1953, 97, 1, N'Post', N'ShortDesc', N'fd', CAST(N'2018-05-13T13:57:36.117' AS DateTime), N'Administrator', CAST(N'2018-05-13T13:57:36.117' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1954, 97, 1, N'Post', N'TechInfo', N'<p>fdfd</p>
', CAST(N'2018-05-13T13:57:36.123' AS DateTime), N'Administrator', CAST(N'2018-05-13T13:57:36.123' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1955, 97, 1, N'Post', N'MetaTitle', N'Căn hộ Imperia An Phú Quận 2', CAST(N'2018-05-13T13:57:36.137' AS DateTime), N'Administrator', CAST(N'2018-05-13T13:57:36.137' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1956, 97, 1, N'Post', N'MetaKeywords', N'Căn hộ Imperia An Phú Quận 2', CAST(N'2018-05-13T13:57:36.140' AS DateTime), N'Administrator', CAST(N'2018-05-13T13:57:36.140' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1957, 97, 1, N'Post', N'MetaDescription', N'Căn hộ Imperia An Phú Quận 2', CAST(N'2018-05-13T13:57:36.150' AS DateTime), N'Administrator', CAST(N'2018-05-13T13:57:36.150' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1958, 96, 1, N'Post', N'Title', N'Nhà ông Trương Công Thuận - 0937.407479', CAST(N'2018-05-13T13:58:28.930' AS DateTime), N'Administrator', CAST(N'2018-05-13T13:58:28.930' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1959, 96, 1, N'Post', N'ProductCode', N'NOTCT-02018.05.13', CAST(N'2018-05-13T13:58:28.980' AS DateTime), N'Administrator', CAST(N'2018-05-13T13:58:28.980' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1960, 96, 1, N'Post', N'MetaTitle', N'Nhà ông Trương Công Thuận - 0937.407479', CAST(N'2018-05-13T13:58:29.033' AS DateTime), N'Administrator', CAST(N'2018-05-13T13:58:29.033' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1961, 96, 1, N'Post', N'MetaKeywords', N'Nhà ông Trương Công Thuận - 0937.407479', CAST(N'2018-05-13T13:58:29.063' AS DateTime), N'Administrator', CAST(N'2018-05-13T13:58:29.063' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1962, 96, 1, N'Post', N'MetaDescription', N'Nhà ông Trương Công Thuận - 0937.407479', CAST(N'2018-05-13T13:58:29.083' AS DateTime), N'Administrator', CAST(N'2018-05-13T13:58:29.083' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1963, 63, 1, N'Post', N'Title', N'Biệt thự phố, mr Duy (0983 83 45 69)', CAST(N'2018-05-13T14:01:31.130' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:01:49.187' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1964, 63, 1, N'Post', N'ProductCode', N'BTPMD(8462018.05.13', CAST(N'2018-05-13T14:01:31.143' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:01:49.207' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1965, 63, 1, N'Post', N'MetaTitle', N'Biệt thự phố, mr Duy (0983 83 45 69)', CAST(N'2018-05-13T14:01:31.153' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:01:49.227' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1966, 63, 1, N'Post', N'MetaKeywords', N'Biệt thự phố, mr Duy (0983 83 45 69)', CAST(N'2018-05-13T14:01:31.157' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:01:49.240' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1967, 63, 1, N'Post', N'MetaDescription', N'Biệt thự phố, mr Duy (0983 83 45 69)', CAST(N'2018-05-13T14:01:31.160' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:01:49.250' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1968, 102, 1, N'Post', N'Title', N'Maecenas consequat mauris', CAST(N'2018-05-19T11:55:14.580' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:23:22.347' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1969, 102, 1, N'Post', N'ProductCode', N'MCM2018.05.19', CAST(N'2018-05-19T11:55:14.583' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:23:22.357' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1970, 102, 1, N'Post', N'MetaTitle', N'Maecenas consequat mauris', CAST(N'2018-05-19T11:55:14.593' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:23:22.370' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1971, 102, 1, N'Post', N'MetaKeywords', N'Maecenas consequat mauris', CAST(N'2018-05-19T11:55:14.597' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:23:22.373' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1972, 102, 1, N'Post', N'MetaDescription', N'Maecenas consequat mauris', CAST(N'2018-05-19T11:55:14.600' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:23:22.407' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1973, 10, 1, N'News', N'Title', N'PHỐI QUẦN JEANS CẠP CAO THEO PHONG CÁCH THẬP NIÊN 1970', CAST(N'2018-05-20T15:15:49.763' AS DateTime), N'Administrator', CAST(N'2018-05-20T15:18:24.773' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1974, 10, 1, N'News', N'ShortDesc', N'<p><strong>Quần jeans cạp cao xuất hiện từ những năm 1970 đ&atilde; quay trở lại, được nhiều t&iacute;n đồ thời trang y&ecirc;u th&iacute;ch v&agrave; phối c&aacute; t&iacute;nh theo hơi hướng hiện đại, trẻ trung.</strong></p>
', CAST(N'2018-05-20T15:15:49.773' AS DateTime), N'Administrator', CAST(N'2018-05-20T15:18:24.800' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1975, 10, 1, N'News', N'Description', N'<table align="center" class="picture" style="-webkit-font-smoothing:antialiased; background:transparent; border-collapse:collapse; border-spacing:0px; border:0px; box-sizing:border-box; color:rgb(85, 85, 85); font-family:arial,helvetica neue,helvetica,sans-serif; font-size:14px; line-height:20px; margin:14px 0px; max-width:100%; outline:0px; padding:0px; text-align:justify; text-rendering:geometricPrecision; vertical-align:baseline; width:560px">
	<tbody>
		<tr>
			<td style="vertical-align:baseline; width:870px"><img alt="Phối quần jeans cạp cao theo phong cách thập niên 1970" src="http://img.v3.news.zdn.vn/w660/Uploaded/cqxrcajwp/2016_02_24/jeans_cap_cao_4.jpg" style="background:transparent; border:0px; box-sizing:border-box; font-weight:inherit; height:auto; margin:0px; max-width:100%; outline:0px; padding:0px; text-rendering:geometricPrecision; vertical-align:baseline; width:560px" /></td>
		</tr>
		<tr>
			<td style="vertical-align:baseline; width:870px">
			<p>Quần jeans cạp cao trở n&ecirc;n chất hơn khi mix c&ugrave;ng &aacute;o kho&aacute;c bomber in tuy&ecirc;n ng&ocirc;n c&aacute; t&iacute;nh.</p>
			</td>
		</tr>
	</tbody>
</table>
', CAST(N'2018-05-20T15:15:49.780' AS DateTime), N'Administrator', CAST(N'2018-05-20T15:18:24.803' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1976, 10, 1, N'News', N'SeoUrl', N'phoi-quan-jeans-cap-cao-theo-phong-cach-thap-nien-1970', CAST(N'2018-05-20T15:15:49.783' AS DateTime), N'Administrator', CAST(N'2018-05-20T15:18:24.810' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1977, 10, 1, N'News', N'MetaTitle', N'PHỐI QUẦN JEANS CẠP CAO THEO PHONG CÁCH THẬP NIÊN 1970', CAST(N'2018-05-20T15:15:49.787' AS DateTime), N'Administrator', CAST(N'2018-05-20T15:18:24.813' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1978, 10, 1, N'News', N'MetaKeywords', N'PHỐI QUẦN JEANS CẠP CAO THEO PHONG CÁCH THẬP NIÊN 1970', CAST(N'2018-05-20T15:15:49.793' AS DateTime), N'Administrator', CAST(N'2018-05-20T15:18:24.817' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1979, 10, 1, N'News', N'MetaDescription', N'PHỐI QUẦN JEANS CẠP CAO THEO PHONG CÁCH THẬP NIÊN 1970', CAST(N'2018-05-20T15:15:49.797' AS DateTime), N'Administrator', CAST(N'2018-05-20T15:18:24.823' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1980, 11, 1, N'News', N'Title', N'Sed ut perspiciatis unde omnis iste natus error', CAST(N'2018-05-20T16:00:29.393' AS DateTime), N'Administrator', CAST(N'2018-05-22T15:09:52.757' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1981, 11, 1, N'News', N'ShortDesc', N'<p><span style="font-family:arial,sans-serif; font-size:14px">Ut tellus dolor, dapibus eget, elementum vel, cursus eleifend, elit. Aenean auctor wisi et urna. Aliquam erat volutpat. Duis ac turpis. Donec sit amet eros. Lorem ipsum dolor sit amet, consecvtetuer adipiscing elit. Mauris fermentum dictum magna. Sed laoreet aliquam leo. Ut tellus dolor, dapibus eget, elementum vel.</span></p>
', CAST(N'2018-05-20T16:00:29.407' AS DateTime), N'Administrator', CAST(N'2018-05-22T15:09:52.793' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1982, 11, 1, N'News', N'Description', N'<div class="entry-meta-data" style="box-sizing: border-box; margin: 0px; padding: 10px 0px; border: 0px; background: transparent; outline: 0px; vertical-align: top; color: rgb(102, 102, 102); font-family: Arial, sans-serif; font-size: 14px;">&nbsp;by:&nbsp;<a href="file:///E:/Theme/Kute-4/Kute-4/kute-themes.com/html/kuteshop/html/blog-detail.html#" style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; background: transparent; color: rgb(102, 102, 102); text-decoration-line: none; font-weight: inherit; vertical-align: top; outline: none !important;">Admin</a>&nbsp;&nbsp;<a href="file:///E:/Theme/Kute-4/Kute-4/kute-themes.com/html/kuteshop/html/blog-detail.html#" style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; background: transparent; color: rgb(102, 102, 102); text-decoration-line: none; font-weight: inherit; vertical-align: top; outline: none !important;">News,&nbsp;</a><a href="file:///E:/Theme/Kute-4/Kute-4/kute-themes.com/html/kuteshop/html/blog-detail.html#" style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; background: transparent; color: rgb(102, 102, 102); text-decoration-line: none; font-weight: inherit; vertical-align: top; outline: none !important;">Promotions</a>&nbsp;&nbsp;3&nbsp;&nbsp;2014-08-05 07:01:49&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(7 votes)</div>

<div class="entry-photo" style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; background: transparent; outline: 0px; vertical-align: top; font-family: Arial, sans-serif; font-size: 14px;"><img alt="Blog" src="file:///E:/Theme/Kute-4/Kute-4/kute-themes.com/html/kuteshop/html/assets/data/blog-full.jpg" style="background:transparent; border:1px solid rgb(234, 234, 234); box-sizing:border-box; font-weight:inherit; margin:0px; max-width:100%; outline:0px; padding:0px; vertical-align:top" /></div>

<div class="content-text clearfix" style="box-sizing: border-box; margin: 0px; padding: 20px 0px; border: 0px; background: transparent; outline: 0px; vertical-align: top; text-align: justify; font-family: Arial, sans-serif; font-size: 14px;">
<p>Ut tellus dolor, dapibus eget, elementum vel, cursus eleifend, elit. Aenean auctor wisi et urna. Aliquam erat volutpat. Duis ac turpis. Donec sit amet eros. Lorem ipsum dolor sit amet, consecvtetuer adipiscing elit. Mauris fermentum dictum magna. Sed laoreet aliquam leo. Ut tellus dolor, dapibus eget, elementum vel.</p>

<p>Aenean auctor wisi et urna. Aliquam erat volutpat. Duis ac turpis. Integer rutrum ante eu lacus. Vestibulum libero nisl, porta vel, scelerisque eget, malesuada at, neque. Vivamus eget nibh. Etiam cursus leo vel metus. Nulla facilisi. Aenean nec eros.</p>

<p>Integer rutrum ante eu lacus.Vestibulum libero nisl, porta vel, scelerisque eget,&nbsp;<a href="file:///E:/Theme/Kute-4/Kute-4/kute-themes.com/html/kuteshop/html/blog-detail.html#" style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; background: transparent; color: rgb(102, 102, 102); text-decoration-line: none; font-weight: inherit; vertical-align: top; outline: none !important;">malesuada at</a>, neque. Vivamus eget nibh. Etiam cursus leo vel metus. Nulla facilisi. Aenean nec eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse sollicitudin velit sed leo. Ut pharetra augue nec augue.</p>

<p>Nam elit agna,endrerit sit amet, tincidunt ac, viverra sed, nulla. Donec porta diam eu massa. Quisque diam lorem, interdum vitae,dapibus ac, scelerisque vitae, pede. Donec eget tellus non erat lacinia fermentum. Donec in velit vel ipsum auctor pulvinar. Vestibulum iaculis lacinia est. Proin dictum elementum velit. Fusce euismod consequat ante. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Pellentesque sed dolor. Aliquam congue fermentum nisl.</p>

<p>Aenean auctor wisi et urna. Aliquam erat volutpat. Duis ac turpis. Integer rutrum ante eu lacus. Vestibulum libero nisl, porta vel, scelerisque eget, malesuada at, neque. Vivamus eget nibh. Etiam cursus leo vel metus. Nulla facilisi. Aenean nec eros.</p>

<p>Integer rutrum ante eu lacus.Vestibulum libero nisl, porta vel, scelerisque eget,&nbsp;<a href="file:///E:/Theme/Kute-4/Kute-4/kute-themes.com/html/kuteshop/html/blog-detail.html#" style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; background: transparent; color: rgb(102, 102, 102); text-decoration-line: none; font-weight: inherit; vertical-align: top; outline: none !important;">malesuada at</a>, neque. Vivamus eget nibh. Etiam cursus leo vel metus. Nulla facilisi. Aenean nec eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse sollicitudin velit sed leo. Ut pharetra augue nec augue.</p>
</div>
', CAST(N'2018-05-20T16:00:29.410' AS DateTime), N'Administrator', CAST(N'2018-05-22T15:09:52.807' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1983, 11, 1, N'News', N'SeoUrl', N'sed-ut-perspiciatis-unde-omnis-iste-natus-error', CAST(N'2018-05-20T16:00:29.420' AS DateTime), N'Administrator', CAST(N'2018-05-22T15:09:52.813' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1984, 11, 1, N'News', N'MetaTitle', N'Sed ut perspiciatis unde omnis iste natus error', CAST(N'2018-05-20T16:00:29.427' AS DateTime), N'Administrator', CAST(N'2018-05-22T15:09:52.827' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1985, 11, 1, N'News', N'MetaKeywords', N'Sed ut perspiciatis unde omnis iste natus error', CAST(N'2018-05-20T16:00:29.427' AS DateTime), N'Administrator', CAST(N'2018-05-22T15:09:52.857' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1986, 11, 1, N'News', N'MetaDescription', N'Sed ut perspiciatis unde omnis iste natus error', CAST(N'2018-05-20T16:00:29.430' AS DateTime), N'Administrator', CAST(N'2018-05-22T15:09:52.863' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2000, 21, 1, N'StaticContent', N'Title', N'Giá trị lớn của sản phẩm', CAST(N'2018-05-24T16:02:03.670' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:23:56.727' AS DateTime), N'Administrator')
GO
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2001, 21, 1, N'StaticContent', N'SeoUrl', N'gia-tri-lon-cua-san-pham', CAST(N'2018-05-24T16:02:03.773' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:23:56.733' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2002, 21, 1, N'StaticContent', N'MetaTitle', N'Giá trị lớn của sản phẩm', CAST(N'2018-05-24T16:02:03.840' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:23:56.740' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2003, 21, 1, N'StaticContent', N'MetaKeywords', N'Giá trị lớn của sản phẩm', CAST(N'2018-05-24T16:02:03.887' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:23:56.743' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2004, 21, 1, N'StaticContent', N'MetaDescription', N'Giá trị lớn của sản phẩm', CAST(N'2018-05-24T16:02:03.927' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:23:56.747' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2005, 21, 1, N'StaticContent', N'ShortDesc', N'<p>fdsafas</p>
', CAST(N'2018-05-24T16:18:43.380' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:23:56.730' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2006, 21, 1, N'StaticContent', N'Description', N'<p>fdsafasdf</p>
', CAST(N'2018-05-24T16:18:43.500' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:23:56.733' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2007, 41, 1, N'MenuLink', N'MenuName', N'Chính sách bảo hành', CAST(N'2018-05-25T14:07:50.350' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:07:50.350' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2008, 41, 1, N'MenuLink', N'SeoUrl', N'chinh-sach-bao-hanh', CAST(N'2018-05-25T14:07:50.360' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:07:50.360' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2009, 41, 1, N'MenuLink', N'MetaTitle', N'Chính sách bảo hành', CAST(N'2018-05-25T14:07:50.363' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:07:50.363' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2010, 41, 1, N'MenuLink', N'MetaKeywords', N'Chính sách bảo hành', CAST(N'2018-05-25T14:07:50.370' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:07:50.370' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2011, 41, 1, N'MenuLink', N'MetaDescription', N'Chính sách bảo hành', CAST(N'2018-05-25T14:07:50.373' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:07:50.373' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2012, 43, 1, N'MenuLink', N'MenuName', N'Hướng dẫn đổi trả', CAST(N'2018-05-25T14:08:05.837' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:08:05.837' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2013, 43, 1, N'MenuLink', N'SeoUrl', N'huong-dan-doi-tra', CAST(N'2018-05-25T14:08:05.847' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:08:05.847' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2014, 43, 1, N'MenuLink', N'MetaTitle', N'Hướng dẫn đổi trả', CAST(N'2018-05-25T14:08:05.850' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:08:05.850' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2015, 43, 1, N'MenuLink', N'MetaKeywords', N'Hướng dẫn đổi trả', CAST(N'2018-05-25T14:08:05.853' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:08:05.853' AS DateTime), N'Administrator')
INSERT [dbo].[LocalizedProperty] ([Id], [EntityId], [LanguageId], [LocaleKeyGroup], [LocaleKey], [LocaleValue], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2016, 43, 1, N'MenuLink', N'MetaDescription', N'Hướng dẫn đổi trả', CAST(N'2018-05-25T14:08:05.860' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:08:05.860' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[LocalizedProperty] OFF
SET IDENTITY_INSERT [dbo].[Manufacturer] ON 

INSERT [dbo].[Manufacturer] ([Id], [Title], [OtherLink], [Description], [Status], [OrderDisplay], [ImageUrl], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (5, N'Sony', NULL, NULL, 1, 1, N'images/post/tiep-nhan-thong-tin-1.jpg', CAST(N'2017-04-25T11:37:56.760' AS DateTime), N'Administrator', CAST(N'2018-02-24T04:15:31.917' AS DateTime), N'Administrator')
INSERT [dbo].[Manufacturer] ([Id], [Title], [OtherLink], [Description], [Status], [OrderDisplay], [ImageUrl], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (6, N'Nokia', NULL, NULL, 1, 2, N'images/post/thong-bao-tinh-trang-1.jpg', CAST(N'2017-04-25T11:38:53.667' AS DateTime), N'Administrator', CAST(N'2018-02-24T04:15:25.600' AS DateTime), N'Administrator')
INSERT [dbo].[Manufacturer] ([Id], [Title], [OtherLink], [Description], [Status], [OrderDisplay], [ImageUrl], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (7, N'SamSung', NULL, NULL, 1, 3, N'images/post/tien-hanh-sua-chua-1.jpg', CAST(N'2017-04-25T11:39:19.673' AS DateTime), N'Administrator', CAST(N'2018-02-24T04:15:20.260' AS DateTime), N'Administrator')
INSERT [dbo].[Manufacturer] ([Id], [Title], [OtherLink], [Description], [Status], [OrderDisplay], [ImageUrl], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (12, N'Apple', NULL, N'<p>Shop b&aacute;n đồ đẹp, mẫu m&atilde; đa dạng gi&aacute; cả ok, nh&acirc;n vi&ecirc;n tư vấn rất nhiệt t&igrave;nh , ch&agrave;o đ&oacute;n kh&aacute;ch vui vẻ. Mặc rộng chật vẫn mang đổi size lại được khi c&ograve;n tem ❤️</p>

<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Dự l&agrave; sẽ ủng hộ Mazzola d&agrave;i d&agrave;i&nbsp;</p>
', 1, 4, N'images/flowstep/tra-san-pham.jpg', CAST(N'2017-04-25T11:46:58.460' AS DateTime), N'Administrator', CAST(N'2018-02-24T04:15:11.860' AS DateTime), N'Administrator')
INSERT [dbo].[Manufacturer] ([Id], [Title], [OtherLink], [Description], [Status], [OrderDisplay], [ImageUrl], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (13, N'HTC', NULL, NULL, 1, 0, N'images/manufacture/htc-6f1fc3ae-0334-4151-8dcc-509342ed5ae7.jpg', CAST(N'2018-03-06T15:46:56.367' AS DateTime), N'Administrator', CAST(N'2018-03-06T15:51:27.330' AS DateTime), N'Administrator')
INSERT [dbo].[Manufacturer] ([Id], [Title], [OtherLink], [Description], [Status], [OrderDisplay], [ImageUrl], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (14, N'SamSung', NULL, NULL, 1, 3, N'images/manufacture/samsung-bea88442-a13e-456a-998f-f586ce31f4b4.jpg', CAST(N'2018-04-03T15:45:33.190' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:49:35.013' AS DateTime), N'Administrator')
INSERT [dbo].[Manufacturer] ([Id], [Title], [OtherLink], [Description], [Status], [OrderDisplay], [ImageUrl], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (15, N'Nokia', NULL, NULL, 1, 2, N'images/post/thong-bao-tinh-trang-1.jpg', CAST(N'2018-04-14T15:54:15.450' AS DateTime), N'truong thanh cong', CAST(N'2018-04-14T15:54:15.450' AS DateTime), N'truong thanh cong')
SET IDENTITY_INSERT [dbo].[Manufacturer] OFF
SET IDENTITY_INSERT [dbo].[MenuLink] ON 

INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (3, 2131, N'c52e52e6-e13f-4830-9347-550ee86fbf7d', N'ca19fb4a-10a1-4515-bdb2-0c091b4107d5/c52e52e6-e13f-4830-9347-550ee86fbf7d', N'Áo sơ mi', 1, 0, 5, 2, NULL, 2, NULL, N'ao-so-mi', N'thoi-trang/ao-so-mi', N'Áo sơ mi', N'Áo sơ mi', N'Áo sơ mi', 1, 1, CAST(N'2017-02-20T05:44:41.357' AS DateTime), N'Administrator', CAST(N'2018-03-06T16:25:44.763' AS DateTime), N'Administrator', 1, N'images/ao-so-mi.jpg', NULL, NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (5, NULL, N'5c845240-517d-4592-acd4-15773d9344a0', N'5c845240-517d-4592-acd4-15773d9344a0', N'Phụ kiện công nghệ', 1, 0, 5, 2, NULL, 4, NULL, N'phu-kien-cong-nghe', NULL, N'Phụ kiện công nghệ', N'Phụ kiện công nghệ', N'Phụ kiện công nghệ', 1, 1, CAST(N'2017-02-20T06:55:59.577' AS DateTime), N'Administrator', CAST(N'2018-04-11T15:47:10.913' AS DateTime), N'Administrator', 1, N'images/menu/phu-kien-cong-nghe.png', N'images/menu/phu-kien-cong-nghe-icon.png', N'images/menu/phu-kien-cong-nghe-iconbar.png', N'#d93838')
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (21, 37, N'ab6eefb0-c074-4799-8637-64a6aa57dd9f', N'8d49acae-84c0-44e4-8da5-96b550cbc90a/ab6eefb0-c074-4799-8637-64a6aa57dd9f', N'Hướng dẫn mua hàng', 1, 0, 2, 6, NULL, 35, NULL, N'huong-dan-mua-hang', N'tro-giup/huong-dan-mua-hang', N'Hướng dẫn mua hàng', N'Hướng dẫn mua hàng', N'Hướng dẫn mua hàng', 1, 1, CAST(N'2017-02-20T09:24:24.193' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:08:20.753' AS DateTime), N'Administrator', 1, N'images/sua-iphone.png', N'images/sua-iphone-icon.png', N'images/sua-iphone-iconbar.png', NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (37, NULL, N'8d49acae-84c0-44e4-8da5-96b550cbc90a', N'8d49acae-84c0-44e4-8da5-96b550cbc90a', N'Trợ giúp', 1, 0, 2, 5, NULL, 5, NULL, N'tro-giup', NULL, N'Trợ giúp', N'Trợ giúp', N'Trợ giúp', 0, 1, CAST(N'2017-02-20T09:42:32.303' AS DateTime), N'Administrator', CAST(N'2018-05-24T14:47:22.887' AS DateTime), N'Administrator', 1, N'images/thong-tin-chung.png', N'images/thong-tin-chung-icon.png', N'images/thong-tin-chung-iconbar.png', NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (41, 37, N'4f5b93c2-4ab0-4bd5-9c61-16a9c9fc5d5d', N'8d49acae-84c0-44e4-8da5-96b550cbc90a/4f5b93c2-4ab0-4bd5-9c61-16a9c9fc5d5d', N'Chính sách bảo hành', 1, 0, 2, 5, NULL, 14, NULL, N'chinh-sach-bao-hanh', N'tro-giup/chinh-sach-bao-hanh', N'Chính sách bảo hành', N'Chính sách bảo hành', N'Chính sách bảo hành', 0, 1, CAST(N'2017-02-20T09:49:04.943' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:07:50.320' AS DateTime), N'Administrator', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (43, 37, N'55aabaf4-b1bc-4269-a2fe-6b8981abe207', N'8d49acae-84c0-44e4-8da5-96b550cbc90a/55aabaf4-b1bc-4269-a2fe-6b8981abe207', N'Hướng dẫn đổi trả', 1, 0, 2, 5, NULL, 25, NULL, N'huong-dan-doi-tra', N'tro-giup/huong-dan-doi-tra', N'Hướng dẫn đổi trả', N'Hướng dẫn đổi trả', N'Hướng dẫn đổi trả', 0, 1, CAST(N'2017-02-20T09:50:13.287' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:08:05.820' AS DateTime), N'Administrator', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (45, 1110, N'5ff97ccf-29d4-47d2-82d9-9d217119a68d', N'f9b39a11-c9b9-4cba-a58e-54713a9f53c2/5ff97ccf-29d4-47d2-82d9-9d217119a68d', N'Giới thiệu', 1, 0, 2, 5, NULL, 1, NULL, N'gioi-thieu', N've-goweb/gioi-thieu', N'Giới thiệu', N'Giới thiệu', N'Giới thiệu', 1, 1, CAST(N'2017-02-20T09:52:17.147' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:09:30.317' AS DateTime), N'Administrator', 1, N'images/gioi-thieu.png', NULL, NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (50, 49, N'e55bb987-554f-4137-82c3-2ad16c97396d', N'3fe8605a-3044-42ca-8755-73f565403ef4/e55bb987-554f-4137-82c3-2ad16c97396d', N'Buổi sáng', 1, 0, 2, 5, NULL, 6, NULL, N'buoi-sang', N'gio-lam-viec/buoi-sang', N'Điện thoại', N'Điện thoại', N'Điện thoại', 0, 1, CAST(N'2017-02-20T10:05:44.913' AS DateTime), N'Administrator', CAST(N'2017-06-05T16:22:20.880' AS DateTime), N'Administrator', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (110, NULL, N'34c7a8cc-5b53-4c8c-ab6c-22f2e2f5f57d', N'34c7a8cc-5b53-4c8c-ab6c-22f2e2f5f57d', N'Tin tức', 1, 0, 1, 1, NULL, 3, NULL, N'tin-tuc', NULL, N'Tin tức', N'Tin tức', N'Tin tức', 1, 1, CAST(N'2017-04-18T11:32:54.657' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:27.570' AS DateTime), N'Administrator', 1, N'images/truyen-thong.jpg', N'images/tin-tuc-icon.png', N'images/tin-tuc-iconbar.png', NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (1110, NULL, N'f9b39a11-c9b9-4cba-a58e-54713a9f53c2', N'f9b39a11-c9b9-4cba-a58e-54713a9f53c2', N'Về GoWeb', 1, 0, 2, 6, NULL, 4, NULL, N've-goweb', NULL, N'Về GoWeb', N'Về GoWeb', N'Về GoWeb', 1, 1, CAST(N'2017-05-05T10:40:03.660' AS DateTime), N'Administrator', CAST(N'2018-05-13T10:05:21.757' AS DateTime), N'Administrator', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (1111, 1110, N'84910c68-7cd6-49f6-b13f-ac223447de1c', N'f9b39a11-c9b9-4cba-a58e-54713a9f53c2/84910c68-7cd6-49f6-b13f-ac223447de1c', N'Tuyển Dụng', 1, 0, 7, 6, NULL, 0, NULL, N'tuyen-dung', N've-goweb/tuyen-dung', N'Tuyển Dụng', N'Tuyển Dụng', N'Tuyển Dụng', 1, 1, CAST(N'2017-05-05T11:17:53.790' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:16:21.630' AS DateTime), N'Administrator', 1, N'images/menu/tuyen-dung.png', N'images/menu/tuyen-dung-icon.png', N'images/menu/tuyen-dung-iconbar.png', NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (1115, 110, N'c806af4b-3f03-4f97-9f45-3a1e82fdb89d', N'34c7a8cc-5b53-4c8c-ab6c-22f2e2f5f57d/c806af4b-3f03-4f97-9f45-3a1e82fdb89d', N'Nội thất phong thủy', 1, 0, 1, 1, NULL, 1, NULL, N'noi-that-phong-thuy', N'tin-tuc-1/noi-that-phong-thuy', N'Nội thất phong thủy', N'Nội thất phong thủy', N'Nội thất phong thủy', 0, 1, CAST(N'2017-06-17T10:30:41.413' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:33:48.840' AS DateTime), N'Administrator', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (2115, 110, N'1454749a-6eef-42da-9787-57de166f8099', N'34c7a8cc-5b53-4c8c-ab6c-22f2e2f5f57d/1454749a-6eef-42da-9787-57de166f8099', N'Không gian xanh', 1, 0, 1, 1, NULL, 0, N'1', N'khong-gian-xanh', N'tin-tuc-1/khong-gian-xanh', N'Không gian xanh', N'Không gian xanh', N'Không gian xanh', 1, 1, CAST(N'2017-06-17T14:08:38.077' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:59:18.460' AS DateTime), N'Administrator', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (2120, 1110, N'f9dd567c-5916-470f-a1ba-09dc3347c81b', N'f9dd567c-5916-470f-a1ba-09dc3347c81b', N'Liên hệ', 1, 0, 7, 3, NULL, 1, NULL, N'lien-he', NULL, N'Liên hệ', N'Liên hệ', N'Liên hệ', 1, 1, CAST(N'2017-06-18T12:06:46.767' AS DateTime), N'Administrator', CAST(N'2018-05-12T16:30:54.683' AS DateTime), N'Administrator', 1, NULL, N'images/menu/lien-he-icon.png', N'images/menu/lien-he-iconbar.png', NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (2121, 5, N'8bf654a9-edcd-47ac-8d86-3d95fb58752c', N'5c845240-517d-4592-acd4-15773d9344a0/8bf654a9-edcd-47ac-8d86-3d95fb58752c', N'Resort', 1, 0, 5, 2, NULL, 1, NULL, N'resort-2', N'phu-kien-cong-nghe/resort-2', N'Resort', N'Resort', N'Resort', 0, 1, CAST(N'2017-06-18T14:44:47.297' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:18:22.803' AS DateTime), N'Administrator', 0, N'images/resort.jpg', NULL, NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (2122, 5, N'6c64d3e8-dd86-4dcc-a4ea-2b340e86051c', N'5c845240-517d-4592-acd4-15773d9344a0/6c64d3e8-dd86-4dcc-a4ea-2b340e86051c', N'Quy hoạch đô thị', 1, 0, 1, 2, NULL, 1, NULL, N'quy-hoach-do-thi', N'phu-kien-cong-nghe/quy-hoach-do-thi', N'Quy hoạch đô thị', N'Quy hoạch đô thị', N'Quy hoạch đô thị', 1, 0, CAST(N'2017-06-18T14:52:32.527' AS DateTime), N'Administrator', CAST(N'2018-05-13T10:05:43.623' AS DateTime), N'Administrator', 0, N'images/quy-hoach-do-thi.jpg', NULL, NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (2123, NULL, N'02daa37c-7c68-46e0-ba22-929126ba4b48', N'02daa37c-7c68-46e0-ba22-929126ba4b48', N'Trang chủ', 1, 0, 1, 2, NULL, 0, N'/', N'trang-chu', N'trang-chu/trang-chu', N'Trang chủ', N'Trang chủ', N'Trang chủ', 0, 1, CAST(N'2017-06-18T15:05:37.040' AS DateTime), N'Administrator', CAST(N'2018-05-12T15:56:02.903' AS DateTime), N'Administrator', 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (2126, 2131, N'7f1600ec-deec-426c-a926-95178701ae42', N'ca19fb4a-10a1-4515-bdb2-0c091b4107d5/7f1600ec-deec-426c-a926-95178701ae42', N'Áo khoác', 1, 0, 5, 2, NULL, 0, NULL, N'ao-khoac', N'thoi-trang/ao-khoac', N'Áo khoác', N'Áo khoác', N'Áo khoác', 1, 1, CAST(N'2017-10-14T12:23:17.060' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:14:08.263' AS DateTime), N'Administrator', 1, N'images/ao-khoac.jpg', N'images/menu/2018.AK/banner-product1.d8d8fa26.jpg', NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (2127, 2131, N'9e77cd8f-b733-4fbb-9f7c-27384b46fd4b', N'ca19fb4a-10a1-4515-bdb2-0c091b4107d5/9e77cd8f-b733-4fbb-9f7c-27384b46fd4b', N'Quần tây', 1, 0, 5, 2, NULL, 0, NULL, N'quan-tay', N'thoi-trang/quan-tay', N'Quần tây', N'Quần tây', N'Quần tây', 1, 1, CAST(N'2017-10-14T12:24:01.997' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:14:52.877' AS DateTime), N'Administrator', 1, N'images/quan-tay.jpg', N'images/menu/2018.QT/20171226145615-0fcb_wm.17a95b49.jpg', NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (2128, 2131, N'df629d2a-445a-44da-8893-ed4ecebb40e7', N'ca19fb4a-10a1-4515-bdb2-0c091b4107d5/df629d2a-445a-44da-8893-ed4ecebb40e7', N'Biệt thự', 1, 0, 5, 2, NULL, 0, NULL, N'biet-thu', N'thoi-trang/biet-thu', N'Biệt thự', N'Biệt thự', N'Biệt thự', 1, 1, CAST(N'2017-10-14T12:24:33.647' AS DateTime), N'Administrator', CAST(N'2018-02-16T08:19:55.923' AS DateTime), N'Administrator', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (2129, 2131, N'a4b261d6-2be8-49c5-889f-5f7b8dadf2d9', N'ca19fb4a-10a1-4515-bdb2-0c091b4107d5/a4b261d6-2be8-49c5-889f-5f7b8dadf2d9', N'Văn phòng', 1, 0, 1, 2, NULL, 0, NULL, N'van-phong', N'cong-trinh/van-phong', N'Văn phòng', N'Văn phòng', N'Văn phòng', 0, 1, CAST(N'2017-10-14T12:31:05.560' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:31:05.560' AS DateTime), N'Administrator', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (2130, 5, N'101e8a73-41c0-4f3a-8089-dfabdfaa34cf', N'5c845240-517d-4592-acd4-15773d9344a0/101e8a73-41c0-4f3a-8089-dfabdfaa34cf', N'Quy hoạch khác', 1, 0, 1, 2, NULL, 0, NULL, N'quy-hoach-khac', N'quy-hoach/quy-hoach-khac', N'Quy hoạch khác', N'Quy hoạch khác', N'Quy hoạch khác', 0, 1, CAST(N'2017-10-14T12:32:15.193' AS DateTime), N'Administrator', CAST(N'2017-10-14T12:32:15.193' AS DateTime), N'Administrator', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (2131, NULL, N'ca19fb4a-10a1-4515-bdb2-0c091b4107d5', N'ca19fb4a-10a1-4515-bdb2-0c091b4107d5', N'Thời trang', 1, 0, 5, 2, NULL, 2, NULL, N'thoi-trang', NULL, N'Thời trang', N'Thời trang', N'Thời trang', 1, 1, CAST(N'2018-04-03T15:45:33.060' AS DateTime), N'Administrator', CAST(N'2018-05-13T14:02:49.120' AS DateTime), N'Administrator', 1, N'images/menu/2018.TT/slide.c88a824f.jpg', N'images/menu/2018.TT/slide.f7479112.jpg', N'images/menu/thoi-trang-iconbar.png', N'#b35858')
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (2132, 2131, N'c52e52e6-e13f-4830-9347-550ee86fbf7d', N'ca19fb4a-10a1-4515-bdb2-0c091b4107d5/c52e52e6-e13f-4830-9347-550ee86fbf7d', N'Chân váy', 1, 0, 5, 2, NULL, 2, NULL, N'chan-vay', N'thoi-trang/chan-vay', N'Chân váy', N'Chân váy', N'Chân váy', 1, 1, CAST(N'2018-04-03T15:45:33.060' AS DateTime), N'Administrator', CAST(N'2018-04-11T16:19:13.953' AS DateTime), N'Administrator', 1, N'images/menu/12.jpg', NULL, NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (2134, 2133, N'8bf654a9-edcd-47ac-8d86-3d95fb58752c', N'5c845240-517d-4592-acd4-15773d9344a0/8bf654a9-edcd-47ac-8d86-3d95fb58752c', N'Resort', 1, 0, 1, 2, NULL, 1, NULL, N'resort', N'phu-kien-cong-nghe/resort', N'Resort', N'Resort', N'Resort', 0, 1, CAST(N'2018-04-03T15:45:33.190' AS DateTime), N'Administrator', CAST(N'2018-04-03T15:45:33.190' AS DateTime), N'Administrator', 0, N'images/resort.jpg', NULL, NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (2135, NULL, N'310f945c-a560-4eb0-b4d5-4aa1ef36dd18', N'310f945c-a560-4eb0-b4d5-4aa1ef36dd18', N'Dịch vụ', 1, 0, 1, 6, NULL, 5, NULL, N'dich-vu', N'tro-giup/dich-vu', N'Dịch vụ', N'Dịch vụ', N'Dịch vụ', 0, 0, CAST(N'2018-05-24T14:46:55.177' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:39:14.640' AS DateTime), N'Administrator', 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (2136, 2135, N'20267e8f-bfd8-4b28-bc94-ff33896d67fd', N'8d49acae-84c0-44e4-8da5-96b550cbc90a/310f945c-a560-4eb0-b4d5-4aa1ef36dd18/20267e8f-bfd8-4b28-bc94-ff33896d67fd', N'Giá trị lớn', 1, 0, 1, 6, NULL, 1, NULL, N'gia-tri-lon', N'dich-vu/gia-tri-lon', N'Giá trị lớn', N'Giá trị lớn', N'Giá trị lớn', 0, 0, CAST(N'2018-05-25T14:29:41.790' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:24:26.617' AS DateTime), N'Administrator', 0, NULL, N'images/menu/2018.GTL/icon-s6-1.d09aa33b.png', N'images/menu/2018.GTL/icon-s6.86efa760.png', NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (2137, 2135, N'579d1240-5537-4149-a6eb-3c5a0ca7e355', N'8d49acae-84c0-44e4-8da5-96b550cbc90a/310f945c-a560-4eb0-b4d5-4aa1ef36dd18/579d1240-5537-4149-a6eb-3c5a0ca7e355', N'Hổ trợ', 1, 0, 1, 6, NULL, 1, NULL, N'ho-tro', N'dich-vu/ho-tro', N'Hổ trợ', N'Hổ trợ', N'Hổ trợ', 0, 0, CAST(N'2018-05-25T16:25:57.400' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:27:02.557' AS DateTime), N'Administrator', 0, NULL, N'images/menu/2018.HT/icon-s1-1.f2050fc4.png', NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (2138, 2135, N'08049607-16d6-4993-b774-eefd30019eb6', N'8d49acae-84c0-44e4-8da5-96b550cbc90a/310f945c-a560-4eb0-b4d5-4aa1ef36dd18/08049607-16d6-4993-b774-eefd30019eb6', N'Sản phẩm', 1, 0, 1, 6, NULL, 0, NULL, N'san-pham', N'dich-vu/san-pham', N'Sản phẩm', N'Sản phẩm', N'Sản phẩm', 0, 0, CAST(N'2018-05-25T16:29:21.073' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:32:17.773' AS DateTime), N'Administrator', 0, NULL, N'images/menu/2018.SPCHBHTTQ/icon-s1-1.47080eae.png', NULL, NULL)
INSERT [dbo].[MenuLink] ([Id], [ParentId], [CurrentVirtualId], [VirtualId], [MenuName], [Status], [TypeMenu], [Position], [TemplateType], [Language], [OrderDisplay], [SourceLink], [SeoUrl], [VirtualSeoUrl], [MetaKeywords], [MetaTitle], [MetaDescription], [DisplayOnHomePage], [DisplayOnMenu], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [DisplayOnSearch], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [ColorHex]) VALUES (2139, 2135, N'f883adaf-d19c-4eb9-929c-4fbaed2dfa01', N'8d49acae-84c0-44e4-8da5-96b550cbc90a/310f945c-a560-4eb0-b4d5-4aa1ef36dd18/f883adaf-d19c-4eb9-929c-4fbaed2dfa01', N'Ứng dụng', 1, 0, 1, 6, NULL, 1, NULL, N'ung-dung', N'dich-vu/ung-dung', N'Ứng dụng', N'Ứng dụng', N'Ứng dụng', 0, 0, CAST(N'2018-05-25T16:30:03.020' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:30:03.020' AS DateTime), N'Administrator', 0, NULL, N'images/menu/2018.UD/icon-s4.8e5bea97.png', NULL, NULL)
SET IDENTITY_INSERT [dbo].[MenuLink] OFF
SET IDENTITY_INSERT [dbo].[News] ON 

INSERT [dbo].[News] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [Video], [VideoLink], [OtherLink], [ShortDesc], [Description], [Status], [OrderDisplay], [SpecialDisplay], [HomeDisplay], [ViewCount], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [VirtualCatUrl], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (4, 2115, N'34c7a8cc-5b53-4c8c-ab6c-22f2e2f5f57d/1454749a-6eef-42da-9787-57de166f8099', NULL, N'Diện váy xẻ cao quyến rũ như Miranda Kerr', 0, NULL, NULL, NULL, NULL, 1, 5, 1, 1, 0, N'Diện váy xẻ cao quyến rũ như Miranda Kerr', N'Diện váy xẻ cao quyến rũ như Miranda Kerr', N'Diện váy xẻ cao quyến rũ như Miranda Kerr', N'dien-vay-xe-cao-quyen-ru-nhu-miranda-kerr', N'tin-tuc-1/khong-gian-xanh', N'images/news/18022018/dien-vay-xe-cao-quyen-ru-nhu-miranda-kerr.jpg', N'images/news/18022018/dien-vay-xe-cao-quyen-ru-nhu-miranda-kerr-a3a5bc99-c088-4cf2-a0a2-2777be6229b0.jpg', N'images/news/18022018/dien-vay-xe-cao-quyen-ru-nhu-miranda-kerr-592edb4c-acb0-46db-9a8f-1c198b32490a.jpg', CAST(N'2017-04-04T09:41:18.013' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:26:23.917' AS DateTime), N'Administrator')
INSERT [dbo].[News] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [Video], [VideoLink], [OtherLink], [ShortDesc], [Description], [Status], [OrderDisplay], [SpecialDisplay], [HomeDisplay], [ViewCount], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [VirtualCatUrl], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (5, 1115, N'34c7a8cc-5b53-4c8c-ab6c-22f2e2f5f57d/c806af4b-3f03-4f97-9f45-3a1e82fdb89d', NULL, N'Những chiếc vòng cổ tạo đẳng cấp cho sao ngoại trên thảm đỏ', 0, NULL, NULL, NULL, NULL, 1, 1, 0, 1, 0, N'Những chiếc vòng cổ tạo đẳng cấp cho sao ngoại trên thảm đỏ', N'Những chiếc vòng cổ tạo đẳng cấp cho sao ngoại trên thảm đỏ', N'Những chiếc vòng cổ tạo đẳng cấp cho sao ngoại trên thảm đỏ', N'nhung-chiec-vong-co-tao-dang-cap-cho-sao-ngoai-tren-tham-do', N'tin-tuc-1/noi-that-phong-thuy', N'images/news/18022018/nhung-chiec-vong-co-tao-dang-cap-cho-sao-ngoai-tren-tham-do.jpg', N'images/news/18022018/nhung-chiec-vong-co-tao-dang-cap-cho-sao-ngoai-tren-tham-do-bb100780-14ef-41d6-bf63-a00e497c9b14.jpg', N'images/news/18022018/nhung-chiec-vong-co-tao-dang-cap-cho-sao-ngoai-tren-tham-do-a9d0252a-93fb-4f1f-85e3-73af7cdb41fd.jpg', CAST(N'2017-06-18T14:41:08.403' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:25:30.937' AS DateTime), N'Administrator')
INSERT [dbo].[News] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [Video], [VideoLink], [OtherLink], [ShortDesc], [Description], [Status], [OrderDisplay], [SpecialDisplay], [HomeDisplay], [ViewCount], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [VirtualCatUrl], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (6, 1115, N'34c7a8cc-5b53-4c8c-ab6c-22f2e2f5f57d/c806af4b-3f03-4f97-9f45-3a1e82fdb89d', NULL, N'20 bộ váy đẹp của các diễn viên từng đoạt giải Oscar', 0, NULL, NULL, NULL, NULL, 1, 1, 0, 1, 0, N'20 bộ váy đẹp của các diễn viên từng đoạt giải Oscar', N'20 bộ váy đẹp của các diễn viên từng đoạt giải Oscar', N'20 bộ váy đẹp của các diễn viên từng đoạt giải Oscar', N'20-bo-vay-dep-cua-cac-dien-vien-tung-doat-giai-oscar', N'tin-tuc-1/noi-that-phong-thuy', N'images/news/18022018/20-bo-vay-dep-cua-cac-dien-vien-tung-doat-giai-oscar.jpg', N'images/news/18022018/20-bo-vay-dep-cua-cac-dien-vien-tung-doat-giai-oscar-40928b16-34ff-4f76-a22d-25ef2df85bda.jpg', N'images/news/18022018/20-bo-vay-dep-cua-cac-dien-vien-tung-doat-giai-oscar-431f0917-82dd-4244-8f1b-445b60e55016.jpg', CAST(N'2017-06-19T13:36:27.530' AS DateTime), N'Administrator', CAST(N'2018-02-18T09:24:39.613' AS DateTime), N'Administrator')
INSERT [dbo].[News] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [Video], [VideoLink], [OtherLink], [ShortDesc], [Description], [Status], [OrderDisplay], [SpecialDisplay], [HomeDisplay], [ViewCount], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [VirtualCatUrl], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (9, 2115, N'34c7a8cc-5b53-4c8c-ab6c-22f2e2f5f57d/1454749a-6eef-42da-9787-57de166f8099', NULL, N'CHẤT BÉO CÓ THỰC SỰ LÀ KẺ THÙ CỦA CƠ THỂ 1', 0, NULL, NULL, NULL, NULL, 1, 1, 0, 1, 0, N'CHẤT BÉO CÓ THỰC SỰ LÀ KẺ THÙ CỦA CƠ THỂ 1', N'CHẤT BÉO CÓ THỰC SỰ LÀ KẺ THÙ CỦA CƠ THỂ 1', N'CHẤT BÉO CÓ THỰC SỰ LÀ KẺ THÙ CỦA CƠ THỂ 1', N'chat-beo-co-thuc-su-la-ke-thu-cua-co-the-1', N'tin-tuc-1/khong-gian-xanh', N'images/news/18022018/chat-beo-co-thuc-su-la-ke-thu-cua-co-the-1.jpg', N'images/news/18022018/chat-beo-co-thuc-su-la-ke-thu-cua-co-the-1-fb89a564-2a06-4641-b06c-4dc4b45f4687.jpg', N'images/news/18022018/chat-beo-co-thuc-su-la-ke-thu-cua-co-the-1-55a9eed8-1dbb-4f48-b848-f5e26ade0210.jpg', CAST(N'2017-07-26T09:35:23.860' AS DateTime), N'Administrator', CAST(N'2018-02-25T15:45:13.820' AS DateTime), N'Administrator')
INSERT [dbo].[News] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [Video], [VideoLink], [OtherLink], [ShortDesc], [Description], [Status], [OrderDisplay], [SpecialDisplay], [HomeDisplay], [ViewCount], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [VirtualCatUrl], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (10, 1115, N'34c7a8cc-5b53-4c8c-ab6c-22f2e2f5f57d/c806af4b-3f03-4f97-9f45-3a1e82fdb89d', NULL, N'PHỐI QUẦN JEANS CẠP CAO THEO PHONG CÁCH THẬP NIÊN 1970', 0, NULL, NULL, NULL, NULL, 1, 1, 0, 1, 0, N'PHỐI QUẦN JEANS CẠP CAO THEO PHONG CÁCH THẬP NIÊN 1970', N'PHỐI QUẦN JEANS CẠP CAO THEO PHONG CÁCH THẬP NIÊN 1970', N'PHỐI QUẦN JEANS CẠP CAO THEO PHONG CÁCH THẬP NIÊN 1970', N'phoi-quan-jeans-cap-cao-theo-phong-cach-thap-nien-1970', N'tin-tuc-1/noi-that-phong-thuy', N'images/news/2018.PQJCCTPCTN1/blog4.e8973bdd.jpg', N'images/news/2018.PQJCCTPCTN1/blog4.6ab03f8c.jpg', N'images/news/2018.PQJCCTPCTN1/blog4.d9a8693b.jpg', CAST(N'2018-05-20T15:15:49.700' AS DateTime), N'Administrator', CAST(N'2018-05-20T15:18:24.763' AS DateTime), N'Administrator')
INSERT [dbo].[News] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [Video], [VideoLink], [OtherLink], [ShortDesc], [Description], [Status], [OrderDisplay], [SpecialDisplay], [HomeDisplay], [ViewCount], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [VirtualCatUrl], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (11, 110, N'34c7a8cc-5b53-4c8c-ab6c-22f2e2f5f57d', NULL, N'Sed ut perspiciatis unde omnis iste natus error', 0, NULL, NULL, NULL, NULL, 1, 1, 0, 1, 0, N'Sed ut perspiciatis unde omnis iste natus error', N'Sed ut perspiciatis unde omnis iste natus error', N'Sed ut perspiciatis unde omnis iste natus error', N'sed-ut-perspiciatis-unde-omnis-iste-natus-error', NULL, N'images/news/2018.SUPUOINE/blog2.efbcc055.jpg', N'images/news/2018.SUPUOINE/blog2.3887ab6b.jpg', N'images/news/2018.SUPUOINE/blog2.0991d3d1.jpg', CAST(N'2018-05-20T16:00:29.183' AS DateTime), N'Administrator', CAST(N'2018-05-22T15:09:52.027' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[News] OFF
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([Id], [OrderNumber], [OrderGuid], [StoreId], [CustomerId], [BillingAddressId], [ShippingAddressId], [OrderStatusId], [ShippingStatusId], [PaymentStatusId], [PaymentMethodSystemName], [CustomerCurrencyCode], [CurrencyRate], [CustomerTaxDisplayTypeId], [VatNumber], [OrderSubtotalInclTax], [OrderSubtotalExclTax], [OrderSubTotalDiscountInclTax], [OrderSubTotalDiscountExclTax], [OrderShippingInclTax], [OrderShippingExclTax], [PaymentMethodAdditionalFeeInclTax], [PaymentMethodAdditionalFeeExclTax], [TaxRates], [OrderTax], [OrderDiscount], [OrderTotal], [RefundedAmount], [RewardPointsWereAdded], [CheckoutAttributeDescription], [CheckoutAttributesXml], [CustomerLanguageId], [AffiliateId], [CustomerIp], [AllowStoringCreditCardNumber], [CardType], [CardName], [CardNumber], [MaskedCreditCardNumber], [CardCvv2], [CardExpirationMonth], [CardExpirationYear], [AllowStoringDirectDebit], [DirectDebitAccountHolder], [DirectDebitAccountNumber], [DirectDebitBankCode], [DirectDebitBankName], [DirectDebitBIC], [DirectDebitCountry], [DirectDebitIban], [AuthorizationTransactionId], [AuthorizationTransactionCode], [AuthorizationTransactionResult], [CaptureTransactionId], [CaptureTransactionResult], [SubscriptionTransactionId], [PurchaseOrderNumber], [PaidDateUtc], [ShippingMethod], [ShippingRateComputationMethodSystemName], [Deleted], [CreatedOnUtc], [UpdatedOnUtc], [RewardPointsRemaining], [CustomerOrderComment], [OrderShippingTaxRate], [PaymentMethodAdditionalFeeTaxRate], [HasNewPaymentNotification], [AcceptThirdPartyEmailHandOver], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1, NULL, N'ec10dcfd-d805-47b7-9f83-e2de8d879289', 0, 10, 18, NULL, 10, 10, 10, N'Trademark', N'VNĐ', CAST(0.00000000 AS Decimal(18, 8)), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(3500.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), N'', CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(3500.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, NULL, NULL, 1, 0, N'172.0.0.0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-04-14T16:01:28.420' AS DateTime), N'Nhận tại cửa hàng', NULL, 0, CAST(N'2018-04-14T16:01:28.420' AS DateTime), CAST(N'2018-04-14T16:01:28.420' AS DateTime), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, 0, CAST(N'2018-04-14T16:01:31.060' AS DateTime), N'truong thanh cong', CAST(N'2018-04-14T16:01:48.820' AS DateTime), N'truong thanh cong')
INSERT [dbo].[Order] ([Id], [OrderNumber], [OrderGuid], [StoreId], [CustomerId], [BillingAddressId], [ShippingAddressId], [OrderStatusId], [ShippingStatusId], [PaymentStatusId], [PaymentMethodSystemName], [CustomerCurrencyCode], [CurrencyRate], [CustomerTaxDisplayTypeId], [VatNumber], [OrderSubtotalInclTax], [OrderSubtotalExclTax], [OrderSubTotalDiscountInclTax], [OrderSubTotalDiscountExclTax], [OrderShippingInclTax], [OrderShippingExclTax], [PaymentMethodAdditionalFeeInclTax], [PaymentMethodAdditionalFeeExclTax], [TaxRates], [OrderTax], [OrderDiscount], [OrderTotal], [RefundedAmount], [RewardPointsWereAdded], [CheckoutAttributeDescription], [CheckoutAttributesXml], [CustomerLanguageId], [AffiliateId], [CustomerIp], [AllowStoringCreditCardNumber], [CardType], [CardName], [CardNumber], [MaskedCreditCardNumber], [CardCvv2], [CardExpirationMonth], [CardExpirationYear], [AllowStoringDirectDebit], [DirectDebitAccountHolder], [DirectDebitAccountNumber], [DirectDebitBankCode], [DirectDebitBankName], [DirectDebitBIC], [DirectDebitCountry], [DirectDebitIban], [AuthorizationTransactionId], [AuthorizationTransactionCode], [AuthorizationTransactionResult], [CaptureTransactionId], [CaptureTransactionResult], [SubscriptionTransactionId], [PurchaseOrderNumber], [PaidDateUtc], [ShippingMethod], [ShippingRateComputationMethodSystemName], [Deleted], [CreatedOnUtc], [UpdatedOnUtc], [RewardPointsRemaining], [CustomerOrderComment], [OrderShippingTaxRate], [PaymentMethodAdditionalFeeTaxRate], [HasNewPaymentNotification], [AcceptThirdPartyEmailHandOver], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2, NULL, N'bb3878d7-7eb4-412a-8e15-144d000ceea9', 0, 10, 18, NULL, 10, 10, 10, N'Trademark', N'VNĐ', CAST(0.00000000 AS Decimal(18, 8)), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(40010.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), N'', CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(40010.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, NULL, NULL, 1, 0, N'172.0.0.0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-04-14T17:08:23.203' AS DateTime), N'Giao tận nơi', NULL, 0, CAST(N'2018-04-14T17:08:23.203' AS DateTime), CAST(N'2018-04-14T17:08:23.203' AS DateTime), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, 0, CAST(N'2018-04-14T17:08:23.307' AS DateTime), N'truong thanh cong', CAST(N'2018-04-14T17:08:23.700' AS DateTime), N'truong thanh cong')
INSERT [dbo].[Order] ([Id], [OrderNumber], [OrderGuid], [StoreId], [CustomerId], [BillingAddressId], [ShippingAddressId], [OrderStatusId], [ShippingStatusId], [PaymentStatusId], [PaymentMethodSystemName], [CustomerCurrencyCode], [CurrencyRate], [CustomerTaxDisplayTypeId], [VatNumber], [OrderSubtotalInclTax], [OrderSubtotalExclTax], [OrderSubTotalDiscountInclTax], [OrderSubTotalDiscountExclTax], [OrderShippingInclTax], [OrderShippingExclTax], [PaymentMethodAdditionalFeeInclTax], [PaymentMethodAdditionalFeeExclTax], [TaxRates], [OrderTax], [OrderDiscount], [OrderTotal], [RefundedAmount], [RewardPointsWereAdded], [CheckoutAttributeDescription], [CheckoutAttributesXml], [CustomerLanguageId], [AffiliateId], [CustomerIp], [AllowStoringCreditCardNumber], [CardType], [CardName], [CardNumber], [MaskedCreditCardNumber], [CardCvv2], [CardExpirationMonth], [CardExpirationYear], [AllowStoringDirectDebit], [DirectDebitAccountHolder], [DirectDebitAccountNumber], [DirectDebitBankCode], [DirectDebitBankName], [DirectDebitBIC], [DirectDebitCountry], [DirectDebitIban], [AuthorizationTransactionId], [AuthorizationTransactionCode], [AuthorizationTransactionResult], [CaptureTransactionId], [CaptureTransactionResult], [SubscriptionTransactionId], [PurchaseOrderNumber], [PaidDateUtc], [ShippingMethod], [ShippingRateComputationMethodSystemName], [Deleted], [CreatedOnUtc], [UpdatedOnUtc], [RewardPointsRemaining], [CustomerOrderComment], [OrderShippingTaxRate], [PaymentMethodAdditionalFeeTaxRate], [HasNewPaymentNotification], [AcceptThirdPartyEmailHandOver], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (3, NULL, N'16b3d992-468e-40ee-b4d5-554c045c2dcc', 0, 5, 19, NULL, 10, 10, 10, N'Trademark', N'VNĐ', CAST(0.00000000 AS Decimal(18, 8)), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(400000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), N'', CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(400000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, NULL, NULL, 1, 0, N'172.0.0.0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-04-14T17:15:38.920' AS DateTime), N'Nhận tại cửa hàng', NULL, 0, CAST(N'2018-04-14T17:15:38.920' AS DateTime), CAST(N'2018-04-14T17:15:38.920' AS DateTime), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, 0, CAST(N'2018-04-14T17:15:38.923' AS DateTime), N'Administrator', CAST(N'2018-04-14T17:15:38.940' AS DateTime), N'Administrator')
INSERT [dbo].[Order] ([Id], [OrderNumber], [OrderGuid], [StoreId], [CustomerId], [BillingAddressId], [ShippingAddressId], [OrderStatusId], [ShippingStatusId], [PaymentStatusId], [PaymentMethodSystemName], [CustomerCurrencyCode], [CurrencyRate], [CustomerTaxDisplayTypeId], [VatNumber], [OrderSubtotalInclTax], [OrderSubtotalExclTax], [OrderSubTotalDiscountInclTax], [OrderSubTotalDiscountExclTax], [OrderShippingInclTax], [OrderShippingExclTax], [PaymentMethodAdditionalFeeInclTax], [PaymentMethodAdditionalFeeExclTax], [TaxRates], [OrderTax], [OrderDiscount], [OrderTotal], [RefundedAmount], [RewardPointsWereAdded], [CheckoutAttributeDescription], [CheckoutAttributesXml], [CustomerLanguageId], [AffiliateId], [CustomerIp], [AllowStoringCreditCardNumber], [CardType], [CardName], [CardNumber], [MaskedCreditCardNumber], [CardCvv2], [CardExpirationMonth], [CardExpirationYear], [AllowStoringDirectDebit], [DirectDebitAccountHolder], [DirectDebitAccountNumber], [DirectDebitBankCode], [DirectDebitBankName], [DirectDebitBIC], [DirectDebitCountry], [DirectDebitIban], [AuthorizationTransactionId], [AuthorizationTransactionCode], [AuthorizationTransactionResult], [CaptureTransactionId], [CaptureTransactionResult], [SubscriptionTransactionId], [PurchaseOrderNumber], [PaidDateUtc], [ShippingMethod], [ShippingRateComputationMethodSystemName], [Deleted], [CreatedOnUtc], [UpdatedOnUtc], [RewardPointsRemaining], [CustomerOrderComment], [OrderShippingTaxRate], [PaymentMethodAdditionalFeeTaxRate], [HasNewPaymentNotification], [AcceptThirdPartyEmailHandOver], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (4, NULL, N'7f7ef9c0-224c-42a1-ba94-c026d61ab1e4', 0, 5, 19, NULL, 10, 10, 10, N'Trademark', N'VNĐ', CAST(0.00000000 AS Decimal(18, 8)), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(12.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), N'', CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(12.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, NULL, NULL, 1, 0, N'172.0.0.0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-04-14T17:42:05.903' AS DateTime), N'Nhận tại cửa hàng', NULL, 0, CAST(N'2018-04-14T17:42:05.903' AS DateTime), CAST(N'2018-04-14T17:42:05.903' AS DateTime), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, 0, CAST(N'2018-04-14T17:42:05.913' AS DateTime), N'Administrator', CAST(N'2018-04-14T17:42:05.960' AS DateTime), N'Administrator')
INSERT [dbo].[Order] ([Id], [OrderNumber], [OrderGuid], [StoreId], [CustomerId], [BillingAddressId], [ShippingAddressId], [OrderStatusId], [ShippingStatusId], [PaymentStatusId], [PaymentMethodSystemName], [CustomerCurrencyCode], [CurrencyRate], [CustomerTaxDisplayTypeId], [VatNumber], [OrderSubtotalInclTax], [OrderSubtotalExclTax], [OrderSubTotalDiscountInclTax], [OrderSubTotalDiscountExclTax], [OrderShippingInclTax], [OrderShippingExclTax], [PaymentMethodAdditionalFeeInclTax], [PaymentMethodAdditionalFeeExclTax], [TaxRates], [OrderTax], [OrderDiscount], [OrderTotal], [RefundedAmount], [RewardPointsWereAdded], [CheckoutAttributeDescription], [CheckoutAttributesXml], [CustomerLanguageId], [AffiliateId], [CustomerIp], [AllowStoringCreditCardNumber], [CardType], [CardName], [CardNumber], [MaskedCreditCardNumber], [CardCvv2], [CardExpirationMonth], [CardExpirationYear], [AllowStoringDirectDebit], [DirectDebitAccountHolder], [DirectDebitAccountNumber], [DirectDebitBankCode], [DirectDebitBankName], [DirectDebitBIC], [DirectDebitCountry], [DirectDebitIban], [AuthorizationTransactionId], [AuthorizationTransactionCode], [AuthorizationTransactionResult], [CaptureTransactionId], [CaptureTransactionResult], [SubscriptionTransactionId], [PurchaseOrderNumber], [PaidDateUtc], [ShippingMethod], [ShippingRateComputationMethodSystemName], [Deleted], [CreatedOnUtc], [UpdatedOnUtc], [RewardPointsRemaining], [CustomerOrderComment], [OrderShippingTaxRate], [PaymentMethodAdditionalFeeTaxRate], [HasNewPaymentNotification], [AcceptThirdPartyEmailHandOver], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (5, NULL, N'82c4cb12-d86b-4d67-b56a-d881b94f3929', 0, 5, 19, NULL, 10, 10, 10, N'Trademark', N'VNĐ', CAST(0.00000000 AS Decimal(18, 8)), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(3500.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), N'', CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(3500.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, NULL, NULL, 1, 0, N'172.0.0.0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-04-19T16:00:06.103' AS DateTime), N'Nhận tại cửa hàng', NULL, 0, CAST(N'2018-04-19T16:00:06.103' AS DateTime), CAST(N'2018-04-19T16:00:06.103' AS DateTime), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, 0, CAST(N'2018-04-19T16:00:08.407' AS DateTime), N'Administrator', CAST(N'2018-04-19T16:00:49.120' AS DateTime), N'Administrator')
INSERT [dbo].[Order] ([Id], [OrderNumber], [OrderGuid], [StoreId], [CustomerId], [BillingAddressId], [ShippingAddressId], [OrderStatusId], [ShippingStatusId], [PaymentStatusId], [PaymentMethodSystemName], [CustomerCurrencyCode], [CurrencyRate], [CustomerTaxDisplayTypeId], [VatNumber], [OrderSubtotalInclTax], [OrderSubtotalExclTax], [OrderSubTotalDiscountInclTax], [OrderSubTotalDiscountExclTax], [OrderShippingInclTax], [OrderShippingExclTax], [PaymentMethodAdditionalFeeInclTax], [PaymentMethodAdditionalFeeExclTax], [TaxRates], [OrderTax], [OrderDiscount], [OrderTotal], [RefundedAmount], [RewardPointsWereAdded], [CheckoutAttributeDescription], [CheckoutAttributesXml], [CustomerLanguageId], [AffiliateId], [CustomerIp], [AllowStoringCreditCardNumber], [CardType], [CardName], [CardNumber], [MaskedCreditCardNumber], [CardCvv2], [CardExpirationMonth], [CardExpirationYear], [AllowStoringDirectDebit], [DirectDebitAccountHolder], [DirectDebitAccountNumber], [DirectDebitBankCode], [DirectDebitBankName], [DirectDebitBIC], [DirectDebitCountry], [DirectDebitIban], [AuthorizationTransactionId], [AuthorizationTransactionCode], [AuthorizationTransactionResult], [CaptureTransactionId], [CaptureTransactionResult], [SubscriptionTransactionId], [PurchaseOrderNumber], [PaidDateUtc], [ShippingMethod], [ShippingRateComputationMethodSystemName], [Deleted], [CreatedOnUtc], [UpdatedOnUtc], [RewardPointsRemaining], [CustomerOrderComment], [OrderShippingTaxRate], [PaymentMethodAdditionalFeeTaxRate], [HasNewPaymentNotification], [AcceptThirdPartyEmailHandOver], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (6, NULL, N'0fe5e724-d3a8-4c8c-9c4a-852b18be39b1', 0, 5, 19, NULL, 10, 10, 10, N'Trademark', N'VNĐ', CAST(0.00000000 AS Decimal(18, 8)), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(3500.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), N'', CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(3500.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, NULL, NULL, 1, 0, N'172.0.0.0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-04-19T16:28:33.317' AS DateTime), N'Nhận tại cửa hàng', NULL, 0, CAST(N'2018-04-19T16:28:33.317' AS DateTime), CAST(N'2018-04-19T16:28:33.317' AS DateTime), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, 0, CAST(N'2018-04-19T16:28:35.050' AS DateTime), N'Administrator', CAST(N'2018-04-19T16:28:40.000' AS DateTime), N'Administrator')
INSERT [dbo].[Order] ([Id], [OrderNumber], [OrderGuid], [StoreId], [CustomerId], [BillingAddressId], [ShippingAddressId], [OrderStatusId], [ShippingStatusId], [PaymentStatusId], [PaymentMethodSystemName], [CustomerCurrencyCode], [CurrencyRate], [CustomerTaxDisplayTypeId], [VatNumber], [OrderSubtotalInclTax], [OrderSubtotalExclTax], [OrderSubTotalDiscountInclTax], [OrderSubTotalDiscountExclTax], [OrderShippingInclTax], [OrderShippingExclTax], [PaymentMethodAdditionalFeeInclTax], [PaymentMethodAdditionalFeeExclTax], [TaxRates], [OrderTax], [OrderDiscount], [OrderTotal], [RefundedAmount], [RewardPointsWereAdded], [CheckoutAttributeDescription], [CheckoutAttributesXml], [CustomerLanguageId], [AffiliateId], [CustomerIp], [AllowStoringCreditCardNumber], [CardType], [CardName], [CardNumber], [MaskedCreditCardNumber], [CardCvv2], [CardExpirationMonth], [CardExpirationYear], [AllowStoringDirectDebit], [DirectDebitAccountHolder], [DirectDebitAccountNumber], [DirectDebitBankCode], [DirectDebitBankName], [DirectDebitBIC], [DirectDebitCountry], [DirectDebitIban], [AuthorizationTransactionId], [AuthorizationTransactionCode], [AuthorizationTransactionResult], [CaptureTransactionId], [CaptureTransactionResult], [SubscriptionTransactionId], [PurchaseOrderNumber], [PaidDateUtc], [ShippingMethod], [ShippingRateComputationMethodSystemName], [Deleted], [CreatedOnUtc], [UpdatedOnUtc], [RewardPointsRemaining], [CustomerOrderComment], [OrderShippingTaxRate], [PaymentMethodAdditionalFeeTaxRate], [HasNewPaymentNotification], [AcceptThirdPartyEmailHandOver], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (7, NULL, N'3cf59f44-eb88-48a2-a7dd-d70f5371c82a', 0, 5, 19, NULL, 10, 10, 10, N'Trademark', N'VNĐ', CAST(0.00000000 AS Decimal(18, 8)), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(3500.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), N'', CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(3500.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, NULL, NULL, 1, 0, N'172.0.0.0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-04-19T16:33:48.467' AS DateTime), N'Nhận tại cửa hàng', NULL, 0, CAST(N'2018-04-19T16:33:48.467' AS DateTime), CAST(N'2018-04-19T16:33:48.467' AS DateTime), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, 0, CAST(N'2018-04-19T16:33:48.483' AS DateTime), N'Administrator', CAST(N'2018-04-19T16:33:48.500' AS DateTime), N'Administrator')
INSERT [dbo].[Order] ([Id], [OrderNumber], [OrderGuid], [StoreId], [CustomerId], [BillingAddressId], [ShippingAddressId], [OrderStatusId], [ShippingStatusId], [PaymentStatusId], [PaymentMethodSystemName], [CustomerCurrencyCode], [CurrencyRate], [CustomerTaxDisplayTypeId], [VatNumber], [OrderSubtotalInclTax], [OrderSubtotalExclTax], [OrderSubTotalDiscountInclTax], [OrderSubTotalDiscountExclTax], [OrderShippingInclTax], [OrderShippingExclTax], [PaymentMethodAdditionalFeeInclTax], [PaymentMethodAdditionalFeeExclTax], [TaxRates], [OrderTax], [OrderDiscount], [OrderTotal], [RefundedAmount], [RewardPointsWereAdded], [CheckoutAttributeDescription], [CheckoutAttributesXml], [CustomerLanguageId], [AffiliateId], [CustomerIp], [AllowStoringCreditCardNumber], [CardType], [CardName], [CardNumber], [MaskedCreditCardNumber], [CardCvv2], [CardExpirationMonth], [CardExpirationYear], [AllowStoringDirectDebit], [DirectDebitAccountHolder], [DirectDebitAccountNumber], [DirectDebitBankCode], [DirectDebitBankName], [DirectDebitBIC], [DirectDebitCountry], [DirectDebitIban], [AuthorizationTransactionId], [AuthorizationTransactionCode], [AuthorizationTransactionResult], [CaptureTransactionId], [CaptureTransactionResult], [SubscriptionTransactionId], [PurchaseOrderNumber], [PaidDateUtc], [ShippingMethod], [ShippingRateComputationMethodSystemName], [Deleted], [CreatedOnUtc], [UpdatedOnUtc], [RewardPointsRemaining], [CustomerOrderComment], [OrderShippingTaxRate], [PaymentMethodAdditionalFeeTaxRate], [HasNewPaymentNotification], [AcceptThirdPartyEmailHandOver], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (8, NULL, N'460cfa91-ca73-491f-8314-e887f102c11d', 0, 5, 19, NULL, 10, 10, 10, N'Trademark', N'VNĐ', CAST(0.00000000 AS Decimal(18, 8)), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(400000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), N'', CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(400000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, NULL, NULL, 1, 0, N'172.0.0.0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-04-19T16:35:20.967' AS DateTime), N'Nhận tại cửa hàng', NULL, 0, CAST(N'2018-04-19T16:35:20.967' AS DateTime), CAST(N'2018-04-19T16:35:20.967' AS DateTime), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, 0, CAST(N'2018-04-19T16:35:20.977' AS DateTime), N'Administrator', CAST(N'2018-04-19T16:35:20.993' AS DateTime), N'Administrator')
INSERT [dbo].[Order] ([Id], [OrderNumber], [OrderGuid], [StoreId], [CustomerId], [BillingAddressId], [ShippingAddressId], [OrderStatusId], [ShippingStatusId], [PaymentStatusId], [PaymentMethodSystemName], [CustomerCurrencyCode], [CurrencyRate], [CustomerTaxDisplayTypeId], [VatNumber], [OrderSubtotalInclTax], [OrderSubtotalExclTax], [OrderSubTotalDiscountInclTax], [OrderSubTotalDiscountExclTax], [OrderShippingInclTax], [OrderShippingExclTax], [PaymentMethodAdditionalFeeInclTax], [PaymentMethodAdditionalFeeExclTax], [TaxRates], [OrderTax], [OrderDiscount], [OrderTotal], [RefundedAmount], [RewardPointsWereAdded], [CheckoutAttributeDescription], [CheckoutAttributesXml], [CustomerLanguageId], [AffiliateId], [CustomerIp], [AllowStoringCreditCardNumber], [CardType], [CardName], [CardNumber], [MaskedCreditCardNumber], [CardCvv2], [CardExpirationMonth], [CardExpirationYear], [AllowStoringDirectDebit], [DirectDebitAccountHolder], [DirectDebitAccountNumber], [DirectDebitBankCode], [DirectDebitBankName], [DirectDebitBIC], [DirectDebitCountry], [DirectDebitIban], [AuthorizationTransactionId], [AuthorizationTransactionCode], [AuthorizationTransactionResult], [CaptureTransactionId], [CaptureTransactionResult], [SubscriptionTransactionId], [PurchaseOrderNumber], [PaidDateUtc], [ShippingMethod], [ShippingRateComputationMethodSystemName], [Deleted], [CreatedOnUtc], [UpdatedOnUtc], [RewardPointsRemaining], [CustomerOrderComment], [OrderShippingTaxRate], [PaymentMethodAdditionalFeeTaxRate], [HasNewPaymentNotification], [AcceptThirdPartyEmailHandOver], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (9, NULL, N'95d56aca-e601-4a1e-80be-771ac1ce793d', 0, 5, 19, NULL, 10, 10, 10, N'Trademark', N'VNĐ', CAST(0.00000000 AS Decimal(18, 8)), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(10000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), N'', CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(10000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, NULL, NULL, 1, 0, N'172.0.0.0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-04-19T17:00:39.687' AS DateTime), N'Nhận tại cửa hàng', NULL, 0, CAST(N'2018-04-19T17:00:39.687' AS DateTime), CAST(N'2018-04-19T17:00:39.687' AS DateTime), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, 0, CAST(N'2018-04-19T17:00:39.723' AS DateTime), N'Administrator', CAST(N'2018-04-19T17:00:39.803' AS DateTime), N'Administrator')
INSERT [dbo].[Order] ([Id], [OrderNumber], [OrderGuid], [StoreId], [CustomerId], [BillingAddressId], [ShippingAddressId], [OrderStatusId], [ShippingStatusId], [PaymentStatusId], [PaymentMethodSystemName], [CustomerCurrencyCode], [CurrencyRate], [CustomerTaxDisplayTypeId], [VatNumber], [OrderSubtotalInclTax], [OrderSubtotalExclTax], [OrderSubTotalDiscountInclTax], [OrderSubTotalDiscountExclTax], [OrderShippingInclTax], [OrderShippingExclTax], [PaymentMethodAdditionalFeeInclTax], [PaymentMethodAdditionalFeeExclTax], [TaxRates], [OrderTax], [OrderDiscount], [OrderTotal], [RefundedAmount], [RewardPointsWereAdded], [CheckoutAttributeDescription], [CheckoutAttributesXml], [CustomerLanguageId], [AffiliateId], [CustomerIp], [AllowStoringCreditCardNumber], [CardType], [CardName], [CardNumber], [MaskedCreditCardNumber], [CardCvv2], [CardExpirationMonth], [CardExpirationYear], [AllowStoringDirectDebit], [DirectDebitAccountHolder], [DirectDebitAccountNumber], [DirectDebitBankCode], [DirectDebitBankName], [DirectDebitBIC], [DirectDebitCountry], [DirectDebitIban], [AuthorizationTransactionId], [AuthorizationTransactionCode], [AuthorizationTransactionResult], [CaptureTransactionId], [CaptureTransactionResult], [SubscriptionTransactionId], [PurchaseOrderNumber], [PaidDateUtc], [ShippingMethod], [ShippingRateComputationMethodSystemName], [Deleted], [CreatedOnUtc], [UpdatedOnUtc], [RewardPointsRemaining], [CustomerOrderComment], [OrderShippingTaxRate], [PaymentMethodAdditionalFeeTaxRate], [HasNewPaymentNotification], [AcceptThirdPartyEmailHandOver], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (10, NULL, N'a926e339-ef30-4040-9144-f9e79e49d2f9', 0, 5, 19, NULL, 10, 10, 10, N'Trademark', N'VNĐ', CAST(0.00000000 AS Decimal(18, 8)), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(10000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), N'', CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(10000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, NULL, NULL, 1, 0, N'172.0.0.0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-04-20T14:31:22.750' AS DateTime), N'Nhận tại cửa hàng', NULL, 0, CAST(N'2018-04-20T14:31:22.750' AS DateTime), CAST(N'2018-04-20T14:31:22.750' AS DateTime), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, 0, CAST(N'2018-04-20T14:31:22.783' AS DateTime), N'Administrator', CAST(N'2018-04-20T14:31:22.857' AS DateTime), N'Administrator')
INSERT [dbo].[Order] ([Id], [OrderNumber], [OrderGuid], [StoreId], [CustomerId], [BillingAddressId], [ShippingAddressId], [OrderStatusId], [ShippingStatusId], [PaymentStatusId], [PaymentMethodSystemName], [CustomerCurrencyCode], [CurrencyRate], [CustomerTaxDisplayTypeId], [VatNumber], [OrderSubtotalInclTax], [OrderSubtotalExclTax], [OrderSubTotalDiscountInclTax], [OrderSubTotalDiscountExclTax], [OrderShippingInclTax], [OrderShippingExclTax], [PaymentMethodAdditionalFeeInclTax], [PaymentMethodAdditionalFeeExclTax], [TaxRates], [OrderTax], [OrderDiscount], [OrderTotal], [RefundedAmount], [RewardPointsWereAdded], [CheckoutAttributeDescription], [CheckoutAttributesXml], [CustomerLanguageId], [AffiliateId], [CustomerIp], [AllowStoringCreditCardNumber], [CardType], [CardName], [CardNumber], [MaskedCreditCardNumber], [CardCvv2], [CardExpirationMonth], [CardExpirationYear], [AllowStoringDirectDebit], [DirectDebitAccountHolder], [DirectDebitAccountNumber], [DirectDebitBankCode], [DirectDebitBankName], [DirectDebitBIC], [DirectDebitCountry], [DirectDebitIban], [AuthorizationTransactionId], [AuthorizationTransactionCode], [AuthorizationTransactionResult], [CaptureTransactionId], [CaptureTransactionResult], [SubscriptionTransactionId], [PurchaseOrderNumber], [PaidDateUtc], [ShippingMethod], [ShippingRateComputationMethodSystemName], [Deleted], [CreatedOnUtc], [UpdatedOnUtc], [RewardPointsRemaining], [CustomerOrderComment], [OrderShippingTaxRate], [PaymentMethodAdditionalFeeTaxRate], [HasNewPaymentNotification], [AcceptThirdPartyEmailHandOver], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (11, NULL, N'86d7a7d6-f45d-48d4-9dea-659ac900dd85', 0, 5, 19, NULL, 10, 10, 10, N'Trademark', N'VNĐ', CAST(0.00000000 AS Decimal(18, 8)), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(10000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), N'', CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(10000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, NULL, NULL, 1, 0, N'172.0.0.0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-04-20T14:38:50.807' AS DateTime), N'Nhận tại cửa hàng', NULL, 0, CAST(N'2018-04-20T14:38:50.807' AS DateTime), CAST(N'2018-04-20T14:38:50.807' AS DateTime), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, 0, CAST(N'2018-04-20T14:38:50.840' AS DateTime), N'Administrator', CAST(N'2018-04-20T14:38:50.923' AS DateTime), N'Administrator')
INSERT [dbo].[Order] ([Id], [OrderNumber], [OrderGuid], [StoreId], [CustomerId], [BillingAddressId], [ShippingAddressId], [OrderStatusId], [ShippingStatusId], [PaymentStatusId], [PaymentMethodSystemName], [CustomerCurrencyCode], [CurrencyRate], [CustomerTaxDisplayTypeId], [VatNumber], [OrderSubtotalInclTax], [OrderSubtotalExclTax], [OrderSubTotalDiscountInclTax], [OrderSubTotalDiscountExclTax], [OrderShippingInclTax], [OrderShippingExclTax], [PaymentMethodAdditionalFeeInclTax], [PaymentMethodAdditionalFeeExclTax], [TaxRates], [OrderTax], [OrderDiscount], [OrderTotal], [RefundedAmount], [RewardPointsWereAdded], [CheckoutAttributeDescription], [CheckoutAttributesXml], [CustomerLanguageId], [AffiliateId], [CustomerIp], [AllowStoringCreditCardNumber], [CardType], [CardName], [CardNumber], [MaskedCreditCardNumber], [CardCvv2], [CardExpirationMonth], [CardExpirationYear], [AllowStoringDirectDebit], [DirectDebitAccountHolder], [DirectDebitAccountNumber], [DirectDebitBankCode], [DirectDebitBankName], [DirectDebitBIC], [DirectDebitCountry], [DirectDebitIban], [AuthorizationTransactionId], [AuthorizationTransactionCode], [AuthorizationTransactionResult], [CaptureTransactionId], [CaptureTransactionResult], [SubscriptionTransactionId], [PurchaseOrderNumber], [PaidDateUtc], [ShippingMethod], [ShippingRateComputationMethodSystemName], [Deleted], [CreatedOnUtc], [UpdatedOnUtc], [RewardPointsRemaining], [CustomerOrderComment], [OrderShippingTaxRate], [PaymentMethodAdditionalFeeTaxRate], [HasNewPaymentNotification], [AcceptThirdPartyEmailHandOver], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (12, NULL, N'756de520-1692-4705-b662-f3ea6e543a96', 0, 5, 19, NULL, 10, 10, 10, N'Trademark', N'VNĐ', CAST(0.00000000 AS Decimal(18, 8)), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(10000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), N'', CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(10000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, NULL, NULL, 1, 0, N'172.0.0.0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-04-20T14:43:09.007' AS DateTime), N'Nhận tại cửa hàng', NULL, 0, CAST(N'2018-04-20T14:43:09.007' AS DateTime), CAST(N'2018-04-20T14:43:09.007' AS DateTime), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, 0, CAST(N'2018-04-20T14:43:09.037' AS DateTime), N'Administrator', CAST(N'2018-04-20T14:43:09.103' AS DateTime), N'Administrator')
INSERT [dbo].[Order] ([Id], [OrderNumber], [OrderGuid], [StoreId], [CustomerId], [BillingAddressId], [ShippingAddressId], [OrderStatusId], [ShippingStatusId], [PaymentStatusId], [PaymentMethodSystemName], [CustomerCurrencyCode], [CurrencyRate], [CustomerTaxDisplayTypeId], [VatNumber], [OrderSubtotalInclTax], [OrderSubtotalExclTax], [OrderSubTotalDiscountInclTax], [OrderSubTotalDiscountExclTax], [OrderShippingInclTax], [OrderShippingExclTax], [PaymentMethodAdditionalFeeInclTax], [PaymentMethodAdditionalFeeExclTax], [TaxRates], [OrderTax], [OrderDiscount], [OrderTotal], [RefundedAmount], [RewardPointsWereAdded], [CheckoutAttributeDescription], [CheckoutAttributesXml], [CustomerLanguageId], [AffiliateId], [CustomerIp], [AllowStoringCreditCardNumber], [CardType], [CardName], [CardNumber], [MaskedCreditCardNumber], [CardCvv2], [CardExpirationMonth], [CardExpirationYear], [AllowStoringDirectDebit], [DirectDebitAccountHolder], [DirectDebitAccountNumber], [DirectDebitBankCode], [DirectDebitBankName], [DirectDebitBIC], [DirectDebitCountry], [DirectDebitIban], [AuthorizationTransactionId], [AuthorizationTransactionCode], [AuthorizationTransactionResult], [CaptureTransactionId], [CaptureTransactionResult], [SubscriptionTransactionId], [PurchaseOrderNumber], [PaidDateUtc], [ShippingMethod], [ShippingRateComputationMethodSystemName], [Deleted], [CreatedOnUtc], [UpdatedOnUtc], [RewardPointsRemaining], [CustomerOrderComment], [OrderShippingTaxRate], [PaymentMethodAdditionalFeeTaxRate], [HasNewPaymentNotification], [AcceptThirdPartyEmailHandOver], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (13, NULL, N'26544f38-ad95-4d7a-afdf-2ee8cb2c894d', 0, 5, 20, NULL, 10, 10, 10, N'Trademark', N'VNĐ', CAST(0.00000000 AS Decimal(18, 8)), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(10000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), N'', CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(10000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, NULL, NULL, 1, 0, N'172.0.0.0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-05-10T14:41:22.893' AS DateTime), N'Nhận tại cửa hàng', NULL, 0, CAST(N'2018-05-10T14:41:22.893' AS DateTime), CAST(N'2018-05-10T14:41:22.893' AS DateTime), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, 0, CAST(N'2018-05-10T14:41:22.923' AS DateTime), N'Administrator', CAST(N'2018-05-10T14:41:22.977' AS DateTime), N'Administrator')
INSERT [dbo].[Order] ([Id], [OrderNumber], [OrderGuid], [StoreId], [CustomerId], [BillingAddressId], [ShippingAddressId], [OrderStatusId], [ShippingStatusId], [PaymentStatusId], [PaymentMethodSystemName], [CustomerCurrencyCode], [CurrencyRate], [CustomerTaxDisplayTypeId], [VatNumber], [OrderSubtotalInclTax], [OrderSubtotalExclTax], [OrderSubTotalDiscountInclTax], [OrderSubTotalDiscountExclTax], [OrderShippingInclTax], [OrderShippingExclTax], [PaymentMethodAdditionalFeeInclTax], [PaymentMethodAdditionalFeeExclTax], [TaxRates], [OrderTax], [OrderDiscount], [OrderTotal], [RefundedAmount], [RewardPointsWereAdded], [CheckoutAttributeDescription], [CheckoutAttributesXml], [CustomerLanguageId], [AffiliateId], [CustomerIp], [AllowStoringCreditCardNumber], [CardType], [CardName], [CardNumber], [MaskedCreditCardNumber], [CardCvv2], [CardExpirationMonth], [CardExpirationYear], [AllowStoringDirectDebit], [DirectDebitAccountHolder], [DirectDebitAccountNumber], [DirectDebitBankCode], [DirectDebitBankName], [DirectDebitBIC], [DirectDebitCountry], [DirectDebitIban], [AuthorizationTransactionId], [AuthorizationTransactionCode], [AuthorizationTransactionResult], [CaptureTransactionId], [CaptureTransactionResult], [SubscriptionTransactionId], [PurchaseOrderNumber], [PaidDateUtc], [ShippingMethod], [ShippingRateComputationMethodSystemName], [Deleted], [CreatedOnUtc], [UpdatedOnUtc], [RewardPointsRemaining], [CustomerOrderComment], [OrderShippingTaxRate], [PaymentMethodAdditionalFeeTaxRate], [HasNewPaymentNotification], [AcceptThirdPartyEmailHandOver], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (14, NULL, N'24b2ec0e-e87b-4d2c-b4e1-af2eb3a4801d', 0, 11, 21, NULL, 10, 10, 10, N'DHL', N'VNĐ', CAST(0.00000000 AS Decimal(18, 8)), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(20000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), N'', CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(20000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, NULL, NULL, 1, 0, N'172.0.0.0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-05-13T12:53:54.800' AS DateTime), N'Giao tận nơi', NULL, 0, CAST(N'2018-05-13T12:53:54.800' AS DateTime), CAST(N'2018-05-13T12:53:54.800' AS DateTime), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, 0, CAST(N'2018-05-13T12:53:54.830' AS DateTime), N'DemoVictim', CAST(N'2018-05-13T12:53:54.880' AS DateTime), N'DemoVictim')
INSERT [dbo].[Order] ([Id], [OrderNumber], [OrderGuid], [StoreId], [CustomerId], [BillingAddressId], [ShippingAddressId], [OrderStatusId], [ShippingStatusId], [PaymentStatusId], [PaymentMethodSystemName], [CustomerCurrencyCode], [CurrencyRate], [CustomerTaxDisplayTypeId], [VatNumber], [OrderSubtotalInclTax], [OrderSubtotalExclTax], [OrderSubTotalDiscountInclTax], [OrderSubTotalDiscountExclTax], [OrderShippingInclTax], [OrderShippingExclTax], [PaymentMethodAdditionalFeeInclTax], [PaymentMethodAdditionalFeeExclTax], [TaxRates], [OrderTax], [OrderDiscount], [OrderTotal], [RefundedAmount], [RewardPointsWereAdded], [CheckoutAttributeDescription], [CheckoutAttributesXml], [CustomerLanguageId], [AffiliateId], [CustomerIp], [AllowStoringCreditCardNumber], [CardType], [CardName], [CardNumber], [MaskedCreditCardNumber], [CardCvv2], [CardExpirationMonth], [CardExpirationYear], [AllowStoringDirectDebit], [DirectDebitAccountHolder], [DirectDebitAccountNumber], [DirectDebitBankCode], [DirectDebitBankName], [DirectDebitBIC], [DirectDebitCountry], [DirectDebitIban], [AuthorizationTransactionId], [AuthorizationTransactionCode], [AuthorizationTransactionResult], [CaptureTransactionId], [CaptureTransactionResult], [SubscriptionTransactionId], [PurchaseOrderNumber], [PaidDateUtc], [ShippingMethod], [ShippingRateComputationMethodSystemName], [Deleted], [CreatedOnUtc], [UpdatedOnUtc], [RewardPointsRemaining], [CustomerOrderComment], [OrderShippingTaxRate], [PaymentMethodAdditionalFeeTaxRate], [HasNewPaymentNotification], [AcceptThirdPartyEmailHandOver], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (15, NULL, N'89f4baa2-5f8d-457e-b83f-acb41a05fa0e', 0, 5, 20, NULL, 10, 10, 10, N'Trademark', N'VNĐ', CAST(0.00000000 AS Decimal(18, 8)), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(20000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), N'', CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(20000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, NULL, NULL, 1, 0, N'172.0.0.0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-05-20T15:04:32.340' AS DateTime), N'Nhận tại cửa hàng', NULL, 0, CAST(N'2018-05-20T15:04:32.340' AS DateTime), CAST(N'2018-05-20T15:04:32.340' AS DateTime), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, 0, CAST(N'2018-05-20T15:04:32.367' AS DateTime), N'Administrator', CAST(N'2018-05-20T15:04:32.433' AS DateTime), N'Administrator')
INSERT [dbo].[Order] ([Id], [OrderNumber], [OrderGuid], [StoreId], [CustomerId], [BillingAddressId], [ShippingAddressId], [OrderStatusId], [ShippingStatusId], [PaymentStatusId], [PaymentMethodSystemName], [CustomerCurrencyCode], [CurrencyRate], [CustomerTaxDisplayTypeId], [VatNumber], [OrderSubtotalInclTax], [OrderSubtotalExclTax], [OrderSubTotalDiscountInclTax], [OrderSubTotalDiscountExclTax], [OrderShippingInclTax], [OrderShippingExclTax], [PaymentMethodAdditionalFeeInclTax], [PaymentMethodAdditionalFeeExclTax], [TaxRates], [OrderTax], [OrderDiscount], [OrderTotal], [RefundedAmount], [RewardPointsWereAdded], [CheckoutAttributeDescription], [CheckoutAttributesXml], [CustomerLanguageId], [AffiliateId], [CustomerIp], [AllowStoringCreditCardNumber], [CardType], [CardName], [CardNumber], [MaskedCreditCardNumber], [CardCvv2], [CardExpirationMonth], [CardExpirationYear], [AllowStoringDirectDebit], [DirectDebitAccountHolder], [DirectDebitAccountNumber], [DirectDebitBankCode], [DirectDebitBankName], [DirectDebitBIC], [DirectDebitCountry], [DirectDebitIban], [AuthorizationTransactionId], [AuthorizationTransactionCode], [AuthorizationTransactionResult], [CaptureTransactionId], [CaptureTransactionResult], [SubscriptionTransactionId], [PurchaseOrderNumber], [PaidDateUtc], [ShippingMethod], [ShippingRateComputationMethodSystemName], [Deleted], [CreatedOnUtc], [UpdatedOnUtc], [RewardPointsRemaining], [CustomerOrderComment], [OrderShippingTaxRate], [PaymentMethodAdditionalFeeTaxRate], [HasNewPaymentNotification], [AcceptThirdPartyEmailHandOver], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (16, NULL, N'b707778e-8432-4506-8401-fdb7179cbcd1', 0, 5, 20, NULL, 10, 10, 10, N'DHL', N'VNĐ', CAST(0.00000000 AS Decimal(18, 8)), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(100000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), N'', CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(100000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, NULL, NULL, 1, 0, N'172.0.0.0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-05-23T16:52:40.497' AS DateTime), N'Giao tận nơi', NULL, 0, CAST(N'2018-05-23T16:52:40.497' AS DateTime), CAST(N'2018-05-23T16:52:40.497' AS DateTime), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, 0, CAST(N'2018-05-23T16:52:40.523' AS DateTime), N'Administrator', CAST(N'2018-05-23T16:52:40.570' AS DateTime), N'Administrator')
INSERT [dbo].[Order] ([Id], [OrderNumber], [OrderGuid], [StoreId], [CustomerId], [BillingAddressId], [ShippingAddressId], [OrderStatusId], [ShippingStatusId], [PaymentStatusId], [PaymentMethodSystemName], [CustomerCurrencyCode], [CurrencyRate], [CustomerTaxDisplayTypeId], [VatNumber], [OrderSubtotalInclTax], [OrderSubtotalExclTax], [OrderSubTotalDiscountInclTax], [OrderSubTotalDiscountExclTax], [OrderShippingInclTax], [OrderShippingExclTax], [PaymentMethodAdditionalFeeInclTax], [PaymentMethodAdditionalFeeExclTax], [TaxRates], [OrderTax], [OrderDiscount], [OrderTotal], [RefundedAmount], [RewardPointsWereAdded], [CheckoutAttributeDescription], [CheckoutAttributesXml], [CustomerLanguageId], [AffiliateId], [CustomerIp], [AllowStoringCreditCardNumber], [CardType], [CardName], [CardNumber], [MaskedCreditCardNumber], [CardCvv2], [CardExpirationMonth], [CardExpirationYear], [AllowStoringDirectDebit], [DirectDebitAccountHolder], [DirectDebitAccountNumber], [DirectDebitBankCode], [DirectDebitBankName], [DirectDebitBIC], [DirectDebitCountry], [DirectDebitIban], [AuthorizationTransactionId], [AuthorizationTransactionCode], [AuthorizationTransactionResult], [CaptureTransactionId], [CaptureTransactionResult], [SubscriptionTransactionId], [PurchaseOrderNumber], [PaidDateUtc], [ShippingMethod], [ShippingRateComputationMethodSystemName], [Deleted], [CreatedOnUtc], [UpdatedOnUtc], [RewardPointsRemaining], [CustomerOrderComment], [OrderShippingTaxRate], [PaymentMethodAdditionalFeeTaxRate], [HasNewPaymentNotification], [AcceptThirdPartyEmailHandOver], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (17, NULL, N'b04da21d-3864-42c1-afe5-6513bad916aa', 0, 5, 20, NULL, 10, 10, 10, N'DHL', N'VNĐ', CAST(0.00000000 AS Decimal(18, 8)), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(400000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), N'', CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(400000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, NULL, NULL, 1, 0, N'172.0.0.0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2018-05-27T14:20:29.917' AS DateTime), N'Giao tận nơi', NULL, 0, CAST(N'2018-05-27T14:20:29.917' AS DateTime), CAST(N'2018-05-27T14:20:29.917' AS DateTime), 0, NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), 0, 0, CAST(N'2018-05-27T14:20:29.940' AS DateTime), N'Administrator', CAST(N'2018-05-27T14:20:29.993' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[Order] OFF
SET IDENTITY_INSERT [dbo].[OrderItem] ON 

INSERT [dbo].[OrderItem] ([Id], [OrderItemGuid], [OrderId], [PostId], [Quantity], [UnitPriceInclTax], [UnitPriceExclTax], [PriceInclTax], [PriceExclTax], [DiscountAmountInclTax], [DiscountAmountExclTax], [AttributeDescription], [AttributesXml], [DownloadCount], [IsDownloadActivated], [LicenseDownloadId], [ItemWeight], [BundleData], [PostCost], [TaxRate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1, N'44972930-56e1-432a-812d-dfa39816c039', 2, 95, 2, CAST(20000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(40000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), NULL, NULL, 0, 0, 0, CAST(0.0000 AS Decimal(18, 4)), NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(N'2018-04-14T17:08:23.613' AS DateTime), N'truong thanh cong', CAST(N'2018-04-14T17:08:23.613' AS DateTime), N'truong thanh cong')
INSERT [dbo].[OrderItem] ([Id], [OrderItemGuid], [OrderId], [PostId], [Quantity], [UnitPriceInclTax], [UnitPriceExclTax], [PriceInclTax], [PriceExclTax], [DiscountAmountInclTax], [DiscountAmountExclTax], [AttributeDescription], [AttributesXml], [DownloadCount], [IsDownloadActivated], [LicenseDownloadId], [ItemWeight], [BundleData], [PostCost], [TaxRate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2, N'248c99d9-65bc-4fd1-b637-ba060809e9e0', 2, 96, 5, CAST(2.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(10.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), NULL, NULL, 0, 0, 0, CAST(0.0000 AS Decimal(18, 4)), NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(N'2018-04-14T17:08:23.700' AS DateTime), N'truong thanh cong', CAST(N'2018-04-14T17:08:23.700' AS DateTime), N'truong thanh cong')
INSERT [dbo].[OrderItem] ([Id], [OrderItemGuid], [OrderId], [PostId], [Quantity], [UnitPriceInclTax], [UnitPriceExclTax], [PriceInclTax], [PriceExclTax], [DiscountAmountInclTax], [DiscountAmountExclTax], [AttributeDescription], [AttributesXml], [DownloadCount], [IsDownloadActivated], [LicenseDownloadId], [ItemWeight], [BundleData], [PostCost], [TaxRate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (3, N'920f79ee-4b18-41ef-bfbb-b06a127d8a45', 3, 97, 1, CAST(400000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(400000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), NULL, NULL, 0, 0, 0, CAST(0.0000 AS Decimal(18, 4)), NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(N'2018-04-14T17:15:38.940' AS DateTime), N'Administrator', CAST(N'2018-04-14T17:15:38.940' AS DateTime), N'Administrator')
INSERT [dbo].[OrderItem] ([Id], [OrderItemGuid], [OrderId], [PostId], [Quantity], [UnitPriceInclTax], [UnitPriceExclTax], [PriceInclTax], [PriceExclTax], [DiscountAmountInclTax], [DiscountAmountExclTax], [AttributeDescription], [AttributesXml], [DownloadCount], [IsDownloadActivated], [LicenseDownloadId], [ItemWeight], [BundleData], [PostCost], [TaxRate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (5, N'b3fdf45c-0cc5-4d4f-96e3-803cef9be109', 4, 99, 1, CAST(2.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(2.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), NULL, NULL, 0, 0, 0, CAST(0.0000 AS Decimal(18, 4)), NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(N'2018-04-14T17:42:05.960' AS DateTime), N'Administrator', CAST(N'2018-04-14T17:42:05.960' AS DateTime), N'Administrator')
INSERT [dbo].[OrderItem] ([Id], [OrderItemGuid], [OrderId], [PostId], [Quantity], [UnitPriceInclTax], [UnitPriceExclTax], [PriceInclTax], [PriceExclTax], [DiscountAmountInclTax], [DiscountAmountExclTax], [AttributeDescription], [AttributesXml], [DownloadCount], [IsDownloadActivated], [LicenseDownloadId], [ItemWeight], [BundleData], [PostCost], [TaxRate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (6, N'f94318cc-62ba-465c-adcb-463e897fff8e', 5, 100, 1, CAST(3500.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(3500.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), NULL, NULL, 0, 0, 0, CAST(0.0000 AS Decimal(18, 4)), NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(N'2018-04-19T16:00:49.120' AS DateTime), N'Administrator', CAST(N'2018-04-19T16:00:49.120' AS DateTime), N'Administrator')
INSERT [dbo].[OrderItem] ([Id], [OrderItemGuid], [OrderId], [PostId], [Quantity], [UnitPriceInclTax], [UnitPriceExclTax], [PriceInclTax], [PriceExclTax], [DiscountAmountInclTax], [DiscountAmountExclTax], [AttributeDescription], [AttributesXml], [DownloadCount], [IsDownloadActivated], [LicenseDownloadId], [ItemWeight], [BundleData], [PostCost], [TaxRate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (7, N'cfa26db2-f642-4889-96de-3afe0a2178e3', 6, 42, 1, CAST(3500.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(3500.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), NULL, NULL, 0, 0, 0, CAST(0.0000 AS Decimal(18, 4)), NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(N'2018-04-19T16:28:40.000' AS DateTime), N'Administrator', CAST(N'2018-04-19T16:28:40.000' AS DateTime), N'Administrator')
INSERT [dbo].[OrderItem] ([Id], [OrderItemGuid], [OrderId], [PostId], [Quantity], [UnitPriceInclTax], [UnitPriceExclTax], [PriceInclTax], [PriceExclTax], [DiscountAmountInclTax], [DiscountAmountExclTax], [AttributeDescription], [AttributesXml], [DownloadCount], [IsDownloadActivated], [LicenseDownloadId], [ItemWeight], [BundleData], [PostCost], [TaxRate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (8, N'5cc48f50-84c9-479e-9700-a48ee00ad702', 7, 42, 1, CAST(3500.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(3500.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), NULL, NULL, 0, 0, 0, CAST(0.0000 AS Decimal(18, 4)), NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(N'2018-04-19T16:33:48.500' AS DateTime), N'Administrator', CAST(N'2018-04-19T16:33:48.500' AS DateTime), N'Administrator')
INSERT [dbo].[OrderItem] ([Id], [OrderItemGuid], [OrderId], [PostId], [Quantity], [UnitPriceInclTax], [UnitPriceExclTax], [PriceInclTax], [PriceExclTax], [DiscountAmountInclTax], [DiscountAmountExclTax], [AttributeDescription], [AttributesXml], [DownloadCount], [IsDownloadActivated], [LicenseDownloadId], [ItemWeight], [BundleData], [PostCost], [TaxRate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (9, N'18b97fd0-7bbe-4cc7-8f49-0aad822d94d6', 8, 55, 1, CAST(400000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(400000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), NULL, NULL, 0, 0, 0, CAST(0.0000 AS Decimal(18, 4)), NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(N'2018-04-19T16:35:20.993' AS DateTime), N'Administrator', CAST(N'2018-04-19T16:35:20.993' AS DateTime), N'Administrator')
INSERT [dbo].[OrderItem] ([Id], [OrderItemGuid], [OrderId], [PostId], [Quantity], [UnitPriceInclTax], [UnitPriceExclTax], [PriceInclTax], [PriceExclTax], [DiscountAmountInclTax], [DiscountAmountExclTax], [AttributeDescription], [AttributesXml], [DownloadCount], [IsDownloadActivated], [LicenseDownloadId], [ItemWeight], [BundleData], [PostCost], [TaxRate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (10, N'8c299210-ee6b-40b3-b6eb-d4c46d204dba', 9, 42, 1, CAST(10000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(10000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), NULL, NULL, 0, 0, 0, CAST(0.0000 AS Decimal(18, 4)), NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(N'2018-04-19T17:00:39.803' AS DateTime), N'Administrator', CAST(N'2018-04-19T17:00:39.803' AS DateTime), N'Administrator')
INSERT [dbo].[OrderItem] ([Id], [OrderItemGuid], [OrderId], [PostId], [Quantity], [UnitPriceInclTax], [UnitPriceExclTax], [PriceInclTax], [PriceExclTax], [DiscountAmountInclTax], [DiscountAmountExclTax], [AttributeDescription], [AttributesXml], [DownloadCount], [IsDownloadActivated], [LicenseDownloadId], [ItemWeight], [BundleData], [PostCost], [TaxRate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (11, N'01855d7e-320e-45d3-b981-b399441c0319', 10, 42, 1, CAST(10000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(10000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), NULL, NULL, 0, 0, 0, CAST(0.0000 AS Decimal(18, 4)), NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(N'2018-04-20T14:31:22.857' AS DateTime), N'Administrator', CAST(N'2018-04-20T14:31:22.857' AS DateTime), N'Administrator')
INSERT [dbo].[OrderItem] ([Id], [OrderItemGuid], [OrderId], [PostId], [Quantity], [UnitPriceInclTax], [UnitPriceExclTax], [PriceInclTax], [PriceExclTax], [DiscountAmountInclTax], [DiscountAmountExclTax], [AttributeDescription], [AttributesXml], [DownloadCount], [IsDownloadActivated], [LicenseDownloadId], [ItemWeight], [BundleData], [PostCost], [TaxRate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (12, N'0ea425d5-58b9-46bb-bb23-c66a67545b90', 11, 42, 1, CAST(10000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(10000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), NULL, NULL, 0, 0, 0, CAST(0.0000 AS Decimal(18, 4)), NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(N'2018-04-20T14:38:50.923' AS DateTime), N'Administrator', CAST(N'2018-04-20T14:38:50.923' AS DateTime), N'Administrator')
INSERT [dbo].[OrderItem] ([Id], [OrderItemGuid], [OrderId], [PostId], [Quantity], [UnitPriceInclTax], [UnitPriceExclTax], [PriceInclTax], [PriceExclTax], [DiscountAmountInclTax], [DiscountAmountExclTax], [AttributeDescription], [AttributesXml], [DownloadCount], [IsDownloadActivated], [LicenseDownloadId], [ItemWeight], [BundleData], [PostCost], [TaxRate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (13, N'dd680e44-88c3-4fcc-b4fc-d3acd58a0d8b', 12, 42, 1, CAST(10000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(10000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), NULL, NULL, 0, 0, 0, CAST(0.0000 AS Decimal(18, 4)), NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(N'2018-04-20T14:43:09.103' AS DateTime), N'Administrator', CAST(N'2018-04-20T14:43:09.103' AS DateTime), N'Administrator')
INSERT [dbo].[OrderItem] ([Id], [OrderItemGuid], [OrderId], [PostId], [Quantity], [UnitPriceInclTax], [UnitPriceExclTax], [PriceInclTax], [PriceExclTax], [DiscountAmountInclTax], [DiscountAmountExclTax], [AttributeDescription], [AttributesXml], [DownloadCount], [IsDownloadActivated], [LicenseDownloadId], [ItemWeight], [BundleData], [PostCost], [TaxRate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (14, N'2e4d36fb-f8eb-4c30-a17e-1fcce3c664cc', 13, 42, 1, CAST(10000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(10000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), NULL, NULL, 0, 0, 0, CAST(0.0000 AS Decimal(18, 4)), NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(N'2018-05-10T14:41:22.977' AS DateTime), N'Administrator', CAST(N'2018-05-10T14:41:22.977' AS DateTime), N'Administrator')
INSERT [dbo].[OrderItem] ([Id], [OrderItemGuid], [OrderId], [PostId], [Quantity], [UnitPriceInclTax], [UnitPriceExclTax], [PriceInclTax], [PriceExclTax], [DiscountAmountInclTax], [DiscountAmountExclTax], [AttributeDescription], [AttributesXml], [DownloadCount], [IsDownloadActivated], [LicenseDownloadId], [ItemWeight], [BundleData], [PostCost], [TaxRate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (15, N'783bd29c-258a-4aca-9595-fe31f7b713ee', 14, 42, 1, CAST(20000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(20000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), NULL, NULL, 0, 0, 0, CAST(0.0000 AS Decimal(18, 4)), NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(N'2018-05-13T12:53:54.880' AS DateTime), N'DemoVictim', CAST(N'2018-05-13T12:53:54.880' AS DateTime), N'DemoVictim')
INSERT [dbo].[OrderItem] ([Id], [OrderItemGuid], [OrderId], [PostId], [Quantity], [UnitPriceInclTax], [UnitPriceExclTax], [PriceInclTax], [PriceExclTax], [DiscountAmountInclTax], [DiscountAmountExclTax], [AttributeDescription], [AttributesXml], [DownloadCount], [IsDownloadActivated], [LicenseDownloadId], [ItemWeight], [BundleData], [PostCost], [TaxRate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (16, N'973ff94e-2d8c-48f3-a120-e2d3053bb3cc', 15, 42, 1, CAST(20000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(20000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), NULL, NULL, 0, 0, 0, CAST(0.0000 AS Decimal(18, 4)), NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(N'2018-05-20T15:04:32.433' AS DateTime), N'Administrator', CAST(N'2018-05-20T15:04:32.433' AS DateTime), N'Administrator')
INSERT [dbo].[OrderItem] ([Id], [OrderItemGuid], [OrderId], [PostId], [Quantity], [UnitPriceInclTax], [UnitPriceExclTax], [PriceInclTax], [PriceExclTax], [DiscountAmountInclTax], [DiscountAmountExclTax], [AttributeDescription], [AttributesXml], [DownloadCount], [IsDownloadActivated], [LicenseDownloadId], [ItemWeight], [BundleData], [PostCost], [TaxRate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (17, N'adb95f82-a7a9-493c-8cee-845d770e9a28', 16, 54, 2, CAST(50000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(100000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), NULL, NULL, 0, 0, 0, CAST(0.0000 AS Decimal(18, 4)), NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(N'2018-05-23T16:52:40.570' AS DateTime), N'Administrator', CAST(N'2018-05-23T16:52:40.570' AS DateTime), N'Administrator')
INSERT [dbo].[OrderItem] ([Id], [OrderItemGuid], [OrderId], [PostId], [Quantity], [UnitPriceInclTax], [UnitPriceExclTax], [PriceInclTax], [PriceExclTax], [DiscountAmountInclTax], [DiscountAmountExclTax], [AttributeDescription], [AttributesXml], [DownloadCount], [IsDownloadActivated], [LicenseDownloadId], [ItemWeight], [BundleData], [PostCost], [TaxRate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (18, N'05c47ff0-4be4-4629-b5d2-8a225adbe586', 17, 55, 1, CAST(400000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(400000.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), NULL, NULL, 0, 0, 0, CAST(0.0000 AS Decimal(18, 4)), NULL, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(N'2018-05-27T14:20:29.993' AS DateTime), N'Administrator', CAST(N'2018-05-27T14:20:29.993' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[OrderItem] OFF
SET IDENTITY_INSERT [dbo].[PageBanner] ON 

INSERT [dbo].[PageBanner] ([Id], [Language], [PageName], [Status], [OrderDisplay], [Position], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1, NULL, N'Đầu trang', 1, 1, 1, CAST(N'2017-02-20T06:52:32.000' AS DateTime), N'Administrator', CAST(N'2017-02-20T06:52:32.000' AS DateTime), N'Administrator')
INSERT [dbo].[PageBanner] ([Id], [Language], [PageName], [Status], [OrderDisplay], [Position], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2, NULL, N'Giữa trang', 1, 2, 6, CAST(N'2017-02-20T06:52:40.987' AS DateTime), N'Administrator', CAST(N'2017-02-20T06:52:40.987' AS DateTime), N'Administrator')
INSERT [dbo].[PageBanner] ([Id], [Language], [PageName], [Status], [OrderDisplay], [Position], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (3, NULL, N'Cuối trang', 1, 4, 9, CAST(N'2017-02-20T06:52:54.053' AS DateTime), N'Administrator', CAST(N'2017-06-28T16:28:16.853' AS DateTime), N'Administrator')
INSERT [dbo].[PageBanner] ([Id], [Language], [PageName], [Status], [OrderDisplay], [Position], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (4, NULL, N'Cạnh tranh (Side Bar)', 1, 1, 5, CAST(N'2017-03-15T20:40:21.883' AS DateTime), N'Administrator', CAST(N'2017-03-15T20:40:21.883' AS DateTime), N'Administrator')
INSERT [dbo].[PageBanner] ([Id], [Language], [PageName], [Status], [OrderDisplay], [Position], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (5, NULL, N'Quy trình', 1, 5, 6, CAST(N'2017-03-23T18:07:57.647' AS DateTime), N'Administrator', CAST(N'2017-06-28T16:28:58.740' AS DateTime), N'Administrator')
INSERT [dbo].[PageBanner] ([Id], [Language], [PageName], [Status], [OrderDisplay], [Position], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (6, NULL, N'Home product', 1, 1, 10, CAST(N'2017-06-05T17:35:36.347' AS DateTime), N'Administrator', CAST(N'2018-01-17T16:56:22.523' AS DateTime), N'Administrator')
INSERT [dbo].[PageBanner] ([Id], [Language], [PageName], [Status], [OrderDisplay], [Position], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (7, NULL, N'Slide dau trang', 1, 1, 5, CAST(N'2017-10-12T14:27:14.703' AS DateTime), N'Administrator', CAST(N'2017-12-14T15:32:39.080' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[PageBanner] OFF
SET IDENTITY_INSERT [dbo].[PaymentMethod] ON 

INSERT [dbo].[PaymentMethod] ([Id], [PaymentMethodSystemName], [Description], [ImageUrl], [Status], [OrderDisplay], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1, N'DHL', NULL, N'images/paymentmethod/dhl-dae54568-5bbc-42de-ae45-a51741e0dbe0.jpg', 1, 1, CAST(N'2017-01-01T00:00:00.000' AS DateTime), NULL, CAST(N'2018-03-08T15:54:52.477' AS DateTime), N'Administrator')
INSERT [dbo].[PaymentMethod] ([Id], [PaymentMethodSystemName], [Description], [ImageUrl], [Status], [OrderDisplay], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2, N'Trademark', NULL, N'images/paymentmethod/trademark-fd34d859-91a5-44ab-b718-10e7710e2adf.jpg', 1, 1, CAST(N'2017-01-01T00:00:00.000' AS DateTime), NULL, CAST(N'2018-03-08T15:55:08.930' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[PaymentMethod] OFF
SET IDENTITY_INSERT [dbo].[Post] ON 

INSERT [dbo].[Post] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [ShortDesc], [Description], [Status], [OrderDisplay], [ViewCount], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [Price], [Discount], [ShowOnHomePage], [ProductHot], [OutOfStock], [ProductNew], [VirtualCatUrl], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [StartDate], [PostType], [ProductCode], [EndDate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [TechInfo], [OldOrNew], [ManufacturerId]) VALUES (42, 5, N'5c845240-517d-4592-acd4-15773d9344a0', NULL, N'Khu du lịch Cát Vân', NULL, NULL, 1, 0, 13, N'Khu du lịch Cát Vân', N'Khu du lịch Cát Vân', N'Khu du lịch Cát Vân', N'khu-du-lich-cat-van', CAST(10000.0000 AS Decimal(18, 4)), CAST(50.0000 AS Decimal(18, 4)), 1, 1, 0, 1, N'quy-hoach/quy-hoach-do-thi', N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.4464b4e9.jpg', N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.cb0d92bb.jpg', N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.43466b4b.jpg', NULL, 0, N'KDLCV2018.05.10', NULL, CAST(N'2017-06-18T11:48:03.243' AS DateTime), N'Administrator', CAST(N'2018-05-27T14:28:24.317' AS DateTime), N'Administrator', NULL, 1, 6)
INSERT [dbo].[Post] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [ShortDesc], [Description], [Status], [OrderDisplay], [ViewCount], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [Price], [Discount], [ShowOnHomePage], [ProductHot], [OutOfStock], [ProductNew], [VirtualCatUrl], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [StartDate], [PostType], [ProductCode], [EndDate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [TechInfo], [OldOrNew], [ManufacturerId]) VALUES (50, 2127, N'ca19fb4a-10a1-4515-bdb2-0c091b4107d5/9e77cd8f-b733-4fbb-9f7c-27384b46fd4b', NULL, N'Ghế nhựa kiểu dạng lưới cao cấp', NULL, NULL, 1, 0, 5, N'Ghế nhựa kiểu dạng lưới cao cấp', N'Ghế nhựa kiểu dạng lưới cao cấp', N'Ghế nhựa kiểu dạng lưới cao cấp', N'ghe-nhua-kieu-dang-luoi-cao-cap', CAST(10.0000 AS Decimal(18, 4)), CAST(2.0000 AS Decimal(18, 4)), 1, 1, 0, 1, N'thoi-trang/quan-tay', N'images/post/2018.GNKDLCC/slide-ghe-nhua-kieu-dang-luoi-cao-cap.cbccec44.jpg', N'images/post/2018.GNKDLCC/slide-ghe-nhua-kieu-dang-luoi-cao-cap.aa62d2a4.jpg', N'images/post/2018.GNKDLCC/slide-ghe-nhua-kieu-dang-luoi-cao-cap.dce01ec1.jpg', NULL, 0, N'GNKDLCC2018.05.15', NULL, CAST(N'2017-10-14T21:41:57.463' AS DateTime), N'Administrator', CAST(N'2018-05-27T14:18:28.567' AS DateTime), N'Administrator', NULL, 1, 7)
INSERT [dbo].[Post] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [ShortDesc], [Description], [Status], [OrderDisplay], [ViewCount], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [Price], [Discount], [ShowOnHomePage], [ProductHot], [OutOfStock], [ProductNew], [VirtualCatUrl], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [StartDate], [PostType], [ProductCode], [EndDate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [TechInfo], [OldOrNew], [ManufacturerId]) VALUES (54, 2127, N'ca19fb4a-10a1-4515-bdb2-0c091b4107d5/9e77cd8f-b733-4fbb-9f7c-27384b46fd4b', NULL, N'Áo tennis nữDonexpro MC-8882-X (Đen)', NULL, NULL, 1, 3, 3, N'Áo tennis nữDonexpro MC-8882-X (Đen)', N'Áo tennis nữDonexpro MC-8882-X (Đen)', N'Áo tennis nữDonexpro MC-8882-X (Đen)', N'ao-tennis-nudonexpro-mc-8882-x-den', CAST(50000.0000 AS Decimal(18, 4)), CAST(2500.0000 AS Decimal(18, 4)), 1, 1, 0, 1, N'thoi-trang/quan-tay', N'images/post/16022018/ao-tennis-nudonexpro-mc-8882-x-den-973e7e20-b662-4f47-a2e9-721e4cc3c279.jpg', N'images/post/16022018/ao-tennis-nudonexpro-mc-8882-x-den-c402e0e4-3419-4914-913c-c312ad5fff06.jpg', N'images/post/16022018/ao-tennis-nudonexpro-mc-8882-x-den-525f170f-269c-4a1d-9ee0-ecdf9c10daed.jpg', NULL, 0, N'MC-8882-', NULL, CAST(N'2018-02-16T11:45:04.427' AS DateTime), N'Administrator', CAST(N'2018-05-23T16:52:11.627' AS DateTime), N'Administrator', NULL, 1, 7)
INSERT [dbo].[Post] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [ShortDesc], [Description], [Status], [OrderDisplay], [ViewCount], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [Price], [Discount], [ShowOnHomePage], [ProductHot], [OutOfStock], [ProductNew], [VirtualCatUrl], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [StartDate], [PostType], [ProductCode], [EndDate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [TechInfo], [OldOrNew], [ManufacturerId]) VALUES (55, 2126, N'ca19fb4a-10a1-4515-bdb2-0c091b4107d5/7f1600ec-deec-426c-a926-95178701ae42', NULL, N'Nồi Áp Suất MIDEA MY-12CH501B', NULL, NULL, 1, 1, 21, N'Nồi Áp Suất MIDEA MY-12CH501B', N'Nồi Áp Suất MIDEA MY-12CH501B', N'Nồi Áp Suất MIDEA MY-12CH501B', N'noi-ap-suat-midea-my-12ch501b', CAST(400000.0000 AS Decimal(18, 4)), NULL, 1, 1, 0, 1, N'thoi-trang/ao-khoac', N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.ccf611d5.jpg', N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.fdf5866e.jpg', N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.472ac75c.jpg', NULL, 0, N'Nồi Áp Suất MIDEA MY-12CH501B', NULL, CAST(N'2018-02-16T12:50:32.297' AS DateTime), N'Administrator', CAST(N'2018-05-27T14:18:53.597' AS DateTime), N'Administrator', NULL, 1, 7)
INSERT [dbo].[Post] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [ShortDesc], [Description], [Status], [OrderDisplay], [ViewCount], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [Price], [Discount], [ShowOnHomePage], [ProductHot], [OutOfStock], [ProductNew], [VirtualCatUrl], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [StartDate], [PostType], [ProductCode], [EndDate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [TechInfo], [OldOrNew], [ManufacturerId]) VALUES (63, 2126, N'ca19fb4a-10a1-4515-bdb2-0c091b4107d5/7f1600ec-deec-426c-a926-95178701ae42', NULL, N'Biệt thự phố, mr Duy (0983 83 45 69)', NULL, NULL, 1, 0, 1, N'Biệt thự phố, mr Duy (0983 83 45 69)', N'Biệt thự phố, mr Duy (0983 83 45 69)', N'Biệt thự phố, mr Duy (0983 83 45 69)', N'biet-thu-pho-mr-duy-0983-83-45-69', CAST(10000.0000 AS Decimal(18, 4)), CAST(50.0000 AS Decimal(18, 4)), 1, 1, 1, 1, N'thoi-trang/ao-khoac', N'images/post/2018.BTPMD-846/slide-biet-thu-pho-mr-duy-0983-83-45-69.df8677d2.jpg', N'images/post/2018.BTPMD-846/slide-biet-thu-pho-mr-duy-0983-83-45-69.59523800.jpg', N'images/post/2018.BTPMD-846/slide-biet-thu-pho-mr-duy-0983-83-45-69.9bdd78c6.jpg', NULL, 0, N'BTPMD(8462018.05.13', NULL, CAST(N'2018-04-03T15:45:33.190' AS DateTime), N'Administrator', CAST(N'2018-05-20T12:07:32.537' AS DateTime), N'Administrator', NULL, 1, 12)
INSERT [dbo].[Post] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [ShortDesc], [Description], [Status], [OrderDisplay], [ViewCount], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [Price], [Discount], [ShowOnHomePage], [ProductHot], [OutOfStock], [ProductNew], [VirtualCatUrl], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [StartDate], [PostType], [ProductCode], [EndDate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [TechInfo], [OldOrNew], [ManufacturerId]) VALUES (95, 3, N'ca19fb4a-10a1-4515-bdb2-0c091b4107d5/c52e52e6-e13f-4830-9347-550ee86fbf7d', NULL, N'Quần jean', NULL, NULL, 1, 0, 3, N'Quần jean', N'Quần jean', N'Quần jean', N'quan-jean', CAST(100000.0000 AS Decimal(18, 4)), CAST(50.0000 AS Decimal(18, 4)), 1, 1, 0, 1, N'thoi-trang/ao-so-mi', N'images/post/2018.QJ/slide-quan-jean.a19a0234.jpg', N'images/post/2018.QJ/slide-quan-jean.0b179451.jpg', N'images/post/2018.QJ/slide-quan-jean.2564f778.jpg', NULL, 0, N'Quần jean', NULL, CAST(N'2018-04-14T17:08:23.613' AS DateTime), N'truong thanh cong', CAST(N'2018-05-15T15:03:04.903' AS DateTime), N'Administrator', NULL, 1, 6)
INSERT [dbo].[Post] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [ShortDesc], [Description], [Status], [OrderDisplay], [ViewCount], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [Price], [Discount], [ShowOnHomePage], [ProductHot], [OutOfStock], [ProductNew], [VirtualCatUrl], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [StartDate], [PostType], [ProductCode], [EndDate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [TechInfo], [OldOrNew], [ManufacturerId]) VALUES (96, 2122, N'5c845240-517d-4592-acd4-15773d9344a0/6c64d3e8-dd86-4dcc-a4ea-2b340e86051c', NULL, N'Nhà ông Trương Công Thuận - 0937.407479', NULL, NULL, 1, 0, 0, N'Nhà ông Trương Công Thuận - 0937.407479', N'Nhà ông Trương Công Thuận - 0937.407479', N'Nhà ông Trương Công Thuận - 0937.407479', N'nha-ong-truong-cong-thuan-0937-407479', CAST(5000000.0000 AS Decimal(18, 4)), CAST(10.0000 AS Decimal(18, 4)), 0, 1, 0, 1, N'phu-kien-cong-nghe/quy-hoach-do-thi', N'images/post/2018.NASKDC6I/slide-nha-anh-son-khu-dan-cu-6b-intresco.1ff42d59.jpg', N'images/post/2018.NASKDC6I/slide-nha-anh-son-khu-dan-cu-6b-intresco.f9af874b.jpg', N'images/post/2018.NASKDC6I/slide-nha-anh-son-khu-dan-cu-6b-intresco.cc44cb09.jpg', NULL, 0, N'NOTCT-02018.05.13', NULL, CAST(N'2018-04-14T17:08:23.700' AS DateTime), N'truong thanh cong', CAST(N'2018-05-13T13:58:28.910' AS DateTime), N'Administrator', NULL, 1, 7)
INSERT [dbo].[Post] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [ShortDesc], [Description], [Status], [OrderDisplay], [ViewCount], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [Price], [Discount], [ShowOnHomePage], [ProductHot], [OutOfStock], [ProductNew], [VirtualCatUrl], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [StartDate], [PostType], [ProductCode], [EndDate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [TechInfo], [OldOrNew], [ManufacturerId]) VALUES (97, 2122, N'5c845240-517d-4592-acd4-15773d9344a0/6c64d3e8-dd86-4dcc-a4ea-2b340e86051c', NULL, N'Căn hộ Imperia An Phú Quận 2', NULL, NULL, 1, 1, 1, N'Căn hộ Imperia An Phú Quận 2', N'Căn hộ Imperia An Phú Quận 2', N'Căn hộ Imperia An Phú Quận 2', N'can-ho-imperia-an-phu-quan-2', CAST(400000.0000 AS Decimal(18, 4)), NULL, 1, 1, 0, 1, N'phu-kien-cong-nghe/quy-hoach-do-thi', N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.a5f8f122.jpg', N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.683d0b50.jpg', N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.78651338.jpg', NULL, 0, N'CHIAPQ22018.05.13', NULL, CAST(N'2018-04-14T17:15:38.940' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:58:50.017' AS DateTime), N'Administrator', NULL, 1, 7)
INSERT [dbo].[Post] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [ShortDesc], [Description], [Status], [OrderDisplay], [ViewCount], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [Price], [Discount], [ShowOnHomePage], [ProductHot], [OutOfStock], [ProductNew], [VirtualCatUrl], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [StartDate], [PostType], [ProductCode], [EndDate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [TechInfo], [OldOrNew], [ManufacturerId]) VALUES (99, 2122, N'5c845240-517d-4592-acd4-15773d9344a0/6c64d3e8-dd86-4dcc-a4ea-2b340e86051c', NULL, N'Quần tây', NULL, NULL, 1, 0, 1, N'Quần tây', N'Quần tây', N'Quần tây', N'quan-tay-1', CAST(5000000.0000 AS Decimal(18, 4)), CAST(10.0000 AS Decimal(18, 4)), 0, 1, 0, 1, N'phu-kien-cong-nghe/quy-hoach-do-thi', N'images/post/2018.QT/slide-quan-tay.7e3df6df.jpg', N'images/post/2018.QT/slide-quan-tay.1574d4e1.jpg', N'images/post/2018.QT/slide-quan-tay.ba018de8.jpg', NULL, 0, N'QT2018.05.13', NULL, CAST(N'2018-04-14T17:42:05.960' AS DateTime), N'Administrator', CAST(N'2018-05-20T15:35:12.470' AS DateTime), N'Administrator', NULL, 1, 7)
INSERT [dbo].[Post] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [ShortDesc], [Description], [Status], [OrderDisplay], [ViewCount], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [Price], [Discount], [ShowOnHomePage], [ProductHot], [OutOfStock], [ProductNew], [VirtualCatUrl], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [StartDate], [PostType], [ProductCode], [EndDate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [TechInfo], [OldOrNew], [ManufacturerId]) VALUES (100, 5, N'5c845240-517d-4592-acd4-15773d9344a0', NULL, N'Áo vest', NULL, NULL, 1, 0, 0, N'Áo vest', N'Áo vest', N'Áo vest', N'ao-vest', CAST(10000.0000 AS Decimal(18, 4)), CAST(50.0000 AS Decimal(18, 4)), 1, 1, 0, 1, N'quy-hoach/quy-hoach-do-thi', N'images/post/2018.AV/04_nice-dress.3bcc58ca.jpg', N'images/post/2018.AV/04_nice-dress.60a4df0b.jpg', N'images/post/2018.AV/04_nice-dress.20f76040.jpg', NULL, 0, N'AV2018.05.13', NULL, CAST(N'2018-04-19T16:00:49.120' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:03:23.493' AS DateTime), N'Administrator', NULL, 1, 6)
INSERT [dbo].[Post] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [ShortDesc], [Description], [Status], [OrderDisplay], [ViewCount], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [Price], [Discount], [ShowOnHomePage], [ProductHot], [OutOfStock], [ProductNew], [VirtualCatUrl], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [StartDate], [PostType], [ProductCode], [EndDate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [TechInfo], [OldOrNew], [ManufacturerId]) VALUES (101, 3, N'ca19fb4a-10a1-4515-bdb2-0c091b4107d5/c52e52e6-e13f-4830-9347-550ee86fbf7d', NULL, N'Dự án Long An', NULL, NULL, 1, 0, 0, N'Dự án Long An', N'Dự án Long An', N'Dự án Long An', N'du-an-long-an', CAST(5000.0000 AS Decimal(18, 4)), CAST(3000.0000 AS Decimal(18, 4)), 1, 0, 0, 0, N'thoi-trang/ao-so-mi', N'images/post/2018.DALA/slide-du-an-long-an.0e8808ec.jpg', N'images/post/2018.DALA/slide-du-an-long-an.4efa6a26.jpg', N'images/post/2018.DALA/slide-du-an-long-an.6bb821af.jpg', NULL, 0, N'DALA2018.04.20', NULL, CAST(N'2018-04-20T16:16:45.420' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:53:58.320' AS DateTime), N'Administrator', NULL, 0, 5)
INSERT [dbo].[Post] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [ShortDesc], [Description], [Status], [OrderDisplay], [ViewCount], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [Price], [Discount], [ShowOnHomePage], [ProductHot], [OutOfStock], [ProductNew], [VirtualCatUrl], [ImageBigSize], [ImageMediumSize], [ImageSmallSize], [StartDate], [PostType], [ProductCode], [EndDate], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [TechInfo], [OldOrNew], [ManufacturerId]) VALUES (102, 2132, N'ca19fb4a-10a1-4515-bdb2-0c091b4107d5/c52e52e6-e13f-4830-9347-550ee86fbf7d', NULL, N'Maecenas consequat mauris', NULL, NULL, 1, 1, 1, N'Maecenas consequat mauris', N'Maecenas consequat mauris', N'Maecenas consequat mauris', N'maecenas-consequat-mauris', NULL, NULL, 1, 0, 0, 0, N'thoi-trang/chan-vay', N'images/post/2018.MCM/slide-maecenas-consequat-mauris.5102dd3a.jpg', N'images/post/2018.MCM/slide-maecenas-consequat-mauris.103c1e4d.jpg', N'images/post/2018.MCM/slide-maecenas-consequat-mauris.90cf187b.jpg', NULL, 0, N'MCM2018.05.19', NULL, CAST(N'2018-05-19T11:55:14.557' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:24:00.600' AS DateTime), N'Administrator', NULL, 0, 5)
SET IDENTITY_INSERT [dbo].[Post] OFF
INSERT [dbo].[PostAttribute] ([AttibuteValueId], [PostId]) VALUES (1, 42)
INSERT [dbo].[PostAttribute] ([AttibuteValueId], [PostId]) VALUES (2, 42)
INSERT [dbo].[PostAttribute] ([AttibuteValueId], [PostId]) VALUES (1, 50)
INSERT [dbo].[PostAttribute] ([AttibuteValueId], [PostId]) VALUES (2, 50)
INSERT [dbo].[PostAttribute] ([AttibuteValueId], [PostId]) VALUES (1, 100)
INSERT [dbo].[PostAttribute] ([AttibuteValueId], [PostId]) VALUES (1, 101)
INSERT [dbo].[PostAttribute] ([AttibuteValueId], [PostId]) VALUES (2, 101)
INSERT [dbo].[PostAttribute] ([AttibuteValueId], [PostId]) VALUES (1, 102)
INSERT [dbo].[PostAttribute] ([AttibuteValueId], [PostId]) VALUES (3, 102)
SET IDENTITY_INSERT [dbo].[PostGallery] ON 

INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (6, 54, NULL, 0, N'images/post/15122017/jp-png-bba0d0c3-38dd-4df0-89a0-d5859f6e577e.png', N'images/post/15122017/jp-png-bfd68457-cfda-459b-83e3-282a6f2d028f.png', N'images/post/15122017/jp-png-a5733963-4d9b-4e43-81cb-e8480f5392f7.png', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (7, 54, NULL, 0, N'images/post/15122017/jp-png-2f8d6972-556b-4769-b7df-8120a7ff84fc.png', N'images/post/15122017/jp-png-d226524e-721c-4b2c-86b5-9463d3d4e218.png', N'images/post/15122017/jp-png-a76137d9-0bf2-4380-b177-0c1191ccd2dd.png', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (13, 53, NULL, 0, N'images/post/19122017/basket-1-png-9b1ca9fc-b8c3-4105-936e-e67a7a7d0b6e.png', N'images/post/19122017/basket-1-png-0b808a6f-ab2c-4810-8345-84e8c90331c1.png', N'images/post/19122017/basket-1-png-d557c09f-acea-45e3-95b8-a64d1c2140c1.png', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (14, 53, NULL, 0, N'images/post/19122017/briefcase-1-png-c3cc6266-2d88-4bd0-9d34-86b9b1ec2513.png', N'images/post/19122017/briefcase-1-png-1337963d-1626-42e3-a455-02e2d9d2f907.png', N'images/post/19122017/briefcase-1-png-d7a09f54-2f58-4e72-b3e4-46806eaf520d.png', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (16, 40, NULL, 0, N'images/post/12012018/la-con-gai-vap-that-tuyet-04-463x348-jpg-a413433f-e1b2-4209-90cd-4922af991b9a.jpg', N'images/post/12012018/la-con-gai-vap-that-tuyet-04-463x348-jpg-ea07b38c-55e5-45da-ae33-828e7dc7ed4e.jpg', N'images/post/12012018/la-con-gai-vap-that-tuyet-04-463x348-jpg-107f93b3-54b5-49cb-92d8-8e19a8ea6fc1.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (17, 40, NULL, 0, N'images/post/12012018/don-giang-sinh-ap-cung-dai-gia-dinh-van-phat-03-463x348-png-5a8748a0-5296-4cac-833d-f6a093efc190.png', N'images/post/12012018/don-giang-sinh-ap-cung-dai-gia-dinh-van-phat-03-463x348-png-0db36b15-ebdf-4f7f-9d23-f84391dd4744.png', N'images/post/12012018/don-giang-sinh-ap-cung-dai-gia-dinh-van-phat-03-463x348-png-0e5dec6c-5286-486e-9b8b-b5d9b37c1214.png', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (18, 40, NULL, 0, N'images/post/04022018/a1-jpg-ee64d3a9-6772-4a81-9f08-7618ea784add.jpg', N'images/post/04022018/a1-jpg-dde06850-868c-4f67-af20-35a722da50ae.jpg', N'images/post/04022018/a1-jpg-99a0c74c-f2f3-4462-83ab-affdeeaaa345.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (19, 41, NULL, 0, N'images/post/04022018/la-con-gai-vap-that-tuyet-04-463x348-jpg-92284b7c-392a-4bc5-8787-a884c1165da2.jpg', N'images/post/04022018/la-con-gai-vap-that-tuyet-04-463x348-jpg-9086549c-5fb1-42fc-ae3e-651b5436aed1.jpg', N'images/post/04022018/la-con-gai-vap-that-tuyet-04-463x348-jpg-360ca1b0-c2ef-409c-bef5-7a99ed33556e.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (20, 41, NULL, 0, N'images/post/04022018/don-giang-sinh-ap-cung-dai-gia-dinh-van-phat-03-463x348-png-2c820095-2026-4981-8287-5c88fd7ff3e4.png', N'images/post/04022018/don-giang-sinh-ap-cung-dai-gia-dinh-van-phat-03-463x348-png-f23b5bdf-553a-435a-b744-0aceaabd4504.png', N'images/post/04022018/don-giang-sinh-ap-cung-dai-gia-dinh-van-phat-03-463x348-png-f8294bdc-bf8d-48dd-af5e-342d761bd3ce.png', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (21, 48, NULL, 0, N'images/post/16022018/afadf-jpg-7b3c37da-8846-4d62-91e4-a5ca95b14b0a.jpg', N'images/post/16022018/afadf-jpg-0f7df886-dca2-42c8-ae5e-f9f789a4b05a.jpg', N'images/post/16022018/afadf-jpg-eda247a9-0b00-4ff7-ac9f-f0694082ce9a.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (22, 48, NULL, 0, N'images/post/16022018/a-jpg-813a736a-221d-4c1a-8468-7d73d04c63c9.jpg', N'images/post/16022018/a-jpg-cf6b7bf5-1167-4181-9832-40d4cfa03747.jpg', N'images/post/16022018/a-jpg-6f6ba1fe-36ed-4021-82c1-68562b45d999.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (23, 53, NULL, 0, N'images/post/18022018/fadf-jpg-652dbb43-1993-454e-a802-e09c0769b637.jpg', N'images/post/18022018/fadf-jpg-dee14634-8e6c-4919-b39e-94849d37ca8c.jpg', N'images/post/18022018/fadf-jpg-0e1f307b-2acf-4952-9655-b40a11b765f4.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (24, 53, NULL, 0, N'images/post/18022018/p52_medium-jpg-fb3edf87-94a6-4205-b378-7437a0e725a1.jpg', N'images/post/18022018/p52_medium-jpg-19e017cd-6e7f-49df-a738-b63d9049730a.jpg', N'images/post/18022018/p52_medium-jpg-ae2c0751-b501-494f-be79-ed4a2b8f7653.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (25, 53, NULL, 0, N'images/post/18022018/p53_medium-jpg-eb738dc7-5b76-414e-818f-9cd9f77e32c2.jpg', N'images/post/18022018/p53_medium-jpg-e50e6191-5889-4ed0-b146-8649b1677d75.jpg', N'images/post/18022018/p53_medium-jpg-de66cc95-0e9f-4667-aa7c-058749207fc1.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (26, 46, NULL, 0, N'images/post/24032018/20171226145615-0fcb_wm-jpg-3f663689-c789-4513-8c08-16b61b8ed011.jpg', N'images/post/24032018/20171226145615-0fcb_wm-jpg-763c5166-ea46-44ac-8b52-aed64a340ba9.jpg', N'images/post/24032018/20171226145615-0fcb_wm-jpg-f8795963-076f-4964-a1b0-401fd5b0ee20.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (27, 46, NULL, 0, N'images/post/24032018/fadf-jpg-15808174-edea-4429-9632-19f7a9628adc.jpg', N'images/post/24032018/fadf-jpg-0d41290f-9f89-4aa9-a79a-99234d419f4f.jpg', N'images/post/24032018/fadf-jpg-66db20e8-00c8-47da-a007-36277e204a71.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (45, 94, NULL, 0, N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.da2fd809.jpg', N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.1c3dff40.jpg', N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.dc04cfd7.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (46, 94, NULL, 1, N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.1cb7e696.jpg', N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.d14abcd2.jpg', N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.7eb43171.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (47, 94, NULL, 2, N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.d7c2a153.jpg', N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.1ad3b0a0.jpg', N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.d4cfbdd7.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (53, 100, NULL, 2, N'images/post/2018.AV/slide-ao-vest.7835c32b.jpg', N'images/post/2018.AV/slide-ao-vest.c65d0f25.jpg', N'images/post/2018.AV/slide-ao-vest.16de7044.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (54, 99, NULL, 0, N'images/post/2018.QT/slide-quan-tay.7e3df6df.jpg', N'images/post/2018.QT/slide-quan-tay.ba018de8.jpg', N'images/post/2018.QT/slide-quan-tay.1574d4e1.jpg', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (55, 99, NULL, 1, N'images/post/2018.QT/slide-quan-tay.f166977e.jpg', N'images/post/2018.QT/slide-quan-tay.d206ea08.jpg', N'images/post/2018.QT/slide-quan-tay.4386cc2b.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (56, 99, NULL, 2, N'images/post/2018.QT/slide-quan-tay.6546bb1f.jpg', N'images/post/2018.QT/slide-quan-tay.39672112.jpg', N'images/post/2018.QT/slide-quan-tay.a04372bd.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (57, 97, NULL, 0, N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.891e75d6.png', N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.25122093.png', N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.d4c43e77.png', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (58, 97, NULL, 1, N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.a5f8f122.jpg', N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.78651338.jpg', N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.683d0b50.jpg', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (59, 97, NULL, 2, N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.66368e4a.jpg', N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.0186ab88.jpg', N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.c46449c2.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (60, 96, NULL, 0, N'images/post/2018.NASKDC6I/slide-nha-anh-son-khu-dan-cu-6b-intresco.1ff42d59.jpg', N'images/post/2018.NASKDC6I/slide-nha-anh-son-khu-dan-cu-6b-intresco.cc44cb09.jpg', N'images/post/2018.NASKDC6I/slide-nha-anh-son-khu-dan-cu-6b-intresco.f9af874b.jpg', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (61, 96, NULL, 1, N'images/post/2018.NASKDC6I/slide-nha-anh-son-khu-dan-cu-6b-intresco.9a8fd4e6.jpg', N'images/post/2018.NASKDC6I/slide-nha-anh-son-khu-dan-cu-6b-intresco.23cc7b72.jpg', N'images/post/2018.NASKDC6I/slide-nha-anh-son-khu-dan-cu-6b-intresco.6e6d0651.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (62, 96, NULL, 2, N'images/post/2018.NASKDC6I/slide-nha-anh-son-khu-dan-cu-6b-intresco.edc80344.JPG', N'images/post/2018.NASKDC6I/slide-nha-anh-son-khu-dan-cu-6b-intresco.2e8c85a9.JPG', N'images/post/2018.NASKDC6I/slide-nha-anh-son-khu-dan-cu-6b-intresco.ceea442f.JPG', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (63, 63, NULL, 0, N'images/post/2018.BTPMD-846/slide-biet-thu-pho-mr-duy-0983-83-45-69.f851e735.jpg', N'images/post/2018.BTPMD-846/slide-biet-thu-pho-mr-duy-0983-83-45-69.e9b6ad8d.jpg', N'images/post/2018.BTPMD-846/slide-biet-thu-pho-mr-duy-0983-83-45-69.ac9727be.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (64, 63, NULL, 1, N'images/post/2018.BTPMD-846/slide-biet-thu-pho-mr-duy-0983-83-45-69.df8677d2.jpg', N'images/post/2018.BTPMD-846/slide-biet-thu-pho-mr-duy-0983-83-45-69.9bdd78c6.jpg', N'images/post/2018.BTPMD-846/slide-biet-thu-pho-mr-duy-0983-83-45-69.59523800.jpg', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (67, 42, NULL, 0, N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.4464b4e9.jpg', N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.43466b4b.jpg', N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.cb0d92bb.jpg', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (68, 42, NULL, 1, N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.e040bcce.jpg', N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.5521f7a7.jpg', N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.ee38ee55.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (69, 42, NULL, 2, N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.173257fd.jpg', N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.7044489d.jpg', N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.8f6c7a5a.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (70, 42, NULL, 3, N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.e0a0bf94.jpg', N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.e0a1aa3e.jpg', N'images/post/2018.KDLCV/slide-khu-du-lich-cat-van.a54c50a3.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (74, 95, NULL, 0, N'images/post/2018.QJ/slide-quan-jean.a19a0234.jpg', N'images/post/2018.QJ/slide-quan-jean.2564f778.jpg', N'images/post/2018.QJ/slide-quan-jean.0b179451.jpg', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (75, 50, NULL, 0, N'images/post/2018.GNKDLCC/slide-ghe-nhua-kieu-dang-luoi-cao-cap.cbccec44.jpg', N'images/post/2018.GNKDLCC/slide-ghe-nhua-kieu-dang-luoi-cao-cap.dce01ec1.jpg', N'images/post/2018.GNKDLCC/slide-ghe-nhua-kieu-dang-luoi-cao-cap.aa62d2a4.jpg', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (76, 55, NULL, 0, N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.67fc93e6.jpg', N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.c237bae0.jpg', N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.f4a1bad2.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (77, 55, NULL, 1, N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.ccf611d5.jpg', N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.472ac75c.jpg', N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.fdf5866e.jpg', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (78, 55, NULL, 2, N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.d610b35a.jpg', N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.42e1a4f1.jpg', N'images/post/2018.NASMM/slide-noi-ap-suat-midea-my-12ch501b.fa046423.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (84, 101, NULL, 0, N'images/post/2018.DALA/slide-du-an-long-an.03bb8ad5.jpg', N'images/post/2018.DALA/slide-du-an-long-an.3b028b9b.jpg', N'images/post/2018.DALA/slide-du-an-long-an.d30bd77d.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (85, 101, NULL, 1, N'images/post/2018.DALA/slide-du-an-long-an.0e8808ec.jpg', N'images/post/2018.DALA/slide-du-an-long-an.6bb821af.jpg', N'images/post/2018.DALA/slide-du-an-long-an.4efa6a26.jpg', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (86, 101, NULL, 2, N'images/post/2018.DALA/slide-du-an-long-an.b2ee7603.jpg', N'images/post/2018.DALA/slide-du-an-long-an.0168b98d.jpg', N'images/post/2018.DALA/slide-du-an-long-an.362d7f59.jpg', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[PostGallery] ([Id], [PostId], [Title], [OrderDisplay], [ImageBigSize], [ImageSmallSize], [ImageMediumSize], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Status], [IsAvatar]) VALUES (93, 102, NULL, 0, N'images/post/2018.MCM/slide-maecenas-consequat-mauris.5102dd3a.jpg', N'images/post/2018.MCM/slide-maecenas-consequat-mauris.90cf187b.jpg', N'images/post/2018.MCM/slide-maecenas-consequat-mauris.103c1e4d.jpg', NULL, NULL, NULL, NULL, 1, 1)
SET IDENTITY_INSERT [dbo].[PostGallery] OFF
SET IDENTITY_INSERT [dbo].[Province] ON 

INSERT [dbo].[Province] ([Id], [Name], [Description], [OrderDisplay], [Status], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1, N'Thành Phố Hồ Chí Minh', NULL, 5, 1, CAST(N'2016-12-03T07:32:55.723' AS DateTime), N'Administrator', CAST(N'2016-12-16T20:21:18.510' AS DateTime), N'Administrator')
INSERT [dbo].[Province] ([Id], [Name], [Description], [OrderDisplay], [Status], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2, N'Bình Dương', NULL, 3, 1, CAST(N'2016-12-03T07:33:06.427' AS DateTime), N'Administrator', CAST(N'2016-12-03T10:25:33.657' AS DateTime), N'Administrator')
INSERT [dbo].[Province] ([Id], [Name], [Description], [OrderDisplay], [Status], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (3, N'Đồng Nai', NULL, 3, 1, CAST(N'2016-12-03T07:33:16.583' AS DateTime), N'Administrator', CAST(N'2016-12-03T07:33:16.583' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[Province] OFF
SET IDENTITY_INSERT [dbo].[Repair] ON 

INSERT [dbo].[Repair] ([Id], [Model], [ModelBrand], [SerialNumber], [BrandId], [OrderCode], [CustomerCode], [StoreName], [CustomerName], [PhoneNumber], [CustomerIdNumber], [Address], [Accessories], [PasswordPhone], [AppleId], [IcloudPassword], [FixedTags], [Category], [OldWarranty], [PhoneStatus], [WarrantyFrom], [WarrantyTo], [FixedFee], [Status], [Note], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2, N'1', N'1', N'1', 2, N'DH1', N'KH1', N'12', N'12', N'1212121', N'1', N'1', NULL, N'1', N'1', NULL, NULL, NULL, 1, N'1', NULL, NULL, NULL, 2, NULL, CAST(N'2017-06-08T14:39:50.903' AS DateTime), N'Administrator', CAST(N'2017-09-22T14:59:09.933' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[Repair] OFF
SET IDENTITY_INSERT [dbo].[RepairGallery] ON 

INSERT [dbo].[RepairGallery] ([Id], [ImagePath], [RepairId]) VALUES (1, N'images/DH1/DH1-d368aea0-f64e-42bf-a306-595ab6db7e4b.jpg', 2)
INSERT [dbo].[RepairGallery] ([Id], [ImagePath], [RepairId]) VALUES (2, N'images/DH1/DH1-5211a8d9-8567-4923-bb42-b902b1462a41.jpg', 2)
INSERT [dbo].[RepairGallery] ([Id], [ImagePath], [RepairId]) VALUES (3, N'images/DH1/DH1-412b90c9-088e-41d9-ac36-d477b886a375.jpg', 2)
INSERT [dbo].[RepairGallery] ([Id], [ImagePath], [RepairId]) VALUES (4, N'images/DH1/DH1-89945288-447d-4fc1-ad97-4135a5378cc7.jpg', 2)
INSERT [dbo].[RepairGallery] ([Id], [ImagePath], [RepairId]) VALUES (5, N'images/DH1/DH1-c0dab435-ea84-43f3-b964-38cc6d370936.jpg', 2)
INSERT [dbo].[RepairGallery] ([Id], [ImagePath], [RepairId]) VALUES (6, N'images/DH1/DH1-81e010db-1009-4032-915d-0811970ebce3.jpg', 2)
INSERT [dbo].[RepairGallery] ([Id], [ImagePath], [RepairId]) VALUES (7, N'images/DH1/DH1-f8cd7732-8c7c-4a29-bb30-2771a30fba7e.jpg', 2)
SET IDENTITY_INSERT [dbo].[RepairGallery] OFF
SET IDENTITY_INSERT [dbo].[RepairItem] ON 

INSERT [dbo].[RepairItem] ([Id], [WarrantyFrom], [WarrantyTo], [FixedFee], [Category], [RepairId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (14, CAST(N'2017-05-30T00:00:00.000' AS DateTime), CAST(N'2017-06-08T00:00:00.000' AS DateTime), CAST(1.00 AS Decimal(18, 2)), N'12', 2, CAST(N'2017-09-22T14:59:09.897' AS DateTime), N'Administrator', CAST(N'2017-09-22T14:59:09.897' AS DateTime), N'Administrator')
INSERT [dbo].[RepairItem] ([Id], [WarrantyFrom], [WarrantyTo], [FixedFee], [Category], [RepairId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (15, CAST(N'2017-05-30T00:00:00.000' AS DateTime), CAST(N'2017-05-30T00:00:00.000' AS DateTime), CAST(5.00 AS Decimal(18, 2)), N'232', 2, CAST(N'2017-09-22T14:59:09.897' AS DateTime), N'Administrator', CAST(N'2017-09-22T14:59:09.897' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[RepairItem] OFF
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'79a41b18-2edb-49cb-b1e3-02decc11f901', N'DeleteEditBanner', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'e64f1379-7ea0-4ec0-b393-03f0ec6ef679', N'ExportLandingPage', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'7dedab84-7294-4e36-986c-074e4fed6ba0', N'DeleteNews', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'0fbf721a-0839-4221-811d-0ea7c4a2879f', N'DeleteLandingPage', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'725051d0-b3bb-460b-a105-0ec050640f32', N'CreateEditFlowStep', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'e75241a2-3dda-4ead-ad77-120950ec74a9', N'DeleteEditRole', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'7e64b27f-148c-415e-aff7-14e92ee8cc1f', N'CreateEditAttribute', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'a8a17534-9195-4cf6-a30e-20a9639d1a74', N'DeleteSeoSetting', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'a8677efa-3994-4449-a3c4-2236aa164b74', N'CreateEditNews', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'4efaf033-0bde-4c89-b5c2-255781ef8567', N'ViewFlowStep', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'cb1b5092-fd6a-4848-ba71-2b6036dfc169', N'ViewRole', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'0f9229ee-4e0c-48f2-b62f-2cb134019d7d', N'ViewProvince', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'7d502e60-693d-4a30-8f0d-31d6f2833722', N'CreateEditAccount', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'0ccdc741-8494-4acd-9cb4-32b7360481d9', N'CreateEditBanner', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'be09502c-d8ea-49cf-bbb2-3320ab3b2130', N'ViewSeoSetting', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'241e44f1-25cb-49dd-a729-3696b3e3a42e', N'CreateEditPageBanner', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'ad98c76b-ff39-4b38-aefa-3b4da2295bd1', N'ViewMailSetting', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'549dd095-2e66-41f9-b512-3ba2d9068a88', N'CreateEditSeoSetting', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'0aa9f8c3-24f8-47ee-890a-3c55b1e07967', N'ViewPageBanner', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'878b7905-dcb2-4faf-802f-42ccae5ad058', N'CreateEditFlowStep', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'1d622e2b-bdf1-40e4-9b9b-4e1cfa4b841f', N'CreateEditDistrict', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'1418c22b-0d1b-483f-b5bf-502c2e342904', N'ViewAttribute', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'76d2112a-72d0-4b41-8e90-6213b5fd91d4', N'CreatePost', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'c3d47655-95f0-4017-a1f7-62f4dd16fc04', N'ViewPost', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'419f99ed-38c7-44a1-9adb-68139526a3ea', N'DeletePost', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'5c8e0d30-9b6b-4c62-ba7e-69ae98779a6c', N'ViewBanner', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'2f667961-bfdf-418b-acd2-6a2e55117bf7', N'ViewContactInfomation', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'e2e66b84-2ea6-49b7-aec3-6a32744edb47', N'CreateEditStaticContent', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'7ba3b301-7ff3-4a12-aedc-748ec95afe7e', N'ViewAccount', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'4711d4cd-2e94-4e81-98fe-793055739a8c', N'DeleteAttribute', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'a241cfff-40a6-48ec-a8c0-7c7391821d61', N'DeleteDistrict', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'67c6ac61-ab44-4fe5-923b-80f178c7d9d3', N'DeleteSystemSetting', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'd33f849b-4b83-4a17-8355-871e11df0a8c', N'ViewStaticContent', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'1b1ec09a-90a6-4543-a09e-892d43b58f04', N'CreateEditContactInfomation', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'f022a253-85a4-4fc1-adb3-95aee321af9d', N'CreateProvince', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'ed128890-a3c7-4755-974e-a5bc1ef1a042', N'ViewSystemSetting', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'8f92cb14-b3ad-40a2-b240-a7fb4800af1d', N'CreateEditMenu', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'e6289f84-74d2-49bf-a3bc-ae1d7ed2793e', N'CreateEditMailSetting', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'92b7a7a7-19da-46cf-9f24-bb8d69ff5be2', N'DeleteContactInfomation', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'36c2ed35-12a3-446e-ba43-bda851fbf3e7', N'CreateEditSystemSetting', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'5b3912d9-0545-4f1b-b286-c53168d97ad9', N'ViewLandingPage', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'e07a1fe5-a924-47df-96bc-caa5d69e2ac6', N'DeleteMenu', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'009b8286-ba0e-4657-85d7-cac9f484b95d', N'ViewDistrict', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'310aec48-ae13-4f57-aa67-cb07f8e5cd1e', N'CreateEditAccount', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'9e01f66c-bd19-4e9a-afd4-d6b6bec39a97', N'ViewMenu', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'6534cb27-ff13-4e1c-a645-d96532ab612c', N'CreateEditRole', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'22992600-c0cf-4e34-a430-e2f72d5e799c', N'ViewNews', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'b12fe51e-05dc-4404-88db-e63dab730d76', N'DeleteMailSetting', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'cb5c5f97-4154-4f36-9adf-ef14a36ac546', N'DeletePageBanner', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'cf5a8f17-62ed-4e26-8300-f6fb2b91fb21', N'DeleteProvince', NULL)
INSERT [dbo].[Role] ([RoleId], [Name], [Description]) VALUES (N'cd3a1632-5fa7-4b46-a13e-fcbb1a43780c', N'DeleteStaticContent', NULL)
SET IDENTITY_INSERT [dbo].[ServerMailSetting] ON 

INSERT [dbo].[ServerMailSetting] ([Id], [FromAddress], [SmtpClient], [UserID], [Password], [SMTPPort], [EnableSSL], [Status], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1, N'ddemo9698@gmail.com', N'smtp.gmail.com', N'ddemo9698@gmail.com', N'abc@12345', N'587', 1, 1, CAST(N'2017-05-05T09:28:43.473' AS DateTime), N'Administrator', CAST(N'2018-03-22T14:31:15.910' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[ServerMailSetting] OFF
SET IDENTITY_INSERT [dbo].[Setting] ON 

INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (3, N'Post.WidthMediumSize', N'263', 0, CAST(N'2018-05-18T16:14:38.847' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:05:35.977' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (5, N'Post.WidthBigSize', N'1280', 0, CAST(N'2018-05-18T17:05:43.173' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:05:30.720' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (6, N'Post.HeightMediumSize', N'247', 0, CAST(N'2018-05-19T03:04:59.700' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:01:18.153' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (7, N'Post.WidthSmallSize', N'105', 0, CAST(N'2018-05-19T03:05:12.273' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:05:40.227' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (8, N'Post.HeightSmallSize', N'70', 0, CAST(N'2018-05-19T03:05:25.153' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:01:27.407' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (11, N'Post.HeightBigSize', N'470', 0, CAST(N'2018-05-19T08:24:25.030' AS DateTime), N'Administrator', CAST(N'2018-05-19T11:00:57.313' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (13, N'Post.GalleryWidthBigSize', N'1280', 0, CAST(N'2018-05-19T11:16:00.730' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:04:36.477' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (14, N'Post.GalleryHeightBigSize', N'470', 0, CAST(N'2018-05-19T11:16:12.737' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:00:27.247' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (15, N'Post.GalleryWidthMediumSize', N'213', 0, CAST(N'2018-05-19T11:16:33.800' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:04:44.520' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (16, N'Post.GalleryHeightMediumSize', N'260', 0, CAST(N'2018-05-19T11:16:44.463' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:00:36.203' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (17, N'Post.GalleryWidthSmallSize', N'80', 0, CAST(N'2018-05-19T11:16:51.213' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:04:49.200' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (18, N'Post.GalleryHeightSmallSize', N'60', 0, CAST(N'2018-05-19T11:16:57.727' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:00:41.670' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (19, N'Post.AttributeWithBigSize', N'840', 0, CAST(N'2018-05-19T12:22:01.783' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:22:01.783' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (20, N'Post.AttributeHeightBigSize', N'840', 0, CAST(N'2018-05-19T12:22:18.210' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:22:18.210' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (21, N'Post.AttributeWidthThumSize', N'390', 0, CAST(N'2018-05-19T12:22:45.853' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:22:45.853' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (22, N'Post.AttributeHeightThumSize', N'485', 0, CAST(N'2018-05-19T12:23:03.020' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:23:03.020' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (23, N'SlideShow.WidthBigSize', N'900', 0, CAST(N'2018-05-19T12:32:37.453' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:35:27.317' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (24, N'SlideShow.HeightBigSize', N'450', 0, CAST(N'2018-05-19T12:35:46.553' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:46:22.603' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (25, N'Banner.WidthBigSize', N'1903', 0, CAST(N'2018-05-19T12:41:00.747' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:41:00.747' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (26, N'Banner.HeightBigSize', N'224', 0, CAST(N'2018-05-19T12:41:15.760' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:41:15.760' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (27, N'Menu.WidthBigSize', N'1280', 0, CAST(N'2018-05-19T12:44:39.767' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:44:39.767' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (28, N'Menu.HeightBigSize', N'470', 0, CAST(N'2018-05-19T12:44:39.767' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:45:05.960' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (29, N'Menu.WidthMediumSize', N'263', 0, CAST(N'2018-05-19T12:46:55.200' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:46:55.200' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (30, N'Menu.HeightMediumSize', N'247', 0, CAST(N'2018-05-19T12:47:07.357' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:47:07.357' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (31, N'Menu.WidthSmallSize', N'16', 0, CAST(N'2018-05-19T12:48:18.707' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:48:18.707' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (32, N'Menu.HeightSmallSize', N'12', 0, CAST(N'2018-05-19T12:48:26.943' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:48:26.943' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (33, N'News.WidthBigSize', N'1903', 0, CAST(N'2018-05-19T12:53:04.610' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:53:04.610' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (34, N'News.HeightBigSize', N'224', 0, CAST(N'2018-05-19T12:53:14.663' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:53:14.663' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (35, N'News.WidthMediumSize', N'224', 0, CAST(N'2018-05-19T12:53:25.373' AS DateTime), N'Administrator', CAST(N'2018-05-20T15:17:45.337' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (36, N'News.HeightMediumSize', N'210', 0, CAST(N'2018-05-19T12:53:34.390' AS DateTime), N'Administrator', CAST(N'2018-05-20T15:17:50.727' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (37, N'News.WidthSmallSize', N'105', 0, CAST(N'2018-05-19T12:53:43.897' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:53:43.897' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (38, N'News.HeightSmallSize', N'70', 0, CAST(N'2018-05-19T12:53:52.630' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:53:52.630' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (39, N'PaymentMethod.WidthBigSize', N'67', 0, CAST(N'2018-05-19T12:59:21.120' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:59:21.120' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (40, N'PaymentMethod.HeightBigSize', N'32', 0, CAST(N'2018-05-19T12:59:39.197' AS DateTime), N'Administrator', CAST(N'2018-05-19T12:59:39.197' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (41, N'StaticContent.WidthBigSize', N'64', 0, CAST(N'2018-05-19T13:02:54.040' AS DateTime), N'Administrator', CAST(N'2018-05-24T15:30:40.953' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (42, N'StaticContent.HeightBigSize', N'64', 0, CAST(N'2018-05-19T13:03:04.563' AS DateTime), N'Administrator', CAST(N'2018-05-24T15:30:37.340' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (43, N'Manufacture.WidthBigSize', N'100', 0, CAST(N'2018-05-19T13:05:54.573' AS DateTime), N'Administrator', CAST(N'2018-05-19T13:05:54.573' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (44, N'Manufacture.HeightBigSize', N'80', 0, CAST(N'2018-05-19T13:06:03.793' AS DateTime), N'Administrator', CAST(N'2018-05-19T13:06:03.793' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (45, N'StaticContent.pngFormat', N'1', 0, CAST(N'2018-05-24T16:14:52.023' AS DateTime), N'Administrator', CAST(N'2018-05-24T16:14:52.023' AS DateTime), N'Administrator')
INSERT [dbo].[Setting] ([Id], [Name], [Value], [StoreId], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (46, N'Menu.pngFormat', N'1', 0, CAST(N'2018-05-25T16:19:15.407' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:19:15.407' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[Setting] OFF
SET IDENTITY_INSERT [dbo].[SettingSeoGlobal] ON 

INSERT [dbo].[SettingSeoGlobal] ([Id], [FbAppId], [FbAdminsId], [SnippetGoogleAnalytics], [MetaTagMasterTool], [PublisherGooglePlus], [FacebookRetargetSnippet], [GoogleRetargetSnippet], [Status], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [FbLink], [GooglePlusLink], [TwitterLink], [PinterestLink], [YoutubeLink]) VALUES (1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(N'2017-06-05T17:20:13.810' AS DateTime), N'Administrator', CAST(N'2017-12-16T10:40:06.787' AS DateTime), N'Administrator', N'https://www.facebook.com/chatbotautomation.org/', N'https://plus.google.com/u/1/107297564061909337921', N'twitter', NULL, N'YouTube')
SET IDENTITY_INSERT [dbo].[SettingSeoGlobal] OFF
SET IDENTITY_INSERT [dbo].[ShippingMethod] ON 

INSERT [dbo].[ShippingMethod] ([Id], [Name], [Description], [DisplayOrder], [IgnoreCharges], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2, N'Giao tận nơi', N'Pick up your items at the store', 0, 0, CAST(N'2017-11-04T21:05:51.303' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[ShippingMethod] ([Id], [Name], [Description], [DisplayOrder], [IgnoreCharges], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (3, N'Nhận tại cửa hàng', N'Compared to other shipping methods, like by flight or over seas, ground shipping is carried out closer to the earth', 1, 0, CAST(N'2017-11-04T21:05:51.303' AS DateTime), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[ShippingMethod] OFF
SET IDENTITY_INSERT [dbo].[ShoppingCartItem] ON 

INSERT [dbo].[ShoppingCartItem] ([Id], [StoreId], [ParentItemId], [BundleItemId], [ShoppingCartTypeId], [CustomerId], [PostId], [AttributesXml], [CustomerEnteredPrice], [Quantity], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2, 1, 0, 0, 0, 5, 42, NULL, CAST(20000.0000 AS Decimal(18, 4)), 1, CAST(N'2018-05-27T14:28:27.253' AS DateTime), N'Administrator', CAST(N'2018-05-27T14:28:27.253' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[ShoppingCartItem] OFF
SET IDENTITY_INSERT [dbo].[SlideShow] ON 

INSERT [dbo].[SlideShow] ([Id], [Title], [WebsiteLink], [ImgPath], [Description], [Video], [Width], [Height], [Target], [FromDate], [ToDate], [Status], [OrderDisplay], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (6, N'slide 1', N'http://www.google.com', N'images/SlideShow/2018.S1/slide-option2.d3879c9c.jpg', NULL, 0, NULL, NULL, N'_parent', NULL, NULL, 1, 1, CAST(N'2017-05-10T09:44:23.133' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:46:47.107' AS DateTime), N'Administrator')
INSERT [dbo].[SlideShow] ([Id], [Title], [WebsiteLink], [ImgPath], [Description], [Video], [Width], [Height], [Target], [FromDate], [ToDate], [Status], [OrderDisplay], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (7, N'Slide 2', NULL, N'images/SlideShow/2018.S2/slider1-1.53bc3c83.jpg', NULL, 0, NULL, NULL, N'_blank', NULL, NULL, 1, 1, CAST(N'2018-02-18T09:29:34.933' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:47:33.590' AS DateTime), N'Administrator')
INSERT [dbo].[SlideShow] ([Id], [Title], [WebsiteLink], [ImgPath], [Description], [Video], [Width], [Height], [Target], [FromDate], [ToDate], [Status], [OrderDisplay], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (9, N'Slide 3', NULL, N'images/SlideShow/2018.S3/slider2.cacd48cb.jpg', NULL, 0, NULL, NULL, N'_blank', NULL, NULL, 1, 1, CAST(N'2018-05-10T14:33:03.127' AS DateTime), N'Administrator', CAST(N'2018-05-19T16:47:38.830' AS DateTime), N'Administrator')
SET IDENTITY_INSERT [dbo].[SlideShow] OFF
SET IDENTITY_INSERT [dbo].[StaticContent] ON 

INSERT [dbo].[StaticContent] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [ShortDesc], [Description], [Status], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [ImagePath], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [ViewCount]) VALUES (14, 45, N'f9b39a11-c9b9-4cba-a58e-54713a9f53c2/5ff97ccf-29d4-47d2-82d9-9d217119a68d', NULL, N'Giới thiệu công ty', N'<p>Ut tellus dolor, dapibus eget, elementum vel, cursus eleifend, elit. Aenean auctor wisi et urna. Aliquam erat volutpat. Duis ac turpis. Donec sit amet eros. Lorem ipsum dolor sit amet, consecvtetuer adipiscing elit. Mauris fermentum dictum magna. Sed laoreet aliquam leo. Ut tellus dolor, dapibus eget, elementum vel.</p>
', N'<p>ABOUT US Ut tellus dolor, dapibus eget, elementum vel, cursus eleifend, elit. Aenean auctor wisi et urna. Aliquam erat volutpat. Duis ac turpis. Donec sit amet eros. Lorem ipsum dolor sit amet, consecvtetuer adipiscing elit. Mauris fermentum dictum magna. Sed laoreet aliquam leo. Ut tellus dolor, dapibus eget, elementum vel. Aenean auctor wisi et urna. Aliquam erat volutpat. Duis ac turpis. Integer rutrum ante eu lacus. Vestibulum libero nisl, porta vel, scelerisque eget, malesuada at, neque. Vivamus eget nibh. Etiam cursus leo vel metus. Nulla facilisi. Aenean nec eros. Integer rutrum ante eu lacus.Vestibulum libero nisl, porta vel, scelerisque eget, malesuada at, neque. Vivamus eget nibh. Etiam cursus leo vel metus. Nulla facilisi. Aenean nec eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse sollicitudin velit sed leo. Ut pharetra augue nec augue. Nam elit agna,endrerit sit amet, tincidunt ac, viverra sed, nulla. Donec porta diam eu massa. Quisque diam lorem, interdum vitae,dapibus ac, scelerisque vitae, pede. Donec eget tellus non erat lacinia fermentum. Donec in velit vel ipsum auctor pulvinar. Vestibulum iaculis lacinia est. Proin dictum elementum velit. Fusce euismod consequat ante. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Pellentesque sed dolor. Aliquam congue fermentum nisl. Aenean auctor wisi et urna. Aliquam erat volutpat. Duis ac turpis. Integer rutrum ante eu lacus. Vestibulum libero nisl, porta vel, scelerisque eget, malesuada at, neque. Vivamus eget nibh. Etiam cursus leo vel metus. Nulla facilisi. Aenean nec eros. Integer rutrum ante eu lacus.Vestibulum libero nisl, porta vel, scelerisque eget, malesuada at, neque. Vivamus eget nibh. Etiam cursus leo vel metus. Nulla facilisi. Aenean nec eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse sollicitudin velit sed leo. Ut pharetra augue nec augue.</p>
', 1, N'Giới thiệu công ty', N'Giới thiệu công ty', N'Giới thiệu công ty', N'gioi-thieu-cong-ty', N'images/staticcontent/gioi-thieu-24452e1c-c4b2-44ae-b2d1-33f1f4a3754b.png', CAST(N'2017-06-17T09:32:37.010' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:10:13.973' AS DateTime), N'Administrator', 1)
INSERT [dbo].[StaticContent] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [ShortDesc], [Description], [Status], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [ImagePath], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [ViewCount]) VALUES (16, 21, N'8d49acae-84c0-44e4-8da5-96b550cbc90a/ab6eefb0-c074-4799-8637-64a6aa57dd9f', NULL, N'Hướng dẫn mua hàng', N'<div class="policies nobottommargin">
<div class="container clearfix">
<div class="row">
<div class="col-xs-12 col-sm-3">
<div class="feature-box fbox-plain fbox-dark fbox-small">
<div class="fbox-icon"><img alt="Công ty thương mại và thời trang NAM LONG" src="/assets/lib/policies_icon_1677f.png?v=226" /></div>

<h3>GIAO H&Agrave;NG TO&Agrave;N QUỐC</h3>

<p>Miễn ph&iacute; khi mua nhiều</p>
</div>
</div>

<div class="col-xs-12 col-sm-3">
<div class="feature-box fbox-plain fbox-dark fbox-small">
<div class="fbox-icon"><img alt="Công ty thương mại và thời trang NAM LONG" src="/assets/lib/policies_icon_2677f.png?v=226" /></div>

<h3>QU&Agrave; TẶNG</h3>

<p>Nhiều qu&agrave; tặng v&agrave; ưu đ&atilde;i hấp dẫn</p>
</div>
</div>

<div class="col-xs-12 col-sm-3">
<div class="feature-box fbox-plain fbox-dark fbox-small">
<div class="fbox-icon"><img alt="Công ty thương mại và thời trang NAM LONG" src="/assets/lib/policies_icon_3677f.png?v=226" /></div>

<h3>CHẤT LƯỢNG</h3>

<p>Sản phẩm đẹp, bền - G&iacute;a tốt nhất</p>
</div>
</div>

<div class="col-xs-12 col-sm-3">
<div class="feature-box fbox-plain fbox-dark fbox-small">
<div class="fbox-icon"><img alt="Công ty thương mại và thời trang NAM LONG" src="/assets/lib/policies_icon_4677f.png?v=226" /></div>

<h3>ĐẶT H&Agrave;NG NHANH</h3>

<p>0937 996 063</p>
</div>
</div>
</div>
</div>
</div>
', N'<p>Ng&agrave;y nay, điện thoại di động th&ocirc;ng minh l&agrave; thiết bị kh&ocirc;ng thể thiếu của con người bởi t&iacute;nh nhanh gọn, tiện &iacute;ch v&agrave; đa dạng của n&oacute;. META đ&atilde; lu&ocirc;n cải tiến v&agrave; kh&ocirc;ng ngừng khắc phục mọi kh&oacute; khăn để c&oacute; thể đem đến cho người mua h&agrave;ng những tiện &iacute;ch tốt nhất cũng như thao t&aacute;c ng&agrave;y c&agrave;ng nhanh ch&oacute;ng v&agrave; tiện lợi, kh&ocirc;ng mất qu&aacute; nhiều thời gian v&agrave; c&ocirc;ng sức. Bạn chỉ cần ngồi tại nh&agrave;, truy cập v&agrave;o website meta.vn qua điện thoại th&ocirc;ng minh của m&igrave;nh v&agrave; Đặt h&agrave;ng, ch&uacute;ng t&ocirc;i sẽ giao h&agrave;ng đến tận nh&agrave;. Lu&ocirc;n d&agrave;nh kh&oacute; khăn, phiền phức về m&igrave;nh để thỏa m&atilde;n kh&aacute;ch h&agrave;ng l&agrave; ti&ecirc;u ch&iacute; số 1 của META ch&uacute;ng t&ocirc;i.</p>

<p>Sau đ&acirc;y, META xin gửi tới Qu&yacute; kh&aacute;ch h&agrave;ng c&aacute;ch đặt h&agrave;ng th&ocirc;ng minh tr&ecirc;n META dễ d&agrave;ng v&agrave; thuận tiện bằng điện thoại di động.</p>

<p style="text-align:center"><iframe allowfullscreen="" frameborder="0" height="422" src="https://www.youtube.com/embed/-DWDpvaMAZU" style="box-sizing: border-box; margin: 0px; padding: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit;" width="750"></iframe></p>

<p style="text-align:center">Video giới thiệu hướng dẫn đặt h&agrave;ng tr&ecirc;n website meta.vn qua điện thoại dễ d&agrave;ng v&agrave; thuận tiện</p>

<p><strong>Bước 1</strong>. Qu&yacute; kh&aacute;ch truy cập v&agrave;o&nbsp;<em>website META.vn&nbsp;</em>tr&ecirc;n thiết bị di động của m&igrave;nh<em>,</em>&nbsp;lựa chọn sản phẩm theo&nbsp;<strong>Danh mục</strong>&nbsp;- từng ng&agrave;nh sản phẩm hoặc g&otilde; t&ecirc;n sản phẩm (từ kh&oacute;a) v&agrave;o phần&nbsp;<strong>T&igrave;m kiếm</strong>&nbsp;(Xem hướng dẫn chi tiết t&igrave;m kiếm sản phẩm&nbsp;<a href="http://meta.vn/hotro/huong-dan-tim-kiem-san-pham-tai-meta/67" style="box-sizing: border-box; background-color: transparent; margin: 0px; padding: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; color: rgb(0, 0, 255) !important; text-decoration-line: none !important;" target="_blank" title="Xem thêm tìm kiếm"><strong>tại đ&acirc;y</strong></a>).</p>

<p style="text-align:center"><img alt="Truy cập vào website META trên điện thoại." src="https://st.meta.com.vn/img/thumb.ashx/data/image/2016/08/31/hotro-mobile-b1.jpg" style="border:0px; box-sizing:border-box; font-family:inherit; font-size:inherit; font-stretch:inherit; font-style:inherit; font-variant:inherit; font-weight:inherit; height:auto; line-height:inherit; margin:0px; max-width:100%; padding:0px; vertical-align:middle; width:422px" title="Truy cập vào website META trên điện thoại." /></p>

<p style="text-align:center"><span style="color:rgb(51, 102, 255); font-family:inherit; font-size:inherit">Truy cập v&agrave;o website META tr&ecirc;n điện thoại.</span></p>

<p>- V&iacute; dụ, Qu&yacute; kh&aacute;ch cần t&igrave;m mua sản phẩm&nbsp;<a href="http://meta.vn/may-chay-bo-dien-co-lon-impulse-pt300-p28279" style="box-sizing: border-box; background-color: transparent; margin: 0px; padding: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; color: rgb(0, 0, 255) !important; text-decoration-line: none !important;" target="_blank" title="Xem thêm máy chạy bộ điện cỡ lớn."><strong>M&aacute;y chạy bộ điện cỡ lớn PT300</strong></a>, Qu&yacute; kh&aacute;ch g&otilde; ở &ocirc; t&igrave;m kiếm m&aacute;y chạy bộ điện cỡ lớn PT300 v&agrave; k&iacute;ch chọn sản phẩm đ&oacute;.</p>

<p style="text-align:center"><img alt="Gõ tên sản phẩm cần mua vào ô Tìm kiếm." src="https://st.meta.com.vn/img/thumb.ashx/data/image/2016/08/31/hotro-mobile-b2.jpg" style="border:0px; box-sizing:border-box; font-family:inherit; font-size:inherit; font-stretch:inherit; font-style:inherit; font-variant:inherit; font-weight:inherit; height:auto; line-height:inherit; margin:0px; max-width:100%; padding:0px; vertical-align:middle; width:422px" title="Gõ tên sản phẩm cần mua vào ô Tìm kiếm." /></p>

<p style="text-align:center"><span style="color:rgb(51, 102, 255); font-family:inherit; font-size:inherit">G&otilde; t&ecirc;n sản phẩm cần mua v&agrave;o &ocirc;&nbsp;<strong>T&igrave;m kiếm.</strong></span></p>

<p>- Th&ocirc;ng tin chi tiết của sản phẩm m&aacute;y chạy bộ điện hiển thị, Qu&yacute; kh&aacute;ch n&ecirc;n đọc kỹ<strong>&nbsp;th&ocirc;ng tin sản phẩm</strong>&nbsp;v&agrave;&nbsp;<strong>th&ocirc;ng số kỹ thuật</strong>&nbsp;cũng như&nbsp;<strong>đ&aacute;nh gi&aacute;</strong>&nbsp;về sản phẩm đ&oacute; để c&oacute; thể đưa ra quyết định mua h&agrave;ng đ&uacute;ng đắn.</p>

<p style="text-align:center"><img alt="Bạn cần đọc kỹ thông tin trước khi quyết định mua hàng." src="https://st.meta.com.vn/img/thumb.ashx/data/image/2016/08/31/hotro-mobile-b3.jpg" style="border:0px; box-sizing:border-box; font-family:inherit; font-size:inherit; font-stretch:inherit; font-style:inherit; font-variant:inherit; font-weight:inherit; height:auto; line-height:inherit; margin:0px; max-width:100%; padding:0px; vertical-align:middle; width:422px" title="Bạn cần đọc kỹ thông tin trước khi quyết định mua hàng." /></p>
', 1, N'Hướng dẫn mua hàng', N'Hướng dẫn mua hàng', N'Hướng dẫn mua hàng', N'huong-dan-mua-hang-1', N'images/staticcontent/chinh-sach-giao-hang-trang-chu-f6a66e57-21c2-4689-a313-e35cca84c95b.jpg', CAST(N'2017-06-18T06:09:36.230' AS DateTime), N'Administrator', CAST(N'2018-05-24T15:47:08.193' AS DateTime), N'Administrator', 1)
INSERT [dbo].[StaticContent] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [ShortDesc], [Description], [Status], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [ImagePath], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [ViewCount]) VALUES (17, 21, N'8d49acae-84c0-44e4-8da5-96b550cbc90a/ab6eefb0-c074-4799-8637-64a6aa57dd9f', NULL, N'Ý kiến khách hàng', NULL, NULL, 1, N'Ý kiến khách hàng', N'Ý kiến khách hàng', N'Ý kiến khách hàng', N'y-kien-khach-hang', N'images/staticcontent/y-kien-khach-hang-8eb22db5-1ff8-4ab8-8a34-0e9f6e02da33.png', CAST(N'2017-10-17T17:52:25.913' AS DateTime), N'Administrator', CAST(N'2018-02-24T15:43:06.343' AS DateTime), N'Administrator', 0)
INSERT [dbo].[StaticContent] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [ShortDesc], [Description], [Status], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [ImagePath], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [ViewCount]) VALUES (18, 1111, N'f9b39a11-c9b9-4cba-a58e-54713a9f53c2/84910c68-7cd6-49f6-b13f-ac223447de1c', NULL, N'Product Manager', N'<p>At Tiki, we believe in growing a sustainable business with strong fundamentals. It means acquiring new customers not just based on promotion but also on excellent customer service. In the backend, it means aiming for efficiency and optimization in Supply Chain, Warehouse and Cost management. Together with a strong team, solid IT solutions is the key to enable all of those.</p>

<p>As a member of Operation Product team, you will work on various solutions that manage our entire fleet of warehouses (inventory management, order processing) and Tiki delivery team. We also need to connect with and manage the cost and quality of our third-party logistics providers. At the same time, we also support our FNA team to track all the cash spent or need to be collected to optimize the cash flow. All of those will ensure that our orders are processed and delivered to customers with a very short leadtime and optimal cost. This is a key differentiation that help Tiki to survive and grow fast in a tough market like Vietnamese e-commerce.</p>

<p>In more details, you will</p>

<ul>
	<li>Work with internal clients (Operation &amp; FNA team) to understand the requirement, finalize the solution with clear scope and detailed documentation</li>
	<li>Finalise delivery plan (scope, timeline, resource/support needed) based on business priorities and team capacity</li>
	<li>Collaborate with Software Architecture, Developer and QC to ensure the quality of product</li>
	<li>Provide guidance and last-tier support for assigned product lines</li>
	<li>Provide coaching to team member</li>
</ul>

<p>We have a strong team with diversified background and a keen interest on being the best in e-commerce. You will gain more domain knowledge in what probably is one of the hottest IT sectors right now and have chances to encounter and solve challenging problems at large scale (think of million of orders, millions of customers and a magnitude more of data in our backend system)</p>

<p><span style="font-size:14pt"><strong>REQUIREMENT</strong></span></p>

<ul>
	<li>3 &ndash; 5 years of working experience.</li>
	<li>Strong accounting background.</li>
	<li>E-commerce Operation knowledge is a plus.</li>
	<li>Product management skill (business analyst, UI/UX mockup, features prioritization).</li>
	<li>Project management skill.</li>
	<li>Technical writing skill.</li>
	<li>Resource planning skill.</li>
	<li>Customer-oriented and have a high bar of quality.</li>
	<li>Ability to work across functions and be aggressive to get things done.</li>
	<li>Coaching skill.</li>
	<li>Good English communication.</li>
</ul>

<p><span style="font-size:14pt"><strong>BENIFIT</strong></span></p>

<ul>
	<li>Competitive salary.</li>
	<li>Dynamic, open and challenging working environment.</li>
	<li>Modern office, cafeteria; library; computer gaming, HD TV platforms.</li>
	<li>Performance review (twice a year), 13th month pay based on performance.</li>
	<li>Annual health check-up and premium healthcare.</li>
	<li>Special internal programs for Tikiers.</li>
</ul>

<div class="wrap" style="box-sizing: border-box; margin-bottom: 45px; font-family: Arial, Helvetica, sans-serif; font-size: 14px;">
<div class="container" style="box-sizing: border-box; margin-right: auto; margin-left: auto; padding-left: 15px; padding-right: 15px; width: 1170px;">
<div class="row style-2" style="box-sizing: border-box; margin-left: -15px; margin-right: -15px;">
<div class="col-lg-8 col-md-7" style="box-sizing: border-box; position: relative; min-height: 1px; padding-left: 15px; padding-right: 15px; float: left; width: 877.5px;">
<div class="right2" style="box-sizing: border-box; margin-top: 20px; border-left: 1px dashed rgb(228, 228, 228); padding-left: 20px;">
<div class="content" style="box-sizing: border-box; border-top: 2px solid rgb(228, 228, 228); padding-top: 20px; line-height: 25px;">
<p><strong>If you are interested in Product Manager position</strong><br />
Please submit online application form via&nbsp;<a class="btn btn--primary btn--large apply-workable" href="https://tiki-corporation.workable.com/jobs/659218/candidates/new" style="box-sizing: border-box; background-color: transparent; color: rgb(0, 170, 241); text-decoration-line: none; background-image: none; white-space: nowrap; line-height: 1.42857; display: inline-block; margin-bottom: 0px; text-align: center; vertical-align: middle; touch-action: manipulation; border: 1px solid transparent; padding: 6px 12px; border-radius: 4px; user-select: none;">This Link</a>&nbsp;or send your CV via mail:&nbsp;<strong>careers@tiki.vn</strong>.</p>
</div>
</div>
</div>
</div>
</div>
</div>
', N'<p>At Tiki, we believe in growing a sustainable business with strong fundamentals. It means acquiring new customers not just based on promotion but also on excellent customer service. In the backend, it means aiming for efficiency and optimization in Supply Chain, Warehouse and Cost management. Together with a strong team, solid IT solutions is the key to enable all of those.</p>

<p>As a member of Operation Product team, you will work on various solutions that manage our entire fleet of warehouses (inventory management, order processing) and Tiki delivery team. We also need to connect with and manage the cost and quality of our third-party logistics providers. At the same time, we also support our FNA team to track all the cash spent or need to be collected to optimize the cash flow. All of those will ensure that our orders are processed and delivered to customers with a very short leadtime and optimal cost. This is a key differentiation that help Tiki to survive and grow fast in a tough market like Vietnamese e-commerce.</p>

<p>In more details, you will</p>

<ul>
	<li>Work with internal clients (Operation &amp; FNA team) to understand the requirement, finalize the solution with clear scope and detailed documentation</li>
	<li>Finalise delivery plan (scope, timeline, resource/support needed) based on business priorities and team capacity</li>
	<li>Collaborate with Software Architecture, Developer and QC to ensure the quality of product</li>
	<li>Provide guidance and last-tier support for assigned product lines</li>
	<li>Provide coaching to team member</li>
</ul>

<p>We have a strong team with diversified background and a keen interest on being the best in e-commerce. You will gain more domain knowledge in what probably is one of the hottest IT sectors right now and have chances to encounter and solve challenging problems at large scale (think of million of orders, millions of customers and a magnitude more of data in our backend system)</p>

<p><span style="font-size:14pt"><strong>REQUIREMENT</strong></span></p>

<ul>
	<li>3 &ndash; 5 years of working experience.</li>
	<li>Strong accounting background.</li>
	<li>E-commerce Operation knowledge is a plus.</li>
	<li>Product management skill (business analyst, UI/UX mockup, features prioritization).</li>
	<li>Project management skill.</li>
	<li>Technical writing skill.</li>
	<li>Resource planning skill.</li>
	<li>Customer-oriented and have a high bar of quality.</li>
	<li>Ability to work across functions and be aggressive to get things done.</li>
	<li>Coaching skill.</li>
	<li>Good English communication.</li>
</ul>

<p><span style="font-size:14pt"><strong>BENIFIT</strong></span></p>

<ul>
	<li>Competitive salary.</li>
	<li>Dynamic, open and challenging working environment.</li>
	<li>Modern office, cafeteria; library; computer gaming, HD TV platforms.</li>
	<li>Performance review (twice a year), 13th month pay based on performance.</li>
	<li>Annual health check-up and premium healthcare.</li>
	<li>Special internal programs for Tikiers.</li>
</ul>

<div class="wrap" style="box-sizing: border-box; margin-bottom: 45px; font-family: Arial, Helvetica, sans-serif; font-size: 14px;">
<div class="container" style="box-sizing: border-box; margin-right: auto; margin-left: auto; padding-left: 15px; padding-right: 15px; width: 1170px;">
<div class="row style-2" style="box-sizing: border-box; margin-left: -15px; margin-right: -15px;">
<div class="col-lg-8 col-md-7" style="box-sizing: border-box; position: relative; min-height: 1px; padding-left: 15px; padding-right: 15px; float: left; width: 877.5px;">
<div class="right2" style="box-sizing: border-box; margin-top: 20px; border-left: 1px dashed rgb(228, 228, 228); padding-left: 20px;">
<div class="content" style="box-sizing: border-box; border-top: 2px solid rgb(228, 228, 228); padding-top: 20px; line-height: 25px;">
<p><strong>If you are interested in Product Manager position</strong><br />
Please submit online application form via&nbsp;<a class="btn btn--primary btn--large apply-workable" href="https://tiki-corporation.workable.com/jobs/659218/candidates/new" style="box-sizing: border-box; background-color: transparent; color: rgb(0, 170, 241); text-decoration-line: none; background-image: none; white-space: nowrap; line-height: 1.42857; display: inline-block; margin-bottom: 0px; text-align: center; vertical-align: middle; touch-action: manipulation; border: 1px solid transparent; padding: 6px 12px; border-radius: 4px; user-select: none;">This Link</a>&nbsp;or send your CV via mail:&nbsp;<strong>careers@tiki.vn</strong>.</p>
</div>
</div>
</div>
</div>
</div>
</div>
', 1, N'Product Manager', N'Product Manager', N'Product Manager', N'product-manager', NULL, CAST(N'2018-02-25T15:02:56.050' AS DateTime), N'Administrator', CAST(N'2018-05-25T14:17:28.237' AS DateTime), N'Administrator', 1)
INSERT [dbo].[StaticContent] ([Id], [MenuId], [VirtualCategoryId], [Language], [Title], [ShortDesc], [Description], [Status], [MetaTitle], [MetaKeywords], [MetaDescription], [SeoUrl], [ImagePath], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [ViewCount]) VALUES (21, 2136, N'8d49acae-84c0-44e4-8da5-96b550cbc90a/310f945c-a560-4eb0-b4d5-4aa1ef36dd18/20267e8f-bfd8-4b28-bc94-ff33896d67fd', NULL, N'Giá trị lớn của sản phẩm', N'<p>fdsafas</p>
', N'<p>fdsafasdf</p>
', 1, N'Giá trị lớn của sản phẩm', N'Giá trị lớn của sản phẩm', N'Giá trị lớn của sản phẩm', N'gia-tri-lon-cua-san-pham', N'images/staticcontent/2018.T/icon-s4.529124ac.png', CAST(N'2018-05-24T16:02:03.617' AS DateTime), N'Administrator', CAST(N'2018-05-25T16:24:00.620' AS DateTime), N'Administrator', 1)
SET IDENTITY_INSERT [dbo].[StaticContent] OFF
SET IDENTITY_INSERT [dbo].[SystemSetting] ON 

INSERT [dbo].[SystemSetting] ([Id], [Language], [Title], [FooterContent], [MetaTitle], [MetaDescription], [MetaKeywords], [Status], [FaviconImage], [LogoImage], [LogoFooterImage], [MaintanceSite], [Hotline], [Email], [Description], [TimeWork], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Slogan]) VALUES (1, NULL, N'– Công ty thương mại và thời trang NAM LONG', NULL, N'– Công ty thương mại và thời trang NAM LONG', N'– Công ty thương mại và thời trang NAM LONG', N'– Công ty thương mại và thời trang NAM LONG', 1, N'images/systemsetting/favicon.png', N'images/systemsetting/logo.png', N'images/systemsetting/logoFooter.png', 0, N'02733.622888', N'ddemo9698@gmail.com', NULL, NULL, CAST(N'2017-02-20T05:31:19.807' AS DateTime), N'Administrator', CAST(N'2018-04-10T15:42:32.163' AS DateTime), N'Administrator', NULL)
SET IDENTITY_INSERT [dbo].[SystemSetting] OFF
INSERT [dbo].[User] ([UserId], [UserName], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [FirstName], [MiddleName], [LastName], [Address], [City], [State], [Phone], [IsLockedOut], [IsSuperAdmin], [Created], [LastLogin]) VALUES (N'807b164a-fd1a-4d16-81d4-0411f87870bc', N'222323233', N'info@namlongfashion.com.vn', 1, N'ADC2xHKGBlhhv0TCDXIel28sYawzLcSu9K1McJtIMOGwlfZ/o05giGdj74yOqUXf/A==', N'febb0f3e-8c1c-48df-aa74-ba475f1d7ea8', N'2313', NULL, N'33', NULL, NULL, NULL, NULL, 0, 0, CAST(N'2018-01-19T17:09:10.000' AS DateTime), NULL)
INSERT [dbo].[User] ([UserId], [UserName], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [FirstName], [MiddleName], [LastName], [Address], [City], [State], [Phone], [IsLockedOut], [IsSuperAdmin], [Created], [LastLogin]) VALUES (N'bc1e404b-2a88-42ed-abea-1ba10478d19e', N'323232', N'ddemo9698@gmail.com', 1, N'AL6rOvg/j8Mj9/ji0LbtViXYhizwNHm6O1p5DAj3ZnRJTaYWO91dbaYR1VYq/CnY3A==', N'01eb5205-8175-402f-b52e-3786114515ec', N'123', NULL, N'2223', NULL, NULL, NULL, NULL, 0, 0, CAST(N'2018-01-19T16:42:25.510' AS DateTime), NULL)
INSERT [dbo].[User] ([UserId], [UserName], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [FirstName], [MiddleName], [LastName], [Address], [City], [State], [Phone], [IsLockedOut], [IsSuperAdmin], [Created], [LastLogin]) VALUES (N'bb72dda7-bc03-4e0d-96b6-1e8256770ea9', N'truong thanh cong', N'truong.thanhcong89@gmail.com', 1, N'ABjc6TyTGvOC7nCEuqmfWX1xE9neGwlZwF9eAwhMOXQ5JOORPieyLr3osNkwJVl+Zw==', N'e6e30166-eca7-4f0c-aed1-381b35a09c33', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, CAST(N'2018-03-17T00:35:39.217' AS DateTime), NULL)
INSERT [dbo].[User] ([UserId], [UserName], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [FirstName], [MiddleName], [LastName], [Address], [City], [State], [Phone], [IsLockedOut], [IsSuperAdmin], [Created], [LastLogin]) VALUES (N'57f2e911-7e87-486f-9999-230c80ca769d', N'DemoVictim', N'0', 1, NULL, N'bcde9145-e632-440c-98df-1947fbf9a627', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, CAST(N'2018-03-22T13:52:20.327' AS DateTime), NULL)
INSERT [dbo].[User] ([UserId], [UserName], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [FirstName], [MiddleName], [LastName], [Address], [City], [State], [Phone], [IsLockedOut], [IsSuperAdmin], [Created], [LastLogin]) VALUES (N'58d6701d-5424-4798-816b-2f9907a86aa8', N'aa233', N'info@namlongfashion.com.vn', 1, N'AKkIk56MFOs7S7uEwbyg5VH8aFQtbxaRs/+6ggT/W9IYBV/R6MYYABZq0dF2SHdG5w==', N'7aaa21b8-2f93-4d93-aa12-462d27914632', N'aa1233', NULL, N'1233', NULL, NULL, NULL, NULL, 0, 0, CAST(N'2018-01-19T16:37:48.417' AS DateTime), NULL)
INSERT [dbo].[User] ([UserId], [UserName], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [FirstName], [MiddleName], [LastName], [Address], [City], [State], [Phone], [IsLockedOut], [IsSuperAdmin], [Created], [LastLogin]) VALUES (N'f3cf155c-e073-46b9-a933-593a29a29d91', N'congtt', N'ddemo9698@gmail.com', 1, N'AJ0BGX7kg4ug5EiRNMUefNFpyo4MmuI7NbwaKS2PagaRkrVGAmNtErkKlUp/7Z7W9w==', N'5a27d2e6-cdd3-42dd-bbba-6e1fc4551643', N'trahnh', NULL, N'cong', NULL, NULL, NULL, NULL, 0, 0, CAST(N'2018-02-21T15:08:46.707' AS DateTime), NULL)
INSERT [dbo].[User] ([UserId], [UserName], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [FirstName], [MiddleName], [LastName], [Address], [City], [State], [Phone], [IsLockedOut], [IsSuperAdmin], [Created], [LastLogin]) VALUES (N'99a154c9-46a4-4e22-89bb-5bf939b102a4', N'ddemo9698@gmail.com', N'ddemo9698@gmail.com', 1, N'ADkyhyOtLBL8XEZXi3XuVUlLT49T+KpmzAPbjppLS1W4yeUp4i3waBl7a1++ie63GQ==', N'e1c94249-a6aa-4d31-85cb-8494cd194979', N'abb', NULL, N'b', NULL, NULL, NULL, NULL, 0, 0, CAST(N'2018-01-20T14:57:55.057' AS DateTime), NULL)
INSERT [dbo].[User] ([UserId], [UserName], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [FirstName], [MiddleName], [LastName], [Address], [City], [State], [Phone], [IsLockedOut], [IsSuperAdmin], [Created], [LastLogin]) VALUES (N'd982936b-5ee9-4e1d-96cd-643f00bb20a0', N'ddemo', N'ddemo9698@gmail.com', 1, NULL, N'32b0e9ac-7f9c-4ce3-9f7a-129a8146dee2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, CAST(N'2018-03-18T09:37:51.633' AS DateTime), NULL)
INSERT [dbo].[User] ([UserId], [UserName], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [FirstName], [MiddleName], [LastName], [Address], [City], [State], [Phone], [IsLockedOut], [IsSuperAdmin], [Created], [LastLogin]) VALUES (N'90dc7ff0-ea2a-401e-a2d5-6b9737c76bbd', N'Administrator', N'ddemo9698@gmail.com', 1, N'AEgZor3mVztRKy4Fy7cMAWDEpzvoi4xuY2gj6LbGC7B8z02IfO3lul4IZHMPnuS5Kg==', N'e0404700-a1e7-4fe2-bf4f-bfa627da1c57', N'Truong', N'Thanh', N'Cong', N'HCM', NULL, NULL, N'123456789', 0, 1, CAST(N'2016-10-15T19:31:59.147' AS DateTime), NULL)
INSERT [dbo].[User] ([UserId], [UserName], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [FirstName], [MiddleName], [LastName], [Address], [City], [State], [Phone], [IsLockedOut], [IsSuperAdmin], [Created], [LastLogin]) VALUES (N'6a4dcbff-d1d6-4f7f-a62a-9b67e564614e', N'ab555', N'info@namlongfashion.com.vn', 1, N'AKoSQkBb8kBDiAbYz061hQQToVaxn45GgtMiZnuqkPHWz28IVHSjhYtKzx0bEMl3Lw==', N'b84d6aec-a8ae-4557-9b52-b100d997ffb1', N'231', NULL, N'3', NULL, NULL, NULL, NULL, 0, 0, CAST(N'2018-01-19T17:14:56.920' AS DateTime), NULL)
INSERT [dbo].[User] ([UserId], [UserName], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [FirstName], [MiddleName], [LastName], [Address], [City], [State], [Phone], [IsLockedOut], [IsSuperAdmin], [Created], [LastLogin]) VALUES (N'f5d8160e-0868-4452-8bb5-a8abdb65e678', N'aa2333', N'info@namlongfashion.com.vn', 1, N'AFxrN+QH9GhIfrjSK+yEl4YGyPJoOQ5wwbN45dKnf4x7k3eIlrEBZddeiC6rRwGqPA==', N'359da74b-c1aa-48b0-a5f2-36fee0a03479', N'aa1233', NULL, N'1233', NULL, NULL, NULL, NULL, 0, 0, CAST(N'2018-01-19T16:38:33.987' AS DateTime), NULL)
INSERT [dbo].[User] ([UserId], [UserName], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [FirstName], [MiddleName], [LastName], [Address], [City], [State], [Phone], [IsLockedOut], [IsSuperAdmin], [Created], [LastLogin]) VALUES (N'08a82ba4-3abb-4acc-bd00-abfb0e75f22b', N'12', N'info@namlongfashion.com.vn', 1, N'APuP9DrY+lzji6OZ3hEHyYrTDDcF5wr76t1w6vcpTCXk0SvFdoZq2wnxE171ABrF1A==', N'76e3be20-67a1-4018-8185-69f652aa1144', N'1', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, CAST(N'2018-01-18T16:45:14.060' AS DateTime), NULL)
INSERT [dbo].[User] ([UserId], [UserName], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [FirstName], [MiddleName], [LastName], [Address], [City], [State], [Phone], [IsLockedOut], [IsSuperAdmin], [Created], [LastLogin]) VALUES (N'd4069960-2e7a-420d-8581-c71ab694db05', N'user1', N'user1@gmail.com', 1, N'ADcRh5C3KBCngj0iMqo6Dja7P8tC+FBZBv3UW1G3lYhAv4pjZySAlW1b4rqFscjXaA==', N'06b5aab3-4f96-442e-8f37-f4ae0fc1ccf1', N'cong', N'truong', N'thanh', NULL, NULL, NULL, NULL, 0, 0, CAST(N'2017-12-10T14:02:03.457' AS DateTime), NULL)
INSERT [dbo].[User] ([UserId], [UserName], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [FirstName], [MiddleName], [LastName], [Address], [City], [State], [Phone], [IsLockedOut], [IsSuperAdmin], [Created], [LastLogin]) VALUES (N'e70a7823-decb-49ba-96c2-d9f5935a450b', N'22232323', N'info@namlongfashion.com.vn', 1, N'AHmpmsbruh28qQLFKvABifE/u5ZJQD/92PWIeOsl0h3AXjkTmfndDZzrfy/xYr4XGg==', N'a55f7b15-fe33-4ce9-b97f-9c7cca7c3deb', N'2313', NULL, N'33', NULL, NULL, NULL, NULL, 0, 0, CAST(N'2018-01-19T17:06:33.497' AS DateTime), NULL)
INSERT [dbo].[User] ([UserId], [UserName], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [FirstName], [MiddleName], [LastName], [Address], [City], [State], [Phone], [IsLockedOut], [IsSuperAdmin], [Created], [LastLogin]) VALUES (N'f80e0887-eee0-432f-9d27-eded600105ba', N'aa', N'info@namlongfashion.com.vn', 1, N'ACbfgfnTYEAPJ2kF4IrsRwH5zaRBwdVAb9Qrkps7weR3FzLlT9dW8iorE3Ckb8sk6A==', N'07e00aa2-0db9-4c3d-b0a7-5902b3475785', N'aa', NULL, N'aaa', NULL, NULL, NULL, NULL, 0, 0, CAST(N'2018-01-19T16:35:04.830' AS DateTime), NULL)
INSERT [dbo].[UserRole] ([RoleId], [UserId]) VALUES (N'79a41b18-2edb-49cb-b1e3-02decc11f901', N'd4069960-2e7a-420d-8581-c71ab694db05')
INSERT [dbo].[UserRole] ([RoleId], [UserId]) VALUES (N'e64f1379-7ea0-4ec0-b393-03f0ec6ef679', N'd4069960-2e7a-420d-8581-c71ab694db05')
INSERT [dbo].[UserRole] ([RoleId], [UserId]) VALUES (N'7dedab84-7294-4e36-986c-074e4fed6ba0', N'd4069960-2e7a-420d-8581-c71ab694db05')
INSERT [dbo].[UserRole] ([RoleId], [UserId]) VALUES (N'0fbf721a-0839-4221-811d-0ea7c4a2879f', N'd4069960-2e7a-420d-8581-c71ab694db05')
INSERT [dbo].[UserRole] ([RoleId], [UserId]) VALUES (N'725051d0-b3bb-460b-a105-0ec050640f32', N'd4069960-2e7a-420d-8581-c71ab694db05')
INSERT [dbo].[UserRole] ([RoleId], [UserId]) VALUES (N'e75241a2-3dda-4ead-ad77-120950ec74a9', N'd4069960-2e7a-420d-8581-c71ab694db05')
INSERT [dbo].[UserRole] ([RoleId], [UserId]) VALUES (N'7e64b27f-148c-415e-aff7-14e92ee8cc1f', N'd4069960-2e7a-420d-8581-c71ab694db05')
INSERT [dbo].[UserRole] ([RoleId], [UserId]) VALUES (N'0ccdc741-8494-4acd-9cb4-32b7360481d9', N'd4069960-2e7a-420d-8581-c71ab694db05')
/****** Object:  Index [IX_AttributeId]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_AttributeId] ON [dbo].[AttribureValue]
(
	[AttributeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_MenuId]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_MenuId] ON [dbo].[Banner]
(
	[MenuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PageId]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_PageId] ON [dbo].[Banner]
(
	[PageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserId]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[Claim]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProvinceId]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_ProvinceId] ON [dbo].[ContactInformation]
(
	[ProvinceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserId]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[ExternalLogin]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AttributeValueId]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_AttributeValueId] ON [dbo].[GalleryImage]
(
	[AttributeValueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PostId]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_PostId] ON [dbo].[GalleryImage]
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShopId]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_ShopId] ON [dbo].[LandingPage]
(
	[ShopId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_MenuLink_CurrentVirtualId]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [idx_MenuLink_CurrentVirtualId] ON [dbo].[MenuLink]
(
	[CurrentVirtualId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_MenuLink_DisplayOnHomePage]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [idx_MenuLink_DisplayOnHomePage] ON [dbo].[MenuLink]
(
	[DisplayOnHomePage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_MenuLink_DisplayOnMenu]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [idx_MenuLink_DisplayOnMenu] ON [dbo].[MenuLink]
(
	[DisplayOnMenu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_MenuLink_Id]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [idx_MenuLink_Id] ON [dbo].[MenuLink]
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_MenuLink_MenuName]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [idx_MenuLink_MenuName] ON [dbo].[MenuLink]
(
	[MenuName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_MenuLink_OrderDisplay]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [idx_MenuLink_OrderDisplay] ON [dbo].[MenuLink]
(
	[OrderDisplay] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_MenuLink_ParentId]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [idx_MenuLink_ParentId] ON [dbo].[MenuLink]
(
	[ParentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_MenuLink_Position]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [idx_MenuLink_Position] ON [dbo].[MenuLink]
(
	[Position] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_MenuLink_SeoUrl]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [idx_MenuLink_SeoUrl] ON [dbo].[MenuLink]
(
	[SeoUrl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_MenuLink_Status]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [idx_MenuLink_Status] ON [dbo].[MenuLink]
(
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_MenuLink_TemplateType]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [idx_MenuLink_TemplateType] ON [dbo].[MenuLink]
(
	[TemplateType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_MenuLink_TypeMenu]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [idx_MenuLink_TypeMenu] ON [dbo].[MenuLink]
(
	[TypeMenu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_MenuLink_VirtualId]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [idx_MenuLink_VirtualId] ON [dbo].[MenuLink]
(
	[VirtualId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_MenuLink_VirtualSeoUrl]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [idx_MenuLink_VirtualSeoUrl] ON [dbo].[MenuLink]
(
	[VirtualSeoUrl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ParentId]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_ParentId] ON [dbo].[MenuLink]
(
	[ParentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_MenuId]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_MenuId] ON [dbo].[News]
(
	[MenuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_MenuId]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_MenuId] ON [dbo].[Post]
(
	[MenuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AttibuteValueId]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_AttibuteValueId] ON [dbo].[PostAttribute]
(
	[AttibuteValueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PostId]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_PostId] ON [dbo].[PostAttribute]
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_MenuId]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_MenuId] ON [dbo].[StaticContent]
(
	[MenuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RoleId]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[UserRole]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserId]    Script Date: 28-May-18 23:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[UserRole]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MenuLink] ADD  CONSTRAINT [DF__MenuLink__Displa__0E6E26BF]  DEFAULT ((0)) FOR [DisplayOnSearch]
GO
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF__Order__UpdatedOn__2B0A656D]  DEFAULT ('2017-06-18T16:30:29.726Z') FOR [UpdatedOnUtc]
GO
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF__Order__OrderShip__2BFE89A6]  DEFAULT ((0)) FOR [OrderShippingTaxRate]
GO
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF__Order__PaymentMe__2CF2ADDF]  DEFAULT ((0)) FOR [PaymentMethodAdditionalFeeTaxRate]
GO
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF__Order__HasNewPay__2DE6D218]  DEFAULT ((0)) FOR [HasNewPaymentNotification]
GO
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF__Order__AcceptThi__2EDAF651]  DEFAULT ((0)) FOR [AcceptThirdPartyEmailHandOver]
GO
ALTER TABLE [dbo].[OrderItem] ADD  CONSTRAINT [DF__OrderItem__TaxRa__42E1EEFE]  DEFAULT ((0)) FOR [TaxRate]
GO
ALTER TABLE [dbo].[Post] ADD  CONSTRAINT [DF__Post__OldOrNew__5441852A]  DEFAULT ((0)) FOR [OldOrNew]
GO
ALTER TABLE [dbo].[Post] ADD  CONSTRAINT [DF_Post_ManufacturerId]  DEFAULT ((0)) FOR [ManufacturerId]
GO
ALTER TABLE [dbo].[PostGallery] ADD  CONSTRAINT [DF_PostGallery_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[StaticContent] ADD  DEFAULT ((0)) FOR [ViewCount]
GO
ALTER TABLE [dbo].[AttribureValue]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AttribureValue_dbo.Attribute_AttributeId] FOREIGN KEY([AttributeId])
REFERENCES [dbo].[Attribute] ([Id])
GO
ALTER TABLE [dbo].[AttribureValue] CHECK CONSTRAINT [FK_dbo.AttribureValue_dbo.Attribute_AttributeId]
GO
ALTER TABLE [dbo].[Banner]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Banner_dbo.MenuLink_MenuId] FOREIGN KEY([MenuId])
REFERENCES [dbo].[MenuLink] ([Id])
GO
ALTER TABLE [dbo].[Banner] CHECK CONSTRAINT [FK_dbo.Banner_dbo.MenuLink_MenuId]
GO
ALTER TABLE [dbo].[Banner]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Banner_dbo.PageBanner_PageId] FOREIGN KEY([PageId])
REFERENCES [dbo].[PageBanner] ([Id])
GO
ALTER TABLE [dbo].[Banner] CHECK CONSTRAINT [FK_dbo.Banner_dbo.PageBanner_PageId]
GO
ALTER TABLE [dbo].[Claim]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Claim_dbo.User_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Claim] CHECK CONSTRAINT [FK_dbo.Claim_dbo.User_UserId]
GO
ALTER TABLE [dbo].[ContactInformation]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ContactInfomation_dbo.Province_ProvinceId] FOREIGN KEY([ProvinceId])
REFERENCES [dbo].[Province] ([Id])
GO
ALTER TABLE [dbo].[ContactInformation] CHECK CONSTRAINT [FK_dbo.ContactInfomation_dbo.Province_ProvinceId]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Address_BillingAddress_Id] FOREIGN KEY([BillingAddress_Id])
REFERENCES [dbo].[Address] ([Id])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Address_BillingAddress_Id]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Address_ShippingAddress_Id] FOREIGN KEY([ShippingAddress_Id])
REFERENCES [dbo].[Address] ([Id])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Address_ShippingAddress_Id]
GO
ALTER TABLE [dbo].[CustomerAddresses]  WITH CHECK ADD  CONSTRAINT [FK_CustomerAddresses_Address] FOREIGN KEY([Address_Id])
REFERENCES [dbo].[Address] ([Id])
GO
ALTER TABLE [dbo].[CustomerAddresses] CHECK CONSTRAINT [FK_CustomerAddresses_Address]
GO
ALTER TABLE [dbo].[CustomerAddresses]  WITH CHECK ADD  CONSTRAINT [FK_CustomerAddresses_Customer] FOREIGN KEY([Customer_Id])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[CustomerAddresses] CHECK CONSTRAINT [FK_CustomerAddresses_Customer]
GO
ALTER TABLE [dbo].[ExternalLogin]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ExternalLogin_dbo.User_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[ExternalLogin] CHECK CONSTRAINT [FK_dbo.ExternalLogin_dbo.User_UserId]
GO
ALTER TABLE [dbo].[GalleryImage]  WITH CHECK ADD  CONSTRAINT [FK_dbo.GalleryImage_dbo.AttribureValue_AttributeValueId] FOREIGN KEY([AttributeValueId])
REFERENCES [dbo].[AttribureValue] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GalleryImage] CHECK CONSTRAINT [FK_dbo.GalleryImage_dbo.AttribureValue_AttributeValueId]
GO
ALTER TABLE [dbo].[GalleryImage]  WITH CHECK ADD  CONSTRAINT [FK_dbo.GalleryImage_dbo.Post_PostId] FOREIGN KEY([PostId])
REFERENCES [dbo].[Post] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GalleryImage] CHECK CONSTRAINT [FK_dbo.GalleryImage_dbo.Post_PostId]
GO
ALTER TABLE [dbo].[GenericControlMenuLink]  WITH CHECK ADD  CONSTRAINT [FK_GenericControlMenuLink_GenericControl] FOREIGN KEY([GenericControlId])
REFERENCES [dbo].[GenericControl] ([Id])
GO
ALTER TABLE [dbo].[GenericControlMenuLink] CHECK CONSTRAINT [FK_GenericControlMenuLink_GenericControl]
GO
ALTER TABLE [dbo].[GenericControlMenuLink]  WITH CHECK ADD  CONSTRAINT [FK_GenericControlMenuLink_MenuLink] FOREIGN KEY([MenuLinkId])
REFERENCES [dbo].[MenuLink] ([Id])
GO
ALTER TABLE [dbo].[GenericControlMenuLink] CHECK CONSTRAINT [FK_GenericControlMenuLink_MenuLink]
GO
ALTER TABLE [dbo].[GenericControlValue]  WITH CHECK ADD  CONSTRAINT [FK_GenericControlValue_GenericControl] FOREIGN KEY([GenericControlId])
REFERENCES [dbo].[GenericControl] ([Id])
GO
ALTER TABLE [dbo].[GenericControlValue] CHECK CONSTRAINT [FK_GenericControlValue_GenericControl]
GO
ALTER TABLE [dbo].[GenericControlValueItem]  WITH CHECK ADD  CONSTRAINT [FK_GenericControlValueItem_GenericControlValue] FOREIGN KEY([GenericControlValueId])
REFERENCES [dbo].[GenericControlValue] ([Id])
GO
ALTER TABLE [dbo].[GenericControlValueItem] CHECK CONSTRAINT [FK_GenericControlValueItem_GenericControlValue]
GO
ALTER TABLE [dbo].[LandingPage]  WITH CHECK ADD  CONSTRAINT [FK_dbo.LandingPage_dbo.ContactInfomation_ShopId] FOREIGN KEY([ShopId])
REFERENCES [dbo].[ContactInformation] ([Id])
GO
ALTER TABLE [dbo].[LandingPage] CHECK CONSTRAINT [FK_dbo.LandingPage_dbo.ContactInfomation_ShopId]
GO
ALTER TABLE [dbo].[LocaleStringResource]  WITH CHECK ADD  CONSTRAINT [FK__LocaleStr__Langu__2645B050] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Language] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LocaleStringResource] CHECK CONSTRAINT [FK__LocaleStr__Langu__2645B050]
GO
ALTER TABLE [dbo].[LocalizedProperty]  WITH CHECK ADD  CONSTRAINT [FK__Localized__Langu__2739D489] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Language] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LocalizedProperty] CHECK CONSTRAINT [FK__Localized__Langu__2739D489]
GO
ALTER TABLE [dbo].[News]  WITH CHECK ADD  CONSTRAINT [FK_dbo.News_dbo.MenuLink_MenuId] FOREIGN KEY([MenuId])
REFERENCES [dbo].[MenuLink] ([Id])
GO
ALTER TABLE [dbo].[News] CHECK CONSTRAINT [FK_dbo.News_dbo.MenuLink_MenuId]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Order_dbo.Address_BillingAddressId] FOREIGN KEY([BillingAddressId])
REFERENCES [dbo].[Address] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_dbo.Order_dbo.Address_BillingAddressId]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Order_dbo.Address_ShippingAddressId] FOREIGN KEY([ShippingAddressId])
REFERENCES [dbo].[Address] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_dbo.Order_dbo.Address_ShippingAddressId]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Address_BillingAddressId] FOREIGN KEY([BillingAddressId])
REFERENCES [dbo].[Address] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Address_BillingAddressId]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customer_CustomerId]
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_dbo.OrderItem_dbo.Order_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [FK_dbo.OrderItem_dbo.Order_OrderId]
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_Post_PostId] FOREIGN KEY([PostId])
REFERENCES [dbo].[Post] ([Id])
GO
ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [FK_OrderItem_Post_PostId]
GO
ALTER TABLE [dbo].[OrderNote]  WITH CHECK ADD  CONSTRAINT [FK_dbo.OrderNote_dbo.Order_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderNote] CHECK CONSTRAINT [FK_dbo.OrderNote_dbo.Order_OrderId]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Post_dbo.MenuLink_MenuId] FOREIGN KEY([MenuId])
REFERENCES [dbo].[MenuLink] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_dbo.Post_dbo.MenuLink_MenuId]
GO
ALTER TABLE [dbo].[PostAttribute]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PostAttribute_dbo.AttribureValue_AttibuteValueId] FOREIGN KEY([AttibuteValueId])
REFERENCES [dbo].[AttribureValue] ([Id])
GO
ALTER TABLE [dbo].[PostAttribute] CHECK CONSTRAINT [FK_dbo.PostAttribute_dbo.AttribureValue_AttibuteValueId]
GO
ALTER TABLE [dbo].[PostAttribute]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PostAttribute_dbo.Post_PostId] FOREIGN KEY([PostId])
REFERENCES [dbo].[Post] ([Id])
GO
ALTER TABLE [dbo].[PostAttribute] CHECK CONSTRAINT [FK_dbo.PostAttribute_dbo.Post_PostId]
GO
ALTER TABLE [dbo].[Repair]  WITH CHECK ADD  CONSTRAINT [FK_Repair_Brand] FOREIGN KEY([Id])
REFERENCES [dbo].[Brand] ([Id])
GO
ALTER TABLE [dbo].[Repair] CHECK CONSTRAINT [FK_Repair_Brand]
GO
ALTER TABLE [dbo].[RepairGallery]  WITH CHECK ADD  CONSTRAINT [FK_dbo.RepairGallery_dbo.Repair_RepairId] FOREIGN KEY([RepairId])
REFERENCES [dbo].[Repair] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairGallery] CHECK CONSTRAINT [FK_dbo.RepairGallery_dbo.Repair_RepairId]
GO
ALTER TABLE [dbo].[RepairItem]  WITH CHECK ADD  CONSTRAINT [FK_dbo.RepairItem_dbo.Repair_RepairId] FOREIGN KEY([RepairId])
REFERENCES [dbo].[Repair] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairItem] CHECK CONSTRAINT [FK_dbo.RepairItem_dbo.Repair_RepairId]
GO
ALTER TABLE [dbo].[StaticContent]  WITH CHECK ADD  CONSTRAINT [FK_dbo.StaticContents_dbo.MenuLink_MenuId] FOREIGN KEY([MenuId])
REFERENCES [dbo].[MenuLink] ([Id])
GO
ALTER TABLE [dbo].[StaticContent] CHECK CONSTRAINT [FK_dbo.StaticContents_dbo.MenuLink_MenuId]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserRole_dbo.Role_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([RoleId])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_dbo.UserRole_dbo.Role_RoleId]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserRole_dbo.User_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_dbo.UserRole_dbo.User_UserId]
GO
/****** Object:  StoredProcedure [dbo].[Post_Insert]    Script Date: 28-May-18 23:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Post_Insert] @VirtualCatUrl VARCHAR(500)
AS
BEGIN
	INSERT Post
	SELECT 3 AS MenuId
		, mn.VirtualId AS 'VirtaulCategoryId'
		, NULL AS LANGUAGE
		, pr.title
		, pr.brief AS 'ShortDesc'
		, pr.detail AS 'Description'
		, 1 AS [Status]
		, 0 AS 'OrderDispaly'
		, 0 AS 'ViewCount'
		, pr.metatitle
		, pr.metakeyword
		, pr.metadescription
		, titleurl AS 'SeoUrl'
		, 0 AS 'Price'
		, 0 AS 'Discount'
		, 1 AS 'ProductHot'
		, 1 AS 'OutOfStock'
		, 1 AS 'ProductNew'
		, 'cong-trinh/nha-pho' AS VirtualCatUrl
		, pr.IMAGE AS ImageBigSize
		, pr.IMAGE AS ImageMediumSize
		, pr.IMAGE AS ImageSmallSize
		, NULL AS StartDate
		, 0 AS PostType
		, RAND() AS ProductCode
		, NULL AS EndDate
		, GETDATE() AS CreatedDate
		, 'Administrator' AS CreateBy
		, GetDate() AS UpdateDate
		, 'Administrator' AS UpdateBy
		, NULL AS TechInfo
		, 1 AS 'OldOrNew'
	FROM MenuLink mn
	LEFT JOIN Kientrucboba.dbo.Product_Tmp pr
		ON pr.categorynamedesc = mn.MenuName
	WHERE pr.CategoryId = 74
END


GO
USE [master]
GO
ALTER DATABASE [KuteShop] SET  READ_WRITE 
GO
