using System;
using System.IO;
using System.Text;
using System.Web;

namespace WebCache.Static
{
	public class StaticContentFilter : Stream
	{
		private readonly static char[] HREF_ATTRIBUTE;

		private readonly static char[] REL_ATTRIBUTE;

		private readonly static char[] HTTP_PREFIX;

		private readonly static char[] IMG_TAG;

		private readonly static char[] LINK_TAG;

		private readonly static char[] SCRIPT_TAG;

		private readonly static char[] SRC_ATTRIBUTE;

		private byte[] _CssPrefix;

		private Encoding _Encoding;

		private byte[] _ImagePrefix;

		private byte[] _JavascriptPrefix;

		private char[] _ApplicationPath;

		private byte[] _BaseUrl;

		private byte[] _CurrentFolder;

		private char[] _PendingBuffer;

		private Stream _ResponseStream;

		private Func<string, string> _getVersionOfFile;

		public override bool CanRead
		{
			get
			{
				return false;
			}
		}

		public override bool CanSeek
		{
			get
			{
				return false;
			}
		}

		public override bool CanWrite
		{
			get
			{
				return true;
			}
		}

		public override long Length
		{
			get
			{
				return 0;
			}
		}

		public override long Position
		{
			get;
			set;
		}

		static StaticContentFilter()
		{
			HREF_ATTRIBUTE = "href".ToCharArray();
			REL_ATTRIBUTE = "rel".ToCharArray();
			HTTP_PREFIX = "http://".ToCharArray();
			IMG_TAG = "img".ToCharArray();
			LINK_TAG = "link".ToCharArray();
			SCRIPT_TAG = "script".ToCharArray();
			SRC_ATTRIBUTE = "src".ToCharArray();
		}

		public StaticContentFilter(HttpResponse response, Func<string, string> getVersionOfFile, string imagePrefix, string javascriptPrefix, string cssPrefix, string baseUrl, string applicationPath, string currentRelativePath)
		{
			_Encoding = response.Output.Encoding;
			_ResponseStream = response.Filter;
			_ImagePrefix = _Encoding.GetBytes(imagePrefix);
			_JavascriptPrefix = _Encoding.GetBytes(javascriptPrefix);
			_CssPrefix = _Encoding.GetBytes(cssPrefix);
			_ApplicationPath = applicationPath.ToCharArray();
			_BaseUrl = _Encoding.GetBytes(baseUrl);
			_CurrentFolder = _Encoding.GetBytes(currentRelativePath);
			_getVersionOfFile = getVersionOfFile;
		}

		public override void Close()
		{
			FlushPendingBuffer();
			_ResponseStream.Close();
			_ResponseStream = null;
			_getVersionOfFile = null;
			_PendingBuffer = null;
		}

		private int FindAttributeValuePos(char[] attributeName, char[] content, int pos)
		{
			for (int i = pos; i < content.Length - attributeName.Length; i++)
			{
				if (62 == content[i])
				{
					return -1;
				}
				if (HasMatch(content, i, attributeName))
				{
					pos = i + attributeName.Length;
					int num = pos;
					pos = num + 1;
					if (34 != content[num])
					{
						return pos;
					}
				}
			}
			return -1;
		}

		public override void Flush()
		{
			FlushPendingBuffer();
			_ResponseStream.Flush();
		}

		private void FlushPendingBuffer()
		{
			if (_PendingBuffer != null)
			{
				WriteOutput(_PendingBuffer, 0, _PendingBuffer.Length);
				_PendingBuffer = null;
			}
		}

		private bool HasMatch(char[] content, int pos, char[] match)
		{
			for (int i = 0; i < match.Length; i++)
			{
				if (content[pos + i] != match[i] && content[pos + i] != match[i])
				{
					return false;
				}
			}
			return true;
		}

		private bool HasTagEnd(char[] content, int pos)
		{
			while (pos < content.Length)
			{
				if (62 == content[pos])
				{
					return true;
				}
				pos++;
			}
			return false;
		}

		public override int Read(byte[] buffer, int offset, int count)
		{
			return _ResponseStream.Read(buffer, offset, count);
		}

		public override long Seek(long offset, SeekOrigin origin)
		{
			return _ResponseStream.Seek(offset, origin);
		}

		public override void SetLength(long length)
		{
			_ResponseStream.SetLength(length);
		}

		public override void Write(byte[] buffer, int offset, int count)
		{
			char[] chrArray;
			char[] chars = _Encoding.GetChars(buffer, offset, count);
			if (_PendingBuffer == null)
			{
				chrArray = chars;
			}
			else
			{
				chrArray = new char[chars.Length + _PendingBuffer.Length];
				Array.Copy(_PendingBuffer, 0, chrArray, 0, _PendingBuffer.Length);
				Array.Copy(chars, 0, chrArray, _PendingBuffer.Length, chars.Length);
				_PendingBuffer = null;
			}
			int num = 0;
			for (int i = 0; i < chrArray.Length; i++)
			{
				if (60 == chrArray[i])
				{
					i++;
					if (!HasTagEnd(chrArray, i))
					{
						_PendingBuffer = new char[chrArray.Length - i];
						Array.Copy(chrArray, i, _PendingBuffer, 0, chrArray.Length - i);
						WriteOutput(chrArray, num, i - num);
						return;
					}
					if (47 != chrArray[i])
					{
						if (HasMatch(chrArray, i, IMG_TAG))
						{
							num = WritePrefixIf(SRC_ATTRIBUTE, chrArray, i, num, _ImagePrefix);
						}
						else if (HasMatch(chrArray, i, SCRIPT_TAG))
						{
							num = WritePrefixIf(SRC_ATTRIBUTE, chrArray, i, num, _JavascriptPrefix);
							num = WritePathWithVersion(chrArray, num);
						}
						else if (HasMatch(chrArray, i, LINK_TAG))
						{
							num = WritePrefixIf(HREF_ATTRIBUTE, chrArray, i, num, _CssPrefix);
							num = WritePathWithVersion(chrArray, num);
						}
						if (num > i)
						{
							i = num;
						}
					}
				}
			}
			WriteOutput(chrArray, num, chrArray.Length - num);
		}

		private void WriteBytes(byte[] bytes, int pos, int length)
		{
			_ResponseStream.Write(bytes, 0, bytes.Length);
		}

		private void WriteOutput(char[] content, int pos, int length)
		{
			if (length == 0)
			{
				return;
			}
			byte[] bytes = _Encoding.GetBytes(content, pos, length);
			WriteBytes(bytes, 0, bytes.Length);
		}

		private int WritePathWithVersion(char[] content, int lastPosWritten)
		{
			if (!HasMatch(content, lastPosWritten, HTTP_PREFIX))
			{
				int num = lastPosWritten + 1;
				while (34 != content[num])
				{
					num++;
				}
				string str = new string(content, lastPosWritten, num - lastPosWritten);
				WriteOutput(content, lastPosWritten, num - lastPosWritten);
				lastPosWritten = num;
				char[] charArray = _getVersionOfFile(str).ToCharArray();
				WriteOutput(charArray, 0, charArray.Length);
			}
			return lastPosWritten;
		}

		private int WritePrefixIf(char[] attributeName, char[] content, int pos, int lastWritePos, byte[] prefix)
		{
			int length = FindAttributeValuePos(attributeName, content, pos);
			if (length <= 0)
			{
				return lastWritePos;
			}
			if (HasMatch(content, length, HTTP_PREFIX))
			{
				return lastWritePos;
			}
			WriteOutput(content, lastWritePos, length - lastWritePos);
			if (prefix.Length != 0)
			{
				WriteBytes(prefix, 0, prefix.Length);
			}
			if (HasMatch(content, length, _ApplicationPath))
			{
				length = length + _ApplicationPath.Length;
			}
			else if (_CurrentFolder.Length != 0)
			{
				WriteBytes(_CurrentFolder, 0, _CurrentFolder.Length);
			}
			if (47 == content[length])
			{
				length++;
			}
			return length;
		}
	}
}