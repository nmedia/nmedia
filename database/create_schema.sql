SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[search_engines]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[search_engines](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](50) NOT NULL,
	[description] [nchar](200) NOT NULL,
 CONSTRAINT [PK_search_engines] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[review_engines]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[review_engines](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nchar](50) NOT NULL,
	[description] [nchar](200) NOT NULL,
 CONSTRAINT [PK_review_engines] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[users]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [nchar](50) NOT NULL,
	[last_name] [nchar](50) NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[media]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[media](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nchar](100) NOT NULL,
	[release_date] [datetime] NOT NULL,
	[search_engine_id] [int] NOT NULL,
	[added_date] [datetime] NOT NULL,
 CONSTRAINT [PK_media] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[reviews]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[reviews](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[media_id] [int] NOT NULL,
	[review_engine_id] [int] NOT NULL,
	[review] [nchar](100) NOT NULL,
 CONSTRAINT [PK_reviews] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[users_media]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[users_media](
	[user_id] [int] NOT NULL,
	[media_id] [int] NOT NULL,
	[id] [int] NOT NULL,
 CONSTRAINT [PK_users_media_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[login]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[login](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[login] [nchar](10) NOT NULL,
	[password] [nchar](10) NOT NULL,
	[user_id] [int] NOT NULL,
 CONSTRAINT [PK_login] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_media_search_engines]') AND parent_object_id = OBJECT_ID(N'[dbo].[media]'))
ALTER TABLE [dbo].[media]  WITH CHECK ADD  CONSTRAINT [FK_media_search_engines] FOREIGN KEY([search_engine_id])
REFERENCES [dbo].[search_engines] ([id])
GO
ALTER TABLE [dbo].[media] CHECK CONSTRAINT [FK_media_search_engines]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_reviews_media]') AND parent_object_id = OBJECT_ID(N'[dbo].[reviews]'))
ALTER TABLE [dbo].[reviews]  WITH CHECK ADD  CONSTRAINT [FK_reviews_media] FOREIGN KEY([media_id])
REFERENCES [dbo].[media] ([id])
GO
ALTER TABLE [dbo].[reviews] CHECK CONSTRAINT [FK_reviews_media]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_reviews_review_engines]') AND parent_object_id = OBJECT_ID(N'[dbo].[reviews]'))
ALTER TABLE [dbo].[reviews]  WITH CHECK ADD  CONSTRAINT [FK_reviews_review_engines] FOREIGN KEY([review_engine_id])
REFERENCES [dbo].[review_engines] ([id])
GO
ALTER TABLE [dbo].[reviews] CHECK CONSTRAINT [FK_reviews_review_engines]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_users_media_media]') AND parent_object_id = OBJECT_ID(N'[dbo].[users_media]'))
ALTER TABLE [dbo].[users_media]  WITH CHECK ADD  CONSTRAINT [FK_users_media_media] FOREIGN KEY([media_id])
REFERENCES [dbo].[media] ([id])
GO
ALTER TABLE [dbo].[users_media] CHECK CONSTRAINT [FK_users_media_media]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_users_media_users]') AND parent_object_id = OBJECT_ID(N'[dbo].[users_media]'))
ALTER TABLE [dbo].[users_media]  WITH CHECK ADD  CONSTRAINT [FK_users_media_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[users_media] CHECK CONSTRAINT [FK_users_media_users]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_login_users]') AND parent_object_id = OBJECT_ID(N'[dbo].[login]'))
ALTER TABLE [dbo].[login]  WITH CHECK ADD  CONSTRAINT [FK_login_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[login] CHECK CONSTRAINT [FK_login_users]
