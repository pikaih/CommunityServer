﻿<%@ Page Language="C#" MasterPageFile="~/Masters/basetemplate.master" AutoEventWireup="true" EnableViewState="false" CodeBehind="Default.aspx.cs" Inherits="ASC.Web.Studio._Default" %>
<%@ MasterType TypeName="ASC.Web.Studio.Masters.BaseTemplate" %>
<%@ Import Namespace="ASC.Web.Core" %>
<%@ Import Namespace="ASC.Core.Users" %>
<%@ Import Namespace="ASC.Web.Studio.Core" %>
<%@ Import Namespace="ASC.Web.Studio.Utility" %>
<%@ Import Namespace="Resources" %>

<asp:Content ContentPlaceHolderID="PageContent" runat="server">
    <div id="GreetingBlock" class="greating-block">
        <div class="greating-modules-block">
            <% if (_showDocs != null) { %>
            <div class="docs-default-page">
                <a class="docs-default-logo" href="<%= VirtualPathUtility.ToAbsolute(_showDocs.StartURL) %>"></a>
                <h2 class="title">
                    <a class="link header" href="<%= VirtualPathUtility.ToAbsolute(_showDocs.StartURL) %>">
                        <%=_showDocs.Name %></a>
                </h2>
                <span class="description">
                    <%= (CurrentUser.IsAdmin()) ? _showDocs.ExtendedDescription : _showDocs.Description %>
                </span>
            </div>
            <div class="clearFix"></div>
            <% } %>

            <div class="default-list-products">
            <% foreach (var product in defaultListProducts) %>
            <% {
                   var productStartUrl = VirtualPathUtility.ToAbsolute(product.StartURL);
                   var productLabel =
                       product.ID == WebItemManager.CRMProductID
                       ? Resource.ProductCRMAndVoIP
                       : (product.ID == WebItemManager.MailProductID && SetupInfo.IsVisibleSettings("AdministrationPage") && CurrentUser.IsAdmin() ?
                                    Resource.AdministrationLabel :
                                    HttpUtility.HtmlEncode(product.Name));
                %>
                <div class="product clearFix">
                        <a class="image-link" href="<%= productStartUrl %>">
                            <img alt="<%= productLabel %>" src="<%= product.GetLargeIconAbsoluteURL() %>" /></a>
                        <h2 class="title">
                            <a class="link header" href="<%= productStartUrl %>">
                                <%= productLabel %>
                            </a>
                        </h2>
                    </div>
            <% } %>
            <% if (TenantExtra.EnableControlPanel)
               { %>
                <div class="product clearFix">
                    <a class="image-link" href="<%= SetupInfo.ControlPanelUrl %>" target="_blank">
                        <img alt="<%= Resource.ControlPanelLabel %>" src="<%= ASC.Web.Core.Utility.Skins.WebImageSupplier.GetAbsoluteWebPath("icon-controlpanel.png") %>" />
                    </a>
                    <h2 class="title">
                        <a class="link header" href="<%= SetupInfo.ControlPanelUrl %>" target="_blank">
                            <%= Resource.ControlPanelLabel %>
                        </a>
                    </h2>
                </div>
            <% } %>
            </div>
        </div>
    </div>

    <% if (!string.IsNullOrEmpty(SetupInfo.UserVoiceURL))
       { %>
    <script type="text/javascript" src="<%= SetupInfo.UserVoiceURL %>"></script>
    <% } %>
</asp:Content>

<%--<asp:Content ID="Content1" ContentPlaceHolderID="FooterContent" runat="server">
    <%if (IsAutorizePartner.HasValue && Partner != null) { %>
    <div class="footerAuth">
        <span class="float-right">
            <%= IsAutorizePartner.Value ? (Partner.DisplayName ?? Partner.CompanyName).HtmlEncode() + " • <a class=\"link\" href=\"" + (Partner.Url.StartsWith("http:") || Partner.Url.StartsWith("https:") ? Partner.Url : string.Concat("http://", Partner.Url)) +"\" target=\"_blank\">" + Partner.Url + "</a>" 
            : Resource.HostedNonAuthorizedVersion%>
        </span>
    </div>
    <%} %>
</asp:Content>--%>