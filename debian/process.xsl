<?xml version="1.0" encoding="utf-8"?>
<!--
 Copyright (c) 2011-2012 Mathieu Malaterre <malat@debian.org>
 .
 This library is free software; you can redistribute it and/or
 modify it under the terms of the GNU Lesser General Public
 License as published by the Free Software Foundation;
 version 2.1 of the License
 .
 This library is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 Lesser General Public License for more details.
 .
 You should have received a copy of the GNU Lesser General Public
 License along with this library; if not, write to the Free Software
 Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" indent="yes" encoding="utf-8"/>
  <xsl:template match="h1">
    <title>
      <xsl:apply-templates/>
    </title>
  </xsl:template>
  <xsl:template match="h2">
    <xsl:choose>
      <xsl:when test="preceding-sibling::h2">
END SECTION
BEGIN SECTION
        </xsl:when>
      <xsl:when test="preceding-sibling::h1">
BEGIN SECTION
        </xsl:when>
    </xsl:choose>
    <title>
      <xsl:apply-templates/>
    </title>
  </xsl:template>
  <xsl:template match="table">
    <informaltable>
      <tgroup cols="2">
        <xsl:apply-templates/>
      </tgroup>
    </informaltable>
  </xsl:template>
  <xsl:template match="tr">
    <row>
      <xsl:apply-templates/>
    </row>
  </xsl:template>
  <xsl:template match="tbody">
    <tbody>
      <xsl:apply-templates/>
    </tbody>
  </xsl:template>
  <xsl:template match="thead">
    <thead>
      <xsl:apply-templates/>
    </thead>
  </xsl:template>
  <xsl:template match="th|td">
    <entry>
      <xsl:apply-templates/>
    </entry>
  </xsl:template>
  <xsl:template match="code">
    <!-- cant use programlisting -->
    <literal>
      <xsl:apply-templates/>
    </literal>
  </xsl:template>
  <xsl:template match="p">
    <xsl:choose>
      <xsl:when test="normalize-space(.) = ''">
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
        <para>
          <xsl:apply-templates/>
        </para>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="dl">
    <variablelist>
      <xsl:for-each select="dt">
        <varlistentry>
          <term>
            <xsl:apply-templates/>
          </term>
          <listitem>
            <xsl:apply-templates select="following-sibling::dd[1]"/>
          </listitem>
        </varlistentry>
      </xsl:for-each>
    </variablelist>
  </xsl:template>
  <xsl:template match="ol">
    <orderedlist>
      <xsl:apply-templates/>
    </orderedlist>
  </xsl:template>
  <xsl:template match="li">
    <listitem>
      <xsl:choose>
        <xsl:when test="count(p) = 0">
          <para>
            <xsl:apply-templates/>
          </para>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </listitem>
  </xsl:template>
  <xsl:template match="dd">
    <xsl:choose>
      <xsl:when test="boolean(p)">
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
        <para>
          <xsl:apply-templates/>
        </para>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="a">
    <ulink>
      <xsl:attribute name="url">
        <xsl:if test="not(contains(@href,'http://'))">
          <xsl:text>http://openslide.org</xsl:text>
        </xsl:if>
        <xsl:value-of select="normalize-space(@href)"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </ulink>
  </xsl:template>
  <xsl:template match="/">
    <xsl:for-each select="//div[@class = 'wikipage']">
      <refsection><xsl:apply-templates/>
END SECTION
      </refsection>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="*">
    <xsl:message>No template for <xsl:value-of select="name()"/>
  </xsl:message>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="@*">
    <xsl:message>Still No template for <xsl:value-of select="name()"/>
  </xsl:message>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="b | strong">
    <emphasis role="bold">
      <xsl:apply-templates/>
    </emphasis>
  </xsl:template>
  <!-- Ignored elements -->
  <xsl:template match="hr"/>
</xsl:stylesheet>
